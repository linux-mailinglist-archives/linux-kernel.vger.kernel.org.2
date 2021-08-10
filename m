Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 013E23E577D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 11:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239305AbhHJJu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 05:50:59 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42156 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232880AbhHJJu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 05:50:57 -0400
Date:   Tue, 10 Aug 2021 11:50:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628589033;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iPMDSiID6HyjOwNCoieXyRQuimu3kmDXsXQXePe21EA=;
        b=L61skdOOHuxS+n1EgWhmZd0FQ8m1evWvHskeQrIEK46cdfK0o0iL+4mwSidMAo1rivQSfN
        4aPeg0+1uykI8ruzHijioSWcinL1KuHLUKrLChHEYAAvrDjg3qpKsA0IY8FUVFVU1ADkt5
        IB2338KYqGoyMni/E+tv2aBxkVyM4ZBZzA3Nm2KpI7rRAadhXXSz+WYIMVcbDpLXAfvqaM
        3SVJ9JwqYvDwV2cIABevrLDlHpqCNnhlX35JslMzLUZCl0QWqUqjx65jAkwxczFxYQLrNt
        EqiGeO48efTkawogNyTYVkk6fZsQIq7P6TVd7ppcvl89S4CYap9NhmO0xgEGsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628589033;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iPMDSiID6HyjOwNCoieXyRQuimu3kmDXsXQXePe21EA=;
        b=KY/MVKsZWQ0TD5d+8XmFYD2fCQzmUA8aG7KAHgxF6OYPZCJa7cFmg7GrT3o6IGTPqA0mkF
        szISeCjS3QM64nDQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Clark Williams <williams@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH PREEMPT_RT] kcov:  fix locking splat from
 kcov_remote_start()
Message-ID: <20210810095032.epdhivjifjlmbhp5@linutronix.de>
References: <20210809155909.333073de@theseus.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210809155909.333073de@theseus.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-08-09 15:59:09 [-0500], Clark Williams wrote:
> Saw the following splat on 5.14-rc4-rt5 with:
=E2=80=A6
> Change kcov_remote_lock from regular spinlock_t to raw_spinlock_t so that
> we don't get "sleeping function called from invalid context" on PREEMPT_R=
T kernel.

I'm not entirely happy with that:
- kcov_remote_start() decouples spin_lock_irq() and does local_irq_save()
  + spin_lock() which shouldn't be done as per
      Documentation/locking/locktypes.rst
  I would prefer to see the local_irq_save() replaced by
  local_lock_irqsave() so we get a context on what is going on.

- kcov_remote_reset() has a kfree() with that irq-off lock acquired.

- kcov_remote_add() has a kmalloc() and is invoked with that irq-off
  lock acquired.

- kcov_remote_area_put() uses INIT_LIST_HEAD() for no reason (just
  happen to notice).

- kcov_remote_stop() does local_irq_save() + spin_lock(&kcov->lock);.
  This should also create a splat.

- With lock kcov_remote_lock acquired there is a possible
  hash_for_each_safe() and list_for_each() iteration. I don't know what
  the limits are here but with a raw_spinlock_t it will contribute to
  the maximal latency.=20

> Signed-off-by: Clark Williams <williams@redhat.com>

Sebastian
