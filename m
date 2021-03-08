Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07980330696
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 04:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234018AbhCHDx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 22:53:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233930AbhCHDxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 22:53:35 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9147C06175F
        for <linux-kernel@vger.kernel.org>; Sun,  7 Mar 2021 19:53:34 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id k2so7636808ili.4
        for <linux-kernel@vger.kernel.org>; Sun, 07 Mar 2021 19:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q8TGG0UKWkmYFGc7Y9qbb22HolcuSRxUaKR8Lr9SYoU=;
        b=XrlwGLOTGlOrwE/OianPDHrFLL7/Cb32+e6rmT/iNTgYljC02P2XJwdVnleaPhM5px
         w60mJWPg66F9rZvs34l+toJQqhkt06PtqaIzikzPCfB5Xip7RX8l5hkXG/rfJAHTYr9o
         srbyuAsYMupT8MhS5PzbUUuHbwOu2oFkvywN4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q8TGG0UKWkmYFGc7Y9qbb22HolcuSRxUaKR8Lr9SYoU=;
        b=IK/I9phAIlPhtzdmzZhCFha0xOKt4KVw2pk4HgcmyxF8cHTkAzuJt0ZLl2wBdur2Rl
         ZC42BZS1sq3VY5RRqbfWJXd39evvQ3G6h4n8P8WRLwIqAldgMbDG2OjCb6/+PCDK7y4E
         3plV2ge/0DlODd42pD44ETiYc3DlKP4u0RogBTPy+H08Imm36oe/RQ6qu/MpRRBd0/1o
         av5iAkmP1UU4sesAeWJOkJgYBwrfk+kUmDWvx2oLOmxDQNw3BlPF/Q8WJCKAG4SzQAEf
         Wm8PXm1t+mlK5VN42kM8TV1k/22XRTHfncbryx+bpPTjUMxr6q2gvl2fF2sTv9R+Akfe
         lrkA==
X-Gm-Message-State: AOAM530OiE6rcAQATTXv3zOcWYx41WiIOR8Rxs8cUV23cvQRLXxYpX0r
        z0Kv8QKVI4a0Ey6XSOXvFgU6sA==
X-Google-Smtp-Source: ABdhPJwYlHGYO4AuJPejd8Arn60zVOYCjtVbUL6XST51uH/KjScwnd/9G11bnY3q39IAZlZ71sVb/A==
X-Received: by 2002:a92:c248:: with SMTP id k8mr18868269ilo.141.1615175614166;
        Sun, 07 Mar 2021 19:53:34 -0800 (PST)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id g6sm5605242ilj.28.2021.03.07.19.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Mar 2021 19:53:33 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     shuah@kernel.org, valentina.manea.m@gmail.com,
        gregkh@linuxfoundation.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, penguin-kernel@I-love.SAKURA.ne.jp
Subject: [PATCH 0/6] usbip fixes to crashes found by syzbot
Date:   Sun,  7 Mar 2021 20:53:25 -0700
Message-Id: <cover.1615171203.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series fixes the following problems founds in syzbot
fuzzing.

1. The first 3 patches fix usbip-host, vhci_hcd, vudc sub-drivers to
   validate the passed in file descriptor is a stream socket. If the
   file descriptor passed was a SOCK_DGRAM socket, sock_recvmsg()
   can't detect end of stream. Reported and fix suggested by Tetsuo Handa
2. All 3 sub-drivers use a common kthread_get_run() to create and 
   start threads. There are races in updating the local and shared status
   in the current stub-up (usbip-host, vudc) and attach (vhci) sequences
   resulting in crashes. These stem from starting rx and tx threads before
   local and shared state is updated correctly to be in sync.
    
    1. Doesn't handle kthread_create() error and saves invalid ptr in local
       state that drives rx and tx threads. Reported and fix suggested by
       Tetsuo Handa.
    2. Updates tcp_socket and sockfd,  starts stub_rx and stub_tx threads
       before updating usbip_device status to correct state. This opens up
       a race condition between the threads and tear down sequences.

TODO: Once these fixes are in, kthread_get_run() macro can be removed
      in a cleanup patch.

Credit goes to syzbot and Tetsuo Handa for finding and root-causing the
kthread_get_run() improper error handling problem and others. This is a
hard problem to find and debug since the races aren't seen in a normal
case. Fuzzing forces the race window to be small enough for the
kthread_get_run() error path bug and starting threads before updating the
local and shared state bug in the stub-up sequence.

Shuah Khan (6):
  usbip: fix stub_dev to check for stream socket
  usbip: fix vhci_hcd to check for stream socket
  usbip: fix vudc to check for stream socket
  usbip: fix stub_dev usbip_sockfd_store() races leading to gpf
  usbip: fix vhci_hcd attach_store() races leading to gpf
  usbip: fix vudc usbip_sockfd_store races leading to gpf

 drivers/usb/usbip/stub_dev.c   | 42 ++++++++++++++++++++++++-----
 drivers/usb/usbip/vhci_sysfs.c | 39 +++++++++++++++++++++++----
 drivers/usb/usbip/vudc_sysfs.c | 49 +++++++++++++++++++++++++++++-----
 3 files changed, 111 insertions(+), 19 deletions(-)

-- 
2.27.0

