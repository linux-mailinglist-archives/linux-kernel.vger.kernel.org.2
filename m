Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 933BE3D9426
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 19:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbhG1RSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 13:18:14 -0400
Received: from mail-io1-f51.google.com ([209.85.166.51]:35365 "EHLO
        mail-io1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbhG1RSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 13:18:12 -0400
Received: by mail-io1-f51.google.com with SMTP id y9so3803653iox.2;
        Wed, 28 Jul 2021 10:18:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MhCaJJI/FxwbAqWqGNqDCa1/ELrQ+ncelMrX8vBhF+Y=;
        b=criz/h4CsvfMp4GUEPIe+RwgtxejctrjF/KarL2ju/0660pDqMy2OjZsGsFpBzE8LD
         T00tgvx15y6WvHPSl0OKr9HrUj1IktyO0GlOPquUAYE6bbF7ajqbz/Oyf+bkcl9Sx7P9
         qSeOCAqzUxJKxYdgJChPBX/PvGL1YeuSq4okBG8AmBrwmHB1NqL+2o+JXweWD/eTJDIa
         6dwT4eNWoxVM7shyFwU+8TUZwReVwbBhqBW0MW+V17FeTkN7E4YBRWTCkgAQ7EJK5teA
         6w8wEZHlgP5JN0lieGIUpcvrSx6dleIY1MeP3YhxrePkvdYdAaLTwVks45BcWti9lawV
         vVPw==
X-Gm-Message-State: AOAM532uoZFwEih92oGv0ayP9ABChR/4IFI0T6GWFqt94baPui5UR0P1
        MZRQ5INCEhkxBdb01+N8og==
X-Google-Smtp-Source: ABdhPJzYD5vrsFQa6LZr+r7UlHykUF0j1thT7fabyZOU1+d+F/lp7UhiifIfk02RMe2Ub3JiO29hVA==
X-Received: by 2002:a5e:dc48:: with SMTP id s8mr386481iop.133.1627492690365;
        Wed, 28 Jul 2021 10:18:10 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id l5sm388932ion.44.2021.07.28.10.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 10:18:09 -0700 (PDT)
Received: (nullmailer pid 1269234 invoked by uid 1000);
        Wed, 28 Jul 2021 17:18:07 -0000
Date:   Wed, 28 Jul 2021 11:18:07 -0600
From:   Rob Herring <robh@kernel.org>
To:     Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Michael Auchter <michael.auchter@ni.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: Re: [PATCH v2 3/3] dt-bindings: extcon: usbc-tusb320: Add TUSB320L
 compatible string
Message-ID: <20210728171807.GA1269122@robh.at.kernel.org>
References: <a4rEWQfScKM8Y0B7u0NXSAdvKC6Xzesp1OWGUYjeWaA@cp3-web-016.plabs.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4rEWQfScKM8Y0B7u0NXSAdvKC6Xzesp1OWGUYjeWaA@cp3-web-016.plabs.ch>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Jul 2021 09:57:15 +0000, Yassine Oudjana wrote:
> Add a compatible string for TUSB320L.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
>  .../devicetree/bindings/extcon/extcon-usbc-tusb320.yaml       | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

