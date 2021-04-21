Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD6636756C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 00:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235749AbhDUW63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 18:58:29 -0400
Received: from mail-oo1-f54.google.com ([209.85.161.54]:36651 "EHLO
        mail-oo1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233822AbhDUW62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 18:58:28 -0400
Received: by mail-oo1-f54.google.com with SMTP id c6-20020a4aacc60000b02901e6260b12e2so7060370oon.3;
        Wed, 21 Apr 2021 15:57:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nHc0vu0f8/Y88zC2/CmuoX75thIIdILFhNQVN4NX95s=;
        b=rTDukeFGpnCT3kKY1ylV/m44Qun3r8aOGzmredzHytSW9OIMa1lZw9zaGN3P3bHuhh
         0jX5rN0QiV71QmXFLJI5rKVCAUQGvSmhHVrbHkTluY8rTkJS6ZWJhq4JRCWWu4NdjMP4
         BsR7nI7QyB6fiA9SmKc7qgJULwbwIQDlIOsAkz+850ylIuw8EWNYgZrJOb78Jthc4hhR
         i4ISD4xUJsAQKjT6QpRtB0I9abtGtVHu39QJdzDuNP5+tP7SkHBCNQYnTodvN7xGI5Fy
         4HiAwlCsrjy6fV6STOzlnzw2vwuoovMlaP1wkowu2y649QHUYZ3f960GoCN+rgjZb6Wo
         n+yg==
X-Gm-Message-State: AOAM533anX1ETS/y7//Ds1ORi2uXYP+lIcWbNLxDnC0fL1LIiKRI+jAk
        +1AttcjkJuBoDq1NXEzQTg==
X-Google-Smtp-Source: ABdhPJwjYos/WcIL+RFdiTSvzgpoXxQwdK0ohpOuRaRk2GRIIl/pMcr7rplvisvozdFf0meqaKMQ8A==
X-Received: by 2002:a4a:a6ca:: with SMTP id i10mr180307oom.62.1619045874190;
        Wed, 21 Apr 2021 15:57:54 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 79sm224478oty.76.2021.04.21.15.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 15:57:53 -0700 (PDT)
Received: (nullmailer pid 1768772 invoked by uid 1000);
        Wed, 21 Apr 2021 22:57:52 -0000
Date:   Wed, 21 Apr 2021 17:57:52 -0500
From:   Rob Herring <robh@kernel.org>
To:     Alistair Francis <alistair@alistair23.me>
Cc:     kuninori.morimoto.gx@renesas.com, devicetree@vger.kernel.org,
        daniel@0x0f.com, linux@rempel-privat.de,
        linux-kernel@vger.kernel.org, shawnguo@kernel.org,
        Max.Merchel@tq-group.com, dri-devel@lists.freedesktop.org,
        geert+renesas@glider.be, daniel@ffwll.ch, krzk@kernel.org,
        sam@ravnborg.org, robh+dt@kernel.org, thierry.reding@gmail.com,
        airlied@linux.ie
Subject: Re: [PATCH 1/2] dt-bindings: Add E Ink to vendor bindings
Message-ID: <20210421225752.GA1768719@robh.at.kernel.org>
References: <20210418210956.3024-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210418210956.3024-1-alistair@alistair23.me>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Apr 2021 07:09:55 +1000, Alistair Francis wrote:
> Add the E Ink Corporation to the vendor bindings.
> 
> Signed-off-by: Alistair Francis <alistair@alistair23.me>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
