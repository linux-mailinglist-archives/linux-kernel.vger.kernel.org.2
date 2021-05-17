Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C605F386BE7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 23:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240048AbhEQVHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 17:07:33 -0400
Received: from mail-ot1-f50.google.com ([209.85.210.50]:37618 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234755AbhEQVHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 17:07:32 -0400
Received: by mail-ot1-f50.google.com with SMTP id v19-20020a0568301413b0290304f00e3d88so6790311otp.4;
        Mon, 17 May 2021 14:06:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Qd0DmgUzwX1B7CuHmFZik+iX9eJ0IyHYNlgHtyEzHJI=;
        b=dLO2sjEsSPkRNjt/pCjQ4I/44AIgOtjO7thmqfdL62D/UyOB3VmLoanOsU0/CPmM6d
         d2VfL4n1duI3nigke1N9UXk3CMhszpBLaBX3YiHVSSM/D7q5jukN78aj22Pc07ZDKKJy
         rfj2upYius4GVOiHNSf0O0VcX7N5jVeJFaSRl/lLUT1ldr6Fm3PmSLHcQt5gg1SMHAih
         OgB1LBc5FFJSbJLm7H7fFyZGvXWiSCRQXSPikB1vynY22CNHzHuEwh/Ld4FtqQYozdZ6
         20CGY25JcZRB+XxPGVTmX25B8rpq4yCh4AqBsG//E0+ECLG9l/ShWARivBWBLm5HwbyD
         EsFA==
X-Gm-Message-State: AOAM533IAOe88rIaiYB7woMYo93oKOyxSeGp6sPwUIBTqSo3HveuXjdm
        NHjdBV3hd4Wf19OYCI3+uA==
X-Google-Smtp-Source: ABdhPJyONtp2uqla/PHannPzbG/gnLRRk3eVi/p0r9fJ78yb8RIfrE3OOkHLyaEFayyYr1IY/sdcmw==
X-Received: by 2002:a05:6830:1209:: with SMTP id r9mr1220347otp.153.1621285574235;
        Mon, 17 May 2021 14:06:14 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id x31sm359291ota.24.2021.05.17.14.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 14:06:13 -0700 (PDT)
Received: (nullmailer pid 3189540 invoked by uid 1000);
        Mon, 17 May 2021 21:06:06 -0000
Date:   Mon, 17 May 2021 16:06:06 -0500
From:   Rob Herring <robh@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lokesh Vutla <lokeshvutla@ti.com>,
        a-govindraju@ti.com
Subject: Re: [PATCH v2 1/6] dt-bindings: mux: Convert reg-mux DT bindings to
 YAML
Message-ID: <20210517210606.GA3185270@robh.at.kernel.org>
References: <20210517061739.5762-1-kishon@ti.com>
 <20210517061739.5762-2-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210517061739.5762-2-kishon@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021 at 11:47:34AM +0530, Kishon Vijay Abraham I wrote:
> Convert reg-mux DT bindings to YAML. Move the examples provided in
> reg-mux.txt to mux-controller.txt and remove reg-mux.txt
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  .../bindings/mux/mux-controller.txt           | 113 ++++++++++++++-

We don't want to be adding to this.

>  .../devicetree/bindings/mux/reg-mux.txt       | 129 ------------------
>  .../devicetree/bindings/mux/reg-mux.yaml      |  47 +++++++
>  3 files changed, 159 insertions(+), 130 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mux/reg-mux.txt
>  create mode 100644 Documentation/devicetree/bindings/mux/reg-mux.yaml

I have a more complete series converting mux bindings I'll send out.

Rob
