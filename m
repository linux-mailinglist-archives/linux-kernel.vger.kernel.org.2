Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9C4449B04
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 18:46:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238994AbhKHRtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 12:49:03 -0500
Received: from mail-oi1-f179.google.com ([209.85.167.179]:37499 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbhKHRtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 12:49:00 -0500
Received: by mail-oi1-f179.google.com with SMTP id o83so28828692oif.4;
        Mon, 08 Nov 2021 09:46:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OhLtM1qDOc9AgI+Uxtjb26VYj1bUDaQwKr8Lj7jp5+Q=;
        b=KgcvbJRsT9CCdLsKA+a4uZR7SwJVeQDTodLNAh0aPvTUcumsox+41tSZPGIxC73Ewp
         5CeutVOT5/ki2XPDnEV2vfdLq9ni7T7MDOMdnMD8P9cBwBH7AQJXxCzf57w4WFIPsaac
         hGUIeND+cZF017YLTmtBHhymF3heMMfkVaGeCnukLkhC2Fv+RXKPn+PBpolVFAi1z2wO
         RFYfbljph3zWasvz2RRSAIq5B+vAYvOhsYU1uuK78pO97y5lzJwahksrOeTzzCbXAthJ
         rlYfXqh/I4WJbSjiEzrz/vu4/Ii4h92GH7lITrpEl5udRmQhSM/FvR/Wizh7fIvlSc7V
         YMsA==
X-Gm-Message-State: AOAM533aLhL+EUTzMnjlVUluwoK48+7/PzzFEQAbU3fwWKg3klJfImzi
        jDvDARQPluGC6UeYeN6Tkg==
X-Google-Smtp-Source: ABdhPJzTcXONjLfKH3LJorHyLMffsSpIJzDLIcjWFi4OUWDZljkNDOIS0HtDiMdrahhOAAaTrv3xQA==
X-Received: by 2002:aca:3903:: with SMTP id g3mr91596oia.12.1636393575204;
        Mon, 08 Nov 2021 09:46:15 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id q63sm6187175oia.55.2021.11.08.09.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 09:46:14 -0800 (PST)
Received: (nullmailer pid 3816121 invoked by uid 1000);
        Mon, 08 Nov 2021 17:46:13 -0000
Date:   Mon, 8 Nov 2021 11:46:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     Qin Jian <qinjian@cqplus1.com>
Cc:     linux-clk@vger.kernel.org, sboyd@kernel.org, wells.lu@sunplus.com,
        linux-kernel@vger.kernel.org, arnd@arndb.de,
        mturquette@baylibre.com, linux@armlinux.org.uk,
        p.zabel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org, maz@kernel.org,
        broonie@kernel.org
Subject: Re: [PATCH v4 05/10] dt-bindings: clock: Add bindings for SP7021
 clock driver
Message-ID: <YYliZb1fVxUqOysu@robh.at.kernel.org>
References: <cover.1635993377.git.qinjian@cqplus1.com>
 <7a951bf660dee25866e9f8e3789c4cd2a87b9f96.1635993377.git.qinjian@cqplus1.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a951bf660dee25866e9f8e3789c4cd2a87b9f96.1635993377.git.qinjian@cqplus1.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 04 Nov 2021 10:57:02 +0800, Qin Jian wrote:
> Add documentation to describe Sunplus SP7021 clock driver bindings.
> 
> Signed-off-by: Qin Jian <qinjian@cqplus1.com>
> ---
>  .../bindings/clock/sunplus,sp7021-clkc.yaml   |  38 ++++++
>  MAINTAINERS                                   |   2 +
>  include/dt-bindings/clock/sp-sp7021.h         | 112 ++++++++++++++++++
>  3 files changed, 152 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/sunplus,sp7021-clkc.yaml
>  create mode 100644 include/dt-bindings/clock/sp-sp7021.h
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

