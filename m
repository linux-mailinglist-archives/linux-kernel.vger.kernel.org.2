Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAA6F45812F
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Nov 2021 00:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238014AbhKTX7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Nov 2021 18:59:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237686AbhKTX7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Nov 2021 18:59:00 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 802D8C061748
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 15:55:56 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id h12-20020a056830034c00b0055c8458126fso22855847ote.0
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 15:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pSPopdaF+ihVTA4ijju/5cBbM6jMosSNPV3+XmETCpM=;
        b=I03PNyMyto7mkvu8Y7aNx7YQP6EPgsoLHyseIWYAjUmPpHZ0IADZbYtEU+j7lOgrzT
         mKVyC/KRKwyq4LkrnTUrtJ9+Aj5ZeN49H30QkvKXNkx0kEiGEGtTn5ElgKAMgI2fLgQ2
         Ohj9msXoyJMua5NAzq99aBjzACm8bLOXTaOt0cEH1lHRCPes3QFyik3CuJLkkvc7YhjA
         geXsQFoT/7vS037ckn/sOC2y9ZX0Wnhx2h5Z13rn3mXOEC7Q2qu1qaK5oSlTnpdqBGQT
         GPpig5RmcdYHyngrUUSAf63sDlJFMKAO/kWACrFbqYK/OOU9smEAo3UHoIiOEU0NxC2n
         zGmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pSPopdaF+ihVTA4ijju/5cBbM6jMosSNPV3+XmETCpM=;
        b=Ehb7iU03niife6cRf2adttuyh+CcPAAcmvX+u3S9OTYWGsRVgMGTn4PsGrk8hlO2Zo
         cyUJOppU5G87LugfX5IoERgjUZyJ/bBeFyxNY6YmLezAnFlmYzGQtbU9NlIntygLIKmk
         Td9UpdL0YGl3PWdfmDmRt4OK3ePczAdw8XTPik9aPIT8MdpcKvFEXt4hTG7FHPq5Stgq
         MZPDOrtQSqd+f12IrgDXqzQOJbX+Bw97J2ySjIg9auo2I4FY/HXkbwbTc+xYaKw1NQEA
         P5WRZKdyJaO1uK1t0rIgRwOwi54BNztQ85EuVWwFFz+qdr7UEUDg5Ondv7e777ZrrPT7
         A2gA==
X-Gm-Message-State: AOAM530Uokg/HBd4w5XGJgC69OnWWx0AQbB2es1Er7FYSu30/+pSUm0k
        52tbGPKJXC9y2KhQoXCdGgkLyw==
X-Google-Smtp-Source: ABdhPJztdwDk3EI1NtJbxWSm86apzdx//aaQW+xl4RllMJ2qfqlYFcnF4S+Y6wtBVwqnK3rb95jxDw==
X-Received: by 2002:a05:6830:1514:: with SMTP id k20mr14061162otp.147.1637452555925;
        Sat, 20 Nov 2021 15:55:55 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id o26sm828474otj.14.2021.11.20.15.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Nov 2021 15:55:55 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawn.guo@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Jami Kettunen <jamipkettunen@gmail.com>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        linux-phy@lists.infradead.org
Subject: Re: (subset) [PATCH v2 3/3] arm64: dts: qcom: Add missing vdd-supply for QUSB2 PHY
Date:   Sat, 20 Nov 2021 17:55:31 -0600
Message-Id: <163745250542.1078332.12783986325450706739.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210928022002.26286-4-shawn.guo@linaro.org>
References: <20210928022002.26286-1-shawn.guo@linaro.org> <20210928022002.26286-4-shawn.guo@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Sep 2021 10:20:02 +0800, Shawn Guo wrote:
> QUSB2 PHY requires vdd-supply for digital circuit operation.  Add it for
> platforms that miss it.
> 
> 

Applied, thanks!

[3/3] arm64: dts: qcom: Add missing vdd-supply for QUSB2 PHY
      commit: 5663ca59bb4f1dfd2501f2af0bfdca93c4d47b3a

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
