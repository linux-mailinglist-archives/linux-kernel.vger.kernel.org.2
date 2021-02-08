Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 864673143AE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 00:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbhBHXYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 18:24:46 -0500
Received: from marcansoft.com ([212.63.210.85]:45304 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230071AbhBHXYf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 18:24:35 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 66B1B4207F;
        Mon,  8 Feb 2021 23:23:50 +0000 (UTC)
Subject: Re: [PATCH 05/18] tty: serial: samsung_tty: add support for Apple
 UARTs
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <maz@kernel.org>, robh+dt@kernel.org,
        Arnd Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Olof Johansson <olof@lixom.net>
References: <20210204203951.52105-1-marcan@marcan.st>
 <20210204203951.52105-6-marcan@marcan.st>
 <20210208105451.yumjjunjeyrglfnw@kozik-lap>
 <11d36c47-45c6-03ee-2d08-6692b5d0e241@marcan.st>
 <20210208183721.4gc7vyfgtpk7nch3@kozik-lap>
From:   Hector Martin <marcan@marcan.st>
Message-ID: <d9ab5faa-5c04-00a2-a560-ff01f14afcc6@marcan.st>
Date:   Tue, 9 Feb 2021 08:23:48 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210208183721.4gc7vyfgtpk7nch3@kozik-lap>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/02/2021 03.37, Krzysztof Kozlowski wrote:
> Looking at Greg's comment, we can get rid of the PORT_ stuff entirely.
> First of all, PORT_S3C2410 == PORT_S3C2412, so this define is not
> accurate.
> 
> This leaves us with three types (s3c2400, s3c2440, s3c6410 and Apple).
> The s3c2440 could be removed with adding a new "ucon_mask" field to
> s3c24xx_serial_drv_data.
> 
> This would end with s3c24xx, s3c6410 and Apple - quite nice choice.

Works for me :)

> You're right. This one would have to be improved before your change.
> Instead of replacing specific op calls in startup, I think it's better
> to have entirely separate ops instance for each variant:
> 
> static const struct uart_ops s3c24xx_serial_ops;
> static const struct uart_ops s3c64xx_serial_ops;
> static const struct uart_ops s5l_serial_ops;
> 
> This allows to add a "const", since uart_port takes such const pointer.
> 
> Still during s3c24xx_serial_probe() correct ops would have to be
> assigned, but at least all ops are easily visible.

Roger, will do this for v2.

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
