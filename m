Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E636E4564A4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 22:02:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233022AbhKRVFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 16:05:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbhKRVFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 16:05:35 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F1DC061574
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 13:02:35 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637269352;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f489daoLpb001Hrar73jObLlk6tLubAuWDyMSkvTu8s=;
        b=lnIKsb5vkSSZ7pB9iyNMAXb7v81+zDKWBZ5k50nKY/XtVxlpJDN99wC2vA61dbHg6Ct1Fc
        adVI4kQ/Jnerevzs/AaYN+2XkKrcY5RoH8ZxOxo70pKsVgLXs/bR1W5z1QD/YZOp1dl82D
        tPiOfpcszkhU6lfqF2djKhvYSaatacqpMoUHsohgFIRpAhoMTrEkzEyre/Kbzkz0tEZN/5
        81nk6gWQTqntF3a8zoigMnwB2ryqMMIMEIUqT3up3oyXKcvjq9Zm1AbLh62bS+9zumJ0v/
        tYFuh9oP0NVtIfmoLd2MeiYQhwwnZwR0CYW68d0XNjnGS5ONIeflod0oWi2CwQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637269352;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f489daoLpb001Hrar73jObLlk6tLubAuWDyMSkvTu8s=;
        b=S5PpW5dRUOpiK+Ek5SCV4xJyqQtiRo/GR18RIJ5VbfHBRab+tGCNNer2QExOcpaVF4Pwfp
        FutSnqaCpON6+yBA==
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     "H . Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] x86/tdx: Don't write CSTAR MSR on Intel
In-Reply-To: <20211116005103.2929441-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20211116005103.2929441-1-sathyanarayanan.kuppuswamy@linux.intel.com>
Date:   Thu, 18 Nov 2021 22:02:32 +0100
Message-ID: <878rxl41p3.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15 2021 at 16:51, Kuppuswamy Sathyanarayanan wrote:
>  
>  DEFINE_PER_CPU(unsigned long, cpu_current_top_of_stack) = TOP_OF_INIT_STACK;
>  
> +/* Don't write CSTAR MSR on Intel platforms */
> +void wrmsrl_cstar(unsigned long val)

static, no?

Thanks,

        tglx
