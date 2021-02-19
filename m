Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCA6832001A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 22:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbhBSVFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 16:05:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbhBSVFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 16:05:47 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF44C06178B
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 13:05:07 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id h8so6938992qkk.6
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 13:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=2lYVwDZ5xTKUwF0mymslM5RS9V2GXg9sfn8REyRMvCA=;
        b=XxL9buqMx+LsIthjD3ggZfUkF57HvltQyUIlckOET+Dnlj1DMMnTcRyal5im+Zbnhy
         RGm4dLvA0GfRz/LAY23MFOfsOTZVTgEhOsuB+S51BTAfF+NUAy9dAL5vAOdPYsGYaHh5
         aCSiDX4FGRcMH+VazBZLZKCAtcAjNA5bgGydgR9q7y3c6AiCQUYDPLHVQzNP55sWU2nT
         uq5eYxb5EnyR7MXSyzCXZn6WwY57E0Dg/ZPObikz5UeGL4j3iIFV+aXgTmwZtOO4at3g
         AIjsHcB3AhiZ6IAEa/Y13feY8FUZURxkAoVqHxsAZrHDNFr4zozEtFyNdxUoAd1q8itO
         r7/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=2lYVwDZ5xTKUwF0mymslM5RS9V2GXg9sfn8REyRMvCA=;
        b=JHVxXxFKjRQ5Awu6Qhc5wSEFdksG7sDvRBbJ4uB0NGp03kA65BsyOcabwiOd8iJhdK
         FgUaKpSvWwYIKalPBf1MjA2v6FMz7x+FW7aMGUJ0gG3bCmP6LvRW4dMzyLMOLjReAgeS
         c738HNJxfcmwmYLeDpeJzVfiB3bw9lr7VqRg/65uNNnwodJWE4N/WrFP2+P2xp9Hmziv
         zRSmjObGLq8s/M14hKoGFHhrVNJIaYyKEBoN7uLwe8jnFnVCqpsCBAyapKWSwiGVQ7G/
         CcohgzZnesakXwaoIpP7Rwt4ijaxVxkdDt0QJxmXBxJdQfNIxPZ+wne4OkzUF65kjprm
         Y4cA==
X-Gm-Message-State: AOAM533IWk7KAXzCdkJNOm+3EW2Q0eIpiN+G+W+QoG4D8gmxoDctcNLn
        mEPdL7eUP3aQEWpYinLAe56jnA==
X-Google-Smtp-Source: ABdhPJwFj/g4tXLD4UbzIckyGXi2xjGGTTe6X/bPWOw11OOdhOQaT2wn5CSRaSkuI+ubBTAZP+erUw==
X-Received: by 2002:ae9:e311:: with SMTP id v17mr10907522qkf.155.1613768706213;
        Fri, 19 Feb 2021 13:05:06 -0800 (PST)
Received: from nicolas-tpx395.lan (173-246-12-168.qc.cable.ebox.net. [173.246.12.168])
        by smtp.gmail.com with ESMTPSA id r80sm7216431qke.97.2021.02.19.13.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 13:05:05 -0800 (PST)
Message-ID: <39f17656195110cc5298f53840ca02f790d7e4af.camel@ndufresne.ca>
Subject: Re: [PATCH v5 01/22] media: camss: Fix vfe_isr_comp_done()
 documentation
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Robert Foss <robert.foss@linaro.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, todor.too@gmail.com,
        mchehab@kernel.org, robh+dt@kernel.org,
        angelogioacchino.delregno@somainline.org,
        linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Andrey Konovalov <andrey.konovalov@linaro.org>
Cc:     Rob Herring <robh@kernel.org>, Tomasz Figa <tfiga@chromium.org>,
        Azam Sadiq Pasha Kapatrala Syed <akapatra@quicinc.com>,
        Sarvesh Sridutt <Sarvesh.Sridutt@smartwirelesscompute.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jonathan Marek <jonathan@marek.ca>
Date:   Fri, 19 Feb 2021 16:05:03 -0500
In-Reply-To: <20210217112122.424236-2-robert.foss@linaro.org>
References: <20210217112122.424236-1-robert.foss@linaro.org>
         <20210217112122.424236-2-robert.foss@linaro.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3 (3.38.3-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robert,

not really a review, but I noticed ....

Le mercredi 17 février 2021 à 12:21 +0100, Robert Foss a écrit :
> Function name is comment is wrong, and was changed to be

                in

> the same as the actual function name.
> 
> The comment was changed to kerneldoc format.
> 
> Signed-off-by: Robert Foss <robert.foss@linaro.org>
> ---
> 
> Changes since v1
>  - Bjorn: Fix function doc name & use kerneldoc format
> 
> 
>  drivers/media/platform/qcom/camss/camss-vfe.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/camss/camss-vfe.c
> b/drivers/media/platform/qcom/camss/camss-vfe.c
> index fae2b513b2f9..94c9ca7d5cbb 100644
> --- a/drivers/media/platform/qcom/camss/camss-vfe.c
> +++ b/drivers/media/platform/qcom/camss/camss-vfe.c
> @@ -1076,8 +1076,8 @@ static void vfe_isr_wm_done(struct vfe_device *vfe, u8
> wm)
>         spin_unlock_irqrestore(&vfe->output_lock, flags);
>  }
>  
> -/*
> - * vfe_isr_wm_done - Process composite image done interrupt
> +/**
> + * vfe_isr_comp_done() - Process composite image done interrupt
>   * @vfe: VFE Device
>   * @comp: Composite image id
>   */


