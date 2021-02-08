Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C341831411B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 21:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234090AbhBHU7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 15:59:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236405AbhBHTtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 14:49:13 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C42CC061788
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 11:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=YgFez7BF/vukNamJA5m6x4ZictvAntBpWelcO2BexDY=; b=D9PzXmIa5nMUPUhNvPdGSbUukc
        R6Q4y4nMWl8+TtQunUpqbYC9hoDgVv3b/rRMiNsGUeAWca60Ij2EuYmFJCIVCxtHTCdLjz4qRf1m4
        PXjSBF2X7QBNpi9vJ9+bE4AD8daPaKPBOK0+mgfkYdxudDe+CzVh7k12mGdx2wNG2cUxq9JgYZ2wV
        2KQaKeiyqNwt1x9RhsUPLjv++GK5aq24G3RDk3Zo4uS1NoIo4f4ecC9TB+JRlUqAb/z6Wn0eGAWQz
        TcDk9N+eejWZjMlZ5cnmW896GyFJJj9OP+uwQT+gcx6LE2JpILH9yQlm8clSfkfqJa83HTUZlsg5O
        4yrZm7yg==;
Received: from [2601:1c0:6280:3f0::cf3b]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l9CW6-0000St-6O; Mon, 08 Feb 2021 19:48:14 +0000
Subject: Re: [PATCH v9 01/18] docs: acrn: Introduce ACRN
To:     shuo.a.liu@intel.com, linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Yu Wang <yu1.wang@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>, Borislav Petkov <bp@suse.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Sen Christopherson <sean.j.christopherson@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Fengwei Yin <fengwei.yin@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
References: <20210207031040.49576-1-shuo.a.liu@intel.com>
 <20210207031040.49576-2-shuo.a.liu@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <6ae2679c-e172-a955-9df5-2b54b79dd854@infradead.org>
Date:   Mon, 8 Feb 2021 11:48:07 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210207031040.49576-2-shuo.a.liu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 2/6/21 7:10 PM, shuo.a.liu@intel.com wrote:
> From: Shuo Liu <shuo.a.liu@intel.com>
> 
> Add documentation on the following aspects of ACRN:
> 
>   1) A brief introduction on the architecture of ACRN.
>   2) I/O request handling in ACRN.
>   3) CPUID functions of ACRN.

> ---

> diff --git a/Documentation/virt/acrn/io-request.rst b/Documentation/virt/acrn/io-request.rst
> new file mode 100644
> index 000000000000..6cc3ea0fa1f5
> --- /dev/null
> +++ b/Documentation/virt/acrn/io-request.rst
> @@ -0,0 +1,97 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +I/O request handling
> +====================
> +
...
> +
> +1. I/O request
> +--------------
> +
> +For each User VM, there is a shared 4-KByte memory region used for I/O requests
> +communication between the hypervisor and Service VM. An I/O request is a
> +256-byte structure buffer, which is 'struct acrn_io_request', that is filled by
> +an I/O handler of the hypervisor when a trapped I/O access happens in a User
> +VM. ACRN userspace in the Service VM first allocates a 4-KByte page and passes
> +the GPA (Guest Physical Address) of the buffer to the hypervisor. The buffer is
> +used as an array of 16 I/O request slots with each I/O request slot being 256
> +bytes. This array is indexed by vCPU ID.

Does this mean that ACRN has a limit of 16 vCPUs ?

thanks.
-- 
~Randy

