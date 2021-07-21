Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 333853D09BB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 09:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234600AbhGUGt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 02:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235067AbhGUGrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 02:47:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F672C0613E9
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 00:25:35 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1626852333;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Iu8+bQKCo8fNCNG9lQPM1PkkNDG5So9x/kh82HBSRlM=;
        b=Bkpm9S2PbfJJh74tkCirVKMg+Sh+JsPXbVc/xBHOGltswQxUpTNB0bTYv3zmZkN2YOhowB
        nbYVottReMSEiT5KI17lWv8btg12+cEZhAOwM4SYwqO0hI+F0fCHMFPE0fjOiKJzDEg3JX
        iL1EQXoQU0rk5Tn8B+57eVDG9teriWiS4mBYsBI1rTSa1VdX3kkVDMQcFBdbmCcglodg1B
        qt72GUaLquMN6RiFFraO1t6Q0ot1wihdAFbVS2vH4hQwJMxU3H6J0Ynbtzq+nv9ij/dbEn
        n4aK6i5C8AZb9bbVCG+VkoeadMVokPOhGJxRc3kWykJmywDL2aN5dFdiRWVtvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1626852333;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Iu8+bQKCo8fNCNG9lQPM1PkkNDG5So9x/kh82HBSRlM=;
        b=nnQ2D9TRJGpZEPuOd1RjNTWxPdMR2VDZ0XaJKCPV+5C+OL/nRo/TQUWWcZHIR/+IVUg7LE
        RoP//CRDPGyHIwBw==
To:     Hillf Danton <hdanton@sina.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Michael S. Tsirkin" <mst@redhat.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: 5.13-rt1 + KVM = WARNING: at fs/eventfd.c:74 eventfd_signal()
In-Reply-To: <20210721070452.1008-1-hdanton@sina.com>
References: <df278db6-1fc0-3d42-9c0e-f5a085c6351e@redhat.com> <8dfc0ee9-b97a-8ca8-d057-31c8cad3f5b6@redhat.com> <f0254740-944d-201b-9a66-9db1fe480ca6@redhat.com> <475f84e2-78ee-1a24-ef57-b16c1f2651ed@redhat.com> <20210715102249.2205-1-hdanton@sina.com> <20210716020611.2288-1-hdanton@sina.com> <20210716075539.2376-1-hdanton@sina.com> <20210716093725.2438-1-hdanton@sina.com> <20210718124219.1521-1-hdanton@sina.com> <20210721070452.1008-1-hdanton@sina.com>
Date:   Wed, 21 Jul 2021 09:25:32 +0200
Message-ID: <87im14cemr.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 21 2021 at 15:04, Hillf Danton wrote:
>
> But the preempting waker can not make sense without the waiter who is bloody
> special. Why is it so in the first place? Or it is not at all but the race
> existing from Monday to Friday.

See the large comment in eventfd_poll().
