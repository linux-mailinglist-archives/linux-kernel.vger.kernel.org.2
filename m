Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22C33366A33
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 13:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238459AbhDUL4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 07:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234800AbhDUL4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 07:56:36 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B33C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 04:56:01 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id e7so32107486wrs.11
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 04:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eA2+GdzjmDlaKe1AeHTuApOJCWhzb0IRtZ0HZSP/vKQ=;
        b=YWDMmZhypQ8JPCGyjSkNop/VspTvOdvkPkaE7ZnMU0WqBQp/oWWCrL/y+4UkePHZOp
         FocKk2n+5bgqOrjULSwuk7620OjDaqDvjn0F4iuh0rXVTAhK/dC5uFfEfjY283EIWcUP
         pwvsNEwdTO39+ihKxjyZ+IC75WjTdHvjJRYP5Mi4AQA0Vdit5Dt25H8Sy0PBieBHvJwK
         mkVC5j6TKmiIG8hh8KQvUkTeFbSQOTRatMZ+CqHcEoc7rxr+jrP062DZh/TWM26dDN5i
         ir/IZ/Tg1AgAU9MFO82JvdqCjDyDddJmpzppnjH/9pAJ9K9xqtmolqI+dE5RdTnbKvUu
         canw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=eA2+GdzjmDlaKe1AeHTuApOJCWhzb0IRtZ0HZSP/vKQ=;
        b=ixp7bfMjalhkVYr2FteO5GZUw9H0HVOTF2ZOo4oq+3CjLBjVCWMBTt04UReyHxQLPx
         afYoffkImULmOsmwHwe6M0AVNt1FeXlb5+FBSVI2pEcJXZXhcT58V5/iD19YM7cGREAE
         jqIGSzdQJC+1uymD5/SyP9gQWPLe+4hzbgF2q6lZkdiwoP6fcL1jlye9T/MqBjpoTLoE
         2WdqHbe9W6Wb7259+12ivvLrHkxfhS7fCeRdPnTBXPDNpNQp86vx1+K3z+ckW8bpscIl
         9qc7w6chHmyFSNk3ey/bkgTf0JkRi9iDtp1vT7R2BiOC3u6QCX6Yicl9CdW3hhBJiOKD
         KTXw==
X-Gm-Message-State: AOAM532fYL8q+Pv7hy636mqp1iMfDiqdPo/dAdoBhPMkh1pVRdAUjagM
        09FvTdO10KCNJouG76ymkUWX6oMWXvxm5baB
X-Google-Smtp-Source: ABdhPJwlaMDo/ZMBZlwU1omRxqUpT6BT0PXYg/69sx48gKsR+lWqcCCVom1+ar5AD5oJc2UCTpx5qQ==
X-Received: by 2002:adf:bc09:: with SMTP id s9mr26074732wrg.329.1619006160111;
        Wed, 21 Apr 2021 04:56:00 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:90c:e290:f781:73d5:3127:752d? ([2a01:e0a:90c:e290:f781:73d5:3127:752d])
        by smtp.gmail.com with ESMTPSA id g132sm2161190wmg.42.2021.04.21.04.55.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Apr 2021 04:55:59 -0700 (PDT)
Subject: Re: [PATCH v4 0/3] drm/bridge: Add it66121 driver
To:     a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com,
        paul@crapouillou.net, robert.foss@linaro.org
Cc:     jonas@kwiboo.se, jernej.skrabec@siol.net,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20210419071223.2673533-1-narmstrong@baylibre.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <b2b8fef3-6a49-3884-8d06-99f6b8997e1f@baylibre.com>
Date:   Wed, 21 Apr 2021 13:55:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210419071223.2673533-1-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/04/2021 09:12, Neil Armstrong wrote:
> The IT66121 is a high-performance and low-power single channel HDMI
> transmitter, fully compliant with HDMI 1.3a, HDCP 1.2 and backward
> compatible to DVI 1.0 specifications.
> It supports pixel rates from 25MHz to 165MHz.
> 
> This series contains document bindings, add vendor prefix, Kconfig to
> enable or not.
> For now, the driver handles only RGB without color conversion.
> Audio, CEC and HDCP are not implemented yet.
> 
> Changes since v3 at [2]:
> - DT
>  - removed i2c reg description
>  - used 4 spaces indent in example
>  - added review tags
> - driver
>  - added missing includes
>  - added missing atomic bridge callbacks
>  - dropped connector creation completely, only supports NO_CONNECTOR
>  - moved single line helpers to inline
>  - some more indentation cleanups
> - MAINTAINER
>  - fixed order
>  - added review tags
> 
> Changes since v2 at [1]:
> - fixed DT bindings by:
>   - adding bus-width property to input port
>   - correctly defining ports
>   - other minor fixes
> - fixed bridge driver by:
>   - general cleanup following Andy's comments
>   - implemented support for NO_CONNECTOR
>   - makes basic usage of the bus width property
>   - add support for bus format negociation
>   - other minor fixes
> - fixed order of MAINTAINERS entries
> 
> [1] https://lore.kernel.org/r/20200311125135.30832-1-ple@baylibre.com
> [2] https://lore.kernel.org/r/20210412154648.3719153-1-narmstrong@baylibre.com
> 
> Phong LE (3):
>   dt-bindings: display: bridge: add it66121 bindings
>   drm: bridge: add it66121 driver
>   MAINTAINERS: add it66121 HDMI bridge driver entry
> 
>  .../bindings/display/bridge/ite,it66121.yaml  |  124 ++
>  MAINTAINERS                                   |    8 +
>  drivers/gpu/drm/bridge/Kconfig                |    8 +
>  drivers/gpu/drm/bridge/Makefile               |    1 +
>  drivers/gpu/drm/bridge/ite-it66121.c          | 1021 +++++++++++++++++
>  5 files changed, 1162 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/ite,it66121.yaml
>  create mode 100644 drivers/gpu/drm/bridge/ite-it66121.c
> 

Applied to drm-misc-next !
