Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB176386F21
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 03:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345681AbhERB2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 21:28:55 -0400
Received: from mail-ot1-f51.google.com ([209.85.210.51]:34528 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238837AbhERB2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 21:28:54 -0400
Received: by mail-ot1-f51.google.com with SMTP id u25-20020a0568302319b02902ac3d54c25eso7293972ote.1;
        Mon, 17 May 2021 18:27:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=x5MuHDr1VuOYtFi32SjfZtdQohcWcKpREmn5Jo1hbuE=;
        b=Q27jtacByMq/gw5VqDadpH08wC36fpKKpU5wLJUDOqtIyhuApSrxxiyHh8CrWTPf6l
         AbeZ4sTyTJ5vjd7f/t4H6+4cYtmn/w80P1I7W/QFhDW9TqzbrxX41w1AAmS4eNCGobYQ
         IG2qdl6ZQclqoC5wq6qcCkGgNg8WnPMZDdU7c6oErk/h/kMUEhXMT7OO7KWA76yr2kmX
         kw3QfQujmTfCC5ur45A2CP9+12ud0o5HOubLSntEF2gTwjDXMDFXbsHz2ETLQ3nt+/uz
         b0weRlH/mCj1oA/sIpzWwD+9bzyZPVV5jOxnbEaWukDHqejVSRJ/5BV5eOKJhDdNu3wv
         Z7og==
X-Gm-Message-State: AOAM5319APeNdAdjl68EC3J2Pn9abE3ApVJSzgxbHIX3YoKPwGuEjpGp
        5LyINlU+YU3tbu3uRAOAPA==
X-Google-Smtp-Source: ABdhPJzW/WET1XynmeNegfDrhTPJIkFYbUP1pwCRoml9gTosHpax4KZkPIP2FBySmP+4CDjgKyLGDA==
X-Received: by 2002:a9d:ea2:: with SMTP id 31mr2193056otj.200.1621301257191;
        Mon, 17 May 2021 18:27:37 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 77sm2500602otc.54.2021.05.17.18.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 18:27:36 -0700 (PDT)
Received: (nullmailer pid 3600153 invoked by uid 1000);
        Tue, 18 May 2021 01:27:35 -0000
Date:   Mon, 17 May 2021 20:27:35 -0500
From:   Rob Herring <robh@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        broonie@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/9] ASoC: dt-bindings: wcd938x-sdw: add bindings for
 wcd938x-sdw
Message-ID: <20210518012735.GA3600100@robh.at.kernel.org>
References: <20210514103405.29927-1-srinivas.kandagatla@linaro.org>
 <20210514103405.29927-5-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210514103405.29927-5-srinivas.kandagatla@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 May 2021 11:34:00 +0100, Srinivas Kandagatla wrote:
> Qualcomm WCD9380/WCD9385 Codec is a standalone Hi-Fi audio codec IC
> connected over SoundWire. This device has two SoundWire devices RX and
> TX respectively. This bindings is for those slave devices on WCD9380/WCD9385.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  .../bindings/sound/qcom,wcd938x-sdw.yaml      | 70 +++++++++++++++++++
>  1 file changed, 70 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/qcom,wcd938x-sdw.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
