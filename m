Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA6F03986FE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 12:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbhFBKzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 06:55:06 -0400
Received: from foss.arm.com ([217.140.110.172]:41424 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230321AbhFBKy6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 06:54:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C61086D;
        Wed,  2 Jun 2021 03:53:15 -0700 (PDT)
Received: from bogus (unknown [10.57.72.241])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A64693F719;
        Wed,  2 Jun 2021 03:53:14 -0700 (PDT)
Date:   Wed, 2 Jun 2021 11:53:10 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Etienne Carriere <etienne.carriere@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Cristian Marussi <cristian.marussi@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/4] dt-bindings: arm: OP-TEE as transport channel for
 SCMI messages
Message-ID: <20210602105310.frlfxmxhqik4cnvr@bogus>
References: <20210521134055.24271-1-etienne.carriere@linaro.org>
 <20210521134055.24271-3-etienne.carriere@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210521134055.24271-3-etienne.carriere@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2021 at 03:40:53PM +0200, Etienne Carriere wrote:
> Introduce compatible "linaro,scmi-optee" for SCMI transport channel
> based on an OP-TEE service invocation.
> 
> Cc: Rob Herring <robh@kernel.org>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
> ---
> Changes since v1:
>  - Removed modification regarding mboxes property description.
> ---
>  Documentation/devicetree/bindings/arm/arm,scmi.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/arm,scmi.txt b/Documentation/devicetree/bindings/arm/arm,scmi.txt
> index 856d041b397e..ccab2ef6f6ec 100644
> --- a/Documentation/devicetree/bindings/arm/arm,scmi.txt
> +++ b/Documentation/devicetree/bindings/arm/arm,scmi.txt
> @@ -14,7 +14,8 @@ Required properties:
>  
>  The scmi node with the following properties shall be under the /firmware/ node.
>  
> -- compatible : shall be "arm,scmi" or "arm,scmi-smc" for smc/hvc transports
> +- compatible : shall be "arm,scmi" or "arm,scmi-smc" for smc/hvc transports,
> +	  or "linaro,scmi-optee" for OP-TEE transport.

Please rebase this [1] when you post next version. It is not clear about
the mailbox or shmem properties here  for this new OP-TEE transport but
I assume it will be easier to understand with yaml schema.

-- 
Regards,
Sudeep

[1] https://lore.kernel.org/r/20210601224904.917990-9-sudeep.holla@arm.com/
