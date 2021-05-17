Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA65386C64
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 23:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245275AbhEQVki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 17:40:38 -0400
Received: from mail-oi1-f174.google.com ([209.85.167.174]:37600 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237766AbhEQVki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 17:40:38 -0400
Received: by mail-oi1-f174.google.com with SMTP id h9so7849572oih.4;
        Mon, 17 May 2021 14:39:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zWnED48EDpwnC0QrK/2GG96NIx3ZITF2lzNhyILVV74=;
        b=OlabhuLUudxdOVPNpDpNdRJsayuzmpLYM7msgQREpm3g8ctQRdGMqZk0uzZQCyhVQ6
         XEOoaD1xPbnrOLlmLU51W32cIVXTkykwJ/jIyonS6e3IuXU/GoFOwVFZCxsfaZZPu5/H
         KfkIrbi2cuy5THhTdGlA4VoeqDMy4tTgGdWROAxl2orkYoghb6nbREfgq1Wo/MeA4gYb
         7uVAZVd3hFKSr6k0vtuMvKJ6M/oPp7XNXBibrXxMBjQV/4wqo3NOBX+h+z0kgHWQbaQM
         4yyU8yz99i5ZyuMxHLZE/8F7uJrelIvHL9UWVLE2kncmCTDWHWeK309f0fAuePvRIOgl
         KVbQ==
X-Gm-Message-State: AOAM533AACeLuDyx1poIjZO70RyqwLa4mRjfTn6C191wdcGltcuJPWGs
        s1eYahra6nKFtZSlLP98maApx+DYHQ==
X-Google-Smtp-Source: ABdhPJxbbgK+3rR9bUWE5aQU5JbRSHEo1oLdNN62ukR0PSLUGUDbIGrEZdBl0bBU6Cnrxo6AJT4mEw==
X-Received: by 2002:aca:f44c:: with SMTP id s73mr1354014oih.142.1621287560921;
        Mon, 17 May 2021 14:39:20 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q1sm3470980otc.21.2021.05.17.14.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 14:39:19 -0700 (PDT)
Received: (nullmailer pid 3247628 invoked by uid 1000);
        Mon, 17 May 2021 21:39:18 -0000
Date:   Mon, 17 May 2021 16:39:18 -0500
From:   Rob Herring <robh@kernel.org>
To:     Peter Hilber <peter.hilber@opensynergy.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org,
        Igor Skalkin <igor.skalkin@opensynergy.com>,
        linux-kernel@vger.kernel.org, sudeep.holla@arm.com,
        souvik.chakravarty@arm.com, alex.bennee@linaro.org,
        jean-philippe@linaro.org, mikhail.golubev@opensynergy.com,
        anton.yakovlev@opensynergy.com,
        Vasyl Vavrychuk <Vasyl.Vavrychuk@opensynergy.com>,
        Andriy Tryshnivskyy <Andriy.Tryshnivskyy@opensynergy.com>,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: Re: [RFC PATCH v3 10/12] dt-bindings: arm: Add virtio transport for
 SCMI
Message-ID: <20210517213918.GA3244026@robh.at.kernel.org>
References: <20210511002040.802226-1-peter.hilber@opensynergy.com>
 <20210511002040.802226-11-peter.hilber@opensynergy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210511002040.802226-11-peter.hilber@opensynergy.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2021 at 02:20:38AM +0200, Peter Hilber wrote:
> From: Igor Skalkin <igor.skalkin@opensynergy.com>
> 
> Document the properties for arm,scmi-virtio compatible nodes. The
> backing virtio SCMI device is described in patch [1].
> 
> [1] https://lists.oasis-open.org/archives/virtio-comment/202005/msg00096.html
> 
> Signed-off-by: Igor Skalkin <igor.skalkin@opensynergy.com>
> [ Peter: Adapted patch for submission to upstream. ]
> Co-developed-by: Peter Hilber <peter.hilber@opensynergy.com>
> Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>
> ---
>  .../devicetree/bindings/arm/arm,scmi.txt      | 35 +++++++++++++++++--
>  1 file changed, 33 insertions(+), 2 deletions(-)

Seems like it may not be perfectly clear what properties apply or not 
for the different transports. Can you convert this to DT schema first.

> 
> diff --git a/Documentation/devicetree/bindings/arm/arm,scmi.txt b/Documentation/devicetree/bindings/arm/arm,scmi.txt
> index 667d58e0a659..5d209ba666f6 100644
> --- a/Documentation/devicetree/bindings/arm/arm,scmi.txt
> +++ b/Documentation/devicetree/bindings/arm/arm,scmi.txt
> @@ -13,6 +13,9 @@ the device tree.
>  Required properties:
>  
>  The scmi node with the following properties shall be under the /firmware/ node.
> +Some properties are specific to a transport type.
> +
> +shmem-based transports (mailbox, smc/hvc):
>  
>  - compatible : shall be "arm,scmi" or "arm,scmi-smc" for smc/hvc transports
>  - mboxes: List of phandle and mailbox channel specifiers. It should contain
> @@ -21,6 +24,15 @@ The scmi node with the following properties shall be under the /firmware/ node.
>  	  supported.
>  - shmem : List of phandle pointing to the shared memory(SHM) area as per
>  	  generic mailbox client binding.
> +
> +Virtio transport:
> +
> +- compatible : shall be "arm,scmi-virtio".
> +
> +The virtio transport only supports a single device.
> +
> +Additional required properties:
> +
>  - #address-cells : should be '1' if the device has sub-nodes, maps to
>  	  protocol identifier for a given sub-node.
>  - #size-cells : should be '0' as 'reg' property doesn't have any size
> @@ -50,7 +62,8 @@ Each protocol supported shall have a sub-node with corresponding compatible
>  as described in the following sections. If the platform supports dedicated
>  communication channel for a particular protocol, the 3 properties namely:
>  mboxes, mbox-names and shmem shall be present in the sub-node corresponding
> -to that protocol.
> +to that protocol. The virtio transport does not support dedicated communication
> +channels.
>  
>  Clock/Performance bindings for the clocks/OPPs based on SCMI Message Protocol
>  ------------------------------------------------------------
> @@ -129,7 +142,8 @@ Required sub-node properties:
>  [5] Documentation/devicetree/bindings/reset/reset.txt
>  [6] Documentation/devicetree/bindings/regulator/regulator.yaml
>  
> -Example:
> +Example (mailbox transport):
> +----------------------------
>  
>  sram@50000000 {
>  	compatible = "mmio-sram";
> @@ -237,3 +251,20 @@ thermal-zones {
>  		...
>  	};
>  };
> +
> +Example (virtio transport):
> +---------------------------
> +
> +virtio_mmio@4b001000 {
> +	compatible = "virtio,mmio";
> +	...
> +};
> +
> +firmware {
> +	...
> +	scmi {
> +		compatible = "arm,scmi-virtio";
> +		...
> +
> +The rest is similar to the mailbox transport example, when omitting the
> +mailbox/shmem-specific properties.
> -- 
> 2.25.1
> 
> 
