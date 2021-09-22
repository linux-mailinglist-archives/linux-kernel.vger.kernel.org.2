Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA41041512A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 22:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237674AbhIVULE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 16:11:04 -0400
Received: from mail-ot1-f43.google.com ([209.85.210.43]:43973 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237827AbhIVUKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 16:10:48 -0400
Received: by mail-ot1-f43.google.com with SMTP id x33-20020a9d37a4000000b0054733a85462so5209379otb.10;
        Wed, 22 Sep 2021 13:09:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pUPWyXoY1FFQGPeAEFJhwFml9k4ZL9Ko+mO59V12D5s=;
        b=jfv5DdEwJV7ie4AUR+8ErgACLKGWsgGgo8I0ECIMTzeqRA98+801rocN/wW+IvduA4
         nuZNfi8p7HIMwZQDCa9jZ2ohqpyZLALfAub6AA6MMMGXEjFggbTGLSFgceSr8PaTwz6i
         g9kk5rz0EFMkgzDIxygiRzWjgGnNOHlEfntmYOUEKoY7OZ1aC4hFzcb01tYzioJrEfdz
         4lMWHpwnCUPvHbLKcNnHnhGgRiTSFQiX9znBzFFge6A6Bv/N1emJ1SqWjwmb1Rzqd9tr
         a5ngkVf/uz1tzMmChvNXFwtVHR2ExiM6g+PZZLF9vg34mRFbK91nKe+L0QkjM7juDwAv
         sEXw==
X-Gm-Message-State: AOAM531xSREJTm/qdIMs6KJhpOBl1mBu8hZR2gSn0eQcIRyjhs6OP6zz
        nT1XRKx30UMpeEfZgzfq4zx3wJodyw==
X-Google-Smtp-Source: ABdhPJwNckKrDizr4psAkZM1ddrjLG9ro1gxOCvwLYUKF4EC0taK1/yfd3L89soniFuxJNQVuLVpdQ==
X-Received: by 2002:a05:6830:11c7:: with SMTP id v7mr836218otq.355.1632341357913;
        Wed, 22 Sep 2021 13:09:17 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id j10sm783344oog.13.2021.09.22.13.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 13:09:17 -0700 (PDT)
Received: (nullmailer pid 1207807 invoked by uid 1000);
        Wed, 22 Sep 2021 20:09:16 -0000
Date:   Wed, 22 Sep 2021 15:09:16 -0500
From:   Rob Herring <robh@kernel.org>
To:     Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
Cc:     sboyd@kernel.org, linux-clk@vger.kernel.org,
        UNGLinuxDriver@microchip.com, Eugen.Hristev@microchip.com,
        Kavyasree.Kotagiri@microchip.com, Manohar.Puri@microchip.com,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH v5 1/3] dt-bindings: clock: lan966x: Add binding includes
 for lan966x SoC clock IDs
Message-ID: <YUuNbFd43jJ4Yaaw@robh.at.kernel.org>
References: <20210917135142.9689-1-kavyasree.kotagiri@microchip.com>
 <20210917135142.9689-2-kavyasree.kotagiri@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210917135142.9689-2-kavyasree.kotagiri@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Sep 2021 19:21:40 +0530, Kavyasree Kotagiri wrote:
> LAN966X supports 14 clock outputs for its peripherals.
> This include file is introduced to use identifiers for clocks.
> 
> Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
> ---
> v4 -> v5:
> - No changes.
> 
> v3 -> v4:
> - No changes.
> 
> v2 -> v3:
> - No changes.
> 
> v1 -> v2:
> - Updated license.
> 
>  include/dt-bindings/clock/microchip,lan966x.h | 28 +++++++++++++++++++
>  1 file changed, 28 insertions(+)
>  create mode 100644 include/dt-bindings/clock/microchip,lan966x.h
> 

Acked-by: Rob Herring <robh@kernel.org>
