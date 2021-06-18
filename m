Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 920EB3AC0B4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 04:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233587AbhFRCHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 22:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbhFRCHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 22:07:21 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64357C061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 19:05:12 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id k22-20020a17090aef16b0290163512accedso6392753pjz.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 19:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=3QPyJRdiwAkOP9ibN/RveYV54YO/LahPvxPTtOsMHNY=;
        b=OKbyzChNUWuVa3TlM/Lf0srSZxyUI+xiL25UE7wx9tFMqinjvKQ2n8BYJP3i1+VYyc
         W8XsS8vKLLCUPtoNmsGwB7f7Iz8fpnHUXA6krjKp1AAX50piafWO5c/hKBfIel3Jzcpu
         OjuFl3yMaQegg3gr2NI1LVn+zpvh8OI/kPN05Ket8IVf63sP03f0ps3npPD3SXkIoSlu
         eXwEQLRa151KiVIKhHgoYYajxc4Sf5btFMYogGocfYmT5fsccJQE71XZiL8YgfcRxmj6
         Y3H33RwzlWdICSgJw698nTcHZiuik2pEDYcD93Phi/ZujU0H5Tzn5+IgI9/stRTOXco2
         Rrqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3QPyJRdiwAkOP9ibN/RveYV54YO/LahPvxPTtOsMHNY=;
        b=cimFUbCTqp26iOu2BcxqkKCVG9eKjEgLWtVbICHPJRatlAMKFAEQKAnLet9fcQgFEE
         air0emg/Ujr+Zl9C8p9NOgK++QoOxSGxtBTPsfEBk7RNZPGYRTXKSdV5XZNA4ztKqC2p
         NYyNcFeDFd+RDkfu3pqMeOjM6cGR6pfhIP8f/V5L5NanzOqwEk+thT+Hd9a7eGt16w7o
         49avdDYK0zgknPJY+PwZqo/oiY3RboTv8qg+V0+hipznodLLpYO3+xFzC/yQl3Lmk5kD
         7gpXvk2OCERdJ1t8ILSh/2DYxbnS4CUhZA/DKcW6DOyCVcgOBazVas8D8znHf5RIw5CL
         V77A==
X-Gm-Message-State: AOAM532oNe8qeWgIUTQ1osPMjo8D8+oJKaERZA8XQHTEJn8YFGK0xxnp
        GHWkwr1STZjhyhTC+GZHjY0=
X-Google-Smtp-Source: ABdhPJz9xwn9lAbm+Vsn7RdyDj3bExaRogNybD7OatBJpp3DUjzyv3ufniMFR+mNp/NIZPzQsa0noQ==
X-Received: by 2002:a17:90b:1d0f:: with SMTP id on15mr19483061pjb.194.1623981912013;
        Thu, 17 Jun 2021 19:05:12 -0700 (PDT)
Received: from bj10045pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id y39sm6023598pfa.119.2021.06.17.19.04.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jun 2021 19:05:11 -0700 (PDT)
From:   Zhenguo Zhao <zhenguo6858@gmail.com>
To:     zhenguo6858@gmail.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] tty: n_gsm: modify the doc punctuation "," to "."
Date:   Fri, 18 Jun 2021 10:03:31 +0800
Message-Id: <1623981811-19505-1-git-send-email-zhenguo6858@gmail.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhenguo Zhao <Zhenguo.Zhao1@unisoc.com>

End punctuation of items 5 and 6 are ".",other lists
should be modify to "."

Signed-off-by: Zhenguo Zhao <Zhenguo.Zhao1@unisoc.com>
---
 Documentation/driver-api/serial/n_gsm.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/driver-api/serial/n_gsm.rst b/Documentation/driver-api/serial/n_gsm.rst
index 87dfcd5..154c75e 100644
--- a/Documentation/driver-api/serial/n_gsm.rst
+++ b/Documentation/driver-api/serial/n_gsm.rst
@@ -14,11 +14,11 @@ How to use it
 -------------
 1. initialize the modem in 0710 mux mode (usually AT+CMUX= command) through
    its serial port. Depending on the modem used, you can pass more or less
-   parameters to this command,
+   parameters to this command.
 2. switch the serial line to using the n_gsm line discipline by using
-   TIOCSETD ioctl,
-3. configure the mux using GSMIOC_GETCONF / GSMIOC_SETCONF ioctl,
-4. obtain base gsmtty number for the used serial port,
+   TIOCSETD ioctl.
+3. configure the mux using GSMIOC_GETCONF / GSMIOC_SETCONF ioctl.
+4. obtain base gsmtty number for the used serial port.
 
 Major parts of the initialization program :
 (a good starting point is util-linux-ng/sys-utils/ldattach.c)::
-- 
1.9.1

