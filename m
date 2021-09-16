Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20A7840D77E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 12:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236755AbhIPKfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 06:35:32 -0400
Received: from foss.arm.com ([217.140.110.172]:35998 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236569AbhIPKfa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 06:35:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EDAD16D;
        Thu, 16 Sep 2021 03:34:09 -0700 (PDT)
Received: from bogus (unknown [10.57.23.241])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 87EE73F5A1;
        Thu, 16 Sep 2021 03:34:08 -0700 (PDT)
Date:   Thu, 16 Sep 2021 11:33:49 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 11/23] MAINTAINERS: update arm,vic.yaml reference
Message-ID: <20210916103349.jn236anjr35zkdem@bogus>
References: <cover.1631785820.git.mchehab+huawei@kernel.org>
 <404ece147136b7094e2e3a6b33426a9359ac1ca1.1631785820.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <404ece147136b7094e2e3a6b33426a9359ac1ca1.1631785820.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2021 at 11:55:10AM +0200, Mauro Carvalho Chehab wrote:
> Changeset b7705ba6d0c4 ("dt-bindings: interrupt-controller: Convert ARM VIC to json-schema")
> renamed: Documentation/devicetree/bindings/interrupt-controller/arm,vic.txt
> to: Documentation/devicetree/bindings/interrupt-controller/arm,vic.yaml.
> 
> Update its cross-reference accordingly.
> 
> Fixes: b7705ba6d0c4 ("dt-bindings: interrupt-controller: Convert ARM VIC to json-schema")
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

You had my ack already here [1] 😄

> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 30f75af400f3..ddea1f2cdadc 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1550,7 +1550,7 @@ ARM PRIMECELL VIC PL190/PL192 DRIVER
>  M:	Linus Walleij <linus.walleij@linaro.org>
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>  S:	Maintained
> -F:	Documentation/devicetree/bindings/interrupt-controller/arm,vic.txt
> +F:	Documentation/devicetree/bindings/interrupt-controller/arm,vic.yaml
>  F:	drivers/irqchip/irq-vic.c
>  
>  ARM SMC WATCHDOG DRIVER
> -- 
> 2.31.1
> 

-- 
Regards,
Sudeep

[1] https://lore.kernel.org/all/20210722101117.5anhjut6djso2ojr@bogus/
