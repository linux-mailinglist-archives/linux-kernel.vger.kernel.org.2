Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11800380BE1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 16:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234472AbhENOeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 10:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234431AbhENOeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 10:34:16 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BEF5C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 07:33:04 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id a4so30257996wrr.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 07:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dAsKBCUtWvT2TBc5FQFA2vVLxfmKKkbA3qujbzupPfM=;
        b=fRRNd//FGa7QVc0likppjcQv7KM9iO7gKQUNmRCd1gAxsArkyy9+bYMptXd+ck79pD
         OSIA8Ve5qcCL29brdwIVHuNhfZQZJsew//87TJCzgze9e3UqghsGUxHQO/mimWtYUpZr
         5kM7M1FFL3mHUrs8z3v7L+l4myMyn132fE0T+QNBbGMa1FpAF+2Uv1fLEfQ4J5qN7SFP
         aCTebmRBsYCWoOnUbnLrFV5IyDYEYeztqu9vgkRjW2o3FiJLtipgX3/fYQkPw8xkYOrc
         NviPYk5Nru3FvuYiFRzks2iCMXaUGV8rUsIIkVt4JU85HGTKToblvbyIuyDROmNQsQYS
         2omA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dAsKBCUtWvT2TBc5FQFA2vVLxfmKKkbA3qujbzupPfM=;
        b=KcSQZn+6fgSxZyl1HT4Ctt6JKpmfI50bn2y+qXwPGBB/bmAqlwF9gOTKSBYoSq549D
         3F5yaTQ+DWppInWmhYos/DiAFDgjLzjsL+XA4Ls8/8i/yEHWSL6QrqSi3yyAQ2wNNTuX
         X6gDoid97o8MHICnHLrlU+AJ4O2QyPNjdHGgZ1gL20fSypYFgattCxd5LfQ5s9F+yEea
         pNQH7/O/uTBVpxdIbz5GLf0FRuXXzMSgNTLKFIuFriHoY4L3ZkTDfqnslYrxIlE0gzQr
         6jFkKv35OpKPNthW2PpshccoVEOE4C2tHqUp2RxNemvT3sAOQC4Kttw7zcL8Y7IVnb5A
         P+kg==
X-Gm-Message-State: AOAM531rtE2nVqbN8dZhVsiZMS0URmZBwdLp61BCAljJBGZsiC42xz5I
        dcp+XvlJwYJev47EJflgLQQBhg==
X-Google-Smtp-Source: ABdhPJx8h5teAgdXD//u9XMzxdRx2sWdw/oSiwMevGN6xDDCQ6y7X2IT9xVohMJgiOXA0XzSoLGSkA==
X-Received: by 2002:a5d:58fc:: with SMTP id f28mr13300656wrd.339.1621002782937;
        Fri, 14 May 2021 07:33:02 -0700 (PDT)
Received: from localhost.localdomain ([37.173.48.34])
        by smtp.gmail.com with ESMTPSA id v21sm11552036wml.5.2021.05.14.07.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 07:33:02 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v3 1/3] arm64: dts: meson-sm1: add toacodec node
Date:   Fri, 14 May 2021 16:32:53 +0200
Message-Id: <20210514143255.3352774-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210514143255.3352774-1-narmstrong@baylibre.com>
References: <20210514143255.3352774-1-narmstrong@baylibre.com>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; i=PiBOxGF9B8KW9XPjSZyFe2Ca0fRRv2NCjlxlTSICTK0=; m=JPhUMX0KwAIy028CLaqNkk0VSurj2OC9d9a2+coI+IM=; p=vYSSa/Es1AGkZ2S88vUhAsnn0Rd+dA2FIygyN1JQJ8o=; g=6d32934740ad81bbded692d5df351bde49b9be52
X-Patch-Sig: m=pgp; i=narmstrong@baylibre.com; s=0xA4CFF8AE; b=iQIzBAABCgAdFiEEPVPGJshWBf4d9CyLd9zb2sjISdEFAmCeigcACgkQd9zb2sjISdF+/g/+Lhb xiMDtRbHkd1MEA2ZyyZpdWfunqAzGrDS2UfXjRqC5eir7L8l2x6F07v0OPz2w46ekg7Ca7xB9fQ3S UVQllt/kIVmKoOtoSvzMMzkmgePKnN2alMsRQv7VKafsRAXTfBtRIUnL/D6lyCaFfHpO5ko30cAd5 Lrppjn4jgEMBInCS1DisKgVPDGRme186EGVmZrQpDTz76pILuqN9r0fqJU1nULS45YNPCLSuozfH4 UV3E3xeVMnQu8Uolg8r/JjcY3PDjjA/TpIUNORzX97pMtnDoYxsD+b6+i4IEiFY7i30EponsyU787 flVB93qG6EqB6cB5yFIyb/L6soTRd9N1UVLCBAOofA3PXRcfmFq+7EfNRoaeUfAh8aMkqo3QJK+tM 8JLm6HJy2dPnt/7MA1OxyvAPWIR09GcD6G+lqL4Auy37wwe9Ht2DxSfLFJSw+Sxl/pp0Bv+XsKB3C QojXhhgJNv4JxPTckDDaiNc3/655S/jgi7as8rW04BlRaHQ7EYqUUf9JyBra4l0kmzDQQOsGC/tp5 D48RoCyMQjsJfGAwUBkl3QyFA5F2XbXxg7TwNEfBwAS1QVVJPRmuc85qZV38DMATBsHMdxi55xzpA S0iEvNpy+cmxbAA3g2XbRK5VJQZL3shBNtXMwMdvZwSiS398v34c3WPenNWoXWcg=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add toacodec node for Amlogic SM1 SoCs.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-sm1.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi b/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
index c309517abae3..3d8b1f4f2001 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
@@ -401,6 +401,16 @@ tdmout_c: audio-controller@580 {
 			status = "disabled";
 		};
 
+		toacodec: audio-controller@740 {
+			compatible = "amlogic,sm1-toacodec",
+				     "amlogic,g12a-toacodec";
+			reg = <0x0 0x740 0x0 0x4>;
+			#sound-dai-cells = <1>;
+			sound-name-prefix = "TOACODEC";
+			resets = <&clkc_audio AUD_RESET_TOACODEC>;
+			status = "disabled";
+		};
+
 		tohdmitx: audio-controller@744 {
 			compatible = "amlogic,sm1-tohdmitx",
 				     "amlogic,g12a-tohdmitx";
-- 
2.25.1

