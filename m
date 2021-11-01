Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8AB1441272
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 04:42:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbhKADpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Oct 2021 23:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbhKADpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Oct 2021 23:45:06 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA424C061714
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 20:42:33 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id f8so10685665plo.12
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 20:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=APpKnlySmIgEFDR/sbeGSY0ig+Ql5pQCqjLI+NAb2Ec=;
        b=dzVsVOGuWeWUwYQRBqkOH179l0p1nrWFZ6O/8+jsKIy43sNdnozqXY/9B2FU9//OUY
         Iy5GdEAX9qQ7alacdssf2k5QwvyIxPFs4XWG+FPuV1mhTQW4dgZZCGWTQqqH6n8TyvNC
         U6Qu4en4fM4/P8PbFlKujZkmWAi2ktHI5X+T5xw+3xSBYFTzd+KNRAZymL6DM2IfgQCm
         IIBvDhEmrfSAjLNbgQu0rCa1Ss5fCC+Bci1kKPOnTXtoFO1DAvbiPdqloMTTydayvC6y
         JxGY9zUR/UBesXYk7FkUabYAoqUNMRzUKc22BxU345f7vCTy3KgryNozL5i4CmU4Ix1n
         cAkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=APpKnlySmIgEFDR/sbeGSY0ig+Ql5pQCqjLI+NAb2Ec=;
        b=D0KePEshk0H+Sfo85UoiBgqpYP8F68JM9O53NiJNfJc/ucGG2mMyIUvL9zBVQdN9IJ
         +lnY4oHmFCiBczcR8SgMfkQbdoAD85a6y8QC9l6r6di4HP0Uyq6BrPaLSWY/y/BIQE2f
         3q2gj6gM4LYIqO8JsRtveMJjeF+Q69X0+uJLV1jRxfy6HMmHp+230JQLpCnmk8r9moMu
         TodLMllijPM02mWWmDnwHbmVE2AI5zzRlOoXFxATEBNXRM/W9+UU93Xq9OIL8iJ7KKHi
         RBA9Q5HOvEtQ4YZ7FVoEfgR9a7KjHKRf9Zl7t03Yq8gEq/FiudVKYv0zRKPJL98pZfRN
         pbKg==
X-Gm-Message-State: AOAM531KAEOZLI9Kzffqn2MfqqFix3FIuGrOKtaeSQDHDPAnOml0jg3r
        HB6c/qo+LnIkpPHOr00aG/e8Qg==
X-Google-Smtp-Source: ABdhPJziZn0z1VI1sEizUJCnQDhdAbpHu0KMs+z4THUQsy1FF8ZRiRcxkeJcIUCd9lc4JFxj/AWQfA==
X-Received: by 2002:a17:903:2c2:b029:101:9c88:d928 with SMTP id s2-20020a17090302c2b02901019c88d928mr22772939plk.62.1635738153146;
        Sun, 31 Oct 2021 20:42:33 -0700 (PDT)
Received: from minbar.home.kylehuey.com (c-71-198-251-229.hsd1.ca.comcast.net. [71.198.251.229])
        by smtp.gmail.com with ESMTPSA id x9sm11270588pga.28.2021.10.31.20.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Oct 2021 20:42:32 -0700 (PDT)
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
Subject: [PATCH] signal: SIGKILL can cause signal effects to appear at PTRACE_EVENT_EXIT without tracer notification
Date:   Sun, 31 Oct 2021 20:41:45 -0700
Message-Id: <20211101034147.6203-1-khuey@kylehuey.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rr, a userspace record and replay debugger[0], uses the recorded register
state at PTRACE_EVENT_EXIT to find the point in time at which to cease
executing the program during replay.

If a SIGKILL races with processing another signal in get_signal, it is
possible for the kernel to decline to notify the tracer of the original
signal. But if the original signal had a handler, the kernel proceeds
with setting up a signal handler frame as if the tracer had chosen to
deliver the signal unmodified to the tracee. When the kernel goes to
execute the signal handler that it has now modified the stack and registers
for, it will discover the pending SIGKILL, and terminate the tracee
without executing the handler. When PTRACE_EVENT_EXIT is delivered to
the tracer, however, the effects of handler setup will be visible to
the tracer.

Because rr (the tracer) was never notified of the signal, it is not aware
that a signal handler frame was set up and expects the state of the program
at PTRACE_EVENT_EXIT to be a state that will be reconstructed naturally
by allowing the program to execute from the last event. When that fails
to happen during replay, rr will assert and die.

The following patches add an explicit check for a newly pending SIGKILL
after the ptracer has been notified and the siglock has been reacquired.
If this happens, we stop processing the current signal and proceed
immediately to handling the SIGKILL. This makes the state reported at
PTRACE_EVENT_EXIT the unmodified state of the program, and also avoids the
work to set up a signal handler frame that will never be used.

This issue was originally reported by the credited rr user.

[0] https://rr-project.org/


