Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8658B346D5D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 23:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234129AbhCWWjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 18:39:37 -0400
Received: from mail-il1-f181.google.com ([209.85.166.181]:40914 "EHLO
        mail-il1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233872AbhCWWjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 18:39:01 -0400
Received: by mail-il1-f181.google.com with SMTP id c17so19676842ilj.7;
        Tue, 23 Mar 2021 15:39:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=n93tRpc1y3Scz8NdK0KtJ25qrRXHPQSGSmrn+ERZczM=;
        b=dGxmj0kg2myws0eLKZaeEQpbjQuh3Ye8AEMy6T3rQm782fq//6dj7EJb3msVxdWQOj
         PNtw1fbFXPtEgY4kkiL3tnbmw9PRQs6bwz73Tney9CKVRktBpIqHpasd6RWncc4tjFZQ
         GNVOkjbeimq0n0dYSTb9geE2y1yqpOdeVkJ3tqugzDyeXWqJ5BQQbELlkmY1cmKxNMiV
         JRqud3LOtsIgULmLdLXc9jArbwLm68c2bXqANg/IhSXtqmfC18yLrPXkwhTgqXQ+97fZ
         dhtIsyFcQoC05bBXLWqfwKonj5zBRoPBW4ivkHUFpRYVVz12WV5uv0AjLN9ECVFFKwQb
         rnjA==
X-Gm-Message-State: AOAM531Cdzolnn+C2qqfZYV+Y4jrteO/wsGmi4UaFkDmn/gsAvHjxLJe
        YMwgCoBPAr9fcaE6L2FQlg==
X-Google-Smtp-Source: ABdhPJzgolRS14HRNOPqMMa6E3INzfkwpnXF6U/WLIxqGlbxnOapNd4xCj65DnXpGVGvmnTY18CeVw==
X-Received: by 2002:a05:6e02:1143:: with SMTP id o3mr374494ill.104.1616539140851;
        Tue, 23 Mar 2021 15:39:00 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id x6sm116569ioh.19.2021.03.23.15.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 15:39:00 -0700 (PDT)
Received: (nullmailer pid 1476934 invoked by uid 1000);
        Tue, 23 Mar 2021 22:38:58 -0000
Date:   Tue, 23 Mar 2021 16:38:58 -0600
From:   Rob Herring <robh@kernel.org>
To:     Alistair Francis <alistair@alistair23.me>
Cc:     shawnguo@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        robh+dt@kernel.org, olof@lixom.net, festevam@gmail.com,
        alistair23@gmail.com, linux-imx@nxp.com, arnd@arndb.de,
        kernel@pengutronix.de, s.hauer@pengutronix.de
Subject: Re: [PATCH v6 1/3] dt-bindings: Add vendor prefix for reMarkable
Message-ID: <20210323223858.GA1476900@robh.at.kernel.org>
References: <20210322130928.132-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210322130928.132-1-alistair@alistair23.me>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Mar 2021 09:09:25 -0400, Alistair Francis wrote:
> reMarkable AS produces eInk tablets
> 
> Signed-off-by: Alistair Francis <alistair@alistair23.me>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
