Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B33F43BF76
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 04:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236468AbhJ0CUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 22:20:49 -0400
Received: from mail-ot1-f50.google.com ([209.85.210.50]:35412 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232231AbhJ0CUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 22:20:48 -0400
Received: by mail-ot1-f50.google.com with SMTP id w12-20020a056830410c00b0054e7ceecd88so1552872ott.2;
        Tue, 26 Oct 2021 19:18:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7VRwiWsFW3qU9OClD0E6PGyfRVEAATUo35AgOU+oVAs=;
        b=5ZuH+r9XvszT4izr2V8H/q77qPdQ2pTi99jttqzaCkGdstuxx5bVfbEYjJPQ6hvmTT
         pjHOdETYcxmcJTS8fo+33owTmimbuZWLrAOFbqJl2bt6vgxwo8IQsFtx+Ar3YhBbOOdw
         BHVySXReaMLfYFRgNTwLx24bbb3LBMW1h8AaWFeydcKsS89hlLormECXxUYYz4HI8UIV
         MCnMggPjjAM0lUFbhrxPoO1Lyg89kmqDBFCQLpM5Qji/tH0ip5F7e4YAIzUC2uBHPIpB
         /Q8iN6Nc0HHUGqC6u3/c+F8EP6/Ik8w+X5nFjfhHrSo4xpqZx880kQYUv5pTvE+VvDoB
         Zx7A==
X-Gm-Message-State: AOAM530p1cRVJR5NMwk9PaNPAtiDTW+9Qmw8gFRCMUSIiq745i8S3xpP
        aRyebuu08CgQUKi07J0pTg==
X-Google-Smtp-Source: ABdhPJyv1pUrxa7Hiz1b6MtytdlGJV6SUTPZtbLUZyB4s9ILL8HXBapLEsoJv6AKeLk4kJofMM2s+g==
X-Received: by 2002:a9d:6009:: with SMTP id h9mr22691428otj.313.1635301103594;
        Tue, 26 Oct 2021 19:18:23 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id j15sm463929ots.58.2021.10.26.19.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 19:18:23 -0700 (PDT)
Received: (nullmailer pid 3814307 invoked by uid 1000);
        Wed, 27 Oct 2021 02:18:22 -0000
Date:   Tue, 26 Oct 2021 21:18:22 -0500
From:   Rob Herring <robh@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     a.hajda@samsung.com, daniel@ffwll.ch, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: display/bridge: tc358764: Convert to
 YAML binding
Message-ID: <YXi27l0bzbEmb65C@robh.at.kernel.org>
References: <20211018144003.878345-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211018144003.878345-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 18, 2021 at 04:40:03PM +0200, AngeloGioacchino Del Regno wrote:
> Convert the Toshiba TC358764 txt documentation to YAML.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
> Note: dtbs_check on exynos5250-arndale.dts will give some warnings after
>       applying this patch: since the preferred way is to have 'ports',
>       this warning was ignored.
>       I have no Exynos5250 board, so the dts fix is left to someone who
>       is able to test on the real hw.
> 
>  .../display/bridge/toshiba,tc358764.txt       | 35 -------
>  .../display/bridge/toshiba,tc358764.yaml      | 94 +++++++++++++++++++
>  2 files changed, 94 insertions(+), 35 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/display/bridge/toshiba,tc358764.txt
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/toshiba,tc358764.yaml

You haven't implemented any of Sam's feedback on v1.
