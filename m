Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5129C42163C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 20:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237860AbhJDSU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 14:20:28 -0400
Received: from mail-ot1-f50.google.com ([209.85.210.50]:39790 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233716AbhJDSUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 14:20:24 -0400
Received: by mail-ot1-f50.google.com with SMTP id j11-20020a9d190b000000b00546fac94456so22740094ota.6;
        Mon, 04 Oct 2021 11:18:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hfPDH+LuFRcAhIlz3hcET85MQea3lnFzaaWohI9DSu4=;
        b=4P9OwGL1ljSS4uXi2zSOg1D7hhBUP2kB+B3YRgeoUwZl68x3r3WwZUlxWdS5wkHy0j
         lC4fzJynCCGCu1iZOMRdHgTZrQRzAhApnj4dIuZZwx+kN6WDQ1yiExTG82V27fdZzETi
         1HkETk0KAqXPT++ERgT8yOvEAxcR2YeyeOC9MAAX0JgwHys6i+/xA25yDh37UQCfVkK5
         A7Rf7ErRIVYDkhWg/t29GOD1L2vtSrZFXGQPGjys9nvR6iqRfrZpUBbPYv8CNXy/ZPBp
         8yPD9TsBN6mrQBVyhMpYB0CTliKZ+PjfIxJpjkkkeRLD1OqV03nczqi5DKZqaM13kc7L
         chEg==
X-Gm-Message-State: AOAM533JmecERwuISaISCMm5/I9tzxKqcj5q9HHyPsNN/OoaJIepqOQa
        L18uhs2raDEhFhhezbn8OQ==
X-Google-Smtp-Source: ABdhPJys2SVCxDLn87c9yaE7EPvbMTc8qjz25EWikXj7QmKkffB3+8vSQZS5zRLhaTBrZfqt6u7LNA==
X-Received: by 2002:a9d:4c0c:: with SMTP id l12mr10656606otf.144.1633371515051;
        Mon, 04 Oct 2021 11:18:35 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id 38sm3036831oti.13.2021.10.04.11.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 11:18:34 -0700 (PDT)
Received: (nullmailer pid 1596326 invoked by uid 1000);
        Mon, 04 Oct 2021 18:18:33 -0000
Date:   Mon, 4 Oct 2021 13:18:33 -0500
From:   Rob Herring <robh@kernel.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     Rob Herring <robh+dt@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>
Subject: Re: [PATCH] dt-bindings: display: simple: hardware can use
 ddc-i2c-bus
Message-ID: <YVtFeWfIa0zZe9sF@robh.at.kernel.org>
References: <20210927214503.36012-1-david@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210927214503.36012-1-david@ixit.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Sep 2021 23:45:03 +0200, David Heidelberg wrote:
> Both hardware and driver can communicate DDC over i2c bus.
> 
> Fixes warnings as:
> arch/arm/boot/dts/tegra20-paz00.dt.yaml: panel: 'ddc-i2c-bus' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	From schema: /home/runner/work/linux/linux/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  .../devicetree/bindings/display/panel/panel-simple.yaml          | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
