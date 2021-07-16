Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7488B3CBC4C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 21:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232697AbhGPTWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 15:22:03 -0400
Received: from mail-io1-f50.google.com ([209.85.166.50]:42673 "EHLO
        mail-io1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbhGPTWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 15:22:01 -0400
Received: by mail-io1-f50.google.com with SMTP id x10so11840604ion.9;
        Fri, 16 Jul 2021 12:19:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cZppq04pKYoyNWSBls8YBBh4TnlFI5KRVdOjVEiwNMo=;
        b=DVw4MTYkbEYN6nPGNd2wYmK5QNrvp5nMqsDW6RaVQdlR0hlw7LUITGZ/XW27Vid3CA
         T++1zjoeaIvil3JjzzbSZA7ZaPKkOdvl5G5gCw39IXnAPYJJ+PB82B6WhlxHx/LdybvB
         tLu+9m4xo3KJMnnt5pWRBVVEtNrFE2NFwbB+3VQZ3ygysmCdOvNp0c0vYR9s0I+Z6AHW
         lTTW3UlP1VjwIu0WjAIEiUTpY6rfPYpnNkbbL6Qqo6IqbpMHsVp3hO5Mi7gb4wD1YRd1
         pgUyKVuBC4nWfJWaIEXfdRXFR2QyH6L5XRVLKrZn9OpvUiO9O77ZwJdzS3VwpkQJliqC
         0GAQ==
X-Gm-Message-State: AOAM530y5O4CytLwW8AL0KSqCBR/rsnTkjSmWA5iFAIB8U4L/R5mVVX9
        xsu66AzdDLvKY+vZwNbGMw==
X-Google-Smtp-Source: ABdhPJx9T6ucNolLXF96aCzQG6B2OaC0CNfdafjW9ORigo9gn8TkffNYI8ymy/xfEzhNi+DmmJbhTQ==
X-Received: by 2002:a5d:80da:: with SMTP id h26mr8596495ior.206.1626463146487;
        Fri, 16 Jul 2021 12:19:06 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id k2sm1901354ioq.1.2021.07.16.12.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 12:19:05 -0700 (PDT)
Received: (nullmailer pid 3829420 invoked by uid 1000);
        Fri, 16 Jul 2021 19:19:04 -0000
Date:   Fri, 16 Jul 2021 13:19:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2] of: kexec: Remove FDT_PROP_* definitions
Message-ID: <20210716191904.GA3829390@robh.at.kernel.org>
References: <af415c86cd2ba9c8a6bb2eaaf56c3198a24b23d3.1626267092.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af415c86cd2ba9c8a6bb2eaaf56c3198a24b23d3.1626267092.git.geert+renesas@glider.be>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jul 2021 14:53:22 +0200, Geert Uytterhoeven wrote:
> The FDT_PROP_* definitions make it harder to follow the code.
> Remove them, and use the actual string literals instead.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> This is v2 of "of: kexec: Always use FDT_PROP_INITRD_START and
> FDT_PROP_INITRD_END".
> https://lore.kernel.org/r/a4e07a0c1efea913ce5a61136162b5b720b96b48.1623835273.git.geert+renesas@glider.be/
> 
> v2:
>   - Invert direction, as requested by Rob.
> ---
>  drivers/of/kexec.c | 40 +++++++++++++++-------------------------
>  1 file changed, 15 insertions(+), 25 deletions(-)
> 

Applied, thanks!
