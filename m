Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA0344349F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 18:36:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234309AbhKBRiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 13:38:46 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:36678 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbhKBRio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 13:38:44 -0400
Received: by mail-ot1-f41.google.com with SMTP id r10-20020a056830448a00b0055ac7767f5eso1051544otv.3;
        Tue, 02 Nov 2021 10:36:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DNq5JSscCMSLWGQ/f7I1V6R1ezEKDvo9DxBdxVJi+eA=;
        b=4Wx6eAc3QoSO48zqs3PXb9u7faLPvjvU9oCUBhTpPpeAimW3gbTsm2najGLErr5Io4
         eNmBOfVf2+DoUwTgxC36clMRsQQ/CLYZfn1V4+LWcoszR5MPEU7vbyD5KoCGNMHhBzRp
         iU7bMe5Rys1cEEL1c9qPaL0/jmEivFSJqKlqHS1LIdIsKomgMAkE6BIX8Av5uSr5YQEU
         oLXr+KLENUsCJSplvAk+A0A68mwN7nUDu4FllRS4OJLgBAOlthSbopm3HFUtWqMAuRcm
         wTd5XeeNe6fvHRHxbNSa1UrPEiMzx3KVKyfLNTA8ImEqiYAzK47tWUGWvAHp0QQrUT6J
         EU2A==
X-Gm-Message-State: AOAM530PouhtubSGQqLohuvjuE7VLUwkl9rAnET9dPysNAyajpRKwUEo
        sP+N6eTHEnWfpfi/jiLZWg==
X-Google-Smtp-Source: ABdhPJwg3GBjEOC1uT7Pb5dnA4rQO19HRiqwgpZr/UMZS9quaJXggSzHr7F04E7nMzk+BwTFY2+3WQ==
X-Received: by 2002:a9d:2002:: with SMTP id n2mr3172454ota.362.1635874569155;
        Tue, 02 Nov 2021 10:36:09 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id g17sm5064996otq.17.2021.11.02.10.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 10:36:08 -0700 (PDT)
Received: (nullmailer pid 3127911 invoked by uid 1000);
        Tue, 02 Nov 2021 17:36:07 -0000
Date:   Tue, 2 Nov 2021 12:36:07 -0500
From:   Rob Herring <robh@kernel.org>
To:     Nathan Rossi <nathan@nathanrossi.com>
Cc:     Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
        Nathan Rossi <nathan.rossi@digi.com>,
        linux-hwmon@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>
Subject: Re: [PATCH v4 2/3] dt-bindings: hwmon: ti,ina2xx: Add ti,shunt-gain
 property
Message-ID: <YYF3B+ztZ5uJMEuP@robh.at.kernel.org>
References: <20211102052754.817220-0-nathan@nathanrossi.com>
 <20211102052754.817220-2-nathan@nathanrossi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211102052754.817220-2-nathan@nathanrossi.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 02 Nov 2021 05:27:54 +0000, Nathan Rossi wrote:
> From: Nathan Rossi <nathan.rossi@digi.com>
> 
> Add a property to the binding to define the selected shunt voltage gain.
> This specifies the range and accuracy that applies to the shunt circuit.
> This property only applies to devices that have a selectable shunt
> voltage range via PGA or ADCRANGE register configuration.
> 
> Signed-off-by: Nathan Rossi <nathan.rossi@digi.com>
> ---
> Changes in v2:
> - Added binding for shunt-gain
> 
> Changes in v3:
> - Fix schema error, setting $ref to uint32
> - Improve the description to detail exactly how to define the property
>   and how the property affects initial device configuration and
>   calculation of values
> ---
>  .../devicetree/bindings/hwmon/ti,ina2xx.yaml        | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
