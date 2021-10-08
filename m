Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3D62426762
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 12:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239654AbhJHKIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 06:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238955AbhJHKIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 06:08:06 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB30C061570
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 03:06:11 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id 5so10047515iov.9
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 03:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DhkGQxymSGNx/5KpVXzR9zkQ3CERpYjuzQVc8kX22kE=;
        b=fC2wpY3mAtWUVqPIwY+pKa4s4ZFzHyKkDAm++cp/5IF3ozL26lMUH4RFsLuesbkAiV
         p9gtHPh/c0kzycpF3OaGzvlao0Jc20fenzWGPYYGCw8P/QAslMV3xtJp9cAdaDzCkkKd
         hCwH9k+614DTTnpA1cbqQIoFN3ggfS6HkxZVSpZ3A5r4VfrpargKe+NYPXUUsWb+YJ8u
         QMB/wNIwGSWwgunrpBnSEACjUfPM3qT2jsS0lHyXGZRBlriFoyqRDKJKuCzkiQpg6H6D
         Hn2wIeT7AU+LiV4m30ZNgdZpkmS88ga6kfipLYHZfpRj3Gh6x60k0FKPdRBE5Iuif/Fs
         6eLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DhkGQxymSGNx/5KpVXzR9zkQ3CERpYjuzQVc8kX22kE=;
        b=hO9lORZkCPCMa/ksyrE3jW8RFAPsEfI6dZxAdfQzi92WN0v0yk1ojr1noPDBB/zlwv
         ukwQbj1E/UoxCHdwORpnQFGaYG5R4pR4nE9D9SsTvnLGLc3Wzb/ys42xTjqktIfbHCjS
         ouxsBLUHlRA5xswQ7l/Pb0MH063j051DGwJjUydvi1QxjRkzqgSq92pWYio0yhRqtsG5
         buK1Yv3fF1AkCnVsEwJdvkEoqkSTihocurep2qQLmCjTfG1WHhFxVdmwGSBXmJimCx8p
         YtqS+XdupyJVSLXv8tFmBa51isqfPX0HPoKYlRxIE3rTLwLx6UybsTgoMXixfKhBewty
         F4Lw==
X-Gm-Message-State: AOAM532wy7EcOZgLJJ6ltD8kQHgTIvu4iyISdy3aaquu1+k3dnjV8Z3K
        N5JNKd5iWpNIntasTOjRNUnU4Flsp5r7Pw==
X-Google-Smtp-Source: ABdhPJwo0fOQsQ/EvHsq5YUbPmrhCr9/J8oAESlPMRgo53U2UrMZogZnHMRDfXJ36uIXzmy/LLFX/Q==
X-Received: by 2002:a05:6638:3052:: with SMTP id u18mr6852229jak.148.1633687570690;
        Fri, 08 Oct 2021 03:06:10 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id d1sm864506ils.25.2021.10.08.03.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 03:06:09 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 714A627C0054;
        Fri,  8 Oct 2021 06:06:08 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 08 Oct 2021 06:06:08 -0400
X-ME-Sender: <xms:EBhgYaD-e-iT2W2NfcYp3blVpB9QGH1qgjsCkgUvNBIyfCh4xqO3Ew>
    <xme:EBhgYUhGBScsaSMW424cZ90a2Nm-5mdiAmuufx3hhk3UjZnYpdCtsV9IAxLyyFg1s
    WHVPfSx8dCdZDNysQ>
X-ME-Received: <xmr:EBhgYdn0I4zy8s9nD76l21NA3gDxE0Hnh9qeGll_vSuZdjX2hN7nLaT94ggnOw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvddttddgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhepieejhfelvddtgeduhfffueegteevleeugfekvefhueduuedugfevvefhtedvuedv
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqh
    hunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddu
    jeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvg
    drnhgrmhgv
X-ME-Proxy: <xmx:EBhgYYyiOSQKt-2Zlgx02JWL2CdhcybfX6nyINjH4Q_NvkPSBiacyQ>
    <xmx:EBhgYfTB57GCFZRcQ8utIFlX6c1RDdrj6b5YQEoI-A3fzNZ21Zi-Ew>
    <xmx:EBhgYTZpxd3dfp1u1do0FYLGNYtHTf7AqGxJ25GVxWJSZZnjmEdeuw>
    <xmx:EBhgYeFLZgvkLHCuje6cTrXwnYRbZ3qVOkN0HY8ebvJIL01HbvLdvQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 Oct 2021 06:06:07 -0400 (EDT)
From:   Boqun Feng <boqun.feng@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [RFC 0/2] Re-entrace of a work when requeued to a different workqueue
Date:   Fri,  8 Oct 2021 18:04:52 +0800
Message-Id: <20211008100454.2802393-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tejun,

I found out a possible re-entrace case of a work item:

	queue_work_on(0, WQ1, W);
	// after a worker picks up W and clear the pending bit
	queue_work_on(1, WQ2, W);
	// workers on CPU0 and CPU1 will execute W in the same time.

To make this happen, work W must be queued to different workqueues (WQ1
& WQ2), which may look weird, but IIUC, we don't disallow it?

I'm sending this patchset out to see whether 1) this is by design (sane
users of workqueues should guarantee no concurrent queuing one work on
two workqueues) or 2) this is a real problem that we should fix. If it's
2), then I have a straight-forward fix in patch #2, which needs some
discussion because I changes the queue_work_on() semantics a little bit:
if WQ1 is a unbound workqueue and WQ2 is a bound one, my change makes
the second queue_work_on() in the above case effectively queue W on WQ1,
which I'm not sure is a desired change.

Patch #1 contains a simple reproduce of the re-entrance case, which is
of course not for merge.

Regards,
Boqun

Boqun Feng (2):
  NOT FOR MERGE: A selftest shows that re-entrance can happen
  workqueue: Fix work re-entrance when requeue to a different workqueue

 kernel/workqueue.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

-- 
2.32.0

