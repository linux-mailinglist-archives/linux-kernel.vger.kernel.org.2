Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36B2934B82F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 17:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbhC0QgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 12:36:22 -0400
Received: from mail-oo1-f48.google.com ([209.85.161.48]:46620 "EHLO
        mail-oo1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbhC0QgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 12:36:13 -0400
Received: by mail-oo1-f48.google.com with SMTP id 125-20020a4a1a830000b02901b6a144a417so2017196oof.13;
        Sat, 27 Mar 2021 09:36:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ezf8ZsxHR7Q2VJAPplq3OYrE78elzd24DdXuyG3/QdU=;
        b=a3f4pP10grtFrooQ1fq5MLPTpoVHT6P+JLw5JXCT9M1UP0b3/0/fSYxvBgSOwHiViP
         VIQHAgxIMVxcyeNeYYkbDLJdx8ZAQttWofuLv4FTluehQLfpEF5mAatd2PdZ6rL7ezqL
         yQLYo4hMMD98kqh8RpwWX+/LTHMIPDbYG5mYLWHUzr/BSic1dIyJy/OxhHVHzv0GSdn8
         LbaQ4mnP1PQ9hwrKJzN37bsp491pJqMEUZdmlknyZKjLIQStiUCc8kCxNIVJUj+oyKjc
         xExtohrPJ0KjpB1eei0+2XgPKv5WA3do7iCYUYi+TnUxN0MkTKrSQJ7Z7uZ1Id9LwEP/
         VLsA==
X-Gm-Message-State: AOAM5313BHxOQrD6WG3foEF4s/jnUBgXsVSvhFCGDYTt+TR/ujDA0N8L
        WlN0Dzm1vqBprtaMEpqTsQ==
X-Google-Smtp-Source: ABdhPJwM2NDuERRYq4E1lpdIQVS9lu3Mp0RN1p4NlSoqMq2IIvvWtukgPmGwLYlQ3CquH1KP9J1iNQ==
X-Received: by 2002:a4a:aa82:: with SMTP id d2mr15919534oon.52.1616862973377;
        Sat, 27 Mar 2021 09:36:13 -0700 (PDT)
Received: from robh.at.kernel.org ([172.58.99.140])
        by smtp.gmail.com with ESMTPSA id l26sm2922978otd.21.2021.03.27.09.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 09:36:12 -0700 (PDT)
Received: (nullmailer pid 210814 invoked by uid 1000);
        Sat, 27 Mar 2021 16:36:08 -0000
Date:   Sat, 27 Mar 2021 10:36:08 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>
Cc:     openbmc@lists.ozlabs.org, Max Merchel <Max.Merchel@tq-group.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        allen <allen.chen@ite.com.tw>, devicetree@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>,
        linux-arm-kernel@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Palmer <daniel@0x0f.com>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH 01/14] dt-bindings: vendor-prefixes: Add Supermicro
Message-ID: <20210327163608.GA203544@robh.at.kernel.org>
References: <20210320181610.680870-1-j.neuschaefer@gmx.net>
 <20210320181610.680870-2-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210320181610.680870-2-j.neuschaefer@gmx.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Mar 2021 19:15:57 +0100, Jonathan Neuschäfer wrote:
> Super Micro Computer, Inc. (https://www.supermicro.com/en/), commonly
> known as Supermicro, is a manufacturer of server hardware.
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
