Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 893BA3143A6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 00:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbhBHXXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 18:23:12 -0500
Received: from marcansoft.com ([212.63.210.85]:44918 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229554AbhBHXXI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 18:23:08 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 0E26B4207F;
        Mon,  8 Feb 2021 23:22:23 +0000 (UTC)
Subject: Re: [PATCH 05/18] tty: serial: samsung_tty: add support for Apple
 UARTs
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        Arnd Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Olof Johansson <olof@lixom.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20210204203951.52105-1-marcan@marcan.st>
 <20210204203951.52105-6-marcan@marcan.st> <87lfc1l4lo.wl-maz@kernel.org>
 <e842f37d-d788-2d34-05e4-86ef94aed8f5@marcan.st>
 <73116feaa00de9173d1f2c35ce16e08f@kernel.org>
 <7adf8ede-f7ff-7c62-d0fd-9ab4eaf25741@marcan.st> <YCFq3DqOzv4//6Vw@kroah.com>
From:   Hector Martin <marcan@marcan.st>
Message-ID: <88ed59d8-e18b-c04c-c164-6b15b7c3e390@marcan.st>
Date:   Tue, 9 Feb 2021 08:22:21 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YCFq3DqOzv4//6Vw@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/02/2021 01.46, Greg Kroah-Hartman wrote:
> I HATE adding new PORT_ types, as I am almost positive no one uses them,
> but as they are in the uapi files, we can't delete them.
> 
> So, just use an existing one, why do you want a new one?  If you don't
> have a userspace tool that requires it, don't bother.
> 
> Just use PORT_8250 and be done with it.  I should force all new drivers
> to use that as well :)

Krzysztof: given this, I think it would be fair to add an enum to the 
driver to keep track of the actual hardware type (grouped into probably 
just 3, S3C24XX, S3C6400, APPLE), get rid of any code in there that 
cares about the uapi-visible port type (other than setting it correctly 
for those that do exist, to maintain current behavior), and just make 
everything else use PORT_8250 for that?

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
