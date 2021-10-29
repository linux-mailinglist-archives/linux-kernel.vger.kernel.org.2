Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAAA443F4A0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 03:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbhJ2Bxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 21:53:30 -0400
Received: from mail-oi1-f175.google.com ([209.85.167.175]:38815 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbhJ2BxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 21:53:23 -0400
Received: by mail-oi1-f175.google.com with SMTP id t4so11115535oie.5;
        Thu, 28 Oct 2021 18:50:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=n3Ihh87f3IefFIDSPqowySAnHL88IGrjudgGPD0ZkIA=;
        b=HR9N6g4x8PrUfee34BgOrI4Sq8aPyCiB+sy7BbFd8VNPsGUltISJoIgl/VO4zyF1gH
         +KYo1Qnc1smhQ8WKP5XZKfo0M/3AVhgSw/0X++ai9MYHfykkd7KlH5R+8ICd/+VPRugd
         HRxuK/qZsk5KiMbRl9A/zrCbQCDUtj+ogyGhAQmopI5MYnqLT08XVT7QYA+GPSq44lT5
         /6ZM8LIwv+SOcH/VeDM2W2Rud0zLEr8BnKkYAaip3coUKpzX1vuAVT3SwO5+Tz2hySYn
         QLQKy++Oi3gb/wzA2/J1RmB21oKHz6eRueJvrwK+9LbD5AeV71W/rguiauHvXj4JJlEy
         Fd9g==
X-Gm-Message-State: AOAM533D7QQ4U2ktuGdTx7SXyx6ZH64dnP0tiv55Op7hciuJyS5JviCB
        vyNGwdGn602tFGhRb1AoUA==
X-Google-Smtp-Source: ABdhPJzBNoEnIm5IEbc2rw19homkNQyHpa+LWVyMziQilq7LHXnUJAXP8Z7eXnyqMKCpBdcYkfMeFw==
X-Received: by 2002:a54:4e1d:: with SMTP id a29mr5606670oiy.39.1635472255224;
        Thu, 28 Oct 2021 18:50:55 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id j25sm5466oos.23.2021.10.28.18.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 18:50:54 -0700 (PDT)
Received: (nullmailer pid 988667 invoked by uid 1000);
        Fri, 29 Oct 2021 01:50:53 -0000
Date:   Thu, 28 Oct 2021 20:50:53 -0500
From:   Rob Herring <robh@kernel.org>
To:     Julian Braha <julianbraha@gmail.com>
Cc:     sam@ravnborg.org, airlied@linux.ie, thierry.reding@gmail.com,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org, daniel@ffwll.ch
Subject: Re: [PATCH RESEND v2 1/2] dt-bindings: panel-simple-dsi: add Tianma
 TL057FVXP01
Message-ID: <YXtTfWTa9nUQLzzK@robh.at.kernel.org>
References: <20211021213445.17289-1-julianbraha@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211021213445.17289-1-julianbraha@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Oct 2021 17:34:44 -0400, Julian Braha wrote:
> Adds the bindings for the Tianma TL057FVXP01 DSI panel,
> found on the Motorola Moto G6.
> 
> v2:
> Fixed accidental whitespace deletion.
> 
> Signed-off-by: Julian Braha <julianbraha@gmail.com>
> ---
>  .../devicetree/bindings/display/panel/panel-simple-dsi.yaml     | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
