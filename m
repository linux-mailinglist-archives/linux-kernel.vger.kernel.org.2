Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEABC4190AD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 10:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233422AbhI0IYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 04:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233337AbhI0IYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 04:24:08 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C82C061575
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 01:22:30 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id x20so5280557wrg.10
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 01:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=OeaTXKlaVHtWb9K06sQqz/ncjeyoN/0BjCyZJCd8lsQ=;
        b=m9O/XZHRDcNGup0AdL09i9hE1Zpbr44lldIM7AgYkND78DWuoadyREFzNIXtnyxW/r
         oMit5qKIe9mfxEiHxgSNCV029YmKOIK5LNowd0wVVFqNZ/rJdauroUOC173+HJfjzrSQ
         RxVPaXz3IOo50cYcykP/6sbHgOZwnX7oneKTPguoANmgndZx8RfELGUaSz4aglGTWs0E
         /MhKE80o4sXR8VoNxZwWtrdP8fzOo8fKfnTrSA7r/U0gIwNCA3ilgRDxBdrXAf5YIZC2
         z73NliwuVDbpc66WQMrF5gBxJ0SZe7vZtJr8O3UFKnFfbyTVJq2Z+3SckXEsQXqdy2YH
         UY/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=OeaTXKlaVHtWb9K06sQqz/ncjeyoN/0BjCyZJCd8lsQ=;
        b=q8FQLtox6HT5UqevMAwQ9f7QzvrZ/Nb87kG+dPw7eblt9zBX3UW7IZuMNbOST49mqk
         m1COvsEnapmucplYWYAGO17fLFyJgLqvmuUOPMCL/dlqe+5xBmXbzTg3DR/PPwyXpEqx
         h6NuBg+fwXujWNAnmnpbzJso0qR7Ufqkh0h7mmpm06/e18obIaxp5LmEaFkolPB+FmJB
         PEDu2SfLEEGOxSwiu2Qdf3DLSC6yn9jEGLoVxx0/1TJ1HwpPIgV2Wdev+RsZu3MaGX/r
         johOPDFIxqQdC1U+ZOfdGU+Sz3Klk2K7UEl1S4PzZR6jgr6vWRbEIkSsUQULqB0HrTLW
         h/xw==
X-Gm-Message-State: AOAM5307dW4dKcyIR6VuYuexAkBUx7gIylY8QU4FxwWLGLCKk9jKh2Uq
        qwUVmw8XdMivYyIFMsKfbwQ=
X-Google-Smtp-Source: ABdhPJw//yTj/1lOKLh8YSIUIdYYGCEc8rNTkNBf4I83AgStEifOJIWynEBMrT7RlAyy68V4uM5mGQ==
X-Received: by 2002:a5d:6b46:: with SMTP id x6mr26030172wrw.192.1632730949140;
        Mon, 27 Sep 2021 01:22:29 -0700 (PDT)
Received: from kev-VirtualBox (host86-149-72-135.range86-149.btcentralplus.com. [86.149.72.135])
        by smtp.gmail.com with ESMTPSA id n7sm16024666wra.37.2021.09.27.01.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 01:22:28 -0700 (PDT)
Date:   Mon, 27 Sep 2021 09:22:27 +0100
From:   Kev Jackson <foamdino@gmail.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] Trivial: docs: correct some English grammar and spelling
Message-ID: <YVF/Q5pA9h9S+wS9@kev-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Header DOC on include/net/xdp.h contained a few English
 grammer and spelling errors.

Signed-off-by: Kev Jackson <foamdino@gmail.com>
---
 include/net/xdp.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/net/xdp.h b/include/net/xdp.h
index ad5b02dcb6f4..447f9b1578f3 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -15,13 +15,13 @@
  * level RX-ring queues.  It is information that is specific to how
  * the driver have configured a given RX-ring queue.
  *
- * Each xdp_buff frame received in the driver carry a (pointer)
+ * Each xdp_buff frame received in the driver carries a (pointer)
  * reference to this xdp_rxq_info structure.  This provides the XDP
  * data-path read-access to RX-info for both kernel and bpf-side
  * (limited subset).
  *
  * For now, direct access is only safe while running in NAPI/softirq
- * context.  Contents is read-mostly and must not be updated during
+ * context.  Contents are read-mostly and must not be updated during
  * driver NAPI/softirq poll.
  *
  * The driver usage API is a register and unregister API.
@@ -30,8 +30,8 @@
  * can be attached as long as it doesn't change the underlying
  * RX-ring.  If the RX-ring does change significantly, the NIC driver
  * naturally need to stop the RX-ring before purging and reallocating
- * memory.  In that process the driver MUST call unregistor (which
- * also apply for driver shutdown and unload).  The register API is
+ * memory.  In that process the driver MUST call unregister (which
+ * also applies for driver shutdown and unload).  The register API is
  * also mandatory during RX-ring setup.
  */
 
-- 
2.30.2

