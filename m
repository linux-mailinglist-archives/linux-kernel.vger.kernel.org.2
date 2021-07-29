Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59FE43DAEE8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 00:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbhG2WcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 18:32:05 -0400
Received: from mail-io1-f44.google.com ([209.85.166.44]:46663 "EHLO
        mail-io1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbhG2WcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 18:32:02 -0400
Received: by mail-io1-f44.google.com with SMTP id z7so8238128iog.13;
        Thu, 29 Jul 2021 15:31:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8xRR7b05CZCC7cFh3+x7THVjJVxqClYmWXBUMBmzhzc=;
        b=cIRNKjit5UGDHbFD5lkg/cTWMtTP39+j7o9TZsCj5lbseoDAw1Mc1TaiyttXcjDNZM
         dk7zg95ZwTrFLOTxHD3qhUVbZn3k4Je3A9qzw7+c1AcCZE/zYlL+gNG4VcNj+hhFsN6C
         66E4XEsMmhrz2wr+5T6/Oc25h94zXWcdy0aMsRbWnf2v4+rivETT21aQ9LPZN4dxJugA
         ylN3MSOgR2vmqWcGKs6XxRY4Uql7mSCeyFk4oLDYXc+8Yc9mxsgfeaLCY76ck5qHgw5m
         oX+y0xoLhr98mc6X4UysQgvH5FCAwhiFocuE5/XAyaMjBuDnwAC4ho+HBOQ/bcdpStWw
         EsgA==
X-Gm-Message-State: AOAM533MOz3CrsIOUeOL/XVPlnvHgJ+SEf0Fit7fpZeTyQVOa1+u5yNu
        YEfRYiLhVe2VwE6OAFrUng==
X-Google-Smtp-Source: ABdhPJz3myyUSpUJ0VTVRdeLG/tG/ZdbT3RE/4rk1olugX7JtG6zT1jFIK54Se6giDwLxuwmQTIE6Q==
X-Received: by 2002:a6b:b795:: with SMTP id h143mr5887746iof.74.1627597918403;
        Thu, 29 Jul 2021 15:31:58 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id p9sm2554309ilj.65.2021.07.29.15.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 15:31:57 -0700 (PDT)
Received: (nullmailer pid 1022957 invoked by uid 1000);
        Thu, 29 Jul 2021 22:31:55 -0000
Date:   Thu, 29 Jul 2021 16:31:55 -0600
From:   Rob Herring <robh@kernel.org>
To:     Alexey Minnekhanov <alexeymin@postmarketos.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Sam Ravnborg <sam@ravnborg.org>, devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        phone-devel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/2] dt-bindings: panel: Add Samsung S6E3FA2 panel
Message-ID: <YQMsW0Z9UhM/PXcW@robh.at.kernel.org>
References: <20210725140339.2465677-1-alexeymin@postmarketos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210725140339.2465677-1-alexeymin@postmarketos.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Jul 2021 17:03:37 +0300, Alexey Minnekhanov wrote:
> The Samsung S6E3FA2 AMOLED cmd LCD panel is used on Samsung Galaxy
> S5 (klte) phone.
> 
> Signed-off-by: Alexey Minnekhanov <alexeymin@postmarketos.org>
> ---
>  .../display/panel/samsung,s6e3fa2.yaml        | 63 +++++++++++++++++++
>  1 file changed, 63 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/samsung,s6e3fa2.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
