Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D37894380AF
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Oct 2021 01:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbhJVXjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 19:39:31 -0400
Received: from mail-ot1-f50.google.com ([209.85.210.50]:40702 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbhJVXja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 19:39:30 -0400
Received: by mail-ot1-f50.google.com with SMTP id s18-20020a0568301e1200b0054e77a16651so6259904otr.7;
        Fri, 22 Oct 2021 16:37:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aHPsIxbcapvVWGDgzw9OJ7HXmoNqDvSGbV9691jEUzA=;
        b=fPyXpoN86Y8ncKdUpJSBf6Zbf1QHDGnnfhRhz82c/bTUTZ3YE2bM7b33SQwpsxGJCZ
         507nv6NiGCmELnNcFPx6D8NwTeBg4TKbubW4A+tycno5ukeYYgp0c9ijoscjPcy46obP
         qfPSXX9sVSWgncHEf0xcj2o3CEcd+EyR7AjHRpbgVf0AwSDahSubUIKkaUueGltYDa2m
         IdPwr2UiXT13XwsiU4VSSPJREhwMUrhLokyiNRd5FZU+v0uv2ozMBHr/widgjxwRe0+l
         g01mNW3+wxlEW2KPh0Limgc4xJPVU2TOODCmCyo57mYZVBAz7GSCLnUddiItK96HT9UG
         rvnw==
X-Gm-Message-State: AOAM533rBnWY5L94j86v2Uw9Ve8rwXu9idoeUiARHNkseOvELuGNDkVg
        UekH2vvrOr2xFC2jmqQMvA==
X-Google-Smtp-Source: ABdhPJyGusuG3Xe+ltcV2VNUzn3Q3aEqUebx3PD43lBIOljUnppVJu/jWBiZYCDU0fTKidHQi4V0IQ==
X-Received: by 2002:a9d:53c4:: with SMTP id i4mr2153509oth.176.1634945832350;
        Fri, 22 Oct 2021 16:37:12 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id bj14sm2376387oib.3.2021.10.22.16.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 16:37:11 -0700 (PDT)
Received: (nullmailer pid 3385679 invoked by uid 1000);
        Fri, 22 Oct 2021 23:37:10 -0000
Date:   Fri, 22 Oct 2021 18:37:10 -0500
From:   Rob Herring <robh@kernel.org>
To:     George Song <george.song@maximintegrated.com>
Cc:     broonie@kernel.org, robh+dt@kernel.org, george.song@analog.com,
        steves.lee@maximintegrated.com, alsa-devel@alsa-project.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, ryans.lee@maximintegrated.com
Subject: Re: [v5 1/2] ASoC: dt-bindings: max98520: add initial bindings
Message-ID: <YXNLJkzWTBoqVa1n@robh.at.kernel.org>
References: <20211020083055.23625-1-george.song@maximintegrated.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211020083055.23625-1-george.song@maximintegrated.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Oct 2021 17:30:54 +0900, George Song wrote:
> add initial bindings for max98520 audio amplifier
> 
> Signed-off-by: George Song <george.song@maximintegrated.com>
> ---
>  .../bindings/sound/maxim,max98520.yaml        | 36 +++++++++++++++++++
>  1 file changed, 36 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/maxim,max98520.yaml
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

