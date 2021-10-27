Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4664843C084
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 05:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238900AbhJ0DLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 23:11:09 -0400
Received: from mail-ot1-f47.google.com ([209.85.210.47]:40935 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237627AbhJ0DLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 23:11:08 -0400
Received: by mail-ot1-f47.google.com with SMTP id s18-20020a0568301e1200b0054e77a16651so1647988otr.7;
        Tue, 26 Oct 2021 20:08:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SL8PyMae2uutAnSwNkclI8/6GxgoD7Yrwbjti1pg/cw=;
        b=4Lfh/LX+YT1Mj/Xg25goTA8bpVYU4TXa5slYALtVklRK9zmW4pZiMqqlheKiQAC8KW
         rKY13+EY94Iy5vQ1osm4I3b2kmsuT4l8Bn6ocX7vKbD/PQRwa1kNf0Io7zG2H9q4oyZt
         O3xnzFjUDQyDf/4TJ1gcaSttDs/2Wf0nuVxO1I9D6ZvDKaGZaT+gqEI+w1fqq/zp8DoN
         e4sfZlg1Q8STjnCw/RFCGo/QKsLMIjA3Hm17EQARd4nFGBhTiBnY0ExuJvuUNC+CZrAJ
         xCXSfTxC+aWJVCHIiMS8uuZGNFJCRokvlncfRBElKMsR/wE/NoFQ73favjUX2uaZgKRY
         o7MA==
X-Gm-Message-State: AOAM533Zzj5o5em4tkD23Am+1JoGgpj7WcEr0rh3rwg2aBlqMjnx3V3c
        jAhr+Ldot3SI7lzF7bqrGQ==
X-Google-Smtp-Source: ABdhPJz+4mg5oVpWm00eIwRq2BUFPO3HTa3JbqtJSpDDxwtONDlpWCleHy//hrVlyc6AHjKPxb1gsQ==
X-Received: by 2002:a05:6830:557:: with SMTP id l23mr22586787otb.125.1635304123626;
        Tue, 26 Oct 2021 20:08:43 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id r14sm5587819oiw.44.2021.10.26.20.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 20:08:42 -0700 (PDT)
Received: (nullmailer pid 3940354 invoked by uid 1000);
        Wed, 27 Oct 2021 03:08:41 -0000
Date:   Tue, 26 Oct 2021 22:08:41 -0500
From:   Rob Herring <robh@kernel.org>
To:     Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        nicolas.ferre@microchip.com, kavyasree.kotagiri@microchip.com,
        eugen.hristev@microchip.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/3] dt-bindings: clock: lan966x: Extend for clock
 gate support
Message-ID: <YXjCufT1WyLEriY2@robh.at.kernel.org>
References: <20211019084449.1411060-1-horatiu.vultur@microchip.com>
 <20211019084449.1411060-2-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211019084449.1411060-2-horatiu.vultur@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 19, 2021 at 10:44:47AM +0200, Horatiu Vultur wrote:
> It is required to add a new resource to be able to access the clock gate
> registers. Now that we have 2 resources, add also reg-names property to
> make more clear.

It is an ABI breakage to require 2 reg entries. If that's okay for this 
binding, you need to explain why. The binding requiring 2 so that DT 
files get updated, but the driver allowing for 1 is okay.

> 
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> ---
>  .../bindings/clock/microchip,lan966x-gck.yaml       | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/microchip,lan966x-gck.yaml b/Documentation/devicetree/bindings/clock/microchip,lan966x-gck.yaml
> index fca83bd68e26..047c77e049f1 100644
> --- a/Documentation/devicetree/bindings/clock/microchip,lan966x-gck.yaml
> +++ b/Documentation/devicetree/bindings/clock/microchip,lan966x-gck.yaml
> @@ -19,7 +19,14 @@ properties:
>      const: microchip,lan966x-gck
>  
>    reg:
> -    maxItems: 1
> +    items:
> +      - description: core registers
> +      - description: gate registers
> +
> +  reg-names:
> +    items:
> +      - const: core
> +      - const: gate
>  
>    clocks:
>      items:
> @@ -39,6 +46,7 @@ properties:
>  required:
>    - compatible
>    - reg
> +  - reg-names
>    - clocks
>    - clock-names
>    - '#clock-cells'
> @@ -52,6 +60,7 @@ examples:
>          #clock-cells = <1>;
>          clocks = <&cpu_clk>, <&ddr_clk>, <&sys_clk>;
>          clock-names = "cpu", "ddr", "sys";
> -        reg = <0xe00c00a8 0x38>;
> +        reg = <0xe00c00a8 0x38>, <0xe00c02cc 0x4>;
> +        reg-names = "core", "gate";
>      };
>  ...
> -- 
> 2.33.0
> 
> 
