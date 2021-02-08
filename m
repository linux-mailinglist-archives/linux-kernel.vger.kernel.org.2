Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 357B7313D99
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 19:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235788AbhBHSdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 13:33:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232677AbhBHQTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 11:19:08 -0500
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E45C061786;
        Mon,  8 Feb 2021 08:18:27 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id B33B54207F;
        Mon,  8 Feb 2021 16:18:23 +0000 (UTC)
Subject: Re: [PATCH 05/18] tty: serial: samsung_tty: add support for Apple
 UARTs
To:     Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        robh+dt@kernel.org, Arnd Bergmann <arnd@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Olof Johansson <olof@lixom.net>,
        Krzysztof Kozlowski <krzk@kernel.org>
References: <20210204203951.52105-1-marcan@marcan.st>
 <20210204203951.52105-6-marcan@marcan.st> <87lfc1l4lo.wl-maz@kernel.org>
 <e842f37d-d788-2d34-05e4-86ef94aed8f5@marcan.st>
 <73116feaa00de9173d1f2c35ce16e08f@kernel.org>
From:   Hector Martin <marcan@marcan.st>
Message-ID: <7adf8ede-f7ff-7c62-d0fd-9ab4eaf25741@marcan.st>
Date:   Tue, 9 Feb 2021 01:18:21 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <73116feaa00de9173d1f2c35ce16e08f@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/02/2021 19.34, Marc Zyngier wrote:
> On 2021-02-07 09:12, Hector Martin 'marcan' wrote:
>> On 06/02/2021 22.15, Marc Zyngier wrote:
>>> Do you actually need a new port type here? Looking at the driver
>>> itself, it is mainly used to work out the IRQ model. Maybe introducing
>>> a new irq_type field in the port structure would be better than
>>> exposing this to userspace (which should see something that is exactly
>>> the same as a S3C UART).
>>
>> Well... every S3C variant already has its own port type here.
>>
>> #define PORT_S3C2410    55
>> #define PORT_S3C2440    61
>> #define PORT_S3C2400    67
>> #define PORT_S3C2412    73
>> #define PORT_S3C6400    84
>>
>> If we don't introduce a new one, which one should we pretend to be? :)
> 
> Pick one! :D

*queries /dev/urandom* :-)

>> I agree that it might make sense to merge all of these into one,
>> though; I don't know what the original reason for splitting them out
>> is. But now that they're part of the userspace API, this might not be
>> a good idea. Though, unsurprisingly, some googling suggests there are
>> zero users of these defines in userspace.
> 
> I don't think we can do that, but I don't think we should keep adding
> to this unless there is a very good reason. Greg would know, I expect.

Greg, what do you think? Add more PORT_ UART types for Samsung variants, 
or overload one of the existing ones and deal with it in the driver?

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
