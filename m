Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5C9D43BC23
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 23:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239465AbhJZVQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 17:16:09 -0400
Received: from mail-ot1-f54.google.com ([209.85.210.54]:45891 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239448AbhJZVQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 17:16:01 -0400
Received: by mail-ot1-f54.google.com with SMTP id l16-20020a9d6a90000000b0054e7ab56f27so532528otq.12;
        Tue, 26 Oct 2021 14:13:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QvEob6Qr7iWKSyZVXTzkOpsa0dqKGWkQr7WLuKJhckA=;
        b=pP0sR4Pn4fCFcvhok8KvS8h1XCrXw9+TT6HAX4EkNVtc7Mooi+xbd5Ghrkt68OBxgb
         PYZfXqQhwvfIKxHFNu3U2159WpSZSG3Zg9HRHpA29xqb7aQy7CPW6AAigbiImpjIzTKE
         ++XJMN1bx80vsFe6yq4RdS9eQy0dq/cJbuwSIW4krPVXL7E2y7HtQPLuROCIMrjnbFqT
         wqars3bklEYPLFXxCc51HxxfH8pZrxPokOH1QZHScseu65LpR4WZTtLLZE2U0GKRUOOI
         EalD7G9yEarc7znXx3lUoSz6TkSL/qWyeOMNQd9PD3TbRSRqTzCe05CrgGwlbvWJpupa
         XaJg==
X-Gm-Message-State: AOAM532Wb8rIwQZKueL8CiTRFt1pKCqu4J6nNTwNIOC4Ja6cp2igiDGs
        zUxQXOe2WSjPFMtqsWh98w==
X-Google-Smtp-Source: ABdhPJwKEwQFvIqQzfSjke9Wchs+7d+PFveTJA/ubbR9Ja1Lx86gbNDR9Vb706t7iLzpQlUsQpvoFw==
X-Received: by 2002:a9d:5610:: with SMTP id e16mr22840815oti.324.1635282817022;
        Tue, 26 Oct 2021 14:13:37 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id a1sm4789796oti.30.2021.10.26.14.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 14:13:36 -0700 (PDT)
Received: (nullmailer pid 3261456 invoked by uid 1000);
        Tue, 26 Oct 2021 21:13:35 -0000
Date:   Tue, 26 Oct 2021 16:13:35 -0500
From:   Rob Herring <robh@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Fabio Estevam <festevam@gmail.com>, linux-kernel@vger.kernel.org,
        Shawn Guo <shawnguo@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        David Jander <david@protonic.nl>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v1 2/3] dt-bindings: arm: fsl: add JOZ Access Point
Message-ID: <YXhvf6/GULVJuJN6@robh.at.kernel.org>
References: <20211014083313.26671-1-o.rempel@pengutronix.de>
 <20211014083313.26671-2-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211014083313.26671-2-o.rempel@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Oct 2021 10:33:12 +0200, Oleksij Rempel wrote:
> Add imx6ull based JOZ Access Point.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
