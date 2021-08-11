Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09C273E90F8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 14:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238859AbhHKM1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 08:27:38 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51266 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238566AbhHKMZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 08:25:53 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628684729;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9Fc7r61LCYAdoePXBxI4aA4CJKIy5jDNHM9L9gFB7dA=;
        b=eaojQdyePYuh2fjOmp9v44XjAja9d7cU7a75zQuTnBs2d6ob7dCsUfp9YB8VTHa/vWg+rg
        HmUggl9EU+mAeq0VamEjZn7Gbcisrw7QAgyMr0tOLCi0mbCkjD+lEYI+A/a9WPR8MVBVY7
        KWh0kytOv2SBYwXAHcZlyHQlg+1xFObnSZ7zi2+gw019y+ZLwLZGLBA2LbuPW3GdSh1Euq
        L3yMhmJgAZK0xkOkRObihMdjq4D5C6cVbiWqLCQPGbDIXu1gKjprGah/ziCSKMAi02u+Lh
        K69xQcIIwoTBE44SlhlgjdtJAsy580dqIn4ZSU/dqcoTE/an/msUvSvB5DNwdQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628684729;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9Fc7r61LCYAdoePXBxI4aA4CJKIy5jDNHM9L9gFB7dA=;
        b=GlohVzjUlTTzk5ErNHrzpKzTts7XWdgsp0gkXse0h6oRLUuabxhz7MH6HbAGKawF3mEDlp
        AcN/28GRBo0+IaBQ==
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Clark Williams <williams@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH PREEMPT_RT] kcov:  fix locking splat from
 kcov_remote_start()
In-Reply-To: <20210811090033.wijh4v37wlnny3ox@linutronix.de>
References: <20210809155909.333073de@theseus.lan>
 <20210810095032.epdhivjifjlmbhp5@linutronix.de> <87sfzhox15.ffs@tglx>
 <20210811090033.wijh4v37wlnny3ox@linutronix.de>
Date:   Wed, 11 Aug 2021 14:25:29 +0200
Message-ID: <87czqkp3ra.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11 2021 at 11:00, Sebastian Andrzej Siewior wrote:
> On 2021-08-10 22:38:30 [+0200], Thomas Gleixner wrote:
>> And that matters because? kcov has a massive overhead and with that
>> enabled you care as much about latencies as you do when running with
>> lockdep enabled.
>
> I wasn't aware of that. However, with that local_irq_save() ->
> local_lock_irqsave() swap and that first C code from
> Documentation/dev-tools/kcov.rst I don't see any spike in cyclictest's
> results. Maybe I'm not using it right=E2=80=A6

The problem starts with remote coverage AFAICT.
