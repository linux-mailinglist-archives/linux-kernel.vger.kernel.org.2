Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B379731591D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 23:08:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233756AbhBIWHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 17:07:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233669AbhBIT0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 14:26:05 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1404FC0611BE;
        Tue,  9 Feb 2021 11:24:06 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id b9so33558851ejy.12;
        Tue, 09 Feb 2021 11:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VKpw+TGxcSonBmJvYVbjnLKEXkavUls9cDkglgeREzs=;
        b=HO1rEER2rQ/ib60OX4LykRzzHUV7TK6M7FXnGi0rK0kf7M3lRCrxd5vuud4Y69slyc
         gcJcjDFwAEKBdd+CV7Gdib0WaDgHMbaLMAOqwcG29CQeTgTSv609bh1St5YhZ6hOsqqF
         dDW3AWzG1b8Qti44pryaVZ/3AdrFfSX9D6q0kPADnuf3JVyEBXU0hpDflZXLPyS8FBmP
         HWCk8sOTr0s4EiNvcw9auqxdZnmoi0Qh+y3CnG4UVM7wkkvzxIRJedjelEyYsRDqxzro
         U2O0iq8BSbNG3VEySL8f/ZrCDoLuvevjlzBFvHyeSwKavRzoA4RxaSDNIne33B53yQCr
         U/EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VKpw+TGxcSonBmJvYVbjnLKEXkavUls9cDkglgeREzs=;
        b=hQ7m9XAUVD3VuNfag27wGegY1qKXHDErsiJf8lRXycKD2ShMh5CqT6maGFGVVpUMLS
         mPhKfmJ/KGXY9prfFZUbI84sbb5Ms+r2N2sC1wD5abbtwWWKeQQm81W7P0aQDJciQ2t9
         nErtn8AEQMFLzJXUn1tqOR9Fb8ZiXw2UQJXyhxL9qJxJEV5zFIINvaccyDYHBbo1pemN
         /KxEMLc0lbJDGP2mLczlYpx+S0rZhq97ex7RzkG4FBEbuJ9ZKfAPiGKW2mB6MOLbjNk9
         cJw1FkYFFB4Rruwn6Qxux/Ewz8jlLS++BePDan9CuQbEV+Jp5jdErzKshH8lkVwKGBaf
         5A6Q==
X-Gm-Message-State: AOAM533mHRuDCIct3LnhIJmIF3sc4JEZtB3P4I5swfHXyw1iP4JhOg8Y
        sFYH58kZrn/9VRqR5nCwiUw=
X-Google-Smtp-Source: ABdhPJw9959wQBn5cvY2Fqpt5Xz+QaWW6YioQ2FYuvburiVrHGpT8oFcjVbVZLt3nDg+4Z/13u4xQA==
X-Received: by 2002:a17:906:b752:: with SMTP id fx18mr24723372ejb.17.1612898644828;
        Tue, 09 Feb 2021 11:24:04 -0800 (PST)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id w3sm11075779eja.52.2021.02.09.11.24.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Feb 2021 11:24:04 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, gregkh@linuxfoundation.org, balbi@kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 8/8] dts64: rockchip: enable dwc3 usb for A95X Z2
Date:   Tue,  9 Feb 2021 20:23:50 +0100
Message-Id: <20210209192350.7130-8-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210209192350.7130-1-jbx6244@gmail.com>
References: <20210209192350.7130-1-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable dwc3 usb for A95X Z2.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
Changed V2:
  remove node wrapper
---
 arch/arm64/boot/dts/rockchip/rk3318-a95x-z2.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3318-a95x-z2.dts b/arch/arm64/boot/dts/rockchip/rk3318-a95x-z2.dts
index 30c73ef25..e71870768 100644
--- a/arch/arm64/boot/dts/rockchip/rk3318-a95x-z2.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3318-a95x-z2.dts
@@ -357,6 +357,11 @@
 	status = "okay";
 };
 
+&usbdrd3 {
+	dr_mode = "host";
+	status = "okay";
+};
+
 &usb_host0_ehci {
 	status = "okay";
 };
-- 
2.11.0

