Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61E0B349441
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 15:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbhCYOhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 10:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbhCYOhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 10:37:03 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499DCC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 07:37:03 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id k25so2138881iob.6
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 07:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cosmicpenguin-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G3cOV8DtVL9po2vtJRX7EdJuczfbIOHklG7/OvU7p9I=;
        b=lf1dMrmMF5QvhZ1+B7SmvRDk7M8p1OD8InFdZqiFJNjSdBajqnrICrLJtsoRnsn8wy
         Rkdcl6L0XvIHo580Q9zUvZu6EnKKy+Dfhka4ZNUDwoxLo0MWvw36tiGCFkLZyOZuAU6k
         gj8aG0KJkkmWnrwekqkTaHAQEqIUgkgaVRXqo5gJQGn6Vm2lHnmDMkHdI5k2c+vlLMiF
         dps7xn+vmbb5f2/qOGZx3tPmmTuBoipgjmEUdws5MnIQ+5t7qpIJxlBjRlJG79lZMDlD
         nSQPUYTanpxjvhN9AUT6iHLVTk08z+qVk7M21WQvxQcLMja3kS25PQCU2gEBPWvjkRb7
         B5oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G3cOV8DtVL9po2vtJRX7EdJuczfbIOHklG7/OvU7p9I=;
        b=LXAgSPpGplRWwk1ICX3+FEd8/Px2/WXvEpbntJczHTloShSn+rZxFy7enNDsF41Vt2
         GNkgZPYsX6Hdgfs6gPKfBFjGKCfLgo0glXRbJHDNBZ1vmd2s/G/frSriQ5kl49K/gYwa
         Nemo+I30qjDb9k2gRNmCghJzctuBJJ6z/1HH9drpk34wdPTZ9SutqdqQpWeU92sCtzlD
         VhrzVXrGVL+v9Qsg2ZwnvPsyasXKViheM8Lo3vZW9wUHONLEJMJDl9/dEnIRPT3nG5W9
         dRckPC5ww+kfWBT75UEyaOdy6logMvT9Uy4SnzCoRM7+HI69W7iQd+ZCAj2RV+8f7hfd
         hBpQ==
X-Gm-Message-State: AOAM533+TipjrusS0m1oInRyWXe1RKtlUlWdwbaJdepZMgtZu6e+Vawo
        h+KcvBudcxCyT/FXOI89fIv5hv31NMGUSrPO
X-Google-Smtp-Source: ABdhPJyN8CG8Dj/tyOUZgYG6FC1ZRwDa9neTBVcT/5MlZ8wzGsR93KrVS08fPYwlV/8lr9GyMLGmEQ==
X-Received: by 2002:a02:ce8d:: with SMTP id y13mr7737038jaq.29.1616683022413;
        Thu, 25 Mar 2021 07:37:02 -0700 (PDT)
Received: from jordan-laptop.lan (c-71-237-100-236.hsd1.co.comcast.net. [71.237.100.236])
        by smtp.gmail.com with ESMTPSA id g8sm2501023ile.44.2021.03.25.07.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 07:37:01 -0700 (PDT)
From:   Jordan Crouse <jordan@cosmicpenguin.net>
To:     linux-kernel@vger.kernel.org
Cc:     Alexander Lobakin <alobakin@pm.me>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        freedreno@lists.freedesktop.org
Subject: [PATCH] mailmap: Update email address for Jordan Crouse
Date:   Thu, 25 Mar 2021 08:37:00 -0600
Message-Id: <20210325143700.1490518-1-jordan@cosmicpenguin.net>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

jcrouse at codeaurora.org ha started bouncing. Redirect to a
more permanent address.

Signed-off-by: Jordan Crouse <jordan@cosmicpenguin.net>
---

 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 85b93cdefc87..8c489cb1d1ce 100644
--- a/.mailmap
+++ b/.mailmap
@@ -165,6 +165,7 @@ Johan Hovold <johan@kernel.org> <jhovold@gmail.com>
 Johan Hovold <johan@kernel.org> <johan@hovoldconsulting.com>
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
 John Stultz <johnstul@us.ibm.com>
+Jordan Crouse <jordan@cosmicpenguin.net> <jcrouse@codeaurora.org>
 <josh@joshtriplett.org> <josh@freedesktop.org>
 <josh@joshtriplett.org> <josh@kernel.org>
 <josh@joshtriplett.org> <josht@linux.vnet.ibm.com>
-- 
2.25.1

