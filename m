Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 174313F88FB
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 15:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242505AbhHZNaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 09:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbhHZNap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 09:30:45 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E68C061757
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 06:29:57 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id y23so3070311pgi.7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 06:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+LoLO1M4+QB+q2rsvGYbdf/T5USS23kElc9PZhkYyxM=;
        b=q+7zG5oZRWCTcfUjkCkBkprxotYrBiGWK1kdfs4WY/yY5ERaszNTJQ0qG2UuMCC4o9
         YQvjayWXCwsH9bHMU87evauTv66bYJ4z6E51JZdKSWz85RnXtDql02XdtdmjMETYoWD5
         Hezd3P1aR3lQDpfT1vbzAgU5X8bCHwoGc+taGBiRneJau0JRtasL0rcBFEBmQMLUOFA8
         +3S8K++kzjoh9wQoK/1sKMU7emtdvCQedFg7WOJJozqEV8IRktV4CcFl9bjoS+NVNFFp
         cM8+Dsi3cEplHnJGVgRznVTUOtlrlWFDO6gm5rh84NzYmvMgckYaiSIHFJvBfD0Q/iZq
         KxVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=+LoLO1M4+QB+q2rsvGYbdf/T5USS23kElc9PZhkYyxM=;
        b=l0tSCJ6TSMWbH0+WQb4wSsdMuZ0nr0h0OtJ0WvoI4mFfyHKSp8rZrIdPMp9FmM0XLB
         ScelLDUSHXXz1L7UhwSZPiTVNu8HiZLzetaoOd6YgbxT6cEojGTBVGkYGspOdk6tepMT
         4dxOI+cHjy0Ds9bNqKYerl5/c1rr9keMieAkZUuXtVj5c11dSx4f7CbCoPwTPLCtemhD
         A1O3oh7cnoeJvh16LJty9wyQCGw3E27CWMvYBvFa9OsULzKiDRZdGz+Eq10Mn5gzR46B
         Ol8RpeBiEJxt9ypaxDy5Dz/zeNa3LhDCilrUdq0X2CsEbbAik13XFJHvV7YOJStP3zJK
         Lrfw==
X-Gm-Message-State: AOAM532vSR1GN9Sla2eYKC/drdzGFCT/KRrGp7y2tf4GOWBoUMF1Vnzn
        pI3cszAiL9ClygFzNcm8kbL6ghb/z7s=
X-Google-Smtp-Source: ABdhPJyIIDSvk072nKRS5xd/3OaR0yLI18mTOtlLdnEwy1XJTW+8VdKvVifbbSoNWJVKIhDUVzi5bg==
X-Received: by 2002:aa7:8685:0:b0:3e1:76d8:922e with SMTP id d5-20020aa78685000000b003e176d8922emr3811341pfo.45.1629984597420;
        Thu, 26 Aug 2021 06:29:57 -0700 (PDT)
Received: from localhost.localdomain ([45.124.203.15])
        by smtp.gmail.com with ESMTPSA id w186sm3359693pfw.78.2021.08.26.06.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 06:29:56 -0700 (PDT)
Sender: "joel.stan@gmail.com" <joel.stan@gmail.com>
From:   Joel Stanley <joel@jms.id.au>
To:     Stafford Horne <shorne@gmail.com>
Cc:     openrisc@lists.librecores.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] openrisc/litex: Update uart address
Date:   Thu, 26 Aug 2021 22:59:44 +0930
Message-Id: <20210826132946.3324593-2-joel@jms.id.au>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210826132946.3324593-1-joel@jms.id.au>
References: <20210826132946.3324593-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recent litex socs will place the UART at 0xe0006800.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/openrisc/boot/dts/or1klitex.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/openrisc/boot/dts/or1klitex.dts b/arch/openrisc/boot/dts/or1klitex.dts
index 3f9867aa3844..baba4f49fa6b 100644
--- a/arch/openrisc/boot/dts/or1klitex.dts
+++ b/arch/openrisc/boot/dts/or1klitex.dts
@@ -41,10 +41,10 @@ pic: pic {
 		interrupt-controller;
 	};
 
-	serial0: serial@e0002000 {
+	serial0: serial@e0006800 {
 		device_type = "serial";
 		compatible = "litex,liteuart";
-		reg = <0xe0002000 0x100>;
+		reg = <0xe0006800 0x100>;
 	};
 
 	soc_ctrl0: soc_controller@e0000000 {
-- 
2.33.0

