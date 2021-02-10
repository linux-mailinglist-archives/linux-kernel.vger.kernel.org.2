Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4806531711F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 21:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233231AbhBJUTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 15:19:23 -0500
Received: from mail-oi1-f178.google.com ([209.85.167.178]:37402 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233224AbhBJUSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 15:18:41 -0500
Received: by mail-oi1-f178.google.com with SMTP id y199so3499153oia.4;
        Wed, 10 Feb 2021 12:18:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PghPjc/EDyUZ+Xv9BQGl3x1AgRl531Jn7MQbiU3ehz8=;
        b=Tra4HvSuf0Dsdcx2FgmL8qXl0ikVJVHY94SKw2nhe4aHsUL0jPNDrFoxJV0VakyK/g
         MqMbwK0eSKnkhWkDTbqBCfIcgnAxGOR8FZDZAOzIPKU3ZeqPFDbV3ggj0XsWaA/o+o/2
         /vbFvGQuyT6uCJoTEPEhFgiqVMsjEw+7/0c2+N1yTJsCQnTN2eHZNIBuyr72GHKPCiVl
         FdZvdsSV4AHA+ktniHsnxwll1fuGaxFerO2PvGVWHI2ZDDdJ/pS/MkG0v32TDwdkvCMp
         bOjvIwdjxKJxvbjynxV90LwA1MULZt9xcyjVqJaMqC0WU+76c5gjogHTR2DF3GKvKH7Q
         9thQ==
X-Gm-Message-State: AOAM5325rBE3Qu7msCmJvNf2ibBCirZOsE1pwWTW76OZ9Q9bmnPkGH8X
        HbMBLIeV9CE87RM2a6xfrg==
X-Google-Smtp-Source: ABdhPJzZlowNIv/ACD6W8hqSxqNRvgQacbTlIF2kKTHuTSotK7FjhvPDFcOX1itOFJV9IHnTcDB4RQ==
X-Received: by 2002:a05:6808:13c4:: with SMTP id d4mr570253oiw.90.1612988280377;
        Wed, 10 Feb 2021 12:18:00 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q7sm682011oif.1.2021.02.10.12.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 12:17:59 -0800 (PST)
Received: (nullmailer pid 2688296 invoked by uid 1000);
        Wed, 10 Feb 2021 20:17:58 -0000
Date:   Wed, 10 Feb 2021 14:17:58 -0600
From:   Rob Herring <robh@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     broonie@kernel.org, lgirdwood@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH v4 5/7] ASoC: qcom: dt-bindings: add bindings for lpass
 tx macro codec
Message-ID: <20210210201758.GA2688240@robh.at.kernel.org>
References: <20210210093055.18350-1-srinivas.kandagatla@linaro.org>
 <20210210093055.18350-6-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210093055.18350-6-srinivas.kandagatla@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Feb 2021 09:30:53 +0000, Srinivas Kandagatla wrote:
> This binding is for LPASS has internal codec TX macro which is
> for connecting with Soundwire TX codecs like WCD938x.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  .../bindings/sound/qcom,lpass-tx-macro.yaml   | 67 +++++++++++++++++++
>  1 file changed, 67 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/qcom,lpass-tx-macro.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
