Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87FAB3122D0
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 09:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbhBGIi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 03:38:26 -0500
Received: from marcansoft.com ([212.63.210.85]:50108 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229522AbhBGIhH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 03:37:07 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 3A3F742856;
        Sun,  7 Feb 2021 08:36:14 +0000 (UTC)
To:     Arnd Bergmann <arnd@kernel.org>, Marc Zyngier <maz@kernel.org>
Cc:     SoC Team <soc@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Olof Johansson <olof@lixom.net>
References: <20210204203951.52105-1-marcan@marcan.st>
 <20210204203951.52105-11-marcan@marcan.st> <87h7mpky0f.wl-maz@kernel.org>
 <CAK8P3a0-Qk1WAUaCWeX8Zypphpadan3YAOES9t7LFYBOJkXKog@mail.gmail.com>
From:   Hector Martin 'marcan' <marcan@marcan.st>
Subject: Re: [PATCH 10/18] arm64: Introduce FIQ support
Message-ID: <cb721f28-d5e9-3381-2d04-746c0aa2a0d3@marcan.st>
Date:   Sun, 7 Feb 2021 17:36:12 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0-Qk1WAUaCWeX8Zypphpadan3YAOES9t7LFYBOJkXKog@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/2021 01.22, Arnd Bergmann wrote:
> * In the fiq handler code, check if normal interrupts were enabled
>    when the fiq hit. Normally they are enabled, so just proceed to
>    handle the timer and ipi directly
> 
> * if irq was disabled, defer the handling by doing a self-ipi
>    through the aic's ipi method, and handle it from there
>    when dealing with the next interrupt once interrupts get
>    enabled.
> 
> This would be similar to the soft-disable feature on powerpc, which
> never actually turns off interrupts from regular kernel code but
> just checks a flag in local_irq_enable that gets set when a
> hardirq happened.

Case #2 seems messy. In AIC, we'd have to either:

* Disable FIQs, and hope that doesn't confuse any save/restore code 
going on, then set a flag and check it in *both* the IRQ and FIQ path 
since either might trigger depending on what happens next, or
* Mask the relevant timer, which we'd then need to make sure does not 
confuse the timer code (Unmask it again when we fire the interrupt? But 
what if the timer code intended to mask it in the interim?)

Neither sounds particularly clean to me... if we had FIQ status masking 
registers this would be more reasonable, but I'm not sure I'd want the 
AIC driver to mess with neither DAIF nor the timer registers. It's bad 
enough that it has to read the latter already (and I hope I can find a 
better way of doing that...).

Plus I don't know if the vector entry code and other scaffolding between 
the vector and the AIC driver would be happy with, effectively, 
recursive interrupts. This could work with a carefully controlled path 
to make sure it doesn't break things, but I'm not so sure about the 
current "just point FIQ and IRQ to the same place" approach here.

-- 
Hector Martin "marcan" (marcan@marcan.st)
Public Key: https://mrcn.st/pub
