Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33D013113B0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 22:39:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbhBEVjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 16:39:03 -0500
Received: from mail-oi1-f174.google.com ([209.85.167.174]:32913 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231699AbhBEVdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 16:33:37 -0500
Received: by mail-oi1-f174.google.com with SMTP id j25so9066110oii.0;
        Fri, 05 Feb 2021 13:33:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=86eO/CLFxDsv5n6pTUydgpIRqU5ON+6WVGskNxWogxA=;
        b=nnceqZNaX8p4AxoOeczekdkvj2ZdP5JyLb2gG3WuYMVOGewFe90GxSm14i2E0lUsFG
         BkSzn72pYuSLdA5vljtjoCCBz859tz3HYe07yxLINDYSCnEKDojqTsXfIvoG3zYZ0NbU
         cCfn6rZNaYj5Mqk+lxgHb1GUZY//jYmgmpP/smhWiUS/R1y7wYcyT2UGn3bPTR4M39U6
         t5xWw3mexIaMcr/atDlmsjQw4gLmTIeWptjG8qXxD5YKFa2DoINbtGQg/AR7ZQ0FpXnI
         jrvs+GF5YZ+s4YJLwqdPoqiLaBpZiZpcp+sDQ8aC2IgPCcFnQx8boqhng6oPGJsmcBdK
         5Rkw==
X-Gm-Message-State: AOAM5335AhW0ZDCjxiq2XYSBzoioJgOiOUk9qtQR2EYYeJqGQ+xuNfgI
        KbTK5VIKs4ihNI8fC6rwfw==
X-Google-Smtp-Source: ABdhPJwKCKLqY/zf52ITpGj52KvCSevpP49mjoubxMi9PUwPQMtCCEx7UBJSzNbPQ08yn9IGf+K1lw==
X-Received: by 2002:aca:308a:: with SMTP id w132mr4243401oiw.69.1612560776545;
        Fri, 05 Feb 2021 13:32:56 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v67sm2102221otb.43.2021.02.05.13.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 13:32:55 -0800 (PST)
Received: (nullmailer pid 3784899 invoked by uid 1000);
        Fri, 05 Feb 2021 21:32:54 -0000
Date:   Fri, 5 Feb 2021 15:32:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     Robert Marko <robert.marko@sartura.hr>
Cc:     linux-doc@vger.kernel.org, linux@roeck-us.net, robh+dt@kernel.org,
        jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, Luka Perkov <luka.perkov@sartura.hr>,
        linux-kernel@vger.kernel.org, corbet@lwn.net
Subject: Re: [PATCH v5 1/3] dt-bindings: hwmon: Add TI TPS23861 bindings
Message-ID: <20210205213254.GA3784838@robh.at.kernel.org>
References: <20210121134434.2782405-1-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121134434.2782405-1-robert.marko@sartura.hr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Jan 2021 14:44:32 +0100, Robert Marko wrote:
> Document bindings for the Texas Instruments TPS23861 driver.
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> Cc: Luka Perkov <luka.perkov@sartura.hr>
> ---
> Changes in v5:
> * Drop uint32 reference
> 
> Changes in v4:
> * Correct shunt binding
> 
>  .../bindings/hwmon/ti,tps23861.yaml           | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/ti,tps23861.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
