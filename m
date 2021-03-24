Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A15EC348063
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 19:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237520AbhCXSXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 14:23:10 -0400
Received: from mail-il1-f175.google.com ([209.85.166.175]:38457 "EHLO
        mail-il1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237354AbhCXSW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 14:22:59 -0400
Received: by mail-il1-f175.google.com with SMTP id d10so15477291ils.5;
        Wed, 24 Mar 2021 11:22:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+7jD9Ziw+YPY/ufj9WrL5bWKS/awbf5purcgVlFjpng=;
        b=DZYsRu+78xhPgTHbur8Fq/BdrU6UCjVyI4j4BD2qNntc/D/k5JsAI68V6OYp5FQ9hN
         MYIBp1e6YiyFz5cD8X37n1sU3JmhZNYwgjCuIU2OTbW2irfJecbOvSNGQizCE9xqNgrR
         ApuFA7QrTyUYEdcrkRdhBHwu0uSRmJA2AuWEFsxdiagwDD4fljcCswtgRt5oL3CBnwr8
         Upm99frxgRvYp+Kt0e+gE9IDtd7LOrxhVX3TCpk7PWr//rgH9XPiCuQ+SIqMAi1bCNkg
         AR0ieNcTiO6yuEzb9/grUJRjry4j21xG8Gm+iDznipn6AKwjfaLJCiZRtAkCoz6Br47k
         qlug==
X-Gm-Message-State: AOAM531u14UEj/97spe9auiG9gAS2+HV84d/INnxoQYDXrOlRTHajoYD
        0IEsR7V+3L7xZETVsRVYMQ==
X-Google-Smtp-Source: ABdhPJwVb9jNY+tf48aCkvEKARd+56FFc2A96PY8V0WlIyLx6KzFPooDrUWIeMIWNHDl/AImI3EhAA==
X-Received: by 2002:a05:6e02:10d1:: with SMTP id s17mr3615039ilj.159.1616610178809;
        Wed, 24 Mar 2021 11:22:58 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id k3sm1404464ioj.35.2021.03.24.11.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 11:22:58 -0700 (PDT)
Received: (nullmailer pid 3375422 invoked by uid 1000);
        Wed, 24 Mar 2021 18:22:56 -0000
Date:   Wed, 24 Mar 2021 12:22:56 -0600
From:   Rob Herring <robh@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, vkoul@kernel.org,
        sanyog.r.kale@intel.com, yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, broonie@kernel.org
Subject: Re: [PATCH v4 4/5] ASoC: dt-bindings: wsa881x: add bindings for port
 mapping
Message-ID: <20210324182256.GA3375367@robh.at.kernel.org>
References: <20210315165650.13392-1-srinivas.kandagatla@linaro.org>
 <20210315165650.13392-5-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210315165650.13392-5-srinivas.kandagatla@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Mar 2021 16:56:49 +0000, Srinivas Kandagatla wrote:
> WSA881x SoundWire device ports are statically assigned to master ports
> at design time. So add bindings required to specify these mappings!
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  .../devicetree/bindings/sound/qcom,wsa881x.yaml          | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
