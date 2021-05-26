Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B19CD391753
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 14:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233564AbhEZMa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 08:30:59 -0400
Received: from mail-ej1-f48.google.com ([209.85.218.48]:38805 "EHLO
        mail-ej1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232829AbhEZMa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 08:30:58 -0400
Received: by mail-ej1-f48.google.com with SMTP id ss26so1910157ejb.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 05:29:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sKSzw4CfWQSF/RHLjmRDXp9EILu+5BuT7fV/lIAA2+o=;
        b=qP6ONqk+LElsLcGFSHIqK7wruvskxbhsBZbhg0u3jiAQcZqlHV0Fa0V3BzBNXQN2hV
         /fIvUHKxqzLzPhYC3JI7EES2Dacr2BTLI5HIoaCIC42jhAB4t0KJZ/k0uW9HJs5N0Mi8
         TVZ/hdYbyTesXqDPcptBQ6CjNRBffVb8n/V0LakOcGaCf7azrjc3zTemLdlkfV1yGZ6E
         uEZPKWrEkEj9k+HPgciKL76rjaeX4wPqCGBO9ykIodanXlG4y18gVS6mbpjm9NSUGk60
         LJ6Hyb2MR+2Xa9ktwrBTfe1CghGPkhQPXBzAy5W5Ihhr9TLnig4BM0PKO8LmwIUxVlbo
         iC6w==
X-Gm-Message-State: AOAM530TiaQ36Dfuhrxwmk70RQg2gj1O/+CSsmCwzgCU0e7P37gIfVAi
        Ti8qqcYf2tp2qGXBQ8KadNKz30lxloSmiLlfG7I=
X-Google-Smtp-Source: ABdhPJySV9llz0Dul2qnlB0Di/o/8HImFsDUBbemjGGsd7Tsl9+mW+Tt3j7nM5H6/xkgRLoOddLZt8T413xMybU2trM=
X-Received: by 2002:a17:906:4789:: with SMTP id cw9mr34067174ejc.325.1622032165346;
 Wed, 26 May 2021 05:29:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210525140232.53872-1-mark.rutland@arm.com> <YK4xQ/BtB4rItRr1@hirez.programming.kicks-ass.net>
In-Reply-To: <YK4xQ/BtB4rItRr1@hirez.programming.kicks-ass.net>
From:   Junio C Hamano <gitster@pobox.com>
Date:   Wed, 26 May 2021 21:29:12 +0900
Message-ID: <CAPc5daVLg2jVEMW6eAZJQTK7YmMmReDNrNWPnLeX2nckbHhmfw@mail.gmail.com>
Subject: Re: [PATCH v2 00/33] locking/atomic: convert all architectures to ARCH_ATOMIC
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        will@kernel.org, boqun.feng@gmail.com, aou@eecs.berkeley.edu,
        arnd@arndb.de, bcain@codeaurora.org, benh@kernel.crashing.org,
        chris@zankel.net, dalias@libc.org, davem@davemloft.net,
        deanbo422@gmail.com, deller@gmx.de, geert@linux-m68k.org,
        gerg@linux-m68k.org, green.hu@gmail.com, guoren@kernel.org,
        ink@jurassic.park.msu.ru, James.Bottomley@hansenpartnership.com,
        jcmvbkbc@gmail.com, jonas@southpole.se, ley.foon.tan@intel.com,
        linux@armlinux.org.uk, mattst88@gmail.com, monstr@monstr.eu,
        mpe@ellerman.id.au, nickhu@andestech.com, palmerdabbelt@google.com,
        paulus@samba.org, paul.walmsley@sifive.com, rth@twiddle.net,
        shorne@gmail.com, stefan.kristiansson@saunalahti.fi,
        tsbogend@alpha.franken.de, vgupta@synopsys.com,
        ysato@users.sourceforge.jp
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, May 25, 2021 at 03:01:59PM +0100, Mark Rutland wrote:
> > Note: I've generated the patches with:
> >
> >   git format-patch -C -M -D
> >
> > ... so the preimage of include/linux/atomic-fallback.h is not included
> > in the diff when it is deleted.
> ...
> Junio; can we get something like the below sorted?

Funny, I recently looked at "git format-patch --help" and read that "-D"
is explicitly described as "The resulting patch is not meant to be applied
with patch or git apply; this is solely for people who want to just
concentrate on reviewing the text after the change."

So, no, I think it is anti-social to send such a patch generated with -D
unless it is purely for discussion. The side that generates the patch
should be told to drop "-D" when running the format-patch command,
or perhaps format-patch should be taught to error out when "-D" is
given, perhaps?
