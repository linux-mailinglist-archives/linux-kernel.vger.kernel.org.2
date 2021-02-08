Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F727313D71
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 19:27:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233498AbhBHS1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 13:27:13 -0500
Received: from marcansoft.com ([212.63.210.85]:38724 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234141AbhBHPv7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 10:51:59 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id DE5D94207F;
        Mon,  8 Feb 2021 15:51:11 +0000 (UTC)
Subject: Re: [PATCH 08/18] arm64: cpufeature: Add a feature for FIQ support
To:     Marc Zyngier <maz@kernel.org>
Cc:     soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        robh+dt@kernel.org, Arnd Bergmann <arnd@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Olof Johansson <olof@lixom.net>
References: <20210204203951.52105-1-marcan@marcan.st>
 <20210204203951.52105-9-marcan@marcan.st> <87im75l2lp.wl-maz@kernel.org>
 <d110504f-2461-8b41-72cc-72681d775a97@marcan.st>
 <87czxalrwc.wl-maz@kernel.org>
From:   Hector Martin <marcan@marcan.st>
Message-ID: <271fc761-d782-31b8-d97b-907041f15289@marcan.st>
Date:   Tue, 9 Feb 2021 00:51:09 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <87czxalrwc.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/02/2021 20.29, Marc Zyngier wrote:
> I'm not sure we want to trust the FW on that particular front (no
> offence intended...;-).

Hey, I don't even *use* the timers IRQs; if they are unmasked it's 
iBoot's fault! :-)

> That is my current take on this patch. Nothing in the arm64 kernel
> expects a FIQ today, so *when* a FIQ fires is pretty much irrelevant,
> as long as we handle it properly (panic). Keeping the two bits in sync
> is trivial, and shouldn't carry material overhead.

Sounds good then, and again that simplifies a ton of stuff. Will go for 
that in v2.

> Aside from the lack of programmable priority, the lack of convenient
> masking for per-CPU interrupts is a bit of an issue...

Yeah... we'll see how that goes.

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
