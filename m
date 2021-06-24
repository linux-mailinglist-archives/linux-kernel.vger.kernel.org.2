Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E45273B367A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 21:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232704AbhFXTD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 15:03:56 -0400
Received: from mail-il1-f174.google.com ([209.85.166.174]:37868 "EHLO
        mail-il1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232689AbhFXTDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 15:03:50 -0400
Received: by mail-il1-f174.google.com with SMTP id i13so3184170ilu.4;
        Thu, 24 Jun 2021 12:01:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IaNmdim0VI9/q6P9t+gzFtuQIN5h89p4Xmjtdi81Amc=;
        b=BPqoFsiSvlhc8b+c6DjERKClMXQmrwmszF9/uP/Rrv4ZBPr/fYdYl211t7jLrus3tF
         a6lNqMTdpfuowDvz4csivVO+799ZWWCoEWDpCx9B2UNQp2tDoNNWzTFEZtynB/BqLt5a
         hZ1lZppz9A8vfQrz2zfGdy5zZ+BWswDXTxQFDBRajXCErhj0Mo8D/DxCOWPa+MYMe8pJ
         5H4Rw2Gbotq7BPlpMs4Oi+/pOFGDwMsvRDJ3GWDgvqnPgJxPuvRIBQWMbFDbypi1Cv4L
         XnZHvUm054f3f5Z1DZZc46qucZ0hB4YnvCl5+W6mkXWTiWB8BUkVd1+YWJWcrgNM5brr
         eGyg==
X-Gm-Message-State: AOAM532makRCguIpNBhEgAHSwcDn56AaZUbV0W1Lhm0tit8Qbs5uWNAV
        XjXucN1SmOuZnSzZNWq36w==
X-Google-Smtp-Source: ABdhPJxW9aEvwV+XCvGTegmR/Kk96g/u4syCLDKkKU/bBuvMFNy3Nb97QF/+7DJGpiHCMyNq+TvDKg==
X-Received: by 2002:a92:d484:: with SMTP id p4mr4440070ilg.139.1624561290343;
        Thu, 24 Jun 2021 12:01:30 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id i6sm2466242ilj.84.2021.06.24.12.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 12:01:28 -0700 (PDT)
Received: (nullmailer pid 1813857 invoked by uid 1000);
        Thu, 24 Jun 2021 19:01:24 -0000
Date:   Thu, 24 Jun 2021 13:01:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     Matthew Hagan <mnhagan88@gmail.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, Ray Jui <rjui@broadcom.com>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        bcm-kernel-feedback-list@broadcom.com,
        Scott Branden <sbranden@broadcom.com>,
        Sam Ravnborg <sam@ravnborg.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: arm: bcm: add NSP devices to SoCs
Message-ID: <20210624190124.GA1813823@robh.at.kernel.org>
References: <20210610203524.2215918-1-mnhagan88@gmail.com>
 <20210610203524.2215918-2-mnhagan88@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210610203524.2215918-2-mnhagan88@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jun 2021 21:35:11 +0100, Matthew Hagan wrote:
> Currently only the SoC names are added. This patch expands these to add
> the devices.
> 
> Signed-off-by: Matthew Hagan <mnhagan88@gmail.com>
> ---
>  .../devicetree/bindings/arm/bcm/brcm,nsp.yaml | 59 +++++++++++++++----
>  1 file changed, 49 insertions(+), 10 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
