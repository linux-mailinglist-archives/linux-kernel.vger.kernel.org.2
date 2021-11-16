Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED284530F8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 12:39:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235197AbhKPLkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 06:40:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235339AbhKPLj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 06:39:58 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B8BC06122B
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 03:35:31 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id z10so59867836edc.11
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 03:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sVHxj0XGH99gC44c3Vz1S9knGo46qZv6E2spfNUHe5g=;
        b=mX7HCEqkuQCtuWj3YNzIsTotX6VEXPODHRv3JvBKJ789nM95iRfySXWemNh86YTByH
         ZAl99+t3uxpmY3Grtg5K9KZic5bPZ1o5jNR5dimec82aegTV4Mi4SP3/D7Qyt07HaKEF
         IJum8Fdq1hkrNU7gzgeQJ51e1/xSFK4uCqNuAvPLIxS7TJevgTB0n30CG4cu5Cxdk+A1
         02OTbxR3k315wRUnrcdeFjcQKGIL8eH5Jq+1Jnda6L7Z5BinqZMC3CO6Tm75EFiZeExG
         K1TIHHjcdDddczxE3/KmPTj6OgaoIF7sTPjwl1V3jDD8c7/CE34FrXVLRVUD4pUhY3VD
         YL/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sVHxj0XGH99gC44c3Vz1S9knGo46qZv6E2spfNUHe5g=;
        b=TPrrmU27isWC/abTPjxvZd4VxXxCD2+hzIPKamXuax9JeZCt5RtIEn0OFChYXdyJgZ
         MG8ajbfegYxmcdJask0SxaWFVXWeOjG4JQlXeLSkjeVlZOtk9yfC6DhC1uj/1BVBWTUG
         cMhJuO78svTRxz9u4ptMZdPjZrfDudxssUCPTe0FXIL56f5uSa4WglKu4aKREFPNeiYX
         mH0nS3plqifxuVf7omsNV3l+gE+xsApc6OkUFM0gfN6vcKU4eMweKHaAzML8fJ2AKtHR
         pgCdAxGLwCwzKc70qxCp4HVcU6nZTg1uVmgqnn6wDhyiLok9fUbSaSVCJN89NSKFvGCR
         mGlA==
X-Gm-Message-State: AOAM530/nNAa/RnFxJ/XrdxLf1mSTtnpPLkmDWkDWNBy9+XrQ/9a5W7+
        J8jeEa5346hqGA9wRxUa4eU=
X-Google-Smtp-Source: ABdhPJzc1JhFgKO6ETSBOQkgEtW7aBp3BZaymEYpHi/drLiMrSZCyiBwtcIVTFmI3X5p6vHeyHwGAg==
X-Received: by 2002:a50:e683:: with SMTP id z3mr9481637edm.206.1637062530030;
        Tue, 16 Nov 2021 03:35:30 -0800 (PST)
Received: from localhost.localdomain (host-82-61-38-115.retail.telecomitalia.it. [82.61.38.115])
        by smtp.gmail.com with ESMTPSA id sd28sm8793071ejc.37.2021.11.16.03.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 03:35:29 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Marco Elver <elver@google.com>
Cc:     syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+5f47a8cea6a12b77a876@syzkaller.appspotmail.com>,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [syzbot] BUG: sleeping function called from invalid context in __might_resched
Date:   Tue, 16 Nov 2021 12:35:27 +0100
Message-ID: <5073833.kmqaQDgJIs@localhost.localdomain>
In-Reply-To: <CANpmjNMNC=3FiBB0aVVP9LXA9-03ug-sE4CqgJu2-sjdxA14TQ@mail.gmail.com>
References: <0000000000003efce905d0b135e6@google.com> <10635720.r0gBeNIlcX@localhost.localdomain> <CANpmjNMNC=3FiBB0aVVP9LXA9-03ug-sE4CqgJu2-sjdxA14TQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, November 16, 2021 11:24:54 AM CET Marco Elver wrote:
> On Tue, 16 Nov 2021 at 08:57, Fabio M. De Francesco
> <fmdefrancesco@gmail.com> wrote:
> [...]
> > I think that this is more readable and comprehensible.
> >
> > Therefore, if I'm not wrong, Marco's "!preemptible()", that is "if (!
> > (preempt_count() == 0 && !irqs_disabled())", might be rewritten to an 
easier
> > to understand "if (preempt_count() || irqs_disabled())".
> >
> > Am I wrong? Let's test it...
> 
> It's right, but why not use preemptible()? The definition of
> preemptible() might change and then you'd have to fix the code again.
> 
> I actually find (preempt_count() || irqs_disabled()) tells me less of
> what your intent here is vs. just writing !preemptible().
> 
You are right :)

If we have a macro, there must be a good reason behind its existence. So 
let's use it. 

For I didn't know that we have that macro, I had to read its definition. Then 
I had to understand what means the negation of its parts. It was a bit 
difficult to understand, so I thought that open coding if we have preemption 
disabled or irqs disabled was easier to understand.

But now I see that, as said, if we have an API we should use it.

I'm preparing a patch and give you proper credit for suggestions.

Thanks,

Fabio M. De Francesco




