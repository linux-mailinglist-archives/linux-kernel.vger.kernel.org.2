Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5DC34198DD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 18:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235457AbhI0Q3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 12:29:49 -0400
Received: from mail-oi1-f182.google.com ([209.85.167.182]:46913 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235338AbhI0Q3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 12:29:46 -0400
Received: by mail-oi1-f182.google.com with SMTP id s69so26224009oie.13;
        Mon, 27 Sep 2021 09:28:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BmWdHyal2+SAHogeOgo0XQ9pH2xwWnNqoDfQ+wehmWo=;
        b=rdQEEtUsZ+u9JhSBcCUJa+6kha44MrqAABmYuUOq9Rv/n108FErChN7PPbrGiQlsvV
         EysGWoYLp34q9GFNltO7fuZHX4fHQWEAvpFhss4B4SWOv06XUO+srRgWmC9/dfE2mx7F
         nFU78NBeXGvvXFF1nXAVkNEA4/Dcyj8UVMV+wT6TzMLV72Kz+BzWxL/i94yqsWuwmSDB
         r1/7BAW8Vd4lfSRRpM4EaDe509UL10rSBRG5alG/uvxEw6evsOZq44px78hyJa/xq3Ga
         JesaPHvdWGRaEX5ppOfAq6adiHcNFtZOtu77dgY7+aL8vtCgm7UgpaEd5OJbTwozcdrA
         0QIg==
X-Gm-Message-State: AOAM530fkjqT9e7SxoLq/XPgOqr+10U1cNNUyPMwZ3GAJpVON4KNS6dp
        WeHIP1Dmsi3xcY0aZ2FlDg==
X-Google-Smtp-Source: ABdhPJwGdhDClDb3vx6+dSGGvZMneq43UC63vBSpI5SCNr93JTU4B/eovY4asckQV5LoOl/TcM56Ow==
X-Received: by 2002:a05:6808:14c9:: with SMTP id f9mr591378oiw.163.1632760087687;
        Mon, 27 Sep 2021 09:28:07 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id o126sm3961971oig.21.2021.09.27.09.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 09:28:06 -0700 (PDT)
Received: (nullmailer pid 3419976 invoked by uid 1000);
        Mon, 27 Sep 2021 16:28:06 -0000
Date:   Mon, 27 Sep 2021 11:28:06 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Jiri Kosina <trivial@kernel.org>
Subject: Re: [PATCH 3/6] dt-bindings: hwmon: ibm,cffps: move to trivial
 devices
Message-ID: <YVHxFkb/9VwkQaA+@robh.at.kernel.org>
References: <20210921102832.143352-1-krzysztof.kozlowski@canonical.com>
 <20210921102832.143352-3-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210921102832.143352-3-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Sep 2021 12:28:29 +0200, Krzysztof Kozlowski wrote:
> The IBM Common Form Factor Power Supply Versions 1 and 2 bindings are
> trivial, so they can be integrated into trivial devices bindings.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../devicetree/bindings/hwmon/ibm,cffps1.txt  | 26 -------------------
>  .../devicetree/bindings/trivial-devices.yaml  |  6 +++++
>  MAINTAINERS                                   |  1 -
>  3 files changed, 6 insertions(+), 27 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/hwmon/ibm,cffps1.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
