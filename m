Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0989C41E1DF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 20:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344294AbhI3S7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 14:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344221AbhI3S7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 14:59:34 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F79EC06176D
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 11:57:51 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id j15so4697274plh.7
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 11:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=INS/NnjmQyvczAJwc1033hNjtGgSshbZrS89HveDlGM=;
        b=WgoreokdsHTzIOGGPFkpgNz8WEGB7izZxJTKl15ASjyea9Mg9vlAxp1OmPHyOHXCEa
         xTpMzOndeiHm2JF4RT0QitL3+dfVb7YV1IYMB2hQDriX8tioJQ7kGpPAooTAjEZtriD4
         lD+CpTfZspbBIyZJ8OnHL4MIyk9Ugc8PD3l9qF9h9YwdXB7zN/ijjxWjAhqbhrE58Ww5
         5mw7NvLES+iBCYjA81UvyZRBem2i3WeZu7K7Y+aOizZUN0cMUwjlM/aAMvYvGpD2slLf
         C8nSChQQ6BngoYOF2D0RdMJRzaHQ5iPSsfvme/ipXMLoo5JUwnRr/av0XQlH9JXxvK/o
         goGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=INS/NnjmQyvczAJwc1033hNjtGgSshbZrS89HveDlGM=;
        b=BgkHC1h95kE1tU1HnZsqp9dtJxGd+XFBuE4gHEkGuPEY70ZhragApLIXkYiezfxhQ2
         D1R7HOKBKGvw/4vfQkw7f/deMiKdQQUHgabUwRfo1BHTDcl6oGblIXhuVZrJ5qQkcKR7
         NsW40buKSkV6W97nESX06URqjrQD0dm5Rxdg48diDybG9IvdS/v11aQzTF/fiqlZTELf
         pUpqNY9Ph5HFzAOQO7wZfYiid5pPsXyHNLTl7TIo7VyrImhuO28VGtlbLPwf9vax+u37
         RH/mdC5WKrnEkMO2Kd8mN/eAuuq5RJawFA4aCpcXroch6Of3dIwan0snNLSynzNAwcra
         nbDw==
X-Gm-Message-State: AOAM531CJwgEU179NDmJ70QAaAh54jqfXsQZp61igxkeSQFvyZ9Bhi6j
        3quy4h/KMKLHkev9y5uB5LVLoA==
X-Google-Smtp-Source: ABdhPJwaoPJvYdeAh2zI6l9aT8mgELUxGUQbjL9dEpa0IauDfkSNJwmen/GiD+a60VO17A+jkO4iag==
X-Received: by 2002:a17:90a:9306:: with SMTP id p6mr14952234pjo.119.1633028270826;
        Thu, 30 Sep 2021 11:57:50 -0700 (PDT)
Received: from localhost.localdomain ([122.172.224.206])
        by smtp.gmail.com with ESMTPSA id l144sm3920997pfd.193.2021.09.30.11.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 11:57:50 -0700 (PDT)
From:   Amit Pundir <amit.pundir@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        John Stultz <john.stultz@linaro.org>
Cc:     linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        dt <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] arm64: dts: qcom: qrb5165-rb5: Add msm-id and board-id
Date:   Fri,  1 Oct 2021 00:27:42 +0530
Message-Id: <20210930185742.117928-2-amit.pundir@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210930185742.117928-1-amit.pundir@linaro.org>
References: <20210930185742.117928-1-amit.pundir@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add qcom,msm-id and qcom,board-id for Robotics Board RB5.
This will help us boot the device with newer Android boot
image header versions, which package dtb separately
instead of the default Image.gz-dtb (appended dtb) format.

Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
---
 arch/arm64/boot/dts/qcom/qrb5165-rb5.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
index 8ac96f8e79d4..b6a8b41ea831 100644
--- a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
+++ b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
@@ -16,6 +16,8 @@
 / {
 	model = "Qualcomm Technologies, Inc. Robotics RB5";
 	compatible = "qcom,qrb5165-rb5", "qcom,sm8250";
+	qcom,msm-id = <455 0x20001>;
+	qcom,board-id = <11 3>;
 
 	aliases {
 		serial0 = &uart12;
-- 
2.25.1

