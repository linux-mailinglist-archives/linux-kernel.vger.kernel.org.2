Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E229355C1B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 21:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240922AbhDFTVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 15:21:31 -0400
Received: from mail-ot1-f52.google.com ([209.85.210.52]:46001 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbhDFTVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 15:21:30 -0400
Received: by mail-ot1-f52.google.com with SMTP id 91-20020a9d08640000b0290237d9c40382so15682431oty.12;
        Tue, 06 Apr 2021 12:21:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=P/5WF24c25eXF4/LauXbS74dqYKfNkXTqF0ifTdvwyM=;
        b=AiQKGUrpUs78qrRHfwEgsOW37ZEzYBotcPd6SaqUdqSpoy66RyJ2wW09txkzIWKyjR
         zORJ+NeVSMC5Kcai2s7fpSND1SLYrxQwJhxzMkaz5AxjU++asTZ4JwO1y/pUTHfKNfp0
         ZTE+ti95kc2sleSoEOsErHyzm2xlrWqBNHeqrMD93eTbpfphHzh+AfPzwEzxQ9J28iJ9
         ab6UayqVg4dzO+PXs+wnqWm+2jMWo/wPa6bJSNDgWrTZfY4uK1Yni/uErQ2KHBOIEgzg
         YAjn01UQ9B/aBgy3g3koaa/4Za7MGCWkzi8uYt0i91SiyzXRQhNdOU2KxlmN/k8xEvyi
         U3vA==
X-Gm-Message-State: AOAM530G0P5eNeb1t6xp/LpG3v2NUaf5AYeggt2G1k4/zCrEkzjuf4Ws
        QQhcFDNTQX68WNempJHhXA==
X-Google-Smtp-Source: ABdhPJzhOj3xNCKqGX3FplsDy6aCWQFZ8eMFPgYBaxPre137YvK2vIxLDpMH+SY77jrs9hkfbskR5g==
X-Received: by 2002:a9d:63d6:: with SMTP id e22mr27512520otl.188.1617736881782;
        Tue, 06 Apr 2021 12:21:21 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 9sm3818434oid.17.2021.04.06.12.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 12:21:21 -0700 (PDT)
Received: (nullmailer pid 2150669 invoked by uid 1000);
        Tue, 06 Apr 2021 19:21:20 -0000
Date:   Tue, 6 Apr 2021 14:21:20 -0500
From:   Rob Herring <robh@kernel.org>
To:     frowand.list@gmail.com
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh+dt@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>
Subject: Re: [PATCH 1/1] of: properly check for error returned by
 fdt_get_name()
Message-ID: <20210406192120.GA2150527@robh.at.kernel.org>
References: <20210405032845.1942533-1-frowand.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210405032845.1942533-1-frowand.list@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 04 Apr 2021 22:28:45 -0500, frowand.list@gmail.com wrote:
> From: Frank Rowand <frank.rowand@sony.com>
> 
> fdt_get_name() returns error values via a parameter pointer
> instead of in function return.  Fix check for this error value
> in populate_node() and callers of populate_node().
> 
> Chasing up the caller tree showed callers of various functions
> failing to initialize the value of pointer parameters that
> can return error values.  Initialize those values to NULL.
> 
> The bug was introduced by
> commit e6a6928c3ea1 ("of/fdt: Convert FDT functions to use libfdt")
> but this patch can not be backported directly to that commit
> because the relevant code has further been restructured by
> commit dfbd4c6eff35 ("drivers/of: Split unflatten_dt_node()")
> 
> The bug became visible by triggering a crash on openrisc with:
> commit 79edff12060f ("scripts/dtc: Update to upstream version v1.6.0-51-g183df9e9c2b9")
> as reported in:
> https://lore.kernel.org/lkml/20210327224116.69309-1-linux@roeck-us.net/
> 
> Fixes: commit 79edff12060f ("scripts/dtc: Update to upstream version v1.6.0-51-g183df9e9c2b9")
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> 
> ---
> 
> This patch papers over the unaligned pointer passed to
> of_fdt_unflatten_tree() bug that Guenter reported in
> https://lore.kernel.org/lkml/20210327224116.69309-1-linux@roeck-us.net/
> 
> I will create a separate patch to fix that problem.
> 
>  drivers/of/fdt.c      | 36 +++++++++++++++++++++++-------------
>  drivers/of/overlay.c  |  2 +-
>  drivers/of/unittest.c | 15 ++++++++++-----
>  3 files changed, 34 insertions(+), 19 deletions(-)
> 

Applied, thanks!
