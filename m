Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6FFD43BC1F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 23:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239441AbhJZVPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 17:15:25 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]:36625 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232025AbhJZVPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 17:15:23 -0400
Received: by mail-ot1-f53.google.com with SMTP id p6-20020a9d7446000000b0054e6bb223f3so594765otk.3;
        Tue, 26 Oct 2021 14:12:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3IzaGKpNTku7T9mnwOZXwZm2WDJJXKS3wu9MraOSP/s=;
        b=StHlQlXn2lFAozr0bhNhAZDW/x+swcHIHpG3xl6sh7jbmQxflknpJIZi4IuJLFe7Kt
         p2vcaYZ1fWkxfi820XWmSACgnbyyMkxWC2E1vuKXETbIHjMyKy+CRvkVM5chLCVSF2XL
         AiUkynGGg3Oow8vN9Jp99Iz1glMSfTfk2581DARMhL9uLXZy54ZFkbyGMtLwtDWOL4Sn
         k6cul+Widq8l/5qZALBsF4Ufq8iymWHRlZEhFu1vw0mLfsFlrqEarI/ZMfTNjbAzCSUW
         vllDBSyvfQ+DooMfyVfUNp7oOqi8YC7wI9uCnMT4tb/FZ4oP3fpDeZMtfeKvrBe28+Di
         rKCw==
X-Gm-Message-State: AOAM532wIDczuf4Dd+pdwnIc2TO6a+g4U0jIUZI7lBkRk6Jtb9DKhu2C
        yekWQ/tBYKmfiDvmP5vLEg==
X-Google-Smtp-Source: ABdhPJxLE2vdj5P0iOzFDhLQUztXrE71ljTlYfkq4U1asAbcxaxhGd64tMwaQxBSGL4rbWB/RFrfqw==
X-Received: by 2002:a9d:734d:: with SMTP id l13mr21835473otk.238.1635282779328;
        Tue, 26 Oct 2021 14:12:59 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id w17sm5005333otm.50.2021.10.26.14.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 14:12:58 -0700 (PDT)
Received: (nullmailer pid 3260336 invoked by uid 1000);
        Tue, 26 Oct 2021 21:12:57 -0000
Date:   Tue, 26 Oct 2021 16:12:57 -0500
From:   Rob Herring <robh@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        David Jander <david@protonic.nl>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH v1 1/3] dt-bindings: vendor-prefixes: Add an entry for
 JOZ BV
Message-ID: <YXhvWbkGJA2GAFeI@robh.at.kernel.org>
References: <20211014083313.26671-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211014083313.26671-1-o.rempel@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Oct 2021 10:33:11 +0200, Oleksij Rempel wrote:
> Add "joz" entry for JOZ BV: https://joz.nl/en/about-joz/
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
