Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2454541B27D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 17:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241464AbhI1PBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 11:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241430AbhI1PBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 11:01:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35BDCC06161C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 08:00:12 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632841210;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ecYTBN5245h9m7K9ET4yicsX/9Ubxva09RZJLtUGFXU=;
        b=NtmSHf+Bc63UF5PzlWpVYR5lA9FAeM6rQrMYokYZqefhil0esK7QbFAbCUuOQeEs5f4+qe
        BCgmRvCb/bYHqp+DsqdX5kcxZ9E40hhsbWgBYI5iaISx4NE32KSawbjh1tPjtAT5PidBj2
        Wn28zZsoTqrbuvqU1BXCfFCQq1ZOEbyQE790OcCyg6MWD8Sd6cTcV+YT1MJEojxbzcniOu
        Z80fvX3/rARJSuU9eaT6f42tc3WuLmFIBMfup+vA80F35+AfsfoQGsTa0yFcUO8j/JfvHO
        2axKQrBxojHeiecDSwR8+TneK8JcxfU4dmnYxQbjCbwHXpzISsDDNHvaE3Ja8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632841210;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ecYTBN5245h9m7K9ET4yicsX/9Ubxva09RZJLtUGFXU=;
        b=ev0pid/hsFKZ+WmwdHmqhdHyY60Sjm5N3WYtLnHQG5LVGNYcI5sDnt6NJhJzMbOiO/+0JH
        IJUoIVaExW7oq3Bg==
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 0/2] rtmutex: Lockless reader wake + explicit check for TASK_RTLOCK_WAIT.
Date:   Tue, 28 Sep 2021 17:00:04 +0200
Message-Id: <20210928150006.597310-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a follow up to
  https://lkml.kernel.org/r/87wnnjcuam.ffs@tglx

While forming the patch, I got currious why the state check is against
TASK_RTLOCK_WAIT and against TASK_NORMAL. So I swapped to to
TASK_RTLOCK_WAIT which should be more robust.

Sebastian


