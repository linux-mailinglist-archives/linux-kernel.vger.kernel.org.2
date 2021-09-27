Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B98D641A3B3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 01:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238096AbhI0XPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 19:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238146AbhI0XPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 19:15:36 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37565C061740
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 16:13:58 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id o59-20020a9d2241000000b0054745f28c69so24547134ota.13
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 16:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fGTt2hnfWiF6e7IYGzXXWDUKyh0sx2hrjsxfMx+frmk=;
        b=bqDgmGGkGcNjFJyVl93eWsMtetWorm4Y5NpIDD6z8sKlV/AAZrMxEToHIVeiAlqoUU
         8lGHMB6zWrpHjYLEc//Ur49ue1GQJZP8598jcs8uv/Z1kjtDy7F7vnoXotv0GVTm8Hbg
         7Dy9FL84QNA8O7IAnoDeoVRF6TOcvW5MAdRSw0x3TFR9xgzPo7uYXKIv9dlmO+vXQeol
         RBWH7ccRfEyk62GSNtMDKcqt5eNr/S0KhH8NMc9jfGWBWrA9OWFTyO2cJL/Y0cFFwl6U
         CurhskZAxcY+Vdg3jiIkwyaB+brt0wgenOr+9hKNIGZpwcfEDabnKXs/0DQWuyAGlBu5
         AKUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fGTt2hnfWiF6e7IYGzXXWDUKyh0sx2hrjsxfMx+frmk=;
        b=yQXDm/cb2OuWYV0wYXTsbcgJodsbjAhSsNsCGT6EpNLHVzMe+Nh01jySwHpZTU427C
         3GOvZSHI2BkI8N2xjcVOcML6kaeV7Ypx1EMP4tZaiG+X9VOm9D7SG9Yw/m0jHiQa6Dsc
         Wm0j/QW2L0t+eipMuiprErBXegFDe37u8GfEPpbf/AftsovK8NvUpp34vkNoay6HzI3d
         1X1y6rgHpqxGR7pdtE4sPEdPE17+5yluRvA92AeOH57KbiYx6b/aRXGdCEwNl+N45dHJ
         7uz9s1E3/c4V8+AbRxDfPJ2RBu+XIKIE6i4nP7JvxcS4/6gMyHyqlCGyBy+YZZpxL+G3
         iWWw==
X-Gm-Message-State: AOAM5329v3rPMLsElAQdSbCSssewFMX2QKDVhh6wpnhlMNX6dPdub/Zu
        qjKvEJHxWmVU1aUT37jjc+RlIw==
X-Google-Smtp-Source: ABdhPJwHC7Lr7HpBuR21ixlUXCwVbpfVNFO9RX/rYG9B2yRCe1NnnWqO5rDMMr1PT1LNN01H2Inukw==
X-Received: by 2002:a9d:6347:: with SMTP id y7mr2206399otk.241.1632784437605;
        Mon, 27 Sep 2021 16:13:57 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id p21sm4162268oip.28.2021.09.27.16.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 16:13:57 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     robh+dt@kernel.org, mka@chromium.org, will@kernel.org,
        Sibi Sankar <sibis@codeaurora.org>, swboyd@chromium.org,
        saiprakash.ranjan@codeaurora.org
Cc:     evgreen@chromium.org, linux-remoteproc@vger.kernel.org,
        robin.murphy@arm.com, linux-kernel@vger.kernel.org,
        joro@8bytes.org, p.zabel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, agross@kernel.org,
        devicetree@vger.kernel.org, dianders@chromium.org, ohad@wizery.com,
        mathieu.poirier@linaro.org
Subject: Re: (subset) [PATCH v5 05/10] remoteproc: mss: q6v5-mss: Add modem support on SC7280
Date:   Mon, 27 Sep 2021 18:13:52 -0500
Message-Id: <163278440375.1524647.12772375211634032908.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <1631886935-14691-6-git-send-email-sibis@codeaurora.org>
References: <1631886935-14691-1-git-send-email-sibis@codeaurora.org> <1631886935-14691-6-git-send-email-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Sep 2021 19:25:30 +0530, Sibi Sankar wrote:
> Add out of reset sequence support for modem sub-system on SC7280 SoCs.
> It requires access to an additional set of qaccept registers, external
> power/clk control registers and halt vq6 register to put the modem back
> into reset.
> 
> 

Applied, thanks!

[05/10] remoteproc: mss: q6v5-mss: Add modem support on SC7280
        commit: 529a0113177abe487614a0cba462d9973caa8c2a

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
