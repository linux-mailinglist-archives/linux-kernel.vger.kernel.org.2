Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF7F424892
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 23:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239614AbhJFVNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 17:13:40 -0400
Received: from mail-ot1-f43.google.com ([209.85.210.43]:45579 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239541AbhJFVNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 17:13:39 -0400
Received: by mail-ot1-f43.google.com with SMTP id 66-20020a9d0548000000b0054e21cd00f4so4694126otw.12;
        Wed, 06 Oct 2021 14:11:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TMbBbaTkeRvCJm9ZSb70KRzbl0JkE0P9uF9VW3nfCtQ=;
        b=WrYX5KvB79Gn9i6h0i/d6qZ6MPSj+pS2QL5mlo/rh0lruKI18K5axXhOn9WCYtmfH4
         D6CeUkhygWD8mKZouOPMhR07ZD2qJ8qjwYep8kGkMspg9vjwDnDMA7tlL+4nKDnqYWiE
         PkZqopq8Ij7jUHNQRG150cwQXueqQ20M6b4CSPVI3TfycfAuwrVbrIzamggpnyfYzSka
         Ljq/Ol/kZ5FBraHNy3XMlIy7004Flo1o2KL1TnsBE2KXSqwiiXhJV7woFqnJnF8TSvHz
         oTm7S3orsJhunN96sh46IxKCHHPjHNj9OWN2T2DZK0B2qJm863lTqoIeHp8xBu1hxcCg
         OiMQ==
X-Gm-Message-State: AOAM5331kK3AddwIsD2LyKHNgsdgwSdkSEu3ZCrHxleIBk5ScOoLHQiL
        K5tfBOFY9C+Ns9nBSxBLyg==
X-Google-Smtp-Source: ABdhPJysTlpXIwh+eH0MNk3KRrWFzHG9RUfNxtyx3upahYuQW6NDt0Jb1U1HAxVzlGHOIU8B9ArvBA==
X-Received: by 2002:a9d:7410:: with SMTP id n16mr417037otk.71.1633554706283;
        Wed, 06 Oct 2021 14:11:46 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id bl23sm2552476oib.40.2021.10.06.14.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 14:11:45 -0700 (PDT)
Received: (nullmailer pid 2882794 invoked by uid 1000);
        Wed, 06 Oct 2021 21:11:44 -0000
Date:   Wed, 6 Oct 2021 16:11:44 -0500
From:   Rob Herring <robh@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, devicetree@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/3] dt-bindings: display: simple: add Innolux
 G070Y2-T02 panel
Message-ID: <YV4REJzcUezYmAMN@robh.at.kernel.org>
References: <20210930100501.15690-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210930100501.15690-1-o.rempel@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Sep 2021 12:04:59 +0200, Oleksij Rempel wrote:
> Add binding for the Innolux G070Y2-T02 panel. It is 7" WVGA (800x480)
> TFT LCD panel with TTL interface and a backlight unit.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
