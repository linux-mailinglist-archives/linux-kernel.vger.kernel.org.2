Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0403F3FBAEA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 19:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238027AbhH3R1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 13:27:32 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53416 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbhH3R1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 13:27:31 -0400
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630344396;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=/TlNdEaYuWrznUySCkzWevBs6NrmuDYVGSJKO0VUco0=;
        b=fqscOD+WHbR7GCHhSec60PogqfANKTcXImMKUqJiVF/6F3wYTxVdN7ir3S3CQUdjfvWyIe
        Ep5WRUlBcj3t8T2kjfdo0OveFom8LlsDQEsWm5wc0RwYfOoDIOJ3owQ0pIgKS+vpwfq6C4
        OpIDqoMlUuZczIxWTjTxFWSL9QP84qEXjQ6GPLkyhe+riADERrl3cBfH0dlsOSHU6dkBty
        J50mfhQoGYwEzfsNFtLtZbVlXBuwpluU7gKD/dpkmHMiV3a+XeFuSQqU0oFvtWeqXYiXXs
        U1FvBwdbqWUepVpR/RzTdlqzO9Nx6zJt53wJPeyFUxbS4Un5eWL2/9V9vntiwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630344396;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=/TlNdEaYuWrznUySCkzWevBs6NrmuDYVGSJKO0VUco0=;
        b=PO7kQ71ZVRFEBEkDPHS2xA+0eDDYxkV1bzTzoCFR1x1WeOa0BojQ885vsreNh4xcoG7Ymq
        0gzuUuSmAaQawTCg==
To:     kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Marco Elver <elver@google.com>,
        Clark Williams <williams@redhat.com>
Subject: [PATCH 0/5] kcov: PREEMPT_RT fixup + misc
Date:   Mon, 30 Aug 2021 19:26:22 +0200
Message-Id: <20210830172627.267989-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The last patch in series is follow-up to address the PREEMPT_RT issue
within in kcov reported by Clark [0].
Patches 1-3 are smaller things that I noticed while staring at it.
Patch 4 is small change which makes replacement in #5 simpler / more
obvious.
I tested this with the three examples in the documentation folder and I
didn't notice higher latency with kcov enabled. Debug or not, I don't
see a reason to make the lock a raw_spin_lock_t annd it would complicate
memory allocation as mentioned in #5.

One thing I noticed and have no idea if this is right or not:
The code seems to mix long and uint64_t for the reported instruction
pointer / position in the buffer. For instance
__sanitizer_cov_trace_pc() refers to a 64bit pointer (in the comment)
while the area pointer itself is (long *). The problematic part is that
a 32bit application on a 64bit pointer will expect a four byte pointer
while kernel uses an eight byte pointer.

[0] https://lkml.kernel.org/r/20210809155909.333073de@theseus.lan

Sebastian


