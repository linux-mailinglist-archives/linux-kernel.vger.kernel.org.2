Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77A47332D12
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 18:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbhCIRT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 12:19:27 -0500
Received: from mail-io1-f45.google.com ([209.85.166.45]:41622 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbhCIRTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 12:19:15 -0500
Received: by mail-io1-f45.google.com with SMTP id z13so14743467iox.8;
        Tue, 09 Mar 2021 09:19:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=YIX7Dnu6ZOI6uthXHSEBFQ73R3SsclPsMOaJ6CWylc0=;
        b=ldDG6qekJEk2ZSrg40F9cWWXxb4haSJBbdfJkhyrrg7aCG6bn8JVXxI4dNZ0m2kcLC
         eCPLq9KzkAf7boM8VzhRPWnJ769KEDQBDFlgeIVBUj28eDg3ABeJGks44hI1ItwmKRNT
         oUQUw5K4if+EO4mqw9QS7ONPEYhcgzEKik+ZxUHEj5b3FUNW3P2usurnIt+BbBcrHz7C
         c6SLt+FdP8dNM+DUjsDF9R+mYUuMInidSPrusT+MEEefIFATWCZ34av7p+b6wM6ySTVf
         GqKCH8V6ETXrVVEHAh6FtIu/sltUSadyWvmPlAvHa5EKOyTUK+M22eTdGzOUQQDMD9m5
         M4wg==
X-Gm-Message-State: AOAM5335u22Gb78NVg34YX9SvHnnGd/XlAv+cDzpXbUCbfXL/TKBY9Qj
        S9GREjU2f5HrZ0khG5hROg==
X-Google-Smtp-Source: ABdhPJzRmdE6z7NC5psRK7MCOEbg7ry4MfLOkKInzkAshEv4vN+lwplyS4guxlm/5dl9K2AhBR6UvQ==
X-Received: by 2002:a05:6638:3884:: with SMTP id b4mr14252658jav.18.1615310355241;
        Tue, 09 Mar 2021 09:19:15 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id r3sm8040263ilq.42.2021.03.09.09.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 09:19:14 -0800 (PST)
Received: (nullmailer pid 485081 invoked by uid 1000);
        Tue, 09 Mar 2021 17:19:11 -0000
From:   Rob Herring <robh@kernel.org>
To:     Evgeny Boger <boger@wirenboard.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
In-Reply-To: <20210309012116.2944-2-boger@wirenboard.com>
References: <20210309012116.2944-1-boger@wirenboard.com> <20210309012116.2944-2-boger@wirenboard.com>
Subject: Re: [PATCH v2 1/2] net: allwinner: reset control support
Date:   Tue, 09 Mar 2021 10:19:11 -0700
Message-Id: <1615310351.605196.485080.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 09 Mar 2021 04:21:15 +0300, Evgeny Boger wrote:
> R40 (aka V40/A40i/T3) and A10/A20 share the same EMAC IP.
> However, on R40 the EMAC is gated by default.
> 
> Signed-off-by: Evgeny Boger <boger@wirenboard.com>
> ---
>  .../net/allwinner,sun4i-a10-emac.yaml         | 11 +++-
>  drivers/net/ethernet/allwinner/sun4i-emac.c   | 65 +++++++++++++++++--
>  2 files changed, 70 insertions(+), 6 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/net/allwinner,sun4i-a10-emac.example.dts:24.28-29 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:349: Documentation/devicetree/bindings/net/allwinner,sun4i-a10-emac.example.dt.yaml] Error 1
make: *** [Makefile:1380: dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1449498

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

