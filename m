Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66EA13EED57
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 15:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237642AbhHQN2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 09:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236398AbhHQN2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 09:28:09 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4439BC061764
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 06:27:36 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id h63-20020a9d14450000b02904ce97efee36so24911726oth.7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 06:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zWHDjIJawTHtbmwaJcKwdk8W++TJIaWlzkrKoGu1IaU=;
        b=dg9OG94AdzJ4ptbnkm6zajAKdgcwQc2B/9ce5oIk4e+K8FFePWxsBRUsqCRBg9ObwY
         8eEBGk31gtAelYKTmqn7zwdMLiPyFJlTIEWhicjSVfQPCJ1vujuAckMuR9ySstax8RmT
         29499/yQ/kxDGEsOii0jh5PqYOf2tuA6HMva16Uc1LMweHD1+zN4U5sZo/6ftqFpx4Mf
         64HpgzLfqpZQtKnwLUJ5BfPSF+jDLsiXO9iB2gr0FVUMk/PqYKcc8c6manWMdq+7mTap
         LAVNHWRoKN55cZ5ZZM4qUfh/h5Y6SM/QbYPnOf26JQJwxYOmYQ+3LN5k2d4ljEKVjTOu
         fVCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zWHDjIJawTHtbmwaJcKwdk8W++TJIaWlzkrKoGu1IaU=;
        b=jIIEIwvskjE/0k+wIXq/lwSQ17IPmi7xeDpCD2Ay+n7bsRhox2qnvt8BOoUFcnkH9N
         wT6tn14wyXAh0KZ4tGCiGGEmk36kPObQKygwaNTc+9Xzu9Sfgx/cwZvaO2jmBIp4SPD+
         1fR45U4I4dqjCc61U548LMDTn1fdhbeg/940z8Tgl32F0k1+duaTRL2rC7C74N80OAhb
         2ZSCNni0SGmXJz2J3XSonm1C8OmDDG+bxSqHJC+lh0IdRaM9xSLmh6dkNq4GaCNNHR2E
         dyg3gEmG30mymKzMSenB+DOc1WLLAqU3OV4agrM3XRmnj/ewwjf5eLkjC1KqJ1hRUWJP
         v5pA==
X-Gm-Message-State: AOAM530RmERgaMeyHmWr3LJTQnfIw4E7gHuazOzs/WRMdVu64eDGhIuD
        rW/ACfaaXQ5pHFfdt5zJUHiv7iJMnuCBT8uHJPQFNA==
X-Google-Smtp-Source: ABdhPJzz5g18ioI6eWHzPZd89cVcbC2pdeXSEWQCiJC21pT2iy9zZifvMdhmcEKvVH0zmPV5E982UyIcLPqeIs00+Ag=
X-Received: by 2002:a9d:d04:: with SMTP id 4mr2775588oti.251.1629206855297;
 Tue, 17 Aug 2021 06:27:35 -0700 (PDT)
MIME-Version: 1.0
References: <YRo58c+JGOvec7tc@elver.google.com> <20210816145945.GB121345@rowland.harvard.edu>
 <YRqfJz/lpUaZpxq7@elver.google.com> <20210816192109.GC121345@rowland.harvard.edu>
 <20210816205057.GN4126399@paulmck-ThinkPad-P17-Gen-1> <20210817122816.GA12746@willie-the-truck>
In-Reply-To: <20210817122816.GA12746@willie-the-truck>
From:   Marco Elver <elver@google.com>
Date:   Tue, 17 Aug 2021 15:27:23 +0200
Message-ID: <CANpmjNMZxiyFbua2ck=0u7cJnHhtG4RY=Db=ry3COEED_sm7Xw@mail.gmail.com>
Subject: Re: LKMM: Read dependencies of writes ordered by dma_wmb()?
To:     Will Deacon <will@kernel.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Aug 2021 at 14:28, Will Deacon <will@kernel.org> wrote:
> Just on this bit...
>
> On Mon, Aug 16, 2021 at 01:50:57PM -0700, Paul E. McKenney wrote:
> > 5.    The dma_mb(), dma_rmb(), and dma_wmb() appear to be specific
> >       to ARMv8.
>
> These are useful on other architectures too! IIRC, they were added by x86 in
> the first place. They're designed to be used with dma_alloc_coherent()
> allocations where you're sharing something like a ring buffer with a device
> and they guarantee accesses won't be reordered before they become visible
> to the device. They _also_ provide the same ordering to other CPUs.

Ah, good you pointed it out again. Re-reading memory-barriers.txt and
it does also say these provide order for other CPUs...

> I gave a talk at LPC about some of this, which might help (or might make
> things worse...):
>
> https://www.youtube.com/watch?v=i6DayghhA8Q

Nice, thank you!

> Ignore the bits about mmiowb() as we got rid of that.
>
> Will
