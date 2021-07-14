Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D28B73C91C1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 22:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239859AbhGNUGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 16:06:43 -0400
Received: from mail-il1-f179.google.com ([209.85.166.179]:35700 "EHLO
        mail-il1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240260AbhGNTwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 15:52:33 -0400
Received: by mail-il1-f179.google.com with SMTP id a11so2782712ilf.2;
        Wed, 14 Jul 2021 12:49:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IMbohv2IVExOXkTG/AjJ+c4zhRP07MFGASU5a/RAwQw=;
        b=NgdgmFNjof33ij17I4aq1Gva22MQMbyXvJiOyUhG96S1k2+F+sXrKayWqpZyw4Xdtl
         pJCL58mFrEkxWlwK6eAnv9WqtJ2hFnGFJnIIQTdI8hq5OPGfNYD//b3DmbjpkrZZdhkS
         jgY6OrenXKqK7/maQnz+SPljiuNuwC++vCRrndjO2N2ktLkGF6SZ51qA4M4BCvbJR5fA
         ZB63LWxcVButRNKhXBzO0Fiy9rS6ZqvMyD02uycWNDshobYWIlSWs+IzzJ0L2h7/FAIp
         FbJq1zbCcfYhE5QIzkr9sVsA7mRpZP4q+9Fov6isHVXf2ZnsD5EiiGNr4Kq7mgTLaTcO
         FG/g==
X-Gm-Message-State: AOAM532ygzXQU60s2YNJo6AteMmfRDUsu8/7gTeq9x1mzsmn6s83tymP
        rRRDlYRKOB5ZQXdhzkiTxw==
X-Google-Smtp-Source: ABdhPJy9I4yrqo70ker5u/Rx9afOG+/tlSZLFXkTDlPFZfAApgPsrw4sGDCDPT4ZvbpejxyCb4avzA==
X-Received: by 2002:a92:2e08:: with SMTP id v8mr7281669ile.50.1626292180120;
        Wed, 14 Jul 2021 12:49:40 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id z7sm1834958iox.4.2021.07.14.12.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 12:49:39 -0700 (PDT)
Received: (nullmailer pid 3278259 invoked by uid 1000);
        Wed, 14 Jul 2021 19:49:38 -0000
Date:   Wed, 14 Jul 2021 13:49:38 -0600
From:   Rob Herring <robh@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     devicetree@vger.kernel.org, heiko@sntech.de,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: power: convert
 rockchip-io-domain.txt to YAML
Message-ID: <20210714194938.GA3278225@robh.at.kernel.org>
References: <20210625111746.6269-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210625111746.6269-1-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Jun 2021 13:17:43 +0200, Johan Jonker wrote:
> Current dts files with 'io-domains' nodes are manually verified.
> In order to automate this process rockchip-io-domain.txt has to be
> converted to YAML.
> 
> Changed:
>   Add supply properties for:
>     rockchip,rk3328-io-voltage-domain
>     rockchip,rv1108-io-voltage-domain
>     rockchip,rv1108-pmu-io-voltage-domain
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
> 
> Changed V2:
>   move grf part in separate patch
>   modify pin description
> 
> ---
> 
> note for rob+dt:
> unevaluatedProperties and
> allOf:
>   -if:
> doesn't seem to work.
> Changed to
> allOf:
>   - $ref:
> ---
>  .../bindings/power/rockchip-io-domain.txt          | 135 ---------
>  .../bindings/power/rockchip-io-domain.yaml         | 330 +++++++++++++++++++++
>  2 files changed, 330 insertions(+), 135 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/power/rockchip-io-domain.txt
>  create mode 100644 Documentation/devicetree/bindings/power/rockchip-io-domain.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
