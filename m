Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD63E3B3A93
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 03:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232995AbhFYBsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 21:48:03 -0400
Received: from mga12.intel.com ([192.55.52.136]:46350 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232917AbhFYBsA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 21:48:00 -0400
IronPort-SDR: ulAcm0+7ej1a1Pvnyfboapkyg5sULlrDsI1FWAywjPD3McC7P/aBYpdbD1i94j+bf5qys3hc9z
 eFvgTuqTEZcQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10025"; a="187279660"
X-IronPort-AV: E=Sophos;i="5.83,297,1616482800"; 
   d="scan'208";a="187279660"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2021 18:45:41 -0700
IronPort-SDR: I1QuzN0qKjgZx2VKhNhdnvRi8+UPvEotRX6g1cDQLtWXcfzgC2Y0lg7NtjypJX11UAvoGxBzwa
 RRcZQfV00qrQ==
X-IronPort-AV: E=Sophos;i="5.83,297,1616482800"; 
   d="scan'208";a="424279578"
Received: from tcoles-mobl.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.213.165.206])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2021 18:45:37 -0700
Message-ID: <925090f035b8e749ea7aca8c857690c8afba7349.camel@intel.com>
Subject: Re: [PATCH v2] x86/sgx: Add missing xa_destroy() when virtual EPC
 is destroyed
From:   Kai Huang <kai.huang@intel.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     linux-sgx@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, bp@alien8.de, seanjc@google.com,
        dave.hansen@intel.com, tglx@linutronix.de, mingo@redhat.com,
        Yang Zhong <yang.zhong@intel.com>
Date:   Fri, 25 Jun 2021 13:45:35 +1200
In-Reply-To: <20210623132844.heleuoxogrpz3cpm@kernel.org>
References: <20210616003634.320206-1-kai.huang@intel.com>
         <20210623132844.heleuoxogrpz3cpm@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.1 (3.40.1-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-06-23 at 16:28 +0300, Jarkko Sakkinen wrote:
> On Wed, Jun 16, 2021 at 12:36:34PM +1200, Kai Huang wrote:
> > xa_destroy() needs to be called to destroy virtual EPC's page array
> > before calling kfree() to free the virtual EPC.  Currently it is not
> > called.  Add the missing xa_destroy() to fix.
> > 
> > Fixes: 540745ddbc70 ("x86/sgx: Introduce virtual EPC for use by KVM guests")
> > Tested-by: Yang Zhong <yang.zhong@intel.com>
> > Acked-by: Dave Hansen <dave.hansen@intel.com>
> > Signed-off-by: Kai Huang <kai.huang@intel.com>
> 
> 
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Thanks Jarkko.

Hi Boris,

Should we consider to get this into 5.13, since it is a fix?

> 
> > ---
> > v1->v2:
> > 
> >  - Fixed typo in commit msg
> >  - Added Dave's Acked-by
> > ---
> >  arch/x86/kernel/cpu/sgx/virt.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/x86/kernel/cpu/sgx/virt.c b/arch/x86/kernel/cpu/sgx/virt.c
> > index 6ad165a5c0cc..64511c4a5200 100644
> > --- a/arch/x86/kernel/cpu/sgx/virt.c
> > +++ b/arch/x86/kernel/cpu/sgx/virt.c
> > @@ -212,6 +212,7 @@ static int sgx_vepc_release(struct inode *inode, struct file *file)
> >  		list_splice_tail(&secs_pages, &zombie_secs_pages);
> >  	mutex_unlock(&zombie_secs_pages_lock);
> >  
> > +	xa_destroy(&vepc->page_array);
> >  	kfree(vepc);
> >  
> >  	return 0;
> > -- 
> > 2.31.1
> > 
> > 
> 
> /Jarkko


