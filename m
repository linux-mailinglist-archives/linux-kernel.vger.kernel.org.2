Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE6F1423C84
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 13:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238312AbhJFLVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 07:21:03 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57650 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238250AbhJFLUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 07:20:52 -0400
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633519137;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Nfru5uqoTnzSuTiXySgqoBLcvKflP0dVDT0PBmrod4Y=;
        b=tMLzPJIfGLkgX548yv4JgyAr2Rj0xt2XR0NEv7A3tLV8qpPuI7GUFvuVTAwCeq20vuybJt
        OAP+CUWZxzX0xkVsda62VZQoX/LjlC+RAlHotC53DRuFiOcmJFOdShrIdlLoYcgD5arwPt
        e+dwx0r7UQZa97pujp41IS8eY1GSlzEc7U/C5RJyHOW/xiOYus5T0OKmMxPFEY/4FvlmAm
        kVd296d9CB8fsJffUn3fHL5yKEfw9+Ichs0UAk+b8ASdk5fiOMDIxXrbUXe+doyxysk2B1
        RwdRMD0tXmXoIf07ah1DYykXgApPZQOgsJtVCyi74pDFR1aWGnkjInCH3gfCfQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633519137;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Nfru5uqoTnzSuTiXySgqoBLcvKflP0dVDT0PBmrod4Y=;
        b=Xf3pI7uUbDxwKfO1NYkmpuBH+8RTF1jofewToD4l/2umnIO6CHoBATz4brtkDaQWmOHHzO
        M1gL1JYbe5VfvkCw==
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2 0/4] irq_work: PREEMPT_RT bits
Date:   Wed,  6 Oct 2021 13:18:48 +0200
Message-Id: <20211006111852.1514359-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is v2 of the series. v1 can be found at
   https://lkml.kernel.org/20210927211919.310855-1-bigeasy@linutronix.de

Changelog:
v1=E2=80=A6v2:
  - Drop "irq_work: Ensure that irq_work runs in in-IRQ context". This
    triggers if a CPU goes down.

  - #3 now uses per-CPU threads with the lowest RT priority instead of
    the timer softirq.

This are the PREEMPT_RT bits for irq_work. The annotation for
IRQ_WORK_HARD_IRQ was already merged except for one missed annotation.
Patch #3 introduces the required processing split of callbacks with are
really invoked from hard-irq context and those which are processed in a
per-CPU thread. Unless "LAZY" the thread is woken from the irq_work
hardirq.

This has been done as quite a few them acquire locks which need to sleep
on PREEMPT_RT and must not be invoked in hardirq context. We can not
delay all of them since a few need to be invoked hardirq context in
order to work properly (NOHZ, scheduler, =E2=80=A6).

Sebastian


