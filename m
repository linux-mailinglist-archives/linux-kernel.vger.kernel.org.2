Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3A5842E2C0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 22:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbhJNU36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 16:29:58 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:43947 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhJNU35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 16:29:57 -0400
Received: by mail-ot1-f45.google.com with SMTP id x33-20020a9d37a4000000b0054733a85462so9836270otb.10;
        Thu, 14 Oct 2021 13:27:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xu5tTcVr8bvpGrBgDRlnsFOc77LQWXDWznkApBGMUEk=;
        b=cG8KLvLrqym1s3FLuPkdvypwNos7l8NXjnxgvKs1T//NGyio/u5N9Fi5fuM0I1vYXo
         emtY+fJRro5lo9QUEJa6bXftahHcTqhYcijctXiUHLmJRg/isa9uAZPG48l5thn8pr4o
         ekPrRZv0WI9fvtGWAU2dDf5/rJV0bdPuXsNUvC8sywaNqaEWJD9u82fjmvfaDZqQrnDw
         Edns33RQBo86ZevnTIAZ8tbl8jWbkXNgUaxHgJFAtgIU1yKDxLfNXyzzVgBiexddbROi
         D+rMsZiEcuVxvuA2Qb+16iwL0AXvBU8ZT6epwnIsbMrOUIVjFZcqK4cmXY2kmdMdoQeQ
         Z9HA==
X-Gm-Message-State: AOAM532WLyOdc9Jopfd2MB//iOD8qXgUeBMTro1TtTOX07zFaysBD2gy
        WmE7YomQqe8hJuAYLWHqNg==
X-Google-Smtp-Source: ABdhPJzOmo9iZlOtlO33lznWBsz3f2YhTocxhTHZLirvfy1olKZGZJQCN9IedDWRxefqBF1u8xVWHQ==
X-Received: by 2002:a05:6830:19f9:: with SMTP id t25mr4174437ott.332.1634243271889;
        Thu, 14 Oct 2021 13:27:51 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id h23sm721803otl.54.2021.10.14.13.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 13:27:51 -0700 (PDT)
Received: (nullmailer pid 3867413 invoked by uid 1000);
        Thu, 14 Oct 2021 20:27:50 -0000
Date:   Thu, 14 Oct 2021 15:27:50 -0500
From:   Rob Herring <robh@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     m.purski@samsung.com, robh+dt@kernel.org, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, daniel@ffwll.ch,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: display/bridge: sil,sii9234: Convert to
 YAML binding
Message-ID: <YWiSxk+JIU5JAlbG@robh.at.kernel.org>
References: <20211006152158.601856-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211006152158.601856-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 06 Oct 2021 17:21:58 +0200, AngeloGioacchino Del Regno wrote:
> Convert the Silicon Image SiI9234 HDMI/MHL bridge documentation to YAML.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../bindings/display/bridge/sii9234.txt       |  49 --------
>  .../bindings/display/bridge/sil,sii9234.yaml  | 110 ++++++++++++++++++
>  2 files changed, 110 insertions(+), 49 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/display/bridge/sii9234.txt
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/sil,sii9234.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
