Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E48233EC9BC
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 16:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238633AbhHOO4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 10:56:07 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:42905 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234323AbhHOO4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 10:56:06 -0400
Received: by mail-ot1-f41.google.com with SMTP id c19-20020a9d6153000000b0051829acbfc7so3133659otk.9;
        Sun, 15 Aug 2021 07:55:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=docV9G0wmJvQAezEAgVv8n1twxHOTjg50DCUlLqjxgA=;
        b=F0Vv2wDwj5l1cVv+hjgjEvOEvTk8nup4/JtBYL0Oz8HdMTcdgTjtsJdYs6lopGSsKJ
         6a1d/DBubMke1SXig34JF/RMaV5OQz8KZGwRn7Q9OaIRvyyGCvLw1WwiVf0OPIBGf1dc
         I/Q3SK/CC/5VFeFaQQpvEDc9nKNXYXWLCdzAPmBcNaqBIJV6tF4Y2dHpzYWYQ7N4hiGQ
         H/eYGWbCgZIRc0jm73rXneJiN8FDYZnpjjwAe4Z0mrNWWAfnA0LOFH4qbe4TT2GHJta9
         wENP3mXGSeXQ6adRASVn91yjcV2v0lrbzRMYi06kYcsHUWolQ2LXindxN0dlEGM1jzAP
         K2QQ==
X-Gm-Message-State: AOAM533FOjHS6YbdTRhlGHcpsMX/DyY/Ciqo9y+TYilVtrEXjNQjEpzA
        Ib3UZeL/qKeq5vbvYmLFeA==
X-Google-Smtp-Source: ABdhPJw1+botyKy/wHxgCmBPsdWN0IvUAWE+5CVgsRVgfJGuKqaWRa4rkGmv5uBQPKxLoYst/hlvcQ==
X-Received: by 2002:a9d:7cc5:: with SMTP id r5mr9564304otn.55.1629039335836;
        Sun, 15 Aug 2021 07:55:35 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w35sm1657200ott.80.2021.08.15.07.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Aug 2021 07:55:35 -0700 (PDT)
Received: (nullmailer pid 3721945 invoked by uid 1000);
        Sun, 15 Aug 2021 14:55:34 -0000
Date:   Sun, 15 Aug 2021 09:55:34 -0500
From:   Rob Herring <robh@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] of: fdt: Remove weak
 early_init_dt_mark_hotplug_memory_arch()
Message-ID: <YRkq5uCVrXNjllvb@robh.at.kernel.org>
References: <1a61f75ec50d3c2922fcdbe33337266a58a4125f.1628671960.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a61f75ec50d3c2922fcdbe33337266a58a4125f.1628671960.git.geert+renesas@glider.be>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Aug 2021 10:53:37 +0200, Geert Uytterhoeven wrote:
> Commit 41a9ada3e6b4253f ("of/fdt: mark hotpluggable memory") introduced
> two (for systems with and without memblock) weak versions of
> early_init_dt_mark_hotplug_memory_arch(), that could be overridden by an
> architecture-specific version.  However, no overrides ever emerged.
> Later, commit aca52c3983891060 ("mm: remove CONFIG_HAVE_MEMBLOCK")
> removed the non-memblock version.
> 
> Remove early_init_dt_mark_hotplug_memory_arch(), and replace it by a
> direct call to memblock_mark_hotplug().
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/of/fdt.c       | 7 +------
>  include/linux/of_fdt.h | 1 -
>  2 files changed, 1 insertion(+), 7 deletions(-)
> 

Applied, thanks!
