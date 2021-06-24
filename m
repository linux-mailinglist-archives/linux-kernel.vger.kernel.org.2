Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6473B37BB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 22:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232638AbhFXUZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 16:25:07 -0400
Received: from mail-io1-f50.google.com ([209.85.166.50]:40505 "EHLO
        mail-io1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232120AbhFXUZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 16:25:04 -0400
Received: by mail-io1-f50.google.com with SMTP id r12so9854634ioa.7;
        Thu, 24 Jun 2021 13:22:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=knEwkp+Z8llmgr1VJTsCXisfmU+yU/tJNLrDFp/f5Bg=;
        b=XKvuzSr9XouvH9KvsUOnFi645eSpgkgqDiVpTnkQfQqwLqbrlWiFG1Jf85Qm15VGeu
         eHJn3MH/WjmNLfZbDqsJPXv3B0wy7yF1FeFYKvC/VcaYSC61856Q0eIdN9Tys3533oF9
         pJcymSklUJWAsikm71U39KcpSXT+TPFinc4Gk8fBv+/cZEen/3Xlc1Bk05CV2vUmliVL
         eR/qrOUwCZV/ttT6D3qQf691+G1VfPZf2UoUIk5bfBjXkLkfDWR/8t9aXyRAp9jbgGs/
         hjvUF0o0LhfhZHO1IzXuleZp7k8KXa1t2vSpQJAyezPPexbu7TJQ9YSV2jQ6Kh/gVMND
         G7xg==
X-Gm-Message-State: AOAM533zQkoU3iuSSL6sXX4rVJUb7vbzbM/lhQxdgzOt0hwNw056zM+4
        sNsVWzU2XpQ8jIlTIw3GMw==
X-Google-Smtp-Source: ABdhPJwobF8PdC0NO8payPPWkGXZGT2rK/e9rI/graPZ4wi+ob3vqdYIhC/ZQ9+WAp50FD9qqZtjMw==
X-Received: by 2002:a5d:8b8b:: with SMTP id p11mr5674403iol.77.1624566163505;
        Thu, 24 Jun 2021 13:22:43 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id g8sm1954736iop.31.2021.06.24.13.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 13:22:42 -0700 (PDT)
Received: (nullmailer pid 1927038 invoked by uid 1000);
        Thu, 24 Jun 2021 20:22:37 -0000
Date:   Thu, 24 Jun 2021 14:22:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Matthew Hagan <mnhagan88@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Geert Uytterhoeven <geert+renesas@glider.be>, soc@kernel.org,
        devicetree@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org,
        Scott Branden <sbranden@broadcom.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Ray Jui <rjui@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH v3 4/4] dt-bindings: arm: bcm: NSP: add Meraki MX64/MX65
Message-ID: <20210624202237.GA1926990@robh.at.kernel.org>
References: <20210613101658.3242777-1-mnhagan88@gmail.com>
 <20210613101658.3242777-5-mnhagan88@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210613101658.3242777-5-mnhagan88@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Jun 2021 11:16:48 +0100, Matthew Hagan wrote:
> Add bindings for the Meraki MX64/MX65 series. Note this patch should be
> applied on top of "dt-bindings: arm: bcm: add NSP devices to SoCs".
> 
> Signed-off-by: Matthew Hagan <mnhagan88@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/bcm/brcm,nsp.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
