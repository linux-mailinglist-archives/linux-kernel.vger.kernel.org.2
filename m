Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41CFA315CCA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 03:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234442AbhBJCC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 21:02:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234630AbhBJAnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 19:43:17 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5F4C061786
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 16:42:29 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id r21so244258otk.13
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 16:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=etuaipsRI8VUBgOpRvDQ8x9GuLj3LBOY0jfZPD+9PZU=;
        b=RyZp4bKd5jXCGBD5pFwR/hdVXBbL9IX4AzrmLeByylFz7gzsGYVcbuRrTX+6s0BQcj
         kQ3nHfB7Oxxdz0toIE7NU2BIn/ub7gbfxk4EjGeBbiVXq9SdLaOpfbNhj0vLqF4fO1VK
         cBq9b3eJsmf+tmJeEtT48SPYH17zjGsqAo3yY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=etuaipsRI8VUBgOpRvDQ8x9GuLj3LBOY0jfZPD+9PZU=;
        b=ARUD8e2rEC7DWNY+kz+9bg51TbTo/QdjbAp37trDQ5sKQualrmvEnSPzmayxLzJkn/
         nF0ikoYQNYoVOV6l6yE4UPHSz9l7Cqp6wXdMzGe1MVQZJ7pnIbczimN1MU5A+7bzxR35
         E0kDiKWKjQ60X1LnaOYkkkjLITlmHgaksoQuvW6hqtmonxZyOmzkqqhqjR3zhkzshFMA
         PbR28jEMd1Dp1aMECzTZlv9d19vzka0mK4q7KF7AU0Glvopb0ln9Nz4SmiegT+xBHeEx
         QFKBpFtnpFCey9mSRwC2VXP5kDdVYKedPspnRWjLSETW4PSXEs2A/F+Av5VZegVfemLP
         Jn/g==
X-Gm-Message-State: AOAM531Va9UTFI5EE7QXE/dcdc3Qv1XmeNUu10ZN5mJND+zHA5WgJWqO
        X1BzpqGiylD7qkjdKUL9WjIsQQ==
X-Google-Smtp-Source: ABdhPJz3qC3Vss2S7hgvN3dmYgFFQWBTBmhf4k+ZiQK8BXjQbj1R8owtdETJ8jUJrHBoGGLX27ZKsg==
X-Received: by 2002:a9d:a87:: with SMTP id 7mr227340otq.319.1612917748911;
        Tue, 09 Feb 2021 16:42:28 -0800 (PST)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id s123sm103060oos.3.2021.02.09.16.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 16:42:28 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] ath10k fixes for warns
Date:   Tue,  9 Feb 2021 17:42:21 -0700
Message-Id: <cover.1612915444.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have been seeing lockdep asserts for a couple of months and finally
found time to debug and fix the problems. The dmesg looks clean with
these fixes.

Enabling LOCKDEP and ATH10K_DEBUGFS triggers the lockdep assert and
RCU warns.

The first two patches in this series are fixes to lockdep assert and
RCU usage bugs.

The last patch (5/5) is a fix to reduce invalid ht params rate message
noise. Patch 3/4 changes a message from debug to warn. Patch 4 adds
detect to assert not calling ath10k_drain_tx() holding conf_mutex.

Shuah Khan (5):
  ath10k: fix conf_mutex lock assert in ath10k_debug_fw_stats_request()
  ath10k: fix WARNING: suspicious RCU usage
  ath10k: change ath10k_offchan_tx_work() peer present msg to a warn
  ath10k: detect conf_mutex held ath10k_drain_tx() calls
  ath10k: reduce invalid ht params rate message noise

 drivers/net/wireless/ath/ath10k/mac.c     | 13 ++++++++-----
 drivers/net/wireless/ath/ath10k/wmi-tlv.c | 15 +++++++++++----
 2 files changed, 19 insertions(+), 9 deletions(-)

-- 
2.27.0

