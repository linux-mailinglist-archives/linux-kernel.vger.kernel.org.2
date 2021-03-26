Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4061B34A4E5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 10:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbhCZJuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 05:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbhCZJtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 05:49:24 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446E6C0613B2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 02:49:24 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id v11so4984641wro.7
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 02:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lnKAUsQR/aiR/AJsMesylDJt5Bahw7/FdeBelMaPv0I=;
        b=nbn4LhBx4czsUXyccjdaGcfL1i7y3MjHhqbybt37vahf0k03f0ol4mbs+UTasMBHbH
         /8QvEauRk4SLBV1DLVm6SwMR2qEUZw3OFjLpqd11CyNtZF3BlEEeYZzLR/fXHVoneTO/
         Rgq9tkaLBcsi+ECBrI26aaQ1u65FgFk7PSJbsAoHBIPCnh9ArFY0X9IWrw2P5iiaCE4Z
         yBvaU7YZGYiP/CUr2Sjh4F1O7kLAH5imCjofI3le1m50HfGdFIBc0TRYrxwfgBItnIHw
         tyhMbMZ0II+LFU5nRA79NUpW3r856O2uPcJhnT30jP429HD632GUQ/OdeeLBjVA1/DSt
         SVtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lnKAUsQR/aiR/AJsMesylDJt5Bahw7/FdeBelMaPv0I=;
        b=tEEHWj9lg5CljF3mPi7RDPm6OV+cHcGp+XMfBCWashF5nKMTyWgEZpCvnibHmGwgUM
         bk8vuMImvJCRqmLp1YoUrnyyvQc45LRRtLgzQoEYwoXGYH9aAuYFopv06zxsQyx8nnES
         hIpqanML0DD0rnYmsbzodnbyAhRw3bhq5dnFaYMwP2e5BKN+TnNjP+YkGP8r6b6KidfQ
         4MDFxrFzNrbzGh6+5vCCpwr9L1ULgKKl7V+mJPJWh7s7dL2POLKvecbgM/BBw62HDgXv
         XPrFL774nMZw4mWVdfll53U1fCXxndDtK96XyiL7iG/eX04AoW6irbX+yiCopNQbpwH+
         g5mA==
X-Gm-Message-State: AOAM533razFVhif9rnipPM/IY587egimR2dWCSMnRfUbDukElrT/NtKh
        o9yMRrDzcpaKf2uW5t2hA8dpdQEQrxQ=
X-Google-Smtp-Source: ABdhPJwULWvj/hVr4amsVkyFI+3DdeJ9AQDnY64XP7LIWwYEsTohOgxEhbz2koz+Ef52Kdf3RtxFuA==
X-Received: by 2002:adf:e791:: with SMTP id n17mr13375384wrm.322.1616752163027;
        Fri, 26 Mar 2021 02:49:23 -0700 (PDT)
Received: from lorien (home.raoult.com. [78.214.78.108])
        by smtp.gmail.com with ESMTPSA id v189sm10662995wme.39.2021.03.26.02.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 02:49:22 -0700 (PDT)
Received: by lorien (Postfix, from userid 1000)
        id 5A9C6140303; Fri, 26 Mar 2021 10:49:19 +0100 (CET)
From:   Bruno Raoult <braoult@gmail.com>
To:     gregkh@linuxfoundation.org, straube.linux@gmail.com,
        zhaoxiao@uniontech.com, dan.carpenter@oracle.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Bruno Raoult <braoult@gmail.com>
Subject: [PATCH 3/5] r8192U_wx.c: style: braces all arms of statement
Date:   Fri, 26 Mar 2021 10:48:33 +0100
Message-Id: <adbbb5243dca7998a31a786eef277bd85068c63a.1616748922.git.braoult@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1616748922.git.braoult@gmail.com>
References: <cover.1616748922.git.braoult@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix checkpatch.pl check:

CHECK: braces {} should be used on all arms of this statement
in drivers/staging/rtl8192u/r8192U_wx.c

Signed-off-by: Bruno Raoult <braoult@gmail.com>
---
 drivers/staging/rtl8192u/r8192U_wx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U_wx.c b/drivers/staging/rtl8192u/r8192U_wx.c
index 039471bcd5b1..03791613853f 100644
--- a/drivers/staging/rtl8192u/r8192U_wx.c
+++ b/drivers/staging/rtl8192u/r8192U_wx.c
@@ -429,9 +429,9 @@ static int r8192_wx_set_frag(struct net_device *dev,
 {
 	struct r8192_priv *priv = ieee80211_priv(dev);
 
-	if (wrqu->frag.disabled)
+	if (wrqu->frag.disabled) {
 		priv->ieee80211->fts = DEFAULT_FRAG_THRESHOLD;
-	else {
+	} else {
 		if (wrqu->frag.value < MIN_FRAG_THRESHOLD ||
 		    wrqu->frag.value > MAX_FRAG_THRESHOLD)
 			return -EINVAL;
-- 
2.27.0

