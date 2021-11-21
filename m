Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3CA45811E
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Nov 2021 00:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237944AbhKTX7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Nov 2021 18:59:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237765AbhKTX64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Nov 2021 18:58:56 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67CD2C061748
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 15:55:52 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id a23-20020a9d4717000000b0056c15d6d0caso22711725otf.12
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 15:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=lRyDgQhOd/ltJVzT23Z2jbf6M0giTa3yBgAnJ8ZBKwc=;
        b=OppVzNlNs1kge6a4STbHbopzetkTnWILN99dxTo91wNadCPCD+qA+etu0groGlhhun
         d2k6QckrXRnFGZfrFioOtA6GTL50Fqg4Fs73uNK4tusiU+Ex63NRQTj8f7euoJfzkr0b
         ZRD1TRs5Xi+q8FszHIIKV63xfqHgka0Ez9V8LDCzLJcgmy2j4wueipUJG4n70nhAmzqx
         OflN43ZUDuLUZmHV9Hn30dqWunK6J1ue6LORbAd+WJGOc5MwwhqyRoyFQQ4qx2cT9ORE
         IASCu+OfpodsnkecPy7rGjKJ2S97c4hwke4fH/WqTHDGgsD1HO0lQ65euH8wwWYC99/T
         3nfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lRyDgQhOd/ltJVzT23Z2jbf6M0giTa3yBgAnJ8ZBKwc=;
        b=MDVvVLBmWsZ5b315S1rxK7MhFFoZ3tIHWtjyP+lG6a40fpow8zTB/hrlDQeo/VJ8rX
         jnp0F6ztsGfZ5FMRYRcM0Dtf0hc3Y1DN2pifVpR+VxLweZ4gjiCiZM+WxXgDz0seQc2z
         EG36ZXIsoEMkupmjAPAVw5XRv7XGWGVwnf4v4KdQChIIwIaaUDkxfb/nhqclg6Bt57bF
         jfC1CuNXnYGt9IlldbGXFdJxZ5tS02yoVkMcyx4UDCoKYVQC3224SHaXOIErGsBfo3tz
         rWW8HAfCooq5tBE2zyG1jiLm9drpy0BI339/fnJwoxzp2L7IUBlYlWDpZcmtV7eHbT9Q
         4l7Q==
X-Gm-Message-State: AOAM532BxDL8MiQgzpwym5NBWC2pP5wShZoIdckoEfauRs6ZhqKaQ92n
        lcznaSYLomFQVotPOqQSL1ZLfg==
X-Google-Smtp-Source: ABdhPJyt/Dw/tn9oCsObV3pkyxAGnQ6CB9dlk/dvTGhpz0lxaQcoqgJpXaIqa+mA2Huf2nEGUraYGA==
X-Received: by 2002:a05:6830:232e:: with SMTP id q14mr14799756otg.133.1637452551828;
        Sat, 20 Nov 2021 15:55:51 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id o26sm828474otj.14.2021.11.20.15.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Nov 2021 15:55:51 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Robert Marko <robimarko@gmail.com>,
        robh+dt@kernel.org, agross@kernel.org
Subject: Re: (subset) [PATCH] arm64: dts: qcom: ipq8074: add MDIO bus
Date:   Sat, 20 Nov 2021 17:55:28 -0600
Message-Id: <163745250540.1078332.4349681413991254316.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211007115846.26255-1-robimarko@gmail.com>
References: <20211007115846.26255-1-robimarko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Oct 2021 13:58:46 +0200, Robert Marko wrote:
> IPQ8074 uses an IPQ4019 compatible MDIO controller that is already
> supported in the kernel, so add the DT node in order to use it.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: ipq8074: add MDIO bus
      commit: d201f67714a302b12ad3d78b982963342939629c

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
