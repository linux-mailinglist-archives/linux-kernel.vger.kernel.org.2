Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1A24310E6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 08:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbhJRG5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 02:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbhJRG5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 02:57:14 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A94EC06161C
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 23:55:03 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id f5so15104581pgc.12
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 23:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amikom.ac.id; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mT/fMOPvxF6dysjN3FyFsMhCYZUwHEaNpBaBjV3uy38=;
        b=U7ERsk2EZL2errwHrMdx7UmJnbU2NUPPjYfkpoNAzvyvml4yz8v83T9MLpq/t3PDLx
         ze0wHbP/zP64Cs83TPANHMUAitM6O54BTyUPwi9BbdNyW8bZtIPWUVmty0/pviXwBDCq
         A3aUynIXsE+4WW8ce3gY32r1o0EyyIhRxocC0XmJBTDy8Rt+qpAdGLN9UToVEvAQYXsV
         OTPpLFbRVQ3lomBmzrtk2LkbZUwfCVq1RhdkuymMhmjbEMLWL3ATnLuWmosSznlBzXSc
         cSK6mA53VouVYlvosvQnx0kkv5JShK7Q6HHlhyEE56L6fxs07ltjvP4ZX+5h4frZJjR1
         x8hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mT/fMOPvxF6dysjN3FyFsMhCYZUwHEaNpBaBjV3uy38=;
        b=YD0vTV5ss0acuN+hm4Ti2kEz+i2GR2lf/nH3bnmZU5r/NQeh/1NLyXFD5jeA2f4Tco
         wNt+CztGbXEiMo1ns2RNiKLrdQ2i0ZfQh0BAzp4iyv4dcvE1eZ8X8mkK9Z+iveD/x2xl
         fCx8x4qqS7z6YJ/dzGceSKjexL1TVqICRqLipEPOeUDuzWgBSicyVJKhTScMoSufurQ7
         tdtcHOsf34zQyA7cgBFCcI6T1z8U/HRd3Y1wzSBmC87QyY1dtjzbBreeYYCALm10ww3Q
         G2uvg8F3ozsdFA/fBISqexcfXsPyU1jTbrJ5DtwGtA8MjXP597fGlo0Nr0zUyQz2rfp7
         31NA==
X-Gm-Message-State: AOAM532hlimcuVW4VIUL3JPLmmlUwAs4c3iY1EbUrylyaHQJChj765y6
        fA1exXJ/rsJPjwBmSPfirp9O1yIux4b3NeAd
X-Google-Smtp-Source: ABdhPJzSVM4RJ8nYv+dP3l1mnjNDYYd+5mh0bGCIWej1KAQQFL78x06Juuub0w84jv5j21UGRZ/RQg==
X-Received: by 2002:a63:e651:: with SMTP id p17mr22051676pgj.66.1634540102764;
        Sun, 17 Oct 2021 23:55:02 -0700 (PDT)
Received: from integral.. ([182.2.39.79])
        by smtp.gmail.com with ESMTPSA id i124sm12263517pfc.153.2021.10.17.23.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Oct 2021 23:55:02 -0700 (PDT)
From:   Ammar Faizi <ammar.faizi@students.amikom.ac.id>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Ammar Faizi <ammar.faizi@students.amikom.ac.id>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Peter Cordes <peter@cordes.ca>,
        Bedirhan KURT <windowz414@gnuweeb.org>,
        Louvian Lyndal <louvianlyndal@gmail.com>
Subject: Re: [PATCH 2/2] tools/nolibc: x86-64: Fix startup code bug
Date:   Mon, 18 Oct 2021 13:53:29 +0700
Message-Id: <O2kEogG8Ln8uUQ-ammarfaizi2@gnuweeb.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211018045828.GA15329@1wt.eu>
References: <20211018045828.GA15329@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 18, 2021 at 11:59 AM Willy Tarreau <w@1wt.eu> wrote:
> > Extra fixes:
> >   - Use NR_exit_group instead of NR_exit.
>
> Please, this is independent on the fix above so it must be subject
> of a different patch with its own justification. Also it should cover
> all supported architectures, otherwise programs will start to behave
> differently on different targets.
>
> >   - Use `mov %eax,%edi` instead of `movzbq %al,%rdi`. This makes the
> >     exit code more observable from strace. While the exit code is
> >     only 8-bit, the kernel has taken care of that, so no need to
> >     worry about it.
>
> I'm fine with this one as well, but similarly, it should be in its own
> patch and applied to all architectures.
>
[...]
>
> I find the whole thing much less readable here, as asm code tends to
> be read as visual groups of patterns. I'm suggesting that you place a
> multi-line comment before the asm statement indicating the general
> rules (e.g. lowest stack frame must be zero, rsp+8 must be multiple of
> 16 etc), then only comment each instruction on the same line as it was
> before.

Got it, agree with that. I will address your review and resend this as a
patchset v2 soon.

-- 
Ammar Faizi
