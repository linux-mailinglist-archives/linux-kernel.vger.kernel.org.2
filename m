Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48C283065E1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 22:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234073AbhA0VVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 16:21:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233903AbhA0VVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 16:21:32 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3289C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 13:20:51 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id p72so3363026iod.12
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 13:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wQExotaT8kbEKgow6n+XjSX7Qtx44wh+aWeRBfCx438=;
        b=etyD3xNqgzOyLU1iYt1n6lFGISMJGZ3g7VnbQ8ldeg0n5LqaCSCcMjrwep9C8QBYRX
         CPz/CDuT+zQYPo+dNQIjTkAT6gt1b0tDGAudMnn1W3FUdaa0vnIwX0Z7wJiHdx3DHNcH
         hZ7ffnU+2sojKfwwHJAXjO9dKSqS/qdcCh0YXYjBTLmppyrypO7mR5cM0ZC+ZmwftbKJ
         LvslqputCu5aWQWOtOdXtMdApyhflTR+y9tBryCBdABucJPZ8qqhG2z1Pinhh6+79/jW
         ecdybUGfeR/5FX2ZTLxg01HCQxyyJH5XtY9/3tIWDRX29HOS4qKJFEd/NehNykcRR2jD
         CRnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wQExotaT8kbEKgow6n+XjSX7Qtx44wh+aWeRBfCx438=;
        b=EmYJS9XnI/PAWbCggvdstrEtYjvAvDH2zthvZqple67XuvK9kPpYmjfm+X4K7rWyaD
         3pb+BWcON2kLjBFUR/7hCEb3CJBJYNdHuv4QFrsq1t3ALQnI01XofXeMjeQh8Q+t5shR
         vixW9wnHx1B5YcTWWI2aLZYXhMm20o+Bv0Kdm1VZPgwk6Kv2imuB8BuCRL9XcS/I2yZm
         gIuTgKGzb4G3dWHPDZM5qNLXvKn2Xb+OvhJxEsUtOAXfKDILh+xccQiDOGHvijBCBhsk
         85DgPXhLmxqrVp666u3ZXMaF+xgP2Y7vW7cIpg6YdNwRjYq4SnF9gJ/CBaEFg6DSgOT8
         nOjg==
X-Gm-Message-State: AOAM533nUv4l5fZWNgG8MiUIyP9PzKLrw7EpyvspsNW026UrB6rybvGV
        MFY/62Phkx48yiycKOI5ZnJXUkgItWm1wiZd+IinyA==
X-Google-Smtp-Source: ABdhPJx8ShodjHeKW72tIIjARjJmmEZaqdHZL90OYpJ3Hwk5EVpiMJ7jycEksnhje3fnDAtBkBwRAMD5jW2uathQeW0=
X-Received: by 2002:a02:ca17:: with SMTP id i23mr10394051jak.25.1611782451087;
 Wed, 27 Jan 2021 13:20:51 -0800 (PST)
MIME-Version: 1.0
References: <20210112181041.356734-1-bgardon@google.com> <20210112181041.356734-16-bgardon@google.com>
 <YAjIddUuw/SZ+7ut@google.com> <460d38b9-d920-9339-1293-5900d242db37@redhat.com>
 <CANgfPd_WvXP=mOnxFR8BY=WnbR5Gn8RpK7aR_mOrdDiCh4VEeQ@mail.gmail.com>
 <fae0e326-cfd4-bf5d-97b5-ae632fb2de34@redhat.com> <CANgfPd_TOpc_cinPwAyH-0WajRM1nZvn9q6s70jno5LFf2vsdQ@mail.gmail.com>
 <f1ef3118-2a8e-4bf2-b3b0-60ac4947e106@redhat.com> <CANgfPd9FaPhQiEkJ=VHKiVWZ_5S3k2uWHU+ViCi4nEF=GU4qsw@mail.gmail.com>
 <4c0d4c30-a95b-7954-d344-fb991270f79a@redhat.com>
In-Reply-To: <4c0d4c30-a95b-7954-d344-fb991270f79a@redhat.com>
From:   Ben Gardon <bgardon@google.com>
Date:   Wed, 27 Jan 2021 13:20:39 -0800
Message-ID: <CANgfPd9torZ_ta7eoB6OwZa3M-LCqU+8802wfWiWDFLio2-Ysg@mail.gmail.com>
Subject: Re: [PATCH 15/24] kvm: mmu: Wrap mmu_lock cond_resched and needbreak
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Peter Xu <peterx@redhat.com>, Peter Shier <pshier@google.com>,
        Peter Feiner <pfeiner@google.com>,
        Junaid Shahid <junaids@google.com>,
        Jim Mattson <jmattson@google.com>,
        Yulei Zhang <yulei.kernel@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 12:55 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 27/01/21 21:08, Ben Gardon wrote:
> > I'm not entirely sure I understand this suggestion. Are you suggesting
> > we'd have the spinlock and rwlock in a union in struct kvm but then
> > use a static define to choose which one is used by other functions? It
> > seems like if we're using static defines the union doesn't add value.
>
> Of course you're right.  You'd just place the #ifdef in the struct kvm
> definition.

Ah okay, thanks for clarifying.

>
> You can place static inline functions for lock/unlock in
> virt/kvm/mmu_lock.h, in order to avoid a proliferation of #ifdefs.

Would you prefer to make that change in this series or at a later
date? I'm assuming this would replace all the wrapper functions and
mean that x86 is rwlock only.

>
> Paolo
>
