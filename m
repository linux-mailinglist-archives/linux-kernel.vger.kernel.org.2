Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93E76414ECC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 19:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236735AbhIVRJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 13:09:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57828 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236676AbhIVRJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 13:09:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632330503;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vWqUMA4PsVlJ2pPT1/p24HsUIkcdO8iEjqhCU7s0cfo=;
        b=Wrz4nNLoEQOh28uxObgAxBPXU0+dZAdtSlT0JeCPuuZDFo3wBMXtnX69kOjrn91QLpoIeA
        MBlyet3Bo6CNOlq6XBJDXqsQY0fc+/5NT0Mk2Bc7cSPCPKtyU1e0uQFY/LqSaesC3Q1Mgd
        aOLJZwaNBV4mw+c2yD7F3T+VrWu6gm8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-483-sPe74zuNN2ut-SWlU0rlig-1; Wed, 22 Sep 2021 13:08:22 -0400
X-MC-Unique: sPe74zuNN2ut-SWlU0rlig-1
Received: by mail-wr1-f70.google.com with SMTP id v15-20020adff68f000000b0015df51efa18so2749810wrp.16
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 10:08:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=vWqUMA4PsVlJ2pPT1/p24HsUIkcdO8iEjqhCU7s0cfo=;
        b=Nyvpqrdmhcf1VgGFEVXIuZO1kH+ynNuQAeQBOfJ8nmTpcJnT5oFNveTPPGZ5zh4AEt
         UjcQsgPcCQtgyBNpXp/CYHilysQqXm95JMSGl8efaAQzL98X432hOl4fXefCBMxElgS3
         LzOduGxg88ofz0Virhwu60izlkZebQusjnNybKjn3uzuvdv7zZZWDLZo6Lqoh68tF8qw
         ncaT0qw67Q3tUngu3OEVAIbjIiMPx1MJNfxYX1/WAti3N/Z7VXIbLzJF/zkC8NH7F+4O
         SVNdY4b9nRQf3Y0Hy8Mn/0lcsQdj4Viza7hK1n/YoI1jmOJmEm2zurECtDdISwIm2MHL
         36Ig==
X-Gm-Message-State: AOAM533yWVjXjJYRRVaiFHy0RAATS4F0Sj2SdFojXYuSJ0yukmugT0gR
        I86V7nVPFblfyYSy7g6iLKDnVP25jXaSn0/6BH5HOMDu9eZfdq7jPp7+aKb7QRhsmUea+MUQ6IC
        kyiRDQfynaXqEZPRzT5UI7XEX
X-Received: by 2002:a5d:6545:: with SMTP id z5mr67132wrv.90.1632330499528;
        Wed, 22 Sep 2021 10:08:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzEoCMdETBf0ZFsulv49iZD/disD0Q/Hgy56XYmufPeu3oyo6LTtFACq/qEWxa6hE3xyuys2Q==
X-Received: by 2002:a5d:6545:: with SMTP id z5mr67076wrv.90.1632330499184;
        Wed, 22 Sep 2021 10:08:19 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-102-46.dyn.eolo.it. [146.241.102.46])
        by smtp.gmail.com with ESMTPSA id g22sm6079241wmp.39.2021.09.22.10.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 10:08:18 -0700 (PDT)
Message-ID: <4e6db6e09ed2baa536f2badf2798daf3591bbd5a.camel@redhat.com>
Subject: Re: [syzbot] possible deadlock in mptcp_close
From:   Paolo Abeni <pabeni@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        syzbot <syzbot+1dd53f7a89b299d59eaf@syzkaller.appspotmail.com>,
        davem@davemloft.net, edumazet@google.com, fw@strlen.de,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        mathew.j.martineau@linux.intel.com, matthieu.baerts@tessares.net,
        mptcp@lists.linux.dev, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        Peter Zijlstra <peterz@infradead.org>
Date:   Wed, 22 Sep 2021 19:07:56 +0200
In-Reply-To: <87zgs4habc.ffs@tglx>
References: <0000000000005183b005cc74779a@google.com> <87zgs4habc.ffs@tglx>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-09-22 at 17:57 +0200, Thomas Gleixner wrote:
> On Mon, Sep 20 2021 at 15:04, syzbot wrote:
> > The issue was bisected to:
> > 
> > commit 2dcb96bacce36021c2f3eaae0cef607b5bb71ede
> > Author: Thomas Gleixner <tglx@linutronix.de>
> > Date:   Sat Sep 18 12:42:35 2021 +0000
> > 
> >     net: core: Correct the sock::sk_lock.owned lockdep annotations
> 
> Shooting the messenger...
> 
> > MPTCP: kernel_bind error, err=-98
> > ============================================
> > WARNING: possible recursive locking detected
> > 5.15.0-rc1-syzkaller #0 Not tainted
> > --------------------------------------------
> > syz-executor998/6520 is trying to acquire lock:
> > ffff8880795718a0 (k-sk_lock-AF_INET){+.+.}-{0:0}, at: mptcp_close+0x267/0x7b0 net/mptcp/protocol.c:2738
> > 
> > but task is already holding lock:
> > ffff8880787c8c60 (k-sk_lock-AF_INET){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1612 [inline]
> > ffff8880787c8c60 (k-sk_lock-AF_INET){+.+.}-{0:0}, at: mptcp_close+0x23/0x7b0 net/mptcp/protocol.c:2720
> 
> So this is a lock nesting issue and looking at the stack trace this
> comes from:
> 
> >  lock_sock_fast+0x36/0x100 net/core/sock.c:3229
> 
> which does not support lockdep nesting. So from a lockdep POV this is
> recursive locking the same lock class. And it's the case I was worried
> about that lockdep testing never takes the slow path. The original
> lockdep annotation would have produced exactly the same splat in the
> slow path case.
> 
> So it's not a new problem. It's just visible by moving the lockdep
> annotations to a place where they actually can detect issues which were
> not reported before.
> 
> See also https://lore.kernel.org/lkml/874kacu248.ffs@tglx/
> 
> There are two ways to address this mptcp one:
> 
>   1) Teach lock_sock_fast() about lock nesting
> 
>   2) Use lock_sock_nested() in mptcp_close() as that should not be
>      really a hotpath. See patch below.

Thank you for looking into this! I agree this specific case is not
fastpath, so definitely the proposed patch LGTM.

I fear there could be other similar cases in the MPTCP code, in more
time critical paths, and perhaps there are other relevant use-case, so
I'd like to experiment too with a lock_sock_fast_nested() variant - if
I find enough coffee ;)

Thanks,

Paolo

