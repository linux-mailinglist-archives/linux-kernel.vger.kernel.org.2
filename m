Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12D3440B3FB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 17:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234896AbhINQAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 12:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232986AbhINQAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 12:00:35 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F95C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 08:59:18 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id x27so29881090lfu.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 08:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XpWi4volfcYSm2oFWphGxI70Xoc4gQDszmXfggbAPag=;
        b=bXLrDvRwiE9LUrsUdTaOb8qv3MpstEI39Z126QnyB2PTkNIRA+z5Ylw/tbECp2MHmV
         gX1JHV2JOFK1e1MJCTTlwV1kibUe3fFGD3LyBUKt18UoGfT0okDbQ+10t1fJme/j5P5U
         D2vgNrnv1RgcRafeCGUDJ8RsTcI/ITO4E3K7Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XpWi4volfcYSm2oFWphGxI70Xoc4gQDszmXfggbAPag=;
        b=Ni0pxraCdHc8/Lucom68EsX5DkECLs/JJm7YoriB1NaKhnkYY/HGzJcmrHcAj2M6cR
         4EzHHI/1Vs3uhFLu7Wp2bLTot+hpi0aeimRu8et+ttW1beWIRylVwGm/EZMXkSJyaDad
         NcTF1X+G15Tdo3BRoq/4IMHH0/C2Ty2l5ypFnSWiUSTsV7uC5JrR0PlompQReh+IHwN7
         g1bH7yAJMTCjhnK1tmvRbxAJGZaBoPxG/ueg8SUWvFBWgJ94HDREo3suPJ3u/otwfkID
         QREE/DSDNQ27kgU6LjtVM0uQILrQMxEXqNqre5PVaNeWuO0kZ7DGQHLDhbD9A7I8ijEx
         PO+Q==
X-Gm-Message-State: AOAM532Qid4V6Wof/BlMgdY6/EfYOXYyvfhpGiaCy7F9/QIpCC7cbiOX
        mEoIoMx35BJxjMdp9WF/kUqANmqwgU+KNEJYRCM=
X-Google-Smtp-Source: ABdhPJy5pDzsndBmLt6Q2GuPPJoMuOudrfo6FoHF6B6m7psfe4pbgDiP74St57elPHMWhW7DDNtijw==
X-Received: by 2002:a05:6512:3d94:: with SMTP id k20mr13667220lfv.260.1631635156175;
        Tue, 14 Sep 2021 08:59:16 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id f7sm565131lfv.96.2021.09.14.08.59.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Sep 2021 08:59:14 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id s3so24825874ljp.11
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 08:59:14 -0700 (PDT)
X-Received: by 2002:a2e:8107:: with SMTP id d7mr16501365ljg.68.1631635154125;
 Tue, 14 Sep 2021 08:59:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210914121036.3975026-1-ardb@kernel.org> <20210914121036.3975026-6-ardb@kernel.org>
 <CAHk-=whLEofPLzzTKXN5etnH5WqsTPQRLVv8uQgHnx7c59omBg@mail.gmail.com> <CAMj1kXH_Q4a4Gsi0Xuw=YsV-b7Mu8TQndk3Ei-JFaRV=GSiqUQ@mail.gmail.com>
In-Reply-To: <CAMj1kXH_Q4a4Gsi0Xuw=YsV-b7Mu8TQndk3Ei-JFaRV=GSiqUQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 14 Sep 2021 08:58:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiaVLChOjJ=7fdoQXKE4JHb98MjDtg8pPkA8EYfd5aj3g@mail.gmail.com>
Message-ID: <CAHk-=wiaVLChOjJ=7fdoQXKE4JHb98MjDtg8pPkA8EYfd5aj3g@mail.gmail.com>
Subject: Re: [RFC PATCH 5/8] sched: move CPU field back into thread_info if THREAD_INFO_IN_TASK=y
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Keith Packard <keithpac@amazon.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Mackerras <paulus@samba.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-s390 <linux-s390@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 8:53 AM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> task_cpu() takes a 'const struct task_struct *', whereas
> task_thread_info() takes a 'struct task_struct *'.

Oh, annoying, but that's easily fixed. Just make that

   static inline struct thread_info *task_thread_info(struct
task_struct *task) ..

be a simple

  #define task_thread_info(tsk) (&(tsk)->thread_info)

instead. That actually then matches the !THREAD_INFO_IN_TASK case anyway.

Make the commit comment be about how that fixes the type problem.

Because while in many cases inline functions are superior to macros,
it clearly isn't the case in this case.

              Linus
