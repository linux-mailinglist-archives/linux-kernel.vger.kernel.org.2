Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0434A43244D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 18:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233811AbhJRQ5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 12:57:07 -0400
Received: from mail-oi1-f172.google.com ([209.85.167.172]:38461 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233765AbhJRQ5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 12:57:05 -0400
Received: by mail-oi1-f172.google.com with SMTP id t4so650902oie.5;
        Mon, 18 Oct 2021 09:54:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bdRCJXyxJHlhD+uhUVlDNIjhWd50IG5Tb57xuwkXB4M=;
        b=zr1GrqOv6+qlRxbRPGU1bFoIAbJS3A9S4jBx9wO+HGFsQOLvRc7Exs4gKtMDJM+HX4
         4fbzXbD3ajQQRXwe6lSDDlryKeI8ColyDmaC6lK/5xJ/c6uo5xozgMZ4qkKDFCjQ5suF
         9KENLyexykQ6RG1hhr/tvGb0JAqH7v9KT1QGh+aYGbz7iaSLdnYCYqvwEgag8LBa+aJl
         CLUttG+KJdWv0YWpgy7toNXVRy+0j5fHkE0QdLxXKXZqWRVL/enHoixESVokYebZoJDe
         q4hCXMaTuy65SNX2a2rKzjBKB2XY4k+uyES7aqeQWMbFT4Au5SF4Fmw1WJAPk4tUqykf
         7+3Q==
X-Gm-Message-State: AOAM531HHUvRkTYTqPzhnSk1xPK/sFsmSGjrjignTM6PQaL7oR6kbHvU
        iE1pX4Gg+P3WXSAi0piQBA==
X-Google-Smtp-Source: ABdhPJxyzYoqbqjLNuyYTlKGQYvnikAwGFrH47dCvc2XhYVTumJcCgWsJJDrge/1k9t25Dc7iDePBw==
X-Received: by 2002:aca:5b07:: with SMTP id p7mr51000oib.14.1634576093925;
        Mon, 18 Oct 2021 09:54:53 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id v22sm2827577ott.80.2021.10.18.09.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 09:54:53 -0700 (PDT)
Received: (nullmailer pid 2551198 invoked by uid 1000);
        Mon, 18 Oct 2021 16:54:52 -0000
Date:   Mon, 18 Oct 2021 11:54:52 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     john@phrozen.org, neil@brown.name, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] dt-bindings: bus: add palmbus device tree bindings
Message-ID: <YW2m3DOv6TvHm2l+@robh.at.kernel.org>
References: <20211016203323.9165-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211016203323.9165-1-sergio.paracuellos@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Oct 2021 22:33:23 +0200, Sergio Paracuellos wrote:
> Add device tree bindings for palmbus controller present in all the MIPS
> ralink based SoCs.
> 
> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> ---
> changes in v5: Sent wrong patch in v4. Hence, properly sent it.
> Changes in v4: The node name pattern is already checked elsewhere. There is only need to
>                define the unit-address part which should be lowercase hex.
> Changes in v3: change sample to use child node which its bindings are
>                already in YAML format to make dtschema happier.
> Changes in v2: fixed missing semicolon in example.
>  .../devicetree/bindings/bus/palmbus.yaml      | 79 +++++++++++++++++++
>  1 file changed, 79 insertions(+)
>  .../devicetree/bindings/bus/palmbus.yaml      | 79 +++++++++++++++++++
>  1 file changed, 79 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/bus/palmbus.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
