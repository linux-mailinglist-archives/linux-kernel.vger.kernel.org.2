Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE923FCAB1
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 17:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239070AbhHaPVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 11:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236959AbhHaPVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 11:21:50 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA185C061760
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 08:20:55 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id g66-20020a9d12c8000000b0051aeba607f1so23213919otg.11
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 08:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1zIJvJx7aKPHA9dq+1gklt6UHbhg1saYHpxhNeageN0=;
        b=OLo5kXmfJqgx3LkOYhuEwMs+FvUTre1urLHM/OgdjbHJVVqQMqrRbqy3HNaS4YjBCE
         KZNyifnwS5ZSXf8AaZ3yZcAli5vw2YwXLOpz32nc5PgswZ+mhCbHxQ/8paIU8VoeQ2//
         YK9wSE7IwWIhV6gcxE32USMwupbp7R5+TnN5f19LyJQaf588t4DcLo0wxxzyaD9djPBT
         O1+LXUm6v5lu2jFX3ffCihLnu+WBTxBd4kVNun876Go/rEFtVbShNR5yBljBQUiBv82S
         I3jzWR11Rb5dQ+R7sEllnaPqjTF/bQRhswja2LPYlMNv4Zmt4XCN5PjJ3rGaBm76t5cW
         WE6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1zIJvJx7aKPHA9dq+1gklt6UHbhg1saYHpxhNeageN0=;
        b=jGb0d1yfaNQhgABX3GXSejLanVHeFQTPbVP6ZfuF8objdmOO3h5Wci54O9QPfJMz1V
         8YswAuJFZg6RSugaalyY0pDCK/uXu8kEd4YeqWZK+s1hxahMnvHCfEUfrYjvQvpjfUJg
         UoaDPmI5y3SpS7gMZWCyMJ26dqPXCrlYx8IIRnG1sc86nLHeZrU00TtVqsqSD6R7tJLF
         rvTULipOAlltkJ8TlZ95x5M4VMwxBHGjjmOq5iOTESM/OkV+xiUfQEN7wZiL/AhpiD8w
         ssqK2n0MS92NgABsnKTLiENxw5TcEjLhQ1Vykz7WEc9HSnDitqjG4+whJPKZJaOhkfQ5
         vR4A==
X-Gm-Message-State: AOAM530QDeEqUrAj4tt2qTq51lp4VCTSbYj3GpulS1QNjJa1wRz+3bjK
        BreY1QIBRLcm/vLIX99g8kMypS0ZT8hggNIg3pQDug==
X-Google-Smtp-Source: ABdhPJwBu1F4pWQkyX/ZsOV5967WUtqX/5Ty24AD+Zs7k0hEBVkXA91oyKbf607WpSP/L2bHCbHjfRnVblRoYKYGQYc=
X-Received: by 2002:a05:6830:353:: with SMTP id h19mr6609040ote.264.1630423254797;
 Tue, 31 Aug 2021 08:20:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210830212951.3541589-1-pgonda@google.com> <CAA03e5Fd2aes=euzXv51d6b3E0S3tK45hkqQhONsmWA5dE33dw@mail.gmail.com>
 <CAA03e5G9TEsmzbQw_m_Zh+Evdief0hgiuMmBGF40xctMAwjY2w@mail.gmail.com> <CAMkAt6r8X5XbhRSbfX5vfHn+F40Mp_Ou+qmtUqeDBCtTF1oTxg@mail.gmail.com>
In-Reply-To: <CAMkAt6r8X5XbhRSbfX5vfHn+F40Mp_Ou+qmtUqeDBCtTF1oTxg@mail.gmail.com>
From:   Marc Orr <marcorr@google.com>
Date:   Tue, 31 Aug 2021 08:20:43 -0700
Message-ID: <CAA03e5Fp2PeY162sL6YVn44an28RBNvbRRF4HLJ_vea9V69Ryg@mail.gmail.com>
Subject: Re: [PATCH 3/3 V6] selftest: KVM: Add intra host migration
To:     Peter Gonda <pgonda@google.com>
Cc:     kvm list <kvm@vger.kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > +
> > > > +       for (i = 0; i < 1000; ++i) {
> > > > +               j = input->source_fds[i % LOCK_TESTING_THREADS];
> > > > +               cap.args[0] = input->source_fds[j];
> > > > +               /*
> > > > +                * Call IOCTL directly without checking return code. We are
> > > > +                * simply trying to confirm there is no deadlock from userspace
> > > > +                * not check correctness of migration here.
> > > > +                */
> > > > +               ioctl(input->vm->fd, KVM_ENABLE_CAP, &cap);
> > >
> > > Should we use `vm_enable_cap()` here?
> > >
>
> I took all other suggestions but this one I just updated the comment.
> vm_enable_cap TEST_ASSERT()s if the ioctl fails. Since we are just
> randomly iterating through a bunch of ioclts we fail often so this
> would kill the test.

Gah, of course! My bad. Anyway, sounds good and thanks!
