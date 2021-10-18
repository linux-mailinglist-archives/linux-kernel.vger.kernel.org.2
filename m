Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66E29432799
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 21:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233476AbhJRTb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 15:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232912AbhJRTb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 15:31:57 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B20C06161C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 12:29:46 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id i5so5747103pla.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 12:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jlMjHH9ZyRt1lbAIXPIOIwmBboNqtkcsdkyJm3CwP0g=;
        b=FlCcuGKUI+QvIxJfaPqinuTV7eFDawzVP8cd9KFoRlL8XMrhwTtuT405Ee7qEGR+1r
         /mXoh/DOntt5K8XRuapAaMURf3SFJcRUuOly8z8w0beS34eW1t84r9CVt1OMwo5jlchn
         hyOyn+1W9//u7Amxxrz27HpYOYXzPFnwMtIWw08onxiRqL/4miehPxBAw1SnZ9g1lf1Y
         Azz31XEUT6Y4OjYo3TbjuV7igVQ7JJcM2GYCbOTCd+4lB9VKSWbQYHtwV4JcOYxBD4lR
         a9Dmsl4n91OBwdRkoMuUJfQ9jvKcIE35n+wrbuDxSgubvpUzCJrjtpa4Td5q3yhVs37+
         kj9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jlMjHH9ZyRt1lbAIXPIOIwmBboNqtkcsdkyJm3CwP0g=;
        b=cvAYpBco7rxx2WkYKsa9wdlU3x693ttGugiW7UH6L+4O1o2QBp0uq2X5NGWRPYOF1s
         eQdcFF5c19w8gP4xGI+yP2Qarj+yHJnN7Vl2r699xTOQPr7ZcXIH63rg8cNzWOLRFw4C
         nMoV5sCgKp2bjcDfX8CHWs5dK9QLSwanYUuSpb33/Qx2PmJak3Z+RZQzg1V/eSWPc37I
         lXNH3Nr9VhongVkUuZAyTWQCj5qV827k376ssL/4HwifmpQZ44APrQja9ulrFPqmstxt
         +2qe1tBDV1LD0Mg8aDxkRZmavUfqtEZzsf25Y7i6itSF1sXZjrNbv37lyjM9sa9FZPOZ
         kQ5w==
X-Gm-Message-State: AOAM532YEQIehaQfvC1mjlMzPnWZns4MjvEpLDpzdeQQeLx6eCr33bpw
        CnhkSWpjeLKuWaQfxRWVwT44jg==
X-Google-Smtp-Source: ABdhPJx/C9Lh++rHhXh2MUm0svRR63Gt4WkhG67SgoSgS4M5TYF8WJOyOwJoRh8c/drFx7nzCWe8SA==
X-Received: by 2002:a17:90a:de8f:: with SMTP id n15mr923484pjv.155.1634585385374;
        Mon, 18 Oct 2021 12:29:45 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id t4sm14771048pfj.13.2021.10.18.12.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 12:29:44 -0700 (PDT)
Date:   Mon, 18 Oct 2021 19:29:41 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Jane Malalane <jane.malalane@citrix.com>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Pu Wen <puwen@hygon.cn>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Yazen Ghannam <Yazen.Ghannam@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Andy Lutomirski <luto@kernel.org>,
        Kim Phillips <kim.phillips@amd.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2] x86/cpu: Fix migration safety with X86_BUG_NULL_SEL
Message-ID: <YW3LJdztZom+xQHv@google.com>
References: <20211013142230.10129-1-jane.malalane@citrix.com>
 <YW25x7AYiM1f1HQA@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YW25x7AYiM1f1HQA@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 18, 2021, Borislav Petkov wrote:
> On Wed, Oct 13, 2021 at 03:22:30PM +0100, Jane Malalane wrote:
> Totally untested of course.
> 
> static void early_probe_null_seg_clearing_base(struct cpuinfo_x86 *c)
> {
> 	/*
> 	 * A hypervisor may sythesize the bit, but may also hide it
> 	 * for migration safety, so do not probe for model-specific
> 	 * behaviour when virtualised.
> 	 */
> 	if (cpu_has(c, X86_FEATURE_HYPERVISOR))

This isn't correct.  When running as a guest, the intended behavior is to fully
trust the CPUID.0x80000021 bit.  If bit 6 is set, yay, the hypervisor has told
the kernel that it will only ever run on hardware without the bug.  If bit 6 is
clear and HYPERVISOR is true, then the FMS crud can't be trusted because the
kernel _may_ run on affected hardware in the future even if the current underlying
hardware is not affected.

> 		return;
> 
> 	/* Zen3 CPUs advertise Null Selector Clears Base in CPUID. */
> 	if (c->extended_cpuid_level >= 0x80000021 && cpuid_eax(0x80000021) & BIT(6))
> 		return;
> 
> 	/* Zen2 CPUs also have this behaviour, but no CPUID bit. */
> 	if (c->x86 == 0x17 && check_null_seg_clears_base(c))
> 		return;
> 
> 	/* All the remaining ones are affected */
> 	set_cpu_bug(c, X86_BUG_NULL_SEG);
> }

...

> > @@ -1457,8 +1457,6 @@ static void generic_identify(struct cpuinfo_x86 *c)
> >  
> >  	get_model_name(c); /* Default name */
> >  
> > -	detect_null_seg_behavior(c);
> > -
> >  	/*
> >  	 * ESPFIX is a strange bug.  All real CPUs have it.  Paravirt
> >  	 * systems that run Linux at CPL > 0 may or may not have the
> 
> So this function is called on all x86 CPUs. Are you sure others besides
> AMD and Hygon do not have the same issue?
> 
> IOW, I wouldn't remove that call here.

I agree.  If the argument for this patch is that the kernel can be migrated to
older hardware, then it stands to reason that the kernel could also be migrated
to a different CPU vendor entirely.  E.g. start on Intel, migrate to Zen1, kaboom.
