Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24ECB3C88C9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 18:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235756AbhGNQk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 12:40:29 -0400
Received: from mail-io1-f49.google.com ([209.85.166.49]:46064 "EHLO
        mail-io1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232434AbhGNQk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 12:40:28 -0400
Received: by mail-io1-f49.google.com with SMTP id y16so2866584iol.12;
        Wed, 14 Jul 2021 09:37:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4tJeunAnZHlhQuigtds/Y0c5fgwGRcJ1HpFKTFeZvbU=;
        b=gpTqHTfrN8ddNqSbMjZ4paKCkbcDPeLcyHWL0mkoA1cMfbVW8qwp7bOqxSGCSCgnBi
         JAJLs9PFXNrsWB8rXdjxVJRTZEf/1ULq/YVTIRtK0iobrZhHcS57qDBoThYZK3me5TkK
         ktDpmvvS1i8sx/I3GJJCNqMsw3aD/f4np5JtDL5Y5wFZF/F5OQy7YzPTrBJ5NQdGsuLm
         ZEu+I/aKL7WzL2r18sQKCwpCn1IGWPpAAFyz2RkiWXfv552E9oTycWKSNZxP4R2g56AD
         qeEYnltWBxuk+0QQh3fq+um9/jCcM9oU7k31RK+sX/7Zo58BJ4bcky695EDy3fRoaUCo
         x8yQ==
X-Gm-Message-State: AOAM531z3PePSZCqlOtZu47fbsYVmfdas42yJfoO88fYXttyGqBJ8Pbr
        tDTLwSgsm4kw/QllNUuV3g==
X-Google-Smtp-Source: ABdhPJzVkkc1P8a634IL2iHsgXQyZ4AE005dkCM4T2KN3A+q4PdX0vgxBSC65J1kRJPnYNA0vZBkvg==
X-Received: by 2002:a02:a595:: with SMTP id b21mr9600496jam.122.1626280656051;
        Wed, 14 Jul 2021 09:37:36 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id c26sm1446889ioa.32.2021.07.14.09.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 09:37:35 -0700 (PDT)
Received: (nullmailer pid 2719952 invoked by uid 1000);
        Wed, 14 Jul 2021 16:37:31 -0000
Date:   Wed, 14 Jul 2021 10:37:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, soc@kernel.org,
        linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Olof Johansson <olof@lixom.net>,
        dri-devel@lists.freedesktop.org, Arnd Bergmann <arnd@arndb.de>,
        David Airlie <airlied@linux.ie>,
        Sam Ravnborg <sam@ravnborg.org>,
        Daniel Vetter <daniel@ffwll.ch>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v2 2/4] dt-bindings: vendor-prefixes: Add an entry for
 SKOV A/S
Message-ID: <20210714163731.GA2719790@robh.at.kernel.org>
References: <20210714045349.10963-1-o.rempel@pengutronix.de>
 <20210714045349.10963-3-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210714045349.10963-3-o.rempel@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jul 2021 06:53:47 +0200, Oleksij Rempel wrote:
> Add "skov" entry for the SKOV A/S: https://www.skov.com/en/
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

