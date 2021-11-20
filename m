Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB643458107
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Nov 2021 00:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237629AbhKTX6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Nov 2021 18:58:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237599AbhKTX6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Nov 2021 18:58:46 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB96FC06174A
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 15:55:42 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id t23so29567307oiw.3
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 15:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1cyHcdgLfdv1R6sJAzHnEVVywe2LRNmMCsaDuVASIdw=;
        b=LZxbTSxNSa1DQpZOgCu815OFHSmLNIRLGKVk0I1N3GPaVZ9mVMhHQezrKJ+tFWYXfe
         cOzGEp7q7Vfzj6PKPU6ysPtLnhqrhT3gYYa0VC+AD0JIKpV7SAain7ra5hJKgLuzHTql
         2CSorUdEafrPeLPJV7PV6udXCsGCyzlJGVPwNlx07RuJm3jUYZPyLIRRgBty2kjw3PA6
         EBifhUlC0xiRNKiR4OnJrebhITzWn0DRsWc72EuasS/lpkcZFxpVF4+5JhEv1NVI+D+J
         L0wL+IL6kxFHGOACwkGwfbb3IhEMzr3EK5BzSL304gESzCMaHphNZQp4hOi2uLGxp/tD
         wReA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1cyHcdgLfdv1R6sJAzHnEVVywe2LRNmMCsaDuVASIdw=;
        b=OqN1oCbmNn4X67vyYf6rNgYqqt9vtMWfCyM/gNqYB178FEaYq5FQLitmy+tBIr9zY+
         7p1bf7xXuiQj+15b1dQipqMC552OzgKO4DjVnZiqcuKeiE/dhI+L0vGJILrR/NQzlnm1
         S0U8YIjhsTSqK/dIZ3NPYvVBaeDlKZU03GUmdJzcyULIMQ8u/qvt5yV+/L3wvqrs4dkk
         jNB6MgMCJbim4WIH3dcfO1UWOVrL7wvVd6Gn+gDJSGGeGR8xQBI2wpmlcW+4rbsNse5k
         6WaoFKXBPsN77Gh3RDuJfwz0WCVBChIqk8SAu7p8XL2iRb6gULC4gEPONuxqHCWpK6sH
         mvaA==
X-Gm-Message-State: AOAM531aLK0kwbNxcwzbQ049SJlLZHbk7pRIo3uFFHUG7+r3Mr/hjC7T
        K1tK4CtnT+cuKuniyhUyYClT4A==
X-Google-Smtp-Source: ABdhPJw9K/QfqlZf1rCFG17DFELFWItbff1nf8gcAot1DaBJjnNj7O7rgzxBI9joCR52LCECDx/8wg==
X-Received: by 2002:a05:6808:f87:: with SMTP id o7mr10610301oiw.122.1637452542293;
        Sat, 20 Nov 2021 15:55:42 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id o26sm828474otj.14.2021.11.20.15.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Nov 2021 15:55:41 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        David Heidelberg <david@ixit.cz>
Cc:     linux-arm-msm@vger.kernel.org, ~okias/devicetree@lists.sr.ht,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: usb: qcom,dwc3: add binding for IPQ4019 and IPQ8064
Date:   Sat, 20 Nov 2021 17:55:18 -0600
Message-Id: <163745250541.1078332.6779273361626681636.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211029103340.26828-1-david@ixit.cz>
References: <20211029103340.26828-1-david@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Oct 2021 12:33:38 +0200, David Heidelberg wrote:
> Add compatible string for Qualcomm IPQ4019 and IPQ8064 SoC.
> 
> 

Applied, thanks!

[1/2] dt-bindings: usb: qcom,dwc3: add binding for IPQ4019 and IPQ8064
      (no commit info)
[2/2] ARM: dts: qcom: update USB nodes with new platform specific compatible
      commit: 801cd261718e44adeb033c428390761adc03e2fc

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
