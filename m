Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6964D4434A5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 18:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234458AbhKBRjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 13:39:42 -0400
Received: from mail-oi1-f170.google.com ([209.85.167.170]:40884 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbhKBRjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 13:39:41 -0400
Received: by mail-oi1-f170.google.com with SMTP id y11so2784366oih.7;
        Tue, 02 Nov 2021 10:37:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Sn6+AkoZFV1ZF/k4K9gJKdb8CffkoibxZf2gz4mB0VE=;
        b=Vp9qo18CguFnKCe24pX+8P0pFv92PzWiArDHPjJrp8frXC/Dq56Axu82dn3jcAfg54
         BYS+c5ZesjmRv/xI5KaRjudqbxOcN91RFCgjBoOyyi+OLfplub+ta8CmgQu6OfMOyprw
         /ZThlzCU36muhxc7ISmE+gfvTdB9g6DQFt/E3whE6W11hj2b6mzM7rqI5/pjJz14t+yO
         /UgjPqUfdv88sVMmVpEEJh1geEmwcPOpUrcwQILvcM6YXhjJUBzZHswwHo30kfzzKhAo
         fQqArwNis84cdGC3pSU4DwzmsMP+2KiDSrxYUBKZSdsLCHIG4CuT8VrGl1GfEwDXFkSx
         6fPQ==
X-Gm-Message-State: AOAM533041nMfDBF0vr7K9tIwxB1hHLK4y3bxdIRnjWx396DHDxwTDb8
        2jlGkhCBnG58Hm6XaDQ4JxGJnA8vvg==
X-Google-Smtp-Source: ABdhPJzADlCKh5gpcvmvnHoAIw+62jcqYwrYFQesFt5odI06SyOXH+XFgDjiaiZLEfRSen5JSHxvDQ==
X-Received: by 2002:aca:de8a:: with SMTP id v132mr6419372oig.61.1635874625667;
        Tue, 02 Nov 2021 10:37:05 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id bb39sm5225195oib.28.2021.11.02.10.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 10:37:05 -0700 (PDT)
Received: (nullmailer pid 3129678 invoked by uid 1000);
        Tue, 02 Nov 2021 17:37:04 -0000
Date:   Tue, 2 Nov 2021 12:37:04 -0500
From:   Rob Herring <robh@kernel.org>
To:     Nathan Rossi <nathan@nathanrossi.com>
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Nathan Rossi <nathan.rossi@digi.com>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v4 1/3] dt-bindings: hwmon: ti,ina2xx: Document ti,ina238
 compatible string
Message-ID: <YYF3QDb2K1rUqCNK@robh.at.kernel.org>
References: <20211102052754.817220-0-nathan@nathanrossi.com>
 <20211102052754.817220-1-nathan@nathanrossi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211102052754.817220-1-nathan@nathanrossi.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 02 Nov 2021 05:27:54 +0000, Nathan Rossi wrote:
> From: Nathan Rossi <nathan.rossi@digi.com>
> 
> Document the compatible string for the Texas Instruments INA238, this
> device is a variant of the existing INA2xx devices and has the same
> device tree bindings (shunt resistor).
> 
> Signed-off-by: Nathan Rossi <nathan.rossi@digi.com>
> ---
>  Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
