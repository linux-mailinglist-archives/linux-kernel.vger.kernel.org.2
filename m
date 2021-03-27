Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D607134B83C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 17:40:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbhC0Qjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 12:39:33 -0400
Received: from mail-oi1-f174.google.com ([209.85.167.174]:34425 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbhC0Qj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 12:39:28 -0400
Received: by mail-oi1-f174.google.com with SMTP id x207so8987301oif.1;
        Sat, 27 Mar 2021 09:39:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=NG67s+7kLptfosAtlZ7QSTWozOvSFpofkzzzHqUW1OE=;
        b=D1bwMfKsXm+mqGTlbTC0hj5Ncx2gQC77fNbeIahMHB+UePKRT2x7oJ9lTaLv3ant5N
         jq0FE4Lvu/ryvp0qHPxExZm/0pmsdjtV3t99Rv2U32qpu9fwYGB0j6drh0IJ7clCj03W
         GQkN7QkqXs0P1+FMEdcxITxNhTPWeIWKUskSDGi7OzAgZQm0xPqdkB7EJgEkW8JDeAML
         lkI+91TmoY+1oXacowmc4TslUA5LUZY71bJRWjANTwkaIwcImO/AHdy7YfteDFE+R4sK
         EWjOFeb8mTMYr0A/D5X0cvNs1Fgs54HF93IMoelpBywpP3PYofwJgPHYxhj9KSGBO87R
         gSTg==
X-Gm-Message-State: AOAM5307uqEyk5odIWLi9Z+oqen69QBkxw3Ss9lJBPml9/sGMjfoD6LP
        JltE8DC5y0OR/J1NS/mgx+4o/GUtXQ==
X-Google-Smtp-Source: ABdhPJwcMyAO8TYRAtSlim09pySM1rrZfPrCV0qys3rvbuZ/RW3vAzPif9ULRbxNjuZv7odUjb3VsQ==
X-Received: by 2002:aca:4188:: with SMTP id o130mr14218309oia.53.1616863168350;
        Sat, 27 Mar 2021 09:39:28 -0700 (PDT)
Received: from robh.at.kernel.org ([172.58.99.140])
        by smtp.gmail.com with ESMTPSA id 3sm2896809otw.58.2021.03.27.09.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 09:39:27 -0700 (PDT)
Received: (nullmailer pid 215462 invoked by uid 1000);
        Sat, 27 Mar 2021 16:39:23 -0000
Date:   Sat, 27 Mar 2021 10:39:23 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tomer Maimon <tmaimon77@gmail.com>,
        Patrick Venture <venture@google.com>,
        Avi Fishman <avifishman70@gmail.com>, openbmc@lists.ozlabs.org,
        Rob Herring <robh+dt@kernel.org>,
        Tali Perry <tali.perry1@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Nancy Yuen <yuenn@google.com>,
        linux-arm-kernel@lists.infradead.org,
        Benjamin Fair <benjaminfair@google.com>
Subject: Re: [PATCH 05/14] dt-bindings: timer: nuvoton,npcm7xx: Add
 wpcm450-timer
Message-ID: <20210327163923.GA215427@robh.at.kernel.org>
References: <20210320181610.680870-1-j.neuschaefer@gmx.net>
 <20210320181610.680870-6-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210320181610.680870-6-j.neuschaefer@gmx.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Mar 2021 19:16:01 +0100, Jonathan Neuschäfer wrote:
> Add a compatible string for WPCM450, which has essentially the same
> timer controller.
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> ---
>  .../devicetree/bindings/timer/nuvoton,npcm7xx-timer.txt        | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
