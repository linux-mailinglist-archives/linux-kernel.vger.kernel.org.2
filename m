Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38CE5313D95
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 19:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235706AbhBHScy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 13:32:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234129AbhBHQPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 11:15:18 -0500
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C82C061788;
        Mon,  8 Feb 2021 08:14:37 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id C510B4207F;
        Mon,  8 Feb 2021 16:14:32 +0000 (UTC)
Subject: Re: [PATCH 05/18] tty: serial: samsung_tty: add support for Apple
 UARTs
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        Arnd Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Olof Johansson <olof@lixom.net>
References: <20210204203951.52105-1-marcan@marcan.st>
 <20210204203951.52105-6-marcan@marcan.st> <87lfc1l4lo.wl-maz@kernel.org>
 <e842f37d-d788-2d34-05e4-86ef94aed8f5@marcan.st>
 <e2bd8f99-58db-4cae-30b3-6fa608bc76dd@marcan.st>
 <20210208093625.trpm3tte2gw24w4l@kozik-lap>
From:   Hector Martin <marcan@marcan.st>
Message-ID: <9d395524-7aa9-0c6f-33a8-0cd47f0a7633@marcan.st>
Date:   Tue, 9 Feb 2021 01:14:30 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210208093625.trpm3tte2gw24w4l@kozik-lap>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/02/2021 18.36, Krzysztof Kozlowski wrote:
> Please use the scripts/get_maintainers.pl to get the list of people to
> Cc. The script would point necessary folks.

I thought I'd try Thomas first since he introduced the IRQF_SHARED 
specifically, but I should've gone straight to maintainers (I did use 
get_maintainers.pl to find you).

> A different issue is that all your emails from this thread were marked
> by Google as spam.  I don't see any particular warning signs in the
> header so it looks more of content-based match for spam.

That's weird. Maybe it's because my server doesn't do DKIM yet, and they 
went through a mailing list? It's probably time to set that up...

>>> Either way, certainly not for Apple SoCs; I'll get rid of IRQF_SHARED
>>> for v2.
> 
> Please send a v2 after fixing issues pointed out by kbuild.

Will do, already have those fixed in my WIP tree.

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
