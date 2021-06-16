Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AAF33AA291
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 19:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbhFPRkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 13:40:47 -0400
Received: from mail-io1-f46.google.com ([209.85.166.46]:39695 "EHLO
        mail-io1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbhFPRkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 13:40:45 -0400
Received: by mail-io1-f46.google.com with SMTP id f10so63768iok.6;
        Wed, 16 Jun 2021 10:38:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=caREsov+kQL6hsFHbO3qE0x8vyqeon2R6xoJZTCN1nE=;
        b=ctZbU2XCyBm8I54J2BKzRXIjgDJBPSrE6x6JYhldKsc3FFxI+xqj6oOzqdJtinntS4
         Zvw71UFj+cZ4k+yDsEYZRiyeelwWj8zrevaKHvywyYDUL6CQ0vlqvbLtCMKexP+NgyV/
         zCfaCOlBF2IwQFnnYetrZcAgUGY8FoIvH7Sv8eF+i19G/hQrPxnejavJdKVWzDS0qozG
         a7+4osgAYCH9RCV/Jz1b9hT+06VJMVPZKJ/L4zabVWEgscm3V9PaDpPCljzojBMryflJ
         5e0D6kqrOXveM6rT76V+HlnoO6G3ZG6OTCK+0hvTr4hjZExoK5iSNxKiEw4Zx+2oHWy1
         bhwA==
X-Gm-Message-State: AOAM530xhjlOc3VeL3n7FtH9CXWE9e1e65yVtVoWf/MutGW5+iLx9j+I
        jtApo0o73vlnUcBWowV12A==
X-Google-Smtp-Source: ABdhPJynatIw6jCXNfKjoGqcXEFsUQJLV+Gn1TbMCCbvi4TDEe/Ax2zuZwJOXxkzisoOzndoBlEIJw==
X-Received: by 2002:a02:956a:: with SMTP id y97mr526313jah.58.1623865118791;
        Wed, 16 Jun 2021 10:38:38 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id h7sm1400430ila.5.2021.06.16.10.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 10:38:37 -0700 (PDT)
Received: (nullmailer pid 3592754 invoked by uid 1000);
        Wed, 16 Jun 2021 17:38:35 -0000
Date:   Wed, 16 Jun 2021 11:38:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <mripard@kernel.org>,
        linux-sunxi@lists.linux.dev, linux-sunxi@googlegroups.com,
        Samuel Holland <samuel@sholland.org>,
        linux-arm-kernel@lists.infradead.org,
        Ondrej Jirman <megous@megous.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        devicetree@vger.kernel.org, Icenowy Zheng <icenowy@aosc.io>
Subject: Re: [PATCH v7 17/19] dt-bindings: arm: sunxi: Add two H616 board
 compatible strings
Message-ID: <20210616173835.GA3592707@robh.at.kernel.org>
References: <20210615110636.23403-1-andre.przywara@arm.com>
 <20210615110636.23403-18-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210615110636.23403-18-andre.przywara@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jun 2021 12:06:34 +0100, Andre Przywara wrote:
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  Documentation/devicetree/bindings/arm/sunxi.yaml | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
