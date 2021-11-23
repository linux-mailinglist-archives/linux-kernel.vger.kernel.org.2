Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF1245A5F3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 15:41:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237532AbhKWOo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 09:44:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234213AbhKWOo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 09:44:28 -0500
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3399C061574;
        Tue, 23 Nov 2021 06:41:19 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 23F32419B4;
        Tue, 23 Nov 2021 14:41:15 +0000 (UTC)
Subject: Re: [PATCH v3 3/4] arm64: dts: apple: t8103: Add i2c nodes
From:   Hector Martin <marcan@marcan.st>
To:     Janne Grunau <j@jannau.net>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211122225807.8105-1-j@jannau.net>
 <20211122225807.8105-4-j@jannau.net>
 <5f16c962-72a1-21ec-9651-744053f74365@marcan.st>
Message-ID: <d48d2e85-42f1-570a-bd8f-e3834147c8b8@marcan.st>
Date:   Tue, 23 Nov 2021 23:41:12 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <5f16c962-72a1-21ec-9651-744053f74365@marcan.st>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/11/2021 14.41, Hector Martin wrote:
> On 23/11/2021 07.58, Janne Grunau wrote:
>> Apple M1 has at least 5 i2c controllers. i2c0, i2c1 and i2c3 are used
>> on all M1 Mac devices. The 2020 Mac Mini uses i2c2 and the 13-inch
>> MacBook Pro uses i2c2 and i2c4.
> 
> On further testing: i2c3 is not used on the 1GbE variant of j274. iBoot
> actually kills the node entirely. The interesting thing is it doesn't
> work; it times out probe transactions. I suspect iBoot does not enable
> its clock or something like that.
> 
> I'll poke around this on IRC, but a priori we probably need m1n1 code to
> kill this node when the ADT doesn't have it. Maybe I should generalize
> the dwc3 killing code...

Did that as of m1n1 be7ff3a, so we're good now :)

For those following along in the list: the reason why i2c3 was getting 
stuck is because it seems the unused bus is weakly pulled low on these 
machines, which jams it. Setting the GPIO pull mode to pull-up makes it 
work as an empty bus, but let's just not instantiate at all in this 
case. m1n1 now checks the Apple DT and sets any FDT i2c devices that are 
not present in it to disabled.

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
