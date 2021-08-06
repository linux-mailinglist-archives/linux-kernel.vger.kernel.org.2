Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B603D3E3157
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 23:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245296AbhHFVrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 17:47:14 -0400
Received: from mail-io1-f51.google.com ([209.85.166.51]:42975 "EHLO
        mail-io1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241587AbhHFVrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 17:47:12 -0400
Received: by mail-io1-f51.google.com with SMTP id h1so14176043iol.9;
        Fri, 06 Aug 2021 14:46:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=t8k1FSkghnl3otNc+cNSXzcyGnQ5mEMP3gk5vD8jYT0=;
        b=Z/hEIcm+75iJjYTxJpPbM0zXsM1PMlc0V20sk6459Qo7qveOIP5xd/aKFhVIjXgmfd
         BFm9GZoRQ9FPFYqDkobpqb2AJX9XLShYH/4ACcQ2tTAIl7Gme1Vi+aai7k9rZeQCD2Uj
         vxiz4VyEw/CmAascAlylRqfetE8V72WGTblJyaG9+ARQ06yEzY3VXIvW0b3DRuneREJj
         UImj7hOQ50rHgWWOfqdDx4aSVpeQz0ad2K237brsD4pxY4E6sQCCQJw3cFpIF2gywx8b
         R5OHWBcF6yvv+8GlorTh9DDAlcUnGJeFmjmHIFhRwnKjJnCEuLiGvT9pngUv6tqtQqe+
         m0vg==
X-Gm-Message-State: AOAM532UapVFFiQcq15kBQnCgdfr3Y6he0Uel5peVbsAm6/tzDI/RyTb
        aaFQfLB9ldq9AZHSJ+Oklg==
X-Google-Smtp-Source: ABdhPJzjqP+aoHh5yEK/ZvPLCNSdC+tf7BH4sBq/dQJUJPAOMfIcAExlJl2QPZW9IsHaTi80jXt05A==
X-Received: by 2002:a92:9412:: with SMTP id c18mr1703496ili.38.1628286416290;
        Fri, 06 Aug 2021 14:46:56 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id x6sm3909883ilp.71.2021.08.06.14.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 14:46:55 -0700 (PDT)
Received: (nullmailer pid 1861306 invoked by uid 1000);
        Fri, 06 Aug 2021 21:46:53 -0000
Date:   Fri, 6 Aug 2021 15:46:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     Icenowy Zheng <icenowy@sipeed.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] dt-bindings: display: add binding for simple-dbi
 panels
Message-ID: <YQ2tzZp9ow6WDaBR@robh.at.kernel.org>
References: <20210802063538.75583-1-icenowy@sipeed.com>
 <20210802063538.75583-3-icenowy@sipeed.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210802063538.75583-3-icenowy@sipeed.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 02, 2021 at 02:35:36PM +0800, Icenowy Zheng wrote:
> As we're going to introduce a driver for MIPI DBI panels that need only
> standard MIPI-DCS commands to initialize (usually because the controller
> has some configuration pre-programmed), add a DT binding file for it,
> which now includes only one DBI Type C Option 3 panel, ZSX154-B1206.
> 
> Signed-off-by: Icenowy Zheng <icenowy@sipeed.com>
> ---
>  .../bindings/display/simple-dbi.yaml          | 72 +++++++++++++++++++
>  1 file changed, 72 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/simple-dbi.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/simple-dbi.yaml b/Documentation/devicetree/bindings/display/simple-dbi.yaml
> new file mode 100644
> index 000000000000..f49b0fda0935
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/simple-dbi.yaml
> @@ -0,0 +1,72 @@
> +# SPDX-License-Identifier: GPL-2.0-only

checkpatch.pl will tell you this should be dual licensed.
