Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3542741A147
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 23:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237268AbhI0VVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 17:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237154AbhI0VVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 17:21:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D66C061575
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 14:19:31 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632777570;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=d6kmTP0hjilOQCCTBr7UonHpnCkJykoJ2XrUl9DZstw=;
        b=4zNRnCVUMhU0y9pewkhTebkOpqwxAECvE0IjfDg2j+caGSlf3ly562CBOXJxdqkdfsXtCO
        yWubf5XChxN8ETPcarqVFTDqfzkou7ot9LdwZ7YO3Laiatj8myTJRLZwd1xfn496flVHBp
        SMFr+jl8pe4BZ912bwvxnBKRhMAza+jS3OMPFRIfbHFnK/584yXHTonlVqZhzRlUyC+7kJ
        8y1pNUqxRxmxG++O1IXJ4XA+sbtRAyTl7YUbO/DrXhcrtdsmuFfFDHBo6bOOd1/b4yXJQ7
        4tREOuCyFjGZOigFFV43E/dK/CdgTrDNoLkVjvvaseCNDpTMuwknCK2SbhUL7w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632777570;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=d6kmTP0hjilOQCCTBr7UonHpnCkJykoJ2XrUl9DZstw=;
        b=Q3uEmUvbu0t5djGPWIzAklW85OSg9z/8l57mFLj/H6Mwt5Isklco+xwoa/oLm4LS1xJND3
        50QE5l+Tp2+I3zDQ==
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 0/5] irq_work: PREEMPT_RT bits
Date:   Mon, 27 Sep 2021 23:19:14 +0200
Message-Id: <20210927211919.310855-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This are the PREEMPT_RT bits for irq_work. The annotation for
IRQ_WORK_HARD_IRQ was already merged except for one missed annotation.
Patch #4 introduces the required processing split of callbacks with are
really invoked from hard-irq context and those which are delayed until
the softirq timer tick. This has been done as quite a few them acquire
locks which need to sleep on PREEMPT_RT and must not be invoked in
hardirq context. We can not delay all of them since a few need to be
invoked hardirq context in order to work properly (NOHZ, scheduler, =E2=80=
=A6).

Sebastian


