Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60D0C435237
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 19:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbhJTSB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 14:01:58 -0400
Received: from mail-oi1-f174.google.com ([209.85.167.174]:39701 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbhJTSB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 14:01:57 -0400
Received: by mail-oi1-f174.google.com with SMTP id s9so8253523oiw.6;
        Wed, 20 Oct 2021 10:59:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KiHAFYPu9WjhWCEOkgmwtUS9QPIVVYJBwC1EpyGQ5yo=;
        b=dqXqImwr/TveMlwMDjgLCg1oEpUSskVnzOwQ9lJ0XA1jSqANgxWVyqjc7ytOcjo7tm
         lWMCUW5OAdydEEErPF8N5FKBAcfz34riJmFbxHx8DR0ICtfFRPAXGZftx5fSfe1YytdG
         3BphZXqE+c+eiAl2eI92NHDrmDV+S7g0KaIZ4e72MT8hfycMGxNi8PX1oTQsx+W1RGg4
         jlb6rc5v5JFxQy3TUGT2Y739upXC42frADfotoy4aktyM61866ysZg8Sxx73yt5EDMRD
         AQ6W0FY3TbuYEx0vgQSYYBuS9X8H9EzxfR6/SjwsaqAvU55dyNZGkL/Mq/+DvSvWhPFv
         R+Lw==
X-Gm-Message-State: AOAM532Qhof73lrqEmiPrOAumPgogcMK0aCXfHm/Q1Cn510RY5r6YJFv
        KLED6IeK7pPZuk8938QoZlBQ8fsC+Q==
X-Google-Smtp-Source: ABdhPJw4cXyWfIz/oFSi9AmXYIp5tIncYGHAzbFdrziWhuk3R4ew2fHztFlSL4DARm3VyHXbWhDzWg==
X-Received: by 2002:aca:4b84:: with SMTP id y126mr714617oia.127.1634752782138;
        Wed, 20 Oct 2021 10:59:42 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id e25sm505596oot.38.2021.10.20.10.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 10:59:41 -0700 (PDT)
Received: (nullmailer pid 2595232 invoked by uid 1000);
        Wed, 20 Oct 2021 17:59:40 -0000
Date:   Wed, 20 Oct 2021 12:59:40 -0500
From:   Rob Herring <robh@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Joey Gouly <joey.gouly@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: Parallelize yamllint
Message-ID: <YXBZDHfoA+mRzY3Z@robh.at.kernel.org>
References: <cover.1634551582.git.geert+renesas@glider.be>
 <c68bdbdf3112c4658e0748c8fc51959e69fbae2e.1634551582.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c68bdbdf3112c4658e0748c8fc51959e69fbae2e.1634551582.git.geert+renesas@glider.be>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Oct 2021 12:54:47 +0200, Geert Uytterhoeven wrote:
> Use xargs sharding like "chk_bindings" does, to parallelize the
> execution of yamllint.
> 
> This reduces the yamllint execution time from ca. 21 to 5 seconds on
> i7-8700K.
> 
> Suggested-by: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v2:
>   - New.
> ---
>  Documentation/devicetree/bindings/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!
