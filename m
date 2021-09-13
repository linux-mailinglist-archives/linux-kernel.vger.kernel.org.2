Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14D7C409D9F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 22:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347755AbhIMUDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 16:03:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:53498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347763AbhIMUDJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 16:03:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BD1A560E9C;
        Mon, 13 Sep 2021 20:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631563310;
        bh=gLNHs6CcvSnX7/miQjZSjEGPQiOP4SA5DpU0CvsJrqk=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=liajztqhepeUtWSNEfNIAqpGCdq5Rx9uhrK7Bt/4aB5DkL2QG/U1cdkUaQgNZFTm1
         BEJRMiLsmo/Vp6PKZ3RFSUNE4uq/buNfLnpmGKxAWEuzkXNaGgzJTLsQuNi1NDLQ+U
         EW0ci2uEGYCEYeTKJK9FnpA0p74lro6O8uRo0B7MGODoFkx+UKKBqv20AeUaZJ5ZB2
         RE97+esnfChnY6ovKlEH/sDn9JOF2DdBXIbAgMfLaAG3VUZC+uyv1svJLFPVRUdLoh
         I7pxT4Chp27Yv3N4qmbDiuWqnx1NabtyGwnSW1Zv16Oyrnw23RV7s5aax45oHyhiNz
         dB3ISjuJoy0gQ==
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id DFDFC27C0054;
        Mon, 13 Sep 2021 16:01:48 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute6.internal (MEProxy); Mon, 13 Sep 2021 16:01:48 -0400
X-ME-Sender: <xms:Kq4_Ydn_1subASKeM25h-gvtkE9kZlnJlgjPs8Z4PLym3Gz8KBQBWQ>
    <xme:Kq4_YY0Baka-lCa4wJo3HqBHUMIWWNYZK5i46g_NbH_BK0YmWXaEsbqfJ3bGBBZQO
    OosN_5rNfcTB1KywE8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudegjedgudegudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedftehn
    ugihucfnuhhtohhmihhrshhkihdfuceolhhuthhosehkvghrnhgvlhdrohhrgheqnecugg
    ftrfgrthhtvghrnheptdfhheettddvtedvtedugfeuuefhtddugedvleevleefvdetleff
    gfefvdekgeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homheprghnugihodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduudeiudek
    heeifedvqddvieefudeiiedtkedqlhhuthhopeepkhgvrhhnvghlrdhorhhgsehlihhnuh
    igrdhluhhtohdruhhs
X-ME-Proxy: <xmx:Kq4_YTqv4-O5-APDb3xYGotkoq2XKhW7D2f4btB1oOsJQ5N31x8y1w>
    <xmx:Kq4_Ydkju7HeoE5G8wEUkUS299lhAJr9iFYgUgYHyiGnJ-ngITkSpw>
    <xmx:Kq4_Yb39MkWZLlqBg9_1dwJdiy69dJ5A_RpNotX_GOGsAu89dCXWFQ>
    <xmx:LK4_YUsPZwMKselyCht0kJT0lpB7Soju-WCKAJpkpVmCpka0DbUMLDe1X1g>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 0E6DCA00387; Mon, 13 Sep 2021 16:01:46 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1229-g7ca81dfce5-fm-20210908.005-g7ca81dfc
Mime-Version: 1.0
Message-Id: <bfeb0b12-5b95-46c9-8ea3-6a4a5bf59076@www.fastmail.com>
In-Reply-To: <20210902105052.2842-1-jiangshanlai@gmail.com>
References: <20210831175025.27570-1-jiangshanlai@gmail.com>
 <20210902105052.2842-1-jiangshanlai@gmail.com>
Date:   Mon, 13 Sep 2021 13:01:25 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Lai Jiangshan" <jiangshanlai@gmail.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Cc:     "Lai Jiangshan" <laijs@linux.alibaba.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Dave Jiang" <dave.jiang@intel.com>,
        "Ben Widawsky" <ben.widawsky@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Arvind Sankar" <nivedita@alum.mit.edu>
Subject: Re: [PATCH 25/24] x86/traps: Rewrite native_load_gs_index in C code
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, Sep 2, 2021, at 3:50 AM, Lai Jiangshan wrote:
> From: Lai Jiangshan <laijs@linux.alibaba.com>
> 
> There is no constrain/limition to force native_load_gs_index() to be in
> ASM code.
> 
> Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>

>  
>  #ifdef CONFIG_X86_64
> +
> +/*
> + * Reload gs selector with exception handling
> + * selector:  new selector
> + *
> + * Is noinstr as it shouldn't be instrumented.
> + */
> +noinstr void native_load_gs_index(unsigned int selector)
> +{
> +	unsigned long flags;
> +
> +	local_irq_save(flags);

This patch would be a bit less alarming if you moved the swapgs into asm.  Also, this needs a comment explaining why skipping the swapgs back to kernel gs in the exception path is correct.

> +	native_swapgs();
> +	asm volatile(
> +		".global asm_load_gs_index_gs_change \n"
> +		"asm_load_gs_index_gs_change: \n"
> +		"1: movl %0, %%gs \n"
> +		"   swapgs \n"
> +		"2: \n"
> +		_ASM_EXTABLE_HANDLE(1b, 2b, ex_handler_clear_gs)
> +		:: "r" (selector) : "memory");
> +	alternative("", "mfence", X86_BUG_SWAPGS_FENCE);
> +	local_irq_restore(flags);
> +}
> +
