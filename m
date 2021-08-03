Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD4AB3DF64F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 22:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239759AbhHCUUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 16:20:16 -0400
Received: from mail-il1-f172.google.com ([209.85.166.172]:35702 "EHLO
        mail-il1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239516AbhHCUUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 16:20:15 -0400
Received: by mail-il1-f172.google.com with SMTP id k3so20668106ilu.2;
        Tue, 03 Aug 2021 13:20:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9EyZVqFWhnDvF/fZbkicwNb9hKyigcBhAdto6bvzEqI=;
        b=pnruIaNLE3W5wPRwJJ00GNbBM/X3tVFZezRGYkWMLalCEyMXXihz2P6EPErJpM0evg
         JMY1xTLQOJEYbsEWPAAOP4bPLRv1bTbYZ192+SNOcWzXVk19GQUtc8phGoJwOeooOiko
         ojQmxSlje6uwsOO4IfY6tKzGYjWVpeeTDz8Ya+F4Cuj1radKODdksEMJ03HEIrsbjRX2
         JlG/WRuz8lEdvUFxN48X5p2sMhA5bZNt2zmqGCfu5hZ5VhNQMWnxKR9PaYBpyqrXHwO0
         2w55SFuxuR4UfDDEUlcZmXYQPQRzm2JJLGF2n8Yh+dmx/dAQpYWbtfT/NHoqto9LiLlr
         Ia4Q==
X-Gm-Message-State: AOAM532wD3Rq8aE+p80E611ojjzyXU/0JUGgDpZiFMMYc+6JVFldNhQG
        uWKAQOUKxACJ2RTWRbq9UQ==
X-Google-Smtp-Source: ABdhPJy1ARgWXY/Hda64KIdJzv4YAa7hEG7bgOu8g42EYhIksgHtJBBFErjZmPZW3qPcJM/ZVTJ0Hg==
X-Received: by 2002:a92:a010:: with SMTP id e16mr1731036ili.138.1628022003989;
        Tue, 03 Aug 2021 13:20:03 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id j10sm77842iop.16.2021.08.03.13.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 13:20:03 -0700 (PDT)
Received: (nullmailer pid 3667174 invoked by uid 1000);
        Tue, 03 Aug 2021 20:20:01 -0000
Date:   Tue, 3 Aug 2021 14:20:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ohhoon Kwon <ohoono.kwon@samsung.com>
Cc:     linux-kernel@vger.kernel.org, frowand.list@gmail.com,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        ohkwon1043@gmail.com, nathan@kernel.org
Subject: Re: [PATCH] of: fdt: do not update local variable after use
Message-ID: <YQmk8fL/QllNnKvO@robh.at.kernel.org>
References: <CGME20210803101726epcas1p257df1a6ab948c39304f4246a95d039c3@epcas1p2.samsung.com>
 <20210803101309.904-1-ohoono.kwon@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210803101309.904-1-ohoono.kwon@samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 03 Aug 2021 19:13:09 +0900, Ohhoon Kwon wrote:
> Fix the below warning:
> drivers/of/fdt.c:196:4: warning: Value stored to 'pprev' is never read
> [clang-analyzer-deadcode.DeadStores]
>              pprev      = &pp->next;
>              ^            ~~~~~~~~~
> 
> Signed-off-by: Ohhoon Kwon <ohoono.kwon@samsung.com>
> ---
>  drivers/of/fdt.c | 1 -
>  1 file changed, 1 deletion(-)
> 

Applied, thanks!
