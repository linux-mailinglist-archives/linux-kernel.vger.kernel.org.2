Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 098B737572E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 17:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235170AbhEFPay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 11:30:54 -0400
Received: from mail-oi1-f178.google.com ([209.85.167.178]:39909 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235757AbhEFP25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 11:28:57 -0400
Received: by mail-oi1-f178.google.com with SMTP id i81so5843969oif.6;
        Thu, 06 May 2021 08:27:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UdT6oYAl8C18McgDZRJwiqBr5EXOadWWjWo9IIpUpiI=;
        b=jcL6JaNIoORjcsWDJngK+Mi5tsiYDZDOjkoGK66WfAFwlymBssz+8k5nxmJf6zO89q
         iuxTHttIkOAfn1xx4zwjn6jPGaHrEiDIlTb/xHJz9tmwZQmnyj4ocCtxZv+t6I2buZ86
         oWAyRE8JRtifanbyOUVhF03DKau4VJ/nz5qVp7KJIlPwc0hkfl4+s8Y7J8od32jdC0Yg
         KZajJ1qNUe9W0P3tv0yE34+p0AU8+LZkKZUviYIIKhEzBT0wdgI8l9WjAHAvkoZcOZ66
         OfFVKtwbeTQ4EDH3luoV2hXSffl0SLZymE5uttQLaXnhhTpcSXizohGj4bdyhz6svpCW
         VhLg==
X-Gm-Message-State: AOAM532qURcutOp0wx5DCAKqXDy2qDgyZ1J9YMApdc76G7lChl7j4gD9
        0gJFOhMxZO7BAriG8EWvCwvgnChakA==
X-Google-Smtp-Source: ABdhPJyfSKCPn1AAWQTLL7rj2o6oQ4zHblgRyRmujHrElL8FaLsjOtDR8HoNVOvV0IzUVddMwqThRg==
X-Received: by 2002:aca:f5c7:: with SMTP id t190mr10889877oih.67.1620314878299;
        Thu, 06 May 2021 08:27:58 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r2sm631451otq.28.2021.05.06.08.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 08:27:57 -0700 (PDT)
Received: (nullmailer pid 357985 invoked by uid 1000);
        Thu, 06 May 2021 15:27:56 -0000
Date:   Thu, 6 May 2021 10:27:56 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chukun Pan <amadeus@jmu.edu.cn>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Chen-Yu Tsai <wens@csie.org>, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 2/2] dt-bindings: arm: Add NanoPi R1S H5
Message-ID: <20210506152756.GA357941@robh.at.kernel.org>
References: <20210503143202.21795-1-amadeus@jmu.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210503143202.21795-1-amadeus@jmu.edu.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 03 May 2021 22:32:02 +0800, Chukun Pan wrote:
> Add the bindings for NanoPi R1S H5 board.
> 
> Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
> ---
>  Documentation/devicetree/bindings/arm/sunxi.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
