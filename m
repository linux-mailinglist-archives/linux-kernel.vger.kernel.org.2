Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC5283895E8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 20:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbhESS4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 14:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231785AbhESS4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 14:56:53 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF023C061760
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 11:55:31 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id n2so21465527ejy.7
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 11:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ozhcNnmjJykX8CENQvAtlJcxEQtoWfnPoMzH44+/u8M=;
        b=EngHpsXszaIQBhtMjNRJ01k9zqE9xMrzgF8qprvmPHRhzIAcGpNGC4cQUMOMyrf1f2
         Fhyol3bEk10lieVYuHRs3+KYBMM9XdAc3+jnFnLHQXH5kmZiBrB2UxdjXYkU8C+VsyDL
         dLo1RuoLL6YueQmJIlyTL0A6EQepvfX0Q3Jc5Swq8ErLUYOFGQJ7zZ6wLP52y761RJYl
         d1niQ6oS8MgHPuU0RPdES7wLjE/W3QzDUE5qCXW6mbrr2hv2V8rPDhVmhZLXVRCuKe9q
         mGY3QrAsL5HKRLx/n9tnmaIqINBYu5lynqTt+u8z3updQzmGI3Z62zdVMR51rq/RS+fs
         4ISA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ozhcNnmjJykX8CENQvAtlJcxEQtoWfnPoMzH44+/u8M=;
        b=GXq8EbV3Sfr/Ii6vXl4zVu2loJ1/2usQku91DdKL2EMOW5TRj7EowefQZEX5v9ga0M
         XUbmTsog3rgM/j1ZEf8H9dGykx+lcYwzFJQ82p3OFHAOFeoiGeJ4NkqyzIPneCRd58S1
         zLJOW27UV8OZwMSPqcQO0jL2W9f7HQQSaod+QtCHtbURGx8+gace0bbT/B/uWc3N5Sif
         mCIvMeg36+kgbmcb4+tmlr7xmsLxlkZi+lb9o3NU3x/UACpDrV/vRTBZ+6L7DUQzakx6
         icOru0PLbl1y1V3PJzO08A+lfqotrKVi4m1IyV1A+rTukzHXz6KCqoiosf8T4oFc3t79
         suyg==
X-Gm-Message-State: AOAM532OczBgLCbEyUTMzPlC3Q3U5CY32L6ZInZ1bBCz+X1fXLh5Vkev
        z7PHIhMKdTZxxBnnhHvaEtm3yu5WFTFBJ2SVG9Nu82iNY5yQjiVY
X-Google-Smtp-Source: ABdhPJwYbfNKIhHUiqg1mzSFPIfho83bxqGf2dIOG1i8CLKWLrPWZQhRDjdvGaMJAyv9UxmfhDNO+fRW27Tqoky78J8=
X-Received: by 2002:a17:906:3544:: with SMTP id s4mr596017eja.73.1621450530245;
 Wed, 19 May 2021 11:55:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210519170158.27586-1-etienne.carriere@linaro.org> <20210519170158.27586-2-etienne.carriere@linaro.org>
In-Reply-To: <20210519170158.27586-2-etienne.carriere@linaro.org>
From:   Etienne Carriere <etienne.carriere@linaro.org>
Date:   Wed, 19 May 2021 20:55:19 +0200
Message-ID: <CAN5uoS_LGCZ6wPrihhN8NOAgaG1y58eTB0CFpHPdmBsO43JQqw@mail.gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: arm: OP-TEE as transport channel for
 SCMI messages
To:     linux-kernel@vger.kernel.org
Cc:     "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 May 2021 at 19:02, Etienne Carriere
<etienne.carriere@linaro.org> wrote:
>
> Introduce compatible "linaro,scmi-optee" for SCMI transport channel
> based on an OP-TEE service invocation.
>
> Cc: Rob Herring <robh@kernel.org>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/arm,scmi.txt | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/arm/arm,scmi.txt b/Documentation/devicetree/bindings/arm/arm,scmi.txt
> index 667d58e0a659..7658f16b3f35 100644
> --- a/Documentation/devicetree/bindings/arm/arm,scmi.txt
> +++ b/Documentation/devicetree/bindings/arm/arm,scmi.txt
> @@ -14,10 +14,11 @@ Required properties:
>
>  The scmi node with the following properties shall be under the /firmware/ node.
>
> -- compatible : shall be "arm,scmi" or "arm,scmi-smc" for smc/hvc transports
> -- mboxes: List of phandle and mailbox channel specifiers. It should contain
> -         exactly one or two mailboxes, one for transmitting messages("tx")
> -         and another optional for receiving the notifications("rx") if
> +- compatible : shall be "arm,scmi" or "arm,scmi-smc" for smc/hvc transports,
> +         or "linaro,scmi-optee" for OP-TEE transport.
> +- mboxes: List of phandle and mailbox channel specifiers. When used, it should
> +         contain exactly one or two mailboxes, one for transmitting messages
> +         ("tx") and another optional for receiving the notifications("rx") if

Sorry, i missed that. This change should not modify mboxes property description.
I'll send a v2. My apologies.

etienne

>           supported.
>  - shmem : List of phandle pointing to the shared memory(SHM) area as per
>           generic mailbox client binding.
> --
> 2.17.1
>
