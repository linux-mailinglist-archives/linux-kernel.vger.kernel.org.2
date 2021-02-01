Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1CC30B038
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 20:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbhBATRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 14:17:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbhBATRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 14:17:11 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538D3C0613ED;
        Mon,  1 Feb 2021 11:16:31 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id kg20so26158462ejc.4;
        Mon, 01 Feb 2021 11:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mllDDoFqrKsaQ7KlxScyjYXTToCMmRRcsUF13aNpIwo=;
        b=TR3QQUl376CKWxkT45Au9qVjuPj9X2icqMv5pUoU6DvPDZ/HdYIx8kdN00mwx85b+r
         aSP+eqe5Dd1ms63DPOBI+EdTcFiO5UK+JmzCq/pFMcocf4ApS00AwLHTqowrf/zWRu7n
         aW0kC7G/KebCWR+wv7lqMmx7zF2Ls75/cyBbkfbRn2xmjFPSCDDVCBdCjTZ1T4XzQnqY
         ZxkZgmgyQqVduA/VEoxb0mMHb3YNSUmixtFt/xNf4OLNpopB1MisSWKPKhAQXlvMQUkI
         An4v3LW8KY6p9w84sNFGUOpzDC/pK+znqbnArLiO/DHdH6Y1+CuF91rW5fzdr42jD3yH
         wzIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mllDDoFqrKsaQ7KlxScyjYXTToCMmRRcsUF13aNpIwo=;
        b=fl3krjE7PGepq3tDNfyyqwWmHSR0XvxdjYxQUS8X/Tk98Kb9wfF63hA9C3KBsA1d+c
         i4jApI7KBCM7iNQVUQoJWSJTnB99JdkaNKEzPZ+ChXbH4TXpg7O8FSl3mSJQfEZEWuSz
         7B7+gf80dhHXKBZmay6Y+d8qEP1C3kygeSyMaXfpUHzCkduC7oE6e//i2Qo1QWPWXSFT
         g6dNsYAnxAe4iddK9HZSGuF073zHdkJnQcrIKJlfpk00+41jN+LbyyS3Xvn3LEm8H2W4
         gHyU9ZmXSWBiuYFl1muVPWvU0R1KGiS+lGjHuv0W/hfORI46J4MEN+5XOpE2dgCUpIZz
         dBNw==
X-Gm-Message-State: AOAM533kgvniuG21w1EE+OaDeXQpuw6FRmTYudcgNyzmMSqK95mPy1Wx
        v+0WdAOXurV18hgiUqtgXU4=
X-Google-Smtp-Source: ABdhPJzLFUzM2fRH4Z8rU6O4IMoW4h0n2tWF9JTlqcSjHoiZpbSDGfV/fX8kQ7Oct7ftJOdotIdl0w==
X-Received: by 2002:a17:906:a8a:: with SMTP id y10mr19290598ejf.139.1612206990147;
        Mon, 01 Feb 2021 11:16:30 -0800 (PST)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id a11sm8243630ejc.64.2021.02.01.11.16.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Feb 2021 11:16:29 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, gregkh@linuxfoundation.org, balbi@kernel.org,
        linux-usb@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 5/5] dts64: rockchip: enable dwc3 usb for A95X Z2
Date:   Mon,  1 Feb 2021 20:16:19 +0100
Message-Id: <20210201191619.32353-5-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210201191619.32353-1-jbx6244@gmail.com>
References: <20210201191619.32353-1-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable dwc3 usb for A95X Z2.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3318-a95x-z2.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3318-a95x-z2.dts b/arch/arm64/boot/dts/rockchip/rk3318-a95x-z2.dts
index 30c73ef25..b26c653c6 100644
--- a/arch/arm64/boot/dts/rockchip/rk3318-a95x-z2.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3318-a95x-z2.dts
@@ -357,6 +357,15 @@
 	status = "okay";
 };
 
+&usbdrd3 {
+	status = "okay";
+};
+
+&usbdrd_dwc3 {
+	dr_mode = "host";
+	status = "okay";
+};
+
 &usb_host0_ehci {
 	status = "okay";
 };
-- 
2.11.0

