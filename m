Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2CA379398
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 18:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbhEJQUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 12:20:33 -0400
Received: from mail-oo1-f52.google.com ([209.85.161.52]:45040 "EHLO
        mail-oo1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbhEJQUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 12:20:31 -0400
Received: by mail-oo1-f52.google.com with SMTP id s24-20020a4aead80000b02901fec6deb28aso3575185ooh.11;
        Mon, 10 May 2021 09:19:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZjnSAV0oy5moNRx7DW3hdZlnMwJhkGmYrn7JhzKJIk8=;
        b=bNe5/65UT34aYqxqkxeTkp49cMZhp51MXmJBWazhAXwCoAjFSWA90erF/7OwReDQx0
         1/zBz3h6ieXlhyhnxgRKCJOmfrkVn4hH1PS1+Pp4WAkCrmNgK9RXfCgkQr7eEyCokuDU
         aCnyP7+eBBkimxBCrFLJAmWEibMaxknxkjxUN71ETNaNa8FVLM5+eu92pvDI+lRlToPa
         rcBDrucoBhaEfXMM0hSSN9s1n4zQ56/nf/d77uWFlLQyS8dI5n24oTh9UgyCdXpPsd/X
         uv6P6auBWTVk5ecsSu+DFszAY18u/no9vDaeo/N48dp+LVdjST3Ueb/TQ/413tGyj0/4
         B+qw==
X-Gm-Message-State: AOAM532RjzwshtiMKAMqf/VRgT2213aIzgbDek2gWAtXPLcEKBX60VVT
        Uxgxnw8wj9pHJov8wx3U9+cte/w2Fw==
X-Google-Smtp-Source: ABdhPJxUKmreKTrTPnZRIU/Z/CznZ1duPQgdNr6CTu5OUDCuJuc5e9gGN956MoL1F2Kvq0tHk8t1ww==
X-Received: by 2002:a4a:5858:: with SMTP id f85mr19608368oob.15.1620663566251;
        Mon, 10 May 2021 09:19:26 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id x11sm2638316otr.36.2021.05.10.09.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 09:19:25 -0700 (PDT)
Received: (nullmailer pid 226435 invoked by uid 1000);
        Mon, 10 May 2021 16:19:24 -0000
Date:   Mon, 10 May 2021 11:19:24 -0500
From:   Rob Herring <robh@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     frieder.schrempf@kontron.de, marex@denx.de, s.hauer@pengutronix.de,
        kernel@pengutronix.de, shawnguo@kernel.org,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        aford173@gmail.com, linux-imx@nxp.com, krzk@kernel.org,
        agx@sigxcpu.org, andrew.smirnov@gmail.com, ping.bai@nxp.com,
        abel.vesa@nxp.com, festevam@gmail.com, p.zabel@pengutronix.de,
        l.stach@pengutronix.de, devicetree@vger.kernel.org
Subject: Re: [PATCH V3 08/13] dt-bindings: imx: gpcv2: add support for
 optional resets
Message-ID: <20210510161924.GA226384@robh.at.kernel.org>
References: <20210510040045.13225-1-peng.fan@oss.nxp.com>
 <20210510040045.13225-9-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210510040045.13225-9-peng.fan@oss.nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 May 2021 12:00:40 +0800, Peng Fan (OSS) wrote:
> From: Lucas Stach <l.stach@pengutronix.de>
> 
> For some domains the resets of the devices in the domain are not
> automatically triggered. Add an optional resets property to allow
> the GPC driver to trigger those resets explicitly.
> 
> The resets belong to devices located inside the power domain,
> which need to be held in reset across the power-up sequence. So we
> have no means to specify what each reset is in a generic power-domain
> binding. Same situation as with the clocks in this binding actually.
> 
> Tested-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../devicetree/bindings/power/fsl,imx-gpcv2.yaml       | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
