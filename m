Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B13744EEF2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 22:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235859AbhKLV7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 16:59:25 -0500
Received: from mail-oi1-f182.google.com ([209.85.167.182]:38901 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbhKLV7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 16:59:22 -0500
Received: by mail-oi1-f182.google.com with SMTP id r26so20415774oiw.5;
        Fri, 12 Nov 2021 13:56:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=U9+VQc020mmJbdUsN6EvanNKFKGmosUJ6gTy0h9MuLg=;
        b=KZsSLvZB9bwhqbgl1zXFRIgyv8VsnzKEFDYvsMVwRoAeUrjVPEl29A5k1Vvx7ivaHS
         dbyUY4k4yq15xkbWWCZYLiQS3tDhltHQUTsLc6d12lmO8RpSI/MHBQ/htGAci5QcaYki
         RR/KY6lZ/4p4j3yy5duvyqWKdwqn2YqqNbUTtDVEGHo0h4hnrLmpFFkbtNgO5z9WvNVw
         AEQujOxGcw3XlRGAttyCexGTgNWeA7GoIHo62F3yH+d3Ah1FwGiKOZt44+5nZDpu2W42
         XWMMiSVrglTARSni/UbjWA1eTkw5ch++yNm+mgOdUQy7EnnadziMfiaisZkb8X+FNi1W
         JzAQ==
X-Gm-Message-State: AOAM5321JEGXU6c+w0Qe3VYZ+Amv0SOSPAKTH0EENPFBpOUhfzNVb65z
        2qzMXsEgEEEYgYX1UZY9rA==
X-Google-Smtp-Source: ABdhPJyqsRqmGEzJFtjui/LGkNT5GgYTDD7ARVbbxu7RUKuQQAavvDotjX2ZY+q2gvt5cLKTh1mmkA==
X-Received: by 2002:a05:6808:609:: with SMTP id y9mr16089326oih.178.1636754190973;
        Fri, 12 Nov 2021 13:56:30 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id t62sm1628794oib.56.2021.11.12.13.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 13:56:30 -0800 (PST)
Received: (nullmailer pid 3442561 invoked by uid 1000);
        Fri, 12 Nov 2021 21:56:29 -0000
Date:   Fri, 12 Nov 2021 15:56:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     Qin Jian <qinjian@cqplus1.com>
Cc:     robh+dt@kernel.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        broonie@kernel.org, linux-clk@vger.kernel.org,
        p.zabel@pengutronix.de, maz@kernel.org, devicetree@vger.kernel.org,
        wells.lu@sunplus.com, linux-arm-kernel@lists.infradead.org,
        sboyd@kernel.org, linux@armlinux.org.uk, mturquette@baylibre.com
Subject: Re: [PATCH v4 03/10] dt-bindings: reset: Add bindings for SP7021
 reset driver
Message-ID: <YY7jDakmH4cPKb5n@robh.at.kernel.org>
References: <cover.1635993377.git.qinjian@cqplus1.com>
 <179206a3d7eb7335ea205830751fbcd618675d86.1635993377.git.qinjian@cqplus1.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179206a3d7eb7335ea205830751fbcd618675d86.1635993377.git.qinjian@cqplus1.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 04 Nov 2021 10:57:00 +0800, Qin Jian wrote:
> Add documentation to describe Sunplus SP7021 reset driver bindings.
> 
> Signed-off-by: Qin Jian <qinjian@cqplus1.com>
> ---
>  .../bindings/reset/sunplus,reset.yaml         | 38 ++++++++
>  MAINTAINERS                                   |  2 +
>  include/dt-bindings/reset/sp-sp7021.h         | 97 +++++++++++++++++++
>  3 files changed, 137 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/sunplus,reset.yaml
>  create mode 100644 include/dt-bindings/reset/sp-sp7021.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
