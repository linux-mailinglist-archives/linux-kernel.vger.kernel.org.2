Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 522943174EF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 01:03:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234170AbhBKADm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 19:03:42 -0500
Received: from mail-oi1-f182.google.com ([209.85.167.182]:39575 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232903AbhBKAD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 19:03:27 -0500
Received: by mail-oi1-f182.google.com with SMTP id l19so4165225oih.6;
        Wed, 10 Feb 2021 16:03:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KhcTPGLbTTQ3ei4hkYQiiov8uAb8bHQwhbSbgo4CZbw=;
        b=Y7cfgujuQMN5/FG5SiQyivGvwYUDALD7FlFcUN3JiM0ooZGL9mExS0D+cq5+BGf9B+
         hsXkV/CaIzdIYaUWXXExsC/G3JgtLmS42nGTHUMOuHdYXHL+5T2D731vv+HWtvWyCAet
         e1dXAxDeHtqdz3/q191BjRKNDIRPoe9gV+CsmZeQvKJVLzX5dtZH+g/TVmQ061RVoeGt
         /5jF97CmUXfkEknG2jYCS2et+LlQiIMCbcJgdwL9LaQNl7mPo9hVdYYgk8YD+DtWfC6j
         IT7wWFKqNxTM0ylxV2nmJUM2On2r3w4GG+yN4ATM8rPV4DRvg9IUUIciyKG3RzplASJv
         bicQ==
X-Gm-Message-State: AOAM533QJp3XIN135iKtzi6QM0CGDtKCTvdmPj9Eb3I/q4fPLAeMlvH8
        TnFXeKXN1solqquVhLdPuw==
X-Google-Smtp-Source: ABdhPJz+LCL4IckHTXfklTHuAZ8PMKqtL1uSXq4WLg0yntYTkAFs1dmMhiokbKm1tUzWC5trMsY5AQ==
X-Received: by 2002:aca:4fca:: with SMTP id d193mr1046762oib.135.1613001767053;
        Wed, 10 Feb 2021 16:02:47 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t65sm788573oie.25.2021.02.10.16.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 16:02:46 -0800 (PST)
Received: (nullmailer pid 3093107 invoked by uid 1000);
        Thu, 11 Feb 2021 00:02:45 -0000
Date:   Wed, 10 Feb 2021 18:02:45 -0600
From:   Rob Herring <robh@kernel.org>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Oleksij Rempel <linux@rempel-privat.de>,
        devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/15] dt-bindings: arm: fsl: add ls1021a-tsn board
Message-ID: <20210211000245.GA3093051@robh.at.kernel.org>
References: <20210205234734.3397-1-leoyang.li@nxp.com>
 <20210205234734.3397-2-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210205234734.3397-2-leoyang.li@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 05 Feb 2021 17:47:20 -0600, Li Yang wrote:
> Add the missing board in the binding docuemnt.
> 
> Signed-off-by: Li Yang <leoyang.li@nxp.com>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
