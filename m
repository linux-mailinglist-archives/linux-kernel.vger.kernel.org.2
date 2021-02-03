Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE1130E33F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 20:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbhBCT2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 14:28:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbhBCT1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 14:27:50 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A96BC061573
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 11:27:09 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id nm1so268211pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 11:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bNbGmsRK7EtE+A+C+li0gY11J+UApuCknxlivtVnoCQ=;
        b=DWjb2bFxqmNAW/BlPcyRIq10tLyWin+KVH+audN+gSu1lquwWUwEWTEYYFO4Ajfl8+
         PLIed1ut3mA3JKPJh3T/xt4N8+olbCwku/bPb+hB1bczhc+8P+a87iwzvwM1lng+6dmi
         Cqgd8077QetOKepECmzQw9y0O1+q3TmjGes49HJ3Q6n/rkMJNvaKPl8QbQmQFsq/kP7A
         cueKGTRD7xwLRRmTNg7XZcEIBfk9rHsId5gDN/3f5JkgiEzdXnGU8Rd48HeF+3GLo236
         +HB6Vn5rFaV4Uh2PcpEyHB0yD8FP9fWIVb/yJfdAy16bXdsgsYlurViEcrjnGEpYwDtM
         1x7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bNbGmsRK7EtE+A+C+li0gY11J+UApuCknxlivtVnoCQ=;
        b=htEq7WbnaTbnJZqGmlYie1yiuF+ELQNOzzY9sYVh8BUk3tlC1jlmKdJ8IHzl/MkXWP
         x960FFt5KbAjfO0JL1QBJWOWHwmithM/bm3QfG6e0vw62ErI1PELoZpmTpUViK0sljJO
         Lx8xwg3TynXmbp3nbGuQ30TpX2LpavMkHfEVzywXdNKWeSwCFszs52tLHPUR1BAp6Zoz
         q3y6VBdtB2WWWBHDFN63ttT7etVoHQxduBSW/pwflwhR3heX/R2iU7KSAFWjQT6SIxFC
         0RSKnk/H1ei+Vm7lwwmEEDC/v1Xd4/o5PeVTUDOEIRObriSnhNNIeV2FyRj/TrekUiIs
         phZA==
X-Gm-Message-State: AOAM533ZEWL17cHWFv1A9wS3GT7vW1+etVa6Gcmip6mUDitiqjfl78AC
        KIz6/AmqD2XMA4QG2OQmj5UBwg==
X-Google-Smtp-Source: ABdhPJyCCy5Wn7Tedwh+xmpYfLj3gtMpYExYZcNb6JG6B51UNpF2Nvs/mNWe7tpbl5nRFMr5MskuYw==
X-Received: by 2002:a17:90a:f0c1:: with SMTP id fa1mr4549473pjb.3.1612380429127;
        Wed, 03 Feb 2021 11:27:09 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id o14sm3865549pgr.44.2021.02.03.11.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 11:27:08 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Christian Hewitt <christianshewitt@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Dongjin Kim <tobetter@gmail.com>
Subject: Re: [PATCH v3 0/5] arm64: dts: meson: add support for ODROID-HC4
Date:   Wed,  3 Feb 2021 11:27:07 -0800
Message-Id: <161238042310.26843.1778876341665074972.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210202021021.11068-1-christianshewitt@gmail.com>
References: <20210202021021.11068-1-christianshewitt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Feb 2021 02:10:16 +0000, Christian Hewitt wrote:
> This series fixes minor sort-order issues in the Amlogic bindings yaml and
> dtb Makefile, then converts the existing ODROID-C4 dts into dtsi so we can
> support its new sister product the ODROID-HC4.
> 
> I've also given the devices different audio card names. This is partly
> cosmetic, but also because HC4 is HDMI-only while C4 can be used with
> other i2c audio devices via an expansion connector so users may want to
> use different alsa configs.
> 
> [...]

Applied, thanks!

[1/5] dt-bindings: arm: amlogic: sort SM1 bindings
      commit: ad6d08d9e909be81c135355716590304e99543b7
[2/5] arm64: dts: meson: sort Amlogic dtb Makefile
      commit: fd88408951aef8c3e6e6a1dd2f0acf47b45182a2
[3/5] arm64: dts: meson: convert meson-sm1-odroid-c4 to dtsi
      commit: e329e6681d55e2ab9b3d033f3ee38f09e96f2f9c
[4/5] dt-bindings: arm: amlogic: add ODROID-HC4 bindings
      commit: 1429c7d223ed436f54e1c30efa7f87eb15d50b31
[5/5] arm64: dts: meson: add initial device-tree for ODROID-HC4
      commit: 9be09db3e2adf5843ec1e20771c598e70d2bd34a

Best regards,
-- 
Kevin Hilman <khilman@baylibre.com>
