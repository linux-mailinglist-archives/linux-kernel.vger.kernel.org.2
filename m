Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 374D33993DB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 21:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbhFBTup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 15:50:45 -0400
Received: from mail-oi1-f172.google.com ([209.85.167.172]:45627 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbhFBTun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 15:50:43 -0400
Received: by mail-oi1-f172.google.com with SMTP id w127so3801012oig.12;
        Wed, 02 Jun 2021 12:48:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jtV1ThCtM7t5bRqErtDMzcqKoHDyAJSDa1BT0RCscz0=;
        b=lv+CxC1sWowu//6J6+uYMXXcmZs6tOVJLT3B9f7Ba9yauzx4R9G6+UE4C5lfp2Z0iH
         IHXf7/UjKvPMHuibWVNYW9tHo8tbXtEbfZPNNmlFCXeNshfpLcQSTrAyZm9x1XnuciKl
         3oWIWx2VyPdsmhJfTKYmJI/6D4HWTNdSLTQFtcyQKCxGqSEvU57M8J+sZDFs/+sNHgNk
         JxDQ/Fm+hvuQkmVrwJHG8rDuTVI4os8fX4gg+jB6bF2JG+12NxSyC5ZIjetEYHT0rlzg
         obRIKjBnVElbSQb2NQQG61pXmDq0wwM+nwby8wtg643nv7Jz0KqCZUTKE99/arZJvxHo
         HjPA==
X-Gm-Message-State: AOAM531ZY2TxcZ6F1+z9ltIyH6pAH+PdzBoGem5ukgGR5E8orogpXGna
        ZzjZbde9hucTOO32z7Fl8w==
X-Google-Smtp-Source: ABdhPJz/oLI4K1/9AxZkHckLFH5qLUyGTkbUyEG9RqzfzQ4n8Q2R5Uu6t5AsQVEeCrA2+xnWW9JlLA==
X-Received: by 2002:a05:6808:6:: with SMTP id u6mr4935800oic.80.1622663339562;
        Wed, 02 Jun 2021 12:48:59 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a14sm180880otl.52.2021.06.02.12.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 12:48:58 -0700 (PDT)
Received: (nullmailer pid 3869918 invoked by uid 1000);
        Wed, 02 Jun 2021 19:48:58 -0000
Date:   Wed, 2 Jun 2021 14:48:58 -0500
From:   Rob Herring <robh@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/4] ASoC: dt-bindings: wcd934x: add bindings for
 Headset Button detection
Message-ID: <20210602194858.GA3869855@robh.at.kernel.org>
References: <20210524110700.27077-1-srinivas.kandagatla@linaro.org>
 <20210524110700.27077-2-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210524110700.27077-2-srinivas.kandagatla@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 May 2021 12:06:57 +0100, Srinivas Kandagatla wrote:
> Add bindings required for Multi Button Headset detection.
> WCD934x support Headsets with upto 8 buttons including, impedance measurement
> on both L/R Headset speakers and cross connection detection.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  .../bindings/sound/qcom,wcd934x.yaml          | 30 +++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
