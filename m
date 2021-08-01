Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC563DCDBD
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Aug 2021 22:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbhHAUcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Aug 2021 16:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbhHAUck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Aug 2021 16:32:40 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 437BBC06175F;
        Sun,  1 Aug 2021 13:32:32 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id ds11-20020a17090b08cbb0290172f971883bso28596506pjb.1;
        Sun, 01 Aug 2021 13:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=C5OkbFMiWM1ChXsrfF8KE2qY/XlniASsnVqp/vvztTk=;
        b=iBnd47dT2pXk72rPqhSUxbhvnfQ+koDwfEvcfdyEwX0NUzNyCUFYUHWPUtKQzvzL5M
         NKrMc26MTvTb9skvC3n6YBc+3QkUP6StousYh3+l+uB+2yjsXG9xdID3FWgERLOvSKM2
         HR7toPlHoctcH+JOVIdyoeks/9UfF93LF65Ho9kkWqko6M171iXFWnNl7ZOXAt2s+xNd
         inr1AgHzrceFNqK1R3BoxnThCS/Ejx7/xwJfWBgR230LeprLxQxAP8EzjoVuEz26l5IN
         ExKZytAPxLwenhFZUF2ZGQ4BB4nXKRXSA/o1byxq9rC3jR2ZJDQJmqMmfOkm0mq1GCmu
         Uv9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=C5OkbFMiWM1ChXsrfF8KE2qY/XlniASsnVqp/vvztTk=;
        b=F3fDwMj53j9Py/ldqrv0UfdUrrWJpOhNOizGYYlouvC9zxqYu4+pukyo3dclQDwohk
         mZQNkuijkFn2ECvgAfucp39B/rASZ3fWszkBpRkDlqsOSf0HuYX8BAnKVrM61Vemnt+K
         hYLdnojBLoNLeMzz7mRXvDkGtY62Eku4wRGY83k7gLEpSZ6iVb9psKpEHMvuDwpzOqoz
         mvd7vtjd2A2WnqCT9mErq784PFvpxuknybdgB5UtaJgJXDULmQSgfG335sCx8/GT6BIn
         TSBYUdNPdfdEjDYfJHHwtJdRKlLI+c/hYyH9tHGW4F8ATs4PqMXo8Xzeo+ZKu0+FQSSV
         inXg==
X-Gm-Message-State: AOAM531UXf36b1UU1fSRujOkzWv7ifYxmufRkAOV8SgQLhvAPoMm21ao
        JqQr1ipkd06QZI8ZstUAmcU6JmtITbY=
X-Google-Smtp-Source: ABdhPJx8ZHL9ztCyHIPoKBWnn7WN4TdEfz5pSkJ56VqjBlPzPGwIB/MUPVUny+rVBqCqlTQ+Oyt+Yw==
X-Received: by 2002:a63:b48:: with SMTP id a8mr4288384pgl.169.1627849951809;
        Sun, 01 Aug 2021 13:32:31 -0700 (PDT)
Received: from localhost.localdomain ([2402:3a80:15b3:589:f07d:5386:a3c2:3056])
        by smtp.gmail.com with ESMTPSA id k10sm8897974pfc.169.2021.08.01.13.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Aug 2021 13:32:31 -0700 (PDT)
From:   Himadri Pandya <himadrispandya@gmail.com>
To:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Himadri Pandya <himadrispandya@gmail.com>
Subject: [PATCH v2 0/6] USB: serial: use wrappers for usb_control_msg()
Date:   Mon,  2 Aug 2021 02:01:16 +0530
Message-Id: <20210801203122.3515-1-himadrispandya@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are many usages of usb_control_msg() that can use the new wrapper
functions usb_contro_msg_send() & usb_control_msg_recv() for better
error checks on short reads and writes. They can also be used to avoid
allocating redundant dma buffers that are generally required to use
usb_control_msg(). Hence use them whenever possible and avoid using
usb_control_msg() directly.

Changes in v2:
 - Drop unnecessary use of wrappers
 - Drop unrelated style changes

Additional Info:
- This is a super late follow-up on v1 that was submitted a while
ago(my sincere apologies). (All patches are rebased and
compile tested.)
- v1 patches: https://lkml.org/lkml/2020/11/4/40
- Patches that introduced the wrapper functions:
  https://lkml.org/lkml/2020/9/14/859

Himadri Pandya (6):
  USB: serial: ch314: use usb_control_msg_recv() and
    usb_control_msg_send()
  USB: serial: cp210x: use usb_control_msg_recv() and
    usb_control_msg_send()
  USB: serial: f81232: use usb_control_msg_recv() and
    usb_control_msg_send()
  USB: serial: ftdi_sio: use usb_control_msg_recv()
  USB: serial: keyspan_pda: use usb_control_msg_recv()
  USB: serial: kl5kusb105: use usb_control_msg_recv() and
    usb_control_msg_send()

 drivers/usb/serial/ch341.c       |  97 +++++++++-------------------
 drivers/usb/serial/cp210x.c      | 107 +++++++++----------------------
 drivers/usb/serial/f81232.c      |  96 ++++++++++-----------------
 drivers/usb/serial/ftdi_sio.c    |  53 +++++----------
 drivers/usb/serial/keyspan_pda.c |  70 +++++++++-----------
 drivers/usb/serial/kl5kusb105.c  |  79 ++++++++++-------------
 6 files changed, 173 insertions(+), 329 deletions(-)

-- 
2.17.1

