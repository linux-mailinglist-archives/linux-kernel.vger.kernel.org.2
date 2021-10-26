Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CCEE43BB71
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 22:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232020AbhJZUTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 16:19:00 -0400
Received: from mail-ot1-f51.google.com ([209.85.210.51]:42990 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231828AbhJZUS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 16:18:59 -0400
Received: by mail-ot1-f51.google.com with SMTP id l24-20020a9d1c98000000b00552a5c6b23cso339929ota.9;
        Tue, 26 Oct 2021 13:16:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=friO7I9eZ9NU4Vui+QX5uK5dDebSZidjdNaIbotBKgE=;
        b=Ee65UZLxx5k/COfT/3BtbBhaHrtDx14Ldr/ZUvbr7LN9+aLMJ36GFud0px9KFiqCMK
         J6E4h+L0r2GOyRmRp7bEhaa0b9Ti4XXTzaNkknXQdOBFO+dZoFTZRq13mnuyGyOwTqPd
         SYo6PdhzHzSB2/YE8WZRU6RtWQ36Nn+lKVSz0TMaCNE3Achqer7w8HrRERxFnJnRpL2V
         w80ha+FacdqlFO3hzdszP8PQoKW0K7jRHMNNZIPOYB4Vk4A6n2gUcB1fC9EA2K2ECbLF
         zCI11nlHa6SzV+0UHk2L3RUixiPPVWvp87d2nQiTnFGlemVjnbcznDyOo4nWnkLXMh3f
         yeHQ==
X-Gm-Message-State: AOAM530QjmQr5s3nxDpeF0C7UYCZ4VjKXCiAxP7sWZC3vsoD7SfJz22A
        TRCmFF8sb5Eyyqr3oI+ewA==
X-Google-Smtp-Source: ABdhPJz6EvUz+TazsUgz3zJHt+zCKdn4QiUqiNHraUrfzagL2o6EgBcfBg07Zok1/FqU//K4+85qWw==
X-Received: by 2002:a05:6830:237d:: with SMTP id r29mr2878450oth.190.1635279394540;
        Tue, 26 Oct 2021 13:16:34 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id t5sm4959701oic.4.2021.10.26.13.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 13:16:33 -0700 (PDT)
Received: (nullmailer pid 3166004 invoked by uid 1000);
        Tue, 26 Oct 2021 20:16:32 -0000
Date:   Tue, 26 Oct 2021 15:16:32 -0500
From:   Rob Herring <robh@kernel.org>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel@vger.kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Markus Niebel <Markus.Niebel@ew.tq-group.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        devicetree@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH 1/3] dt-bindings: arm: fsl: add TQ-Systems boards based
 on i.MX6Q/QP/DL
Message-ID: <YXhiIOAtvnejtPgZ@robh.at.kernel.org>
References: <20211013111202.6231-1-matthias.schiffer@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013111202.6231-1-matthias.schiffer@ew.tq-group.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Oct 2021 13:12:00 +0200, Matthias Schiffer wrote:
> The TQ-Systems MBa6x mainboard can be used with TQMa6 variants with
> i.MX6Q/QP/DL SoCs (TQMa6Q/QP/DL). The TQMa6Q and DL exist in two variants:
> The newer variants "A" have a hardware workaround for Erratum ERR006687,
> while variants "B" are missing such a workaround, so it needs to be
> handled in software. The erratum was fixed in i.MX6QP, so no "A" variant
> of the TQMa6QP exists.
> 
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> ---
>  .../devicetree/bindings/arm/fsl.yaml          | 35 +++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
