Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38025450166
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 10:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237125AbhKOJcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 04:32:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237360AbhKOJc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 04:32:27 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1771C061767
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 01:29:11 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id d5so29316513wrc.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 01:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0RKufxnEkGwvgDrdIXbzHHGgttZ8o4UlM8CnSVDJeTk=;
        b=u8dblw3+lpHAPpWi0ipUGv62e48JAFU3zYUcMhaIV1SOfuuG4SoQ5xrho8U2auArYF
         lbFVR/yY8o0+3OEOsByw+SQSqnlOCZsFswdoCuAjO8p2NDDw7S9l6xbAa77PXxMUSUrA
         FrLIV7k23OELyQIQYYib3YWEamzi4QFfj1bmgFeIoSMNcoQOkFEmjlIghgig4sUFnSgW
         6tO5DB/ye7RKa1PsKOIKEyEZYUsCa4vUCmPFEjwa2p6i2/JN7d2so9UiwmAWN6RcGRHJ
         HOIcuitriFGT67Caicyox7XZNYZwluO3EMjzo7WxESfawSvHoHaYTXhLZSGf53U58EcK
         vxdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0RKufxnEkGwvgDrdIXbzHHGgttZ8o4UlM8CnSVDJeTk=;
        b=sNo49XxFez7UZDgE0X1AHekBOnDMpoQzU9/2GIpntEva0vLNNtk0lMBPgzNc6Ja5Co
         tZm4GBy7XMO0xYZA9LPXy80Vu6nJFHZ0ECFE+JGpvevgukohMyxx9m8DqlnnxGNfRGAJ
         0O3l5Q4xjjUsCpKAnFct2DELqLUiTrHpCcNws5lFKYxUYwXCS8r/2rd22xA5mww8ELBa
         fDszcSYc4A5izbH3g2YTRGdqzJdLaYaxuBTFcc3HcrLX6tfvsdZjqdyd6FhcY8ECR0a4
         7/skPznvaEXu3UFhrtu3jBLRLXiybdaocgTa1yAUwwC6Q7Jbs78o00yDFvBOl4B7pawq
         5u0g==
X-Gm-Message-State: AOAM530Ma8/uPTHJ9Dgb3RLLdCoqZ7C1Xweqkz7PAaxPsMkjjTNhVzNB
        YyXF6moWdq/YXGouG+E+ckgugQ==
X-Google-Smtp-Source: ABdhPJxJEZECFmk9t1OoTcXPY8UZjRYEW9SutGZsotZFwtcHeKTlx+Bghir0+ZKuZYtHpdO5xCMoUw==
X-Received: by 2002:adf:f787:: with SMTP id q7mr45091526wrp.1.1636968550451;
        Mon, 15 Nov 2021 01:29:10 -0800 (PST)
Received: from localhost.localdomain ([2001:861:44c0:66c0:f56f:2409:301:93ad])
        by smtp.gmail.com with ESMTPSA id u2sm15871407wrs.17.2021.11.15.01.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 01:29:10 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Christian Hewitt <christianshewitt@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-kernel@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH 0/3] arm64: dts: meson: fixups for WeTek common dtsi
Date:   Mon, 15 Nov 2021 10:29:04 +0100
Message-Id: <163696851316.448838.395017402297767954.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211012052522.30873-1-christianshewitt@gmail.com>
References: <20211012052522.30873-1-christianshewitt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 12 Oct 2021 05:25:19 +0000, Christian Hewitt wrote:
> Two fixes from work on u-boot support and following access to the original
> vendor schematics, plus a minor change to use revised LED bindings.
> 
> - Mark VDDIO_AO18 always-on and link hdmi-supply to fix HDMI on boot
> - Add missing GPIO binding
> - Update LED bindings
> 
> [...]

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v5.17/dt64)

[1/3] arm64: dts: meson-gxbb-wetek: fix HDMI in early boot
      https://git.kernel.org/amlogic/c/8182a35868db5f053111d5d9d4da8fcb3f99259d
[2/3] arm64: dts: meson-gxbb-wetek: fix missing GPIO binding
      https://git.kernel.org/amlogic/c/c019abb2feba3cbbd7cf7178f8e6499c4fa6fced
[3/3] arm64: dts: meson-gxbb-wetek: use updated LED bindings
      https://git.kernel.org/amlogic/c/1e9fc71213d784dfbd153289daf08fdfc87f32ba

-- 
Neil
