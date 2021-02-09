Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07456315B6D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 01:40:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234130AbhBJAjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 19:39:08 -0500
Received: from mail-ot1-f42.google.com ([209.85.210.42]:44926 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234191AbhBIU4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 15:56:35 -0500
Received: by mail-ot1-f42.google.com with SMTP id e5so11957232otb.11;
        Tue, 09 Feb 2021 12:56:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RP3dhPMdlKAjivrXGUHAi9hHjPbrEKsu6Dv+Yzctmhw=;
        b=PoZ93d/ZjJLUEG7Xo15K49AUUoxBwjFKZEAvy/pO0X3csLBYFJPK7sFMP/Q2i4kEEE
         ATevZw084dYdpE778y0xHwASE8UfUrCHjHoDaDcyY9Kx0LWHIBtTFkxmDcq88ZihX33X
         SUH9KSVlC8bPJ6CYnut+zAm/BrbblKGrE8ZWJtgAHccYMqUZGMKoLsEcGtkJmrEaTXPT
         Coo8ep6nElTn2dNX+H0kFOsUfphK5SWAEFj3jQEQmKUxkrgREvIrLjdZpCUj8yJdSa/3
         1zHbI3aEb0ZX3eUjZy5tdCAoYvi8iSeN6eq80s6WabMgUhGtKzJ0hOQOgFe+1+SZUNBU
         Y9cQ==
X-Gm-Message-State: AOAM533XhvZiJggHP3w8x7xQoHKaaMrhhWy2+Xf/u39v+npJ8QwO9xdQ
        A1mXpozX7m6Je9EovG+Vbw==
X-Google-Smtp-Source: ABdhPJyKYoGnii7JnW/1A4WdWWq6HpZ+jUyGwMPxsQGjJmlzc/2O4MqhObgvPviB1qdJQgl1D0k8Cw==
X-Received: by 2002:a05:6830:c6:: with SMTP id x6mr2228694oto.135.1612904151832;
        Tue, 09 Feb 2021 12:55:51 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a63sm4597844otc.75.2021.02.09.12.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 12:55:50 -0800 (PST)
Received: (nullmailer pid 164883 invoked by uid 1000);
        Tue, 09 Feb 2021 20:55:49 -0000
Date:   Tue, 9 Feb 2021 14:55:49 -0600
From:   Rob Herring <robh@kernel.org>
To:     Iskren Chernev <iskren.chernev@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: panel: Add Samsung S6E3FA2 panel
Message-ID: <20210209205549.GA164827@robh.at.kernel.org>
References: <20210201165307.51443-1-iskren.chernev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210201165307.51443-1-iskren.chernev@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 01 Feb 2021 18:53:05 +0200, Iskren Chernev wrote:
> The Samsung S6E3FA2 AMOLED cmd LCD panel is used on the Samsung Galaxy
> S5 (klte).
> 
> Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
> ---
> Add a simple generated panel driver that supports on/off and the corresponding
> binding documentation.
> 
> Changes in v3:
> - fix dt_binding_check issue with missing include
> - fix panel type (cmd) in kconfig description
> 
> Changes in v2:
> - move bindings to separate file, add 2 regulators
> - add standalone panel driver
> 
> v1: https://lkml.org/lkml/2020/12/30/293
> v2: https://lkml.org/lkml/2021/2/1/313
> 
>  .../display/panel/samsung,s6e3fa2.yaml        | 64 +++++++++++++++++++
>  1 file changed, 64 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/samsung,s6e3fa2.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
