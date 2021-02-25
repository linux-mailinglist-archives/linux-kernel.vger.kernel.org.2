Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00E0732587D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 22:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbhBYVRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 16:17:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbhBYVRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 16:17:18 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C401C061574
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 13:16:38 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id o22so5618535pjs.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 13:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=L+15buzFSO+wmGF8wIGRELylp1Ige8/Z4b20PdJ1kvs=;
        b=XkCtrdURkT7J2cFFwlt1wxUTETBNr4vHEthI99Kg8cHTvz+Y5s7A2S/l+YzmOE6mlE
         /CMw3kpQlv4LtVsFOLUnuiPsVWCujSRUo5UZGHYszaGKyuvk8ZWh+y7MY5/rtIOj825Z
         8VIqp2rH/xDDyVxTV7UESCQfmgU0uc9w/+qrvzGDhVXIz+Ykj8ZHQ6p/22qe2a5n49sX
         u4nxTVyUIwPjSWkxWN5evIu9+RsFoZYvTX5D452kfXm1qNbHfGhS42xvkvPxsFEDUubw
         DOMcsVx0Yy3GyfrqAWk4/ntKrRR2FlQzRcUfAJI496SVT803nENuSxzl0YGhJGizdWfz
         uWTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=L+15buzFSO+wmGF8wIGRELylp1Ige8/Z4b20PdJ1kvs=;
        b=T3CFCEhjxmTH5q+rr5jhuOkmpPv0GixLSRhcHYB736G+9dDwKp4R3tJBXd67y+W8Tm
         NYft5RhvUW0Oh/PUANzqa7fCr37UgiROqfyDkZrl6RuKXZhV3pzS41mvE6EUfQS642cN
         1dZxtXhUfXZXffXW4jwYwZjN/ypvNxEy9+1EVy/X8lhryLCiQ+/d7Nf+z4uMWeM0ZXms
         dAuAWdAdp2dCkKhllHCIU65lgie5DVaH5wpnEhkzQILKDPeJdDsdURzv8vm1xBzUMjzd
         8BadRaUFyQUQmEDCTEZCtV4hcM10PNyrzu2gB0mcY0+GCC/FsE1GwyGOqfL+j48NE8Vm
         JjZQ==
X-Gm-Message-State: AOAM530178oVtL/PKkCurTbade2WNftFSXR6KmDJDv/VvL4b2uaC4pBO
        llxeHUQuysc/5ftHTGdvWZZSUsId5GSWkg==
X-Google-Smtp-Source: ABdhPJy9GrNM8xIUtij9FqzPAlyjFhjJVErTEtF3Rr5zRg8baB7A45kasmYHyhC7TIEcZJhXTiHfXA==
X-Received: by 2002:a17:90a:694c:: with SMTP id j12mr317875pjm.176.1614287797549;
        Thu, 25 Feb 2021 13:16:37 -0800 (PST)
Received: from google.com ([2620:15c:f:10:34c4:7c1d:f9ba:4576])
        by smtp.gmail.com with ESMTPSA id c6sm7488114pfc.94.2021.02.25.13.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 13:16:36 -0800 (PST)
Date:   Thu, 25 Feb 2021 13:16:30 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Hugh Dickins <hughd@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Nadav Amit <namit@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org
Subject: Re: [RFC 1/6] vdso/extable: fix calculation of base
Message-ID: <YDgTrqNDk+vPF9LA@google.com>
References: <20210225072910.2811795-1-namit@vmware.com>
 <20210225072910.2811795-2-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210225072910.2811795-2-namit@vmware.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 24, 2021, Nadav Amit wrote:
> From: Nadav Amit <namit@vmware.com>
> 
> Apparently, the assembly considers __ex_table as the location when the
> pushsection directive was issued. Therefore when there is more than a
> single entry in the vDSO exception table, the calculations of the base
> and fixup are wrong.
> 
> Fix the calculations of the expected fault IP and new IP by adjusting
> the base after each entry.
> 
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Sean Christopherson <seanjc@google.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: x86@kernel.org
> Signed-off-by: Nadav Amit <namit@vmware.com>
> ---
>  arch/x86/entry/vdso/extable.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/entry/vdso/extable.c b/arch/x86/entry/vdso/extable.c
> index afcf5b65beef..c81e78636220 100644
> --- a/arch/x86/entry/vdso/extable.c
> +++ b/arch/x86/entry/vdso/extable.c
> @@ -32,7 +32,7 @@ bool fixup_vdso_exception(struct pt_regs *regs, int trapnr,
>  	nr_entries = image->extable_len / (sizeof(*extable));
>  	extable = image->extable;
>  
> -	for (i = 0; i < nr_entries; i++) {
> +	for (i = 0; i < nr_entries; i++, base += sizeof(*extable)) {

It's been literally years since I wrote this code, but I distinctly remember the
addresses being relative to the base.  I also remember testing multiple entries,
but again, that was a long time ago.

Assuming things have changed, or I was flat out wrong, the comment above the
macro magic should also be updated.

/*
 * Inject exception fixup for vDSO code.  Unlike normal exception fixup,
 * vDSO uses a dedicated handler the addresses are relative to the overall
 * exception table, not each individual entry.
 */

>  		if (regs->ip == base + extable[i].insn) {
>  			regs->ip = base + extable[i].fixup;
>  			regs->di = trapnr;
> -- 
> 2.25.1
> 
