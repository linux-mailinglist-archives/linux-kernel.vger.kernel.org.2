Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CBE4331440
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 18:11:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbhCHRKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 12:10:41 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:33172 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbhCHRKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 12:10:01 -0500
Received: from mail-wm1-f72.google.com ([209.85.128.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lJJOK-0003Kw-FD
        for linux-kernel@vger.kernel.org; Mon, 08 Mar 2021 17:10:00 +0000
Received: by mail-wm1-f72.google.com with SMTP id a3so2286481wmm.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 09:10:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U4pUbqXfXgnnLhDhksCamnOqM1YsLoMYiBC/1NCNg+0=;
        b=krlzwIf4cRK4IVYJV0LI+u+i7cKa2MU7cAxkJ7n2y3es9/zTJCifKD5VgXGoSQdnHm
         Bmmj81AVbrfNX6hDg6MfDIPAE8kBYJP1DfgJS3X8EsOwb3t+urH9E9prpi7Yor3hwGyi
         JQMouHqA/KDaGPZk9257MRNWz+jxoYhMa4fF5rjmBgyIiz6c5Ya6PNttIzSCXmsII23x
         pw63Ku6gHc0nr/9EEe+Xwgp75RUMIBf1sh884zkwYk4GjcPP+vfJJPxLNR4kTfJ1xTy4
         W0HpDpYIq9Wg8QmJzNoT+CQCZrN6DHrjLWkQd7HZ7uxdFGmsNLydy/VP+fjw5mcRDU2L
         9ohA==
X-Gm-Message-State: AOAM532/Ug79LRjtaSrmJG37rMOMa/TFCBWcV7CPbW1041O96fr0KcKc
        /4aLWJvyBctZbY5IuPaf+XTSO2jSJrWs7vVvi0OEZ8+Ho9WfUwNM35nAWY/tUK/ETnz2W8g/+aI
        IJr+bWAzGa/G+e4bho6ZKeiQQxcSDPbsCVZmjK4XxGg==
X-Received: by 2002:a7b:c0d5:: with SMTP id s21mr23367782wmh.30.1615223400279;
        Mon, 08 Mar 2021 09:10:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzDoAApcr5gaPCMJBgkDD5QBgXndL+LmIS5tK2e0cy377KXLKCREY1WOwOMtQJZ38tBp1Z3Nw==
X-Received: by 2002:a7b:c0d5:: with SMTP id s21mr23367768wmh.30.1615223400166;
        Mon, 08 Mar 2021 09:10:00 -0800 (PST)
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.gmail.com with ESMTPSA id c11sm19568762wrs.28.2021.03.08.09.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 09:09:59 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     "Paul J. Murphy" <paul.j.murphy@intel.com>,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, arm@kernel.org, soc@kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [RESEND 2nd PATCH 05/10] arm64: dts: intel: socfpga_agilex: remove default status=okay
Date:   Mon,  8 Mar 2021 18:09:40 +0100
Message-Id: <20210308170945.161468-6-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210308170945.161468-1-krzysztof.kozlowski@canonical.com>
References: <20210308170945.161468-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Krzysztof Kozlowski <krzk@kernel.org>

New nodes are okay by default.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/intel/socfpga_agilex.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
index 25882faccbdb..f46d678ba775 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
@@ -472,7 +472,6 @@ uart1: serial1@ffc02100 {
 		usbphy0: usbphy@0 {
 			#phy-cells = <0>;
 			compatible = "usb-nop-xceiv";
-			status = "okay";
 		};
 
 		usb0: usb@ffb00000 {
-- 
2.25.1

