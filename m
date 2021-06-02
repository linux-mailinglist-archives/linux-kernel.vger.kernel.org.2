Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 240C03986B7
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 12:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232609AbhFBKmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 06:42:46 -0400
Received: from foss.arm.com ([217.140.110.172]:41088 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231990AbhFBKmo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 06:42:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BB61C1063;
        Wed,  2 Jun 2021 03:41:01 -0700 (PDT)
Received: from bogus (unknown [10.57.72.241])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3F6C43F73D;
        Wed,  2 Jun 2021 03:41:00 -0700 (PDT)
Date:   Wed, 2 Jun 2021 11:40:50 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Etienne Carriere <etienne.carriere@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Cristian Marussi <cristian.marussi@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/4] dt-bindings: arm: scmi property mboxes is not
 mandatory
Message-ID: <20210602104039.aoaty3is2ntokax2@bogus>
References: <20210521134055.24271-1-etienne.carriere@linaro.org>
 <20210521134055.24271-2-etienne.carriere@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210521134055.24271-2-etienne.carriere@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2021 at 03:40:52PM +0200, Etienne Carriere wrote:
> Since "arm,scmi-smc" compatible support, mboxes property is not mandated.
> This change fixes the DT bindings description accordingly.
> 
> Cc: Rob Herring <robh@kernel.org>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
> ---
> Changes since v1:
>  - New patch is the series. Addresses mboxes propery description.
> ---
>  Documentation/devicetree/bindings/arm/arm,scmi.txt | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/arm,scmi.txt b/Documentation/devicetree/bindings/arm/arm,scmi.txt
> index 667d58e0a659..856d041b397e 100644
> --- a/Documentation/devicetree/bindings/arm/arm,scmi.txt
> +++ b/Documentation/devicetree/bindings/arm/arm,scmi.txt
> @@ -15,10 +15,10 @@ Required properties:
>  The scmi node with the following properties shall be under the /firmware/ node.
>  
>  - compatible : shall be "arm,scmi" or "arm,scmi-smc" for smc/hvc transports
> -- mboxes: List of phandle and mailbox channel specifiers. It should contain
> -	  exactly one or two mailboxes, one for transmitting messages("tx")
> -	  and another optional for receiving the notifications("rx") if
> -	  supported.
> +- mboxes: List of phandle and mailbox channel specifiers. When used, it should
> +	  contain exactly one or two mailboxes, one for transmitting messages
> +	  ("tx") and another optional for receiving the notifications("rx") if
> +	  supported. Mandated by compatible "arm,scmi".

This change is not required with yaml as you can have right schema to reflect
this dependency. I think I already took care of this.

-- 
Regards,
Sudeep
