Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB6743BDF4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 01:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237478AbhJZXig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 19:38:36 -0400
Received: from mail-oi1-f178.google.com ([209.85.167.178]:37811 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234584AbhJZXif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 19:38:35 -0400
Received: by mail-oi1-f178.google.com with SMTP id o83so953627oif.4;
        Tue, 26 Oct 2021 16:36:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aL27fpyh+m4rC09TIGIfGG4t2Fp9eQL4JHIxdInBGZA=;
        b=l3h5aVRPqHIsqBU3KNzi2rEwR0CPN/68KpNZDBuD/8GxuY7oFFnGu/rbmVGERLLTq/
         aVmMVpgSZ6qm8n7MlaU5JKiaT9QmsEvwCwcsglfp0rN/r1vVFwtr+hBiuSgQSdNKJoZU
         Q7fsOfO4hzebueE745q7o2tb8rGxwO4Jv6bn05to+3j81jRyXedDhcYF14dOjZM2LGg+
         xCIeWw1prCjSQXGmx5LFwRSADYDlYYWM8mLLqK3C5PpMcwxmkPVKIF/ic2rK8xEbkWd4
         MOC/29DdMj3d5rVzzkw1UM+qhZmQ/Q7OMJcHMw67/CsYpyHFZIVU2G+K4xjlBkHx30RQ
         bRQQ==
X-Gm-Message-State: AOAM530tISMMNLNJMfyaOa+Gjj41nrW88r7JypfEYyygcfm3b41Ka+c4
        GJcvllnazt6+qBpMc304qA==
X-Google-Smtp-Source: ABdhPJyZ7JY+ahGPMk0kwlKWneszs92Rj1q/CcqeR9fru4UgGFV50VtR3x/IWVNI5i5R53ptJFSmjw==
X-Received: by 2002:a05:6808:14c2:: with SMTP id f2mr1324097oiw.99.1635291370941;
        Tue, 26 Oct 2021 16:36:10 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id w17sm5125073otm.50.2021.10.26.16.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 16:36:10 -0700 (PDT)
Received: (nullmailer pid 3536854 invoked by uid 1000);
        Tue, 26 Oct 2021 23:36:09 -0000
Date:   Tue, 26 Oct 2021 18:36:09 -0500
From:   Rob Herring <robh@kernel.org>
To:     Xin Ji <xji@analogixsemi.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, hsinyi@chromium.org, zhenli@analogixsemi.com,
        mripard@kernel.org, airlied@linux.ie, span@analogixsemi.com,
        sam@ravnborg.org, linux-kernel@vger.kernel.org,
        bliang@analogixsemi.com, drinkcat@google.com, broonie@kernel.org,
        ricardo.canuelo@collabora.com, daniel@ffwll.ch,
        laurent.pinchart+renesas@ideasonboard.com
Subject: Re: [PATCH v11 1/4] dt-bindings:drm/bridge:anx7625:add vendor define
Message-ID: <YXiQ6Q8zhY+RZRue@robh.at.kernel.org>
References: <e5f8aed7556535aeaf07b148bdbca7f5aec28203.1628161369.git.xji@analogixsemi.com>
 <20211018030323.2055114-1-xji@analogixsemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211018030323.2055114-1-xji@analogixsemi.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Oct 2021 11:03:23 +0800, Xin Ji wrote:
> Add 'bus-type' and 'data-lanes' define for port0. Add DP tx lane0,
> lane1 swing register setting array, and audio enable flag.
> 
> The device which cannot pass DP tx PHY CTS caused by long PCB trace or
> embedded MUX, adjusting ANX7625 PHY parameters can pass the CTS test. The
> adjusting type include Pre-emphasis, Vp-p, Rterm(Resistor Termination)
> and Rsel(Driven Strength). Each lane has maximum 20 registers for
> these settings.
> 
> Signed-off-by: Xin Ji <xji@analogixsemi.com>
> ---
>  .../display/bridge/analogix,anx7625.yaml      | 65 ++++++++++++++++++-
>  1 file changed, 63 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
