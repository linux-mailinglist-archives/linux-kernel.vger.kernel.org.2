Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FECE441271
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 04:42:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbhKADpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Oct 2021 23:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbhKADpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Oct 2021 23:45:08 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10841C061764
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 20:42:36 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id t5-20020a17090a4e4500b001a0a284fcc2so15083430pjl.2
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 20:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4GCHBzdOf2l0ezku52x9JJD/iLvZwQIsn8CJ4kxN7Wk=;
        b=eJ92wLALf8grP7AuDxt1fe95Q9cWAaHH9hoWfOIBXyCVfUU7biOa2m6D6+rtZSDLtG
         b6rMC9nR9afgOtMffqlHzoUymK/o52GIAo3ugA2dEBhfUW8ILzTDp7XRN1XXFhjKOlCS
         /K8ULNf7SrZNjQFrL+trSzMXnI1FczTFavH1sXBqXQLIQmsN8WZYaznFvA4l9atZUn7J
         OmUVsSyBDKPu4RdPsFB8cYtuywc/lad+FW/UTKsiJ+P/OBpD7e9xSjiERDEBEsLCFo1F
         UF2z0eYJYu9R7T6fq0DOOIcXnqERiWdxhFHyPrrowvv7ebMwrxBpAB+GfpOG5PrlxIhm
         CwAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4GCHBzdOf2l0ezku52x9JJD/iLvZwQIsn8CJ4kxN7Wk=;
        b=botqRlVHyM6/dF1r4IqsGaCJcCisQ/218kEV+KkVRJ4QW0GJdxHLBNUWeEnRIj9QE5
         QSA6XpVqxKsbYDCrIUB7zNB6R6qW4FzB/EK+of/SXdDPrdTo74dx4ltczUFIbkg+NpIv
         aqaNCJJvj1ja53/+glamGRxRWmr1ci7yWhl2QzPggQ6mGL1bzIM8loPjM5vu9rK2Gdsl
         3Av+VOGm9pGIu1Do17gdwWlXdaMXuVRAmub2+G4n3t+RoZwyxh/wV9ZJDxZRG6A3qY3T
         /hJNo61brfAW3Dwl3WLRXpKf9Hc2v3KYdyQxaIvYKf7UBG1AaVk+FiX0WH4+gJtxj1l8
         5ORQ==
X-Gm-Message-State: AOAM53396BHYtaMNY/mOkB6UdoLKdjNT4dWAfL7P+T+epBeUnrbDf/9s
        BbGkSz3UVZcpPAsys94YlivOyw==
X-Google-Smtp-Source: ABdhPJwpkW6p/Tj6R9VnkM2OphVwIjej61GoJVix9aAwah5ue6wLahOXW8cf7AoHYzvyz18MT317LA==
X-Received: by 2002:a17:90b:388a:: with SMTP id mu10mr34265770pjb.221.1635738155543;
        Sun, 31 Oct 2021 20:42:35 -0700 (PDT)
Received: from minbar.home.kylehuey.com (c-71-198-251-229.hsd1.ca.comcast.net. [71.198.251.229])
        by smtp.gmail.com with ESMTPSA id x9sm11270588pga.28.2021.10.31.20.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Oct 2021 20:42:35 -0700 (PDT)
From:   Kyle Huey <me@kylehuey.com>
X-Google-Original-From: Kyle Huey <khuey@kylehuey.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Jens Axboe <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        Marco Elver <elver@google.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Collingbourne <pcc@google.com>,
        Alexey Gladkov <legion@kernel.org>
Cc:     Robert O'Callahan <rocallahan@gmail.com>,
        =?UTF-8?q?Marko=20M=C3=A4kel=C3=A4?= <marko.makela@mariadb.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] signal: after notifying a ptracer of a signal, recheck for pending SIGKILLs
Date:   Sun, 31 Oct 2021 20:41:47 -0700
Message-Id: <20211101034147.6203-3-khuey@kylehuey.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211101034147.6203-1-khuey@kylehuey.com>
References: <20211101034147.6203-1-khuey@kylehuey.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ptrace_signal will release the siglock which could result in the current
task catching a SIGKILL that was not present on our first check in
get_signal. If that happens, bail out of the current signal and go
straight to the SIGKILL. This avoids setting up a frame for a signal
that the ptracer may not be notified of but that will be visible at
PTRACE_EVENT_EXIT.

Signed-off-by: Kyle Huey <khuey@kylehuey.com>
Reported-by: Marko Mäkelä <marko.makela@mariadb.com>
---
 kernel/signal.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/signal.c b/kernel/signal.c
index 4d26ee5c662a..09810777c61b 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2738,6 +2738,13 @@ bool get_signal(struct ksignal *ksig)
 			signr = ptrace_signal(signr, &ksig->info);
 			if (!signr)
 				continue;
+			/*
+			 * After calling the debugger anything could have changed.
+			 * If there's a pending SIGKILL stop processing the current
+			 * signal and skip straight to the end.
+			 */
+			if (signal_group_exit(signal))
+				goto kill;
 		}
 
 		ka = &sighand->action[signr-1];
-- 
2.33.1

