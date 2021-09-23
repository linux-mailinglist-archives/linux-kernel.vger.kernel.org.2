Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61672416394
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 18:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242057AbhIWQtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 12:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231564AbhIWQtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 12:49:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D86C061574
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 09:47:50 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632415668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=y0wDMkgnV956fboXQ4HXhkXy5kQoth5WK1arjbx0f5k=;
        b=nBMrVpde8b9oYffgSzl+RBZiizAy+zhael4TT8SUCsPkVbB/uQdt4qSWPl+g7LvE8KZAjv
        AGlPGvwB8W87ZGxprAU5x4p4fLATPZ4g8BPIht+IOPIiyiS65PR4EsiEWmKIykm1ziH8hs
        P2D53EfYmb+N506CRei+MW3VpyKljawFkMHB4VRiv4Q8ffzsgTlfh8yTOPLok78nA8oIHI
        6h1KFjsFxrdJJtRZERNcVgW2TiPQft1VPTTSYASWCrJhjsMy5amM9/088WXsd8CH9/k67k
        SbhtGqTTMrD5ki7SU3+L730PoT4blNpOLm283yA3C7tWdN1o5C9bHeg5iTExLA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632415668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=y0wDMkgnV956fboXQ4HXhkXy5kQoth5WK1arjbx0f5k=;
        b=GZXPr5oO8M/2eBpvmpcvjZbmGvuBFvp9/0adiIM9c3SERmTxaPmZIFCsNMHccSY19bq8Go
        pCzkLxNaKl8BtABw==
To:     kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Marco Elver <elver@google.com>,
        Clark Williams <williams@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 0/5] kcov: PREEMPT_RT fixup + misc
Date:   Thu, 23 Sep 2021 18:47:36 +0200
Message-Id: <20210923164741.1859522-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a repost of my initial series [0] with collected tags.=20

The last patch in series is follow-up to address the PREEMPT_RT issue
within in kcov reported by Clark [1].
Patches 1-3 are smaller things that I noticed while staring at it.
Patch 4 is small change which makes replacement in #5 simpler / more
obvious.
I tested this with the snippets in examples, Marco Elver used to run syzkal=
ler
for a few hours.

[0] https://lkml.kernel.org/r/20210830172627.267989-1-bigeasy@linutronix.de
[1] https://lkml.kernel.org/r/20210809155909.333073de@theseus.lan


