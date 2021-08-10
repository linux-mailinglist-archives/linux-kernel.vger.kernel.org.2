Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 426593E8675
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 01:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235467AbhHJX1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 19:27:43 -0400
Received: from mga11.intel.com ([192.55.52.93]:36799 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235301AbhHJX1l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 19:27:41 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10072"; a="211907725"
X-IronPort-AV: E=Sophos;i="5.84,310,1620716400"; 
   d="scan'208";a="211907725"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2021 16:27:17 -0700
X-IronPort-AV: E=Sophos;i="5.84,310,1620716400"; 
   d="scan'208";a="589684431"
Received: from conyeama-mobl.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.254.48.221])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2021 16:27:15 -0700
Date:   Wed, 11 Aug 2021 11:27:13 +1200
From:   Kai Huang <kai.huang@intel.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     linux-sgx@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/sgx: Always deregister /dev/sgx_provision on
 failure
Message-Id: <20210811112713.267a1d0b99ee53813ba733b3@intel.com>
In-Reply-To: <20210810225627.202890-1-jarkko@kernel.org>
References: <20210810225627.202890-1-jarkko@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Aug 2021 01:56:27 +0300 Jarkko Sakkinen wrote:
> When /dev/sgx_vepc for KVM was added, the initialization was relaxed so
> that this file can be accessed even when the driver is disabled.
> 
> Deregister /dev/sgx_provision when the driver is disabled, because it is
> only useful for the driver.

Hi Jarkko,

This is not true.  KVM also uses /dev/sgx_provision to restrict enclave in guest
from accessing provisoning key.  Specifically, in order to allow guest enclave
to be able to use provisioning key, when one VM is created, Qemu must have
permission to open /dev/sgx_provision, and pass the fd as parameter to
KVM_CAP_SGX_ATTRIBUTE.

Please see below KVM API:

7.25 KVM_CAP_SGX_ATTRIBUTE
--------------------------           
                                                     
:Architectures: x86                                         
:Target: VM                                                              
:Parameters: args[0] is a file handle of a SGX attribute file in securityfs
:Returns: 0 on success, -EINVAL if the file handle is invalid or if a requested
          attribute is not supported by KVM.                         
                                                                               
KVM_CAP_SGX_ATTRIBUTE enables a userspace VMM to grant a VM access to one or
more priveleged enclave attributes.  args[0] must hold a file handle to a valid
SGX attribute file corresponding to an attribute that is supported/restricted
by KVM (currently only PROVISIONKEY).
                                                                    
The SGX subsystem restricts access to a subset of enclave attributes to provide
additional security for an uncompromised kernel, e.g. use of the PROVISIONKEY
is restricted to deter malware from using the PROVISIONKEY to obtain a stable
system fingerprint.  To prevent userspace from circumventing such restrictions
by running an enclave in a VM, KVM prevents access to privileged attributes by
default.                                                 

> 
> Fixes: faa7d3e6f3b9 ("x86/sgx: Initialize virtual EPC driver even when SGX driver is disabled")
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
>  arch/x86/kernel/cpu/sgx/driver.c | 17 +++++++++++++++++
>  arch/x86/kernel/cpu/sgx/main.c   | 20 +-------------------
>  2 files changed, 18 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/sgx/driver.c b/arch/x86/kernel/cpu/sgx/driver.c
> index aa9b8b868867..b7698f7628d4 100644
> --- a/arch/x86/kernel/cpu/sgx/driver.c
> +++ b/arch/x86/kernel/cpu/sgx/driver.c
> @@ -143,6 +143,17 @@ static struct miscdevice sgx_dev_enclave = {
>  	.fops = &sgx_encl_fops,
>  };
>  
> +const struct file_operations sgx_provision_fops = {
> +	.owner			= THIS_MODULE,
> +};
> +
> +static struct miscdevice sgx_dev_provision = {
> +	.minor = MISC_DYNAMIC_MINOR,
> +	.name = "sgx_provision",
> +	.nodename = "sgx_provision",
> +	.fops = &sgx_provision_fops,
> +};
> +
>  int __init sgx_drv_init(void)
>  {
>  	unsigned int eax, ebx, ecx, edx;
> @@ -176,5 +187,11 @@ int __init sgx_drv_init(void)
>  	if (ret)
>  		return ret;
>  
> +	ret = misc_register(&sgx_dev_provision);
> +	if (ret) {
> +		misc_deregister(&sgx_dev_enclave);
> +		return ret;
> +	}
> +
>  	return 0;
>  }
> diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
> index 63d3de02bbcc..b8f210f15b62 100644
> --- a/arch/x86/kernel/cpu/sgx/main.c
> +++ b/arch/x86/kernel/cpu/sgx/main.c
> @@ -745,17 +745,6 @@ void sgx_update_lepubkeyhash(u64 *lepubkeyhash)
>  		wrmsrl(MSR_IA32_SGXLEPUBKEYHASH0 + i, lepubkeyhash[i]);
>  }
>  
> -const struct file_operations sgx_provision_fops = {
> -	.owner			= THIS_MODULE,
> -};
> -
> -static struct miscdevice sgx_dev_provision = {
> -	.minor = MISC_DYNAMIC_MINOR,
> -	.name = "sgx_provision",
> -	.nodename = "sgx_provision",
> -	.fops = &sgx_provision_fops,
> -};
> -
>  /**
>   * sgx_set_attribute() - Update allowed attributes given file descriptor
>   * @allowed_attributes:		Pointer to allowed enclave attributes
> @@ -806,10 +795,6 @@ static int __init sgx_init(void)
>  		goto err_page_cache;
>  	}
>  
> -	ret = misc_register(&sgx_dev_provision);
> -	if (ret)
> -		goto err_kthread;
> -
>  	/*
>  	 * Always try to initialize the native *and* KVM drivers.
>  	 * The KVM driver is less picky than the native one and
> @@ -821,13 +806,10 @@ static int __init sgx_init(void)
>  	ret = sgx_drv_init();
>  
>  	if (sgx_vepc_init() && ret)
> -		goto err_provision;
> +		goto err_kthread;
>  
>  	return 0;
>  
> -err_provision:
> -	misc_deregister(&sgx_dev_provision);
> -
>  err_kthread:
>  	kthread_stop(ksgxd_tsk);
>  
> -- 
> 2.32.0
> 
