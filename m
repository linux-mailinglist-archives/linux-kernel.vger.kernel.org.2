Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42A7D4565D2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 23:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbhKRWr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 17:47:28 -0500
Received: from mail-oi1-f176.google.com ([209.85.167.176]:40704 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232460AbhKRWrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 17:47:25 -0500
Received: by mail-oi1-f176.google.com with SMTP id bk14so17652335oib.7;
        Thu, 18 Nov 2021 14:44:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rjpsRWH0PgCRL7LwTN0EvynoHBqTaDIG3WDWt/eAtH8=;
        b=E+9S0EMIZPnhXTtjeAXU6H1SQxNwvAKj6ys2hv7huXwqydrCPZ/UfYIofF11xwTmAk
         CqUc6XMbKOtnt2Dcq7b1FnUOLrb64DspoyZpjYqg0RPSLWpzGLI0itWnjB4mPkPsFXIm
         uSV3tCPRySG7ktVze4u0P/uQNbBwrV4d6xKD5c+P8BvkTJldD2sjxwb1JNEuogNc1TQC
         /tWviCBb02YWx27+9XYKwR37B8BtQrGjXZ3p4+ieBWDFZeR45B/HH6PNaZJeF1F5pZQe
         msz59sYsYoXW/GvP7zLhmc5UR+2DW8EDfkW+McR4XAT3pkSY3Ou14WJIsK3+qwRLI/nv
         7cAQ==
X-Gm-Message-State: AOAM533+Hz/O5JpXY0hf7v9fCPyCgXKaBFhuyrwnxUbXcBGoXhN2NvxG
        HxTjBScOFzGNvPwKiNGBLA==
X-Google-Smtp-Source: ABdhPJz9o1M3WHv7KjQVL0KDh9BGiushajnOmQnCXcreeffLUqnVVIy5EypxfRlZDi8V3by9rxcCMg==
X-Received: by 2002:a05:6808:218b:: with SMTP id be11mr570075oib.80.1637275464768;
        Thu, 18 Nov 2021 14:44:24 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id o19sm315375oiw.22.2021.11.18.14.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 14:44:24 -0800 (PST)
Received: (nullmailer pid 1898132 invoked by uid 1000);
        Thu, 18 Nov 2021 22:44:23 -0000
Date:   Thu, 18 Nov 2021 16:44:23 -0600
From:   Rob Herring <robh@kernel.org>
To:     James Lo <james.lo@mediatek.com>
Cc:     linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v15 2/4] dt-bindings: spmi: document binding for the
 Mediatek SPMI controller
Message-ID: <YZbXR1Vy9CHhsg2X@robh.at.kernel.org>
References: <20211115042030.30293-1-james.lo@mediatek.com>
 <20211115042030.30293-3-james.lo@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211115042030.30293-3-james.lo@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Nov 2021 12:20:28 +0800, James Lo wrote:
> This adds documentation for the SPMI controller found on Mediatek SoCs.
> 
> Signed-off-by: James Lo <james.lo@mediatek.com>
> Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
> ---
>  .../bindings/spmi/mtk,spmi-mtk-pmif.yaml      | 76 +++++++++++++++++++
>  1 file changed, 76 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spmi/mtk,spmi-mtk-pmif.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
