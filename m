Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6FB4327F4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 21:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233182AbhJRTwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 15:52:04 -0400
Received: from mail-ot1-f47.google.com ([209.85.210.47]:45916 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbhJRTwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 15:52:03 -0400
Received: by mail-ot1-f47.google.com with SMTP id l16-20020a9d6a90000000b0054e7ab56f27so1181065otq.12;
        Mon, 18 Oct 2021 12:49:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=21IgNcOzTW10vAg0/6zH/SOZJHt58u5z1E5yUcMpGQ4=;
        b=RrSUsGhmJQAai5a4GE9/b1DDF70+dDQD/a2VrFclndEw6HYfFKNkH0TOL2eMwu6FWA
         VP8k0u4aO8Xd5YgI4pcVOPcBCtUHRgfpnBxrFP4PI5/cqea5/b6H9550vZqfSH10WJw7
         oD19z0N+5lwOWRFacQwEuLf0CTWv7oJ+ojFIvefGhmvw851+RICUw8Ne7p60de7Oa9bx
         oA16fa79WhvuOWdLKuX0K0O/fjSNqowfth6cQ11IGdP5nepXH0d0CgoQh03ZEnlYKKDo
         0mHs9ztGFSe4m1cfswQoiDxpDlb7uejuc4OHSCpCOEDVGDyYP6UjK6NIZm9tTDLOC4b2
         4uZw==
X-Gm-Message-State: AOAM532OVSYpevh2WAIfWeIqhTtpniQKgrZUcHHz128fByT66FVA+ED0
        rk6AI98nhTWMyYUEZrl1Og==
X-Google-Smtp-Source: ABdhPJzvzvwjO4OXfCnPr5/eILTq2Lq4LVXtAin4yo7u1XW3BSDA6T7gghsm8NbySfxKCRuzK53t9A==
X-Received: by 2002:a05:6830:23a6:: with SMTP id m6mr1567801ots.38.1634586591549;
        Mon, 18 Oct 2021 12:49:51 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id j8sm2623027ooc.21.2021.10.18.12.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 12:49:51 -0700 (PDT)
Received: (nullmailer pid 2837570 invoked by uid 1000);
        Mon, 18 Oct 2021 19:49:50 -0000
Date:   Mon, 18 Oct 2021 14:49:50 -0500
From:   Rob Herring <robh@kernel.org>
To:     George Song <george.song@maximintegrated.com>
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        steves.lee@maximintegrated.com, broonie@kernel.org,
        george.song@analog.com, robh+dt@kernel.org,
        ryans.lee@maximintegrated.com, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [v3 1/2] ASoC: dt-bindings: max98520: add initial bindings
Message-ID: <YW3P3ggca5CinwXH@robh.at.kernel.org>
References: <20211018083554.5360-1-george.song@maximintegrated.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211018083554.5360-1-george.song@maximintegrated.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Oct 2021 17:35:53 +0900, George Song wrote:
> add initial bindings for max98520 audio amplifier
> 
> Signed-off-by: George Song <george.song@maximintegrated.com>
> ---
>  .../bindings/sound/maxim,max98520.yaml        | 36 +++++++++++++++++++
>  1 file changed, 36 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/maxim,max98520.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
