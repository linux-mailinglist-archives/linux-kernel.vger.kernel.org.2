Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E407F31355E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 15:40:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbhBHOjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 09:39:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232111AbhBHONk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 09:13:40 -0500
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88FFC061788;
        Mon,  8 Feb 2021 06:12:59 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 45F7141F47;
        Mon,  8 Feb 2021 14:12:55 +0000 (UTC)
To:     Arnd Bergmann <arnd@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     SoC Team <soc@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Olof Johansson <olof@lixom.net>
References: <20210204203951.52105-1-marcan@marcan.st>
 <20210204203951.52105-19-marcan@marcan.st>
 <20210208110441.25qc6yken4effd6c@kozik-lap>
 <cd67b2ce-9676-31b4-85f7-de1ec9b2bf72@marcan.st>
 <20210208121325.owjjd7nfbdanszny@kozik-lap>
 <CAK8P3a0yBC3dui6vcz+NByWD-3LqRj-2MF89jpjb_k8r5xmNRA@mail.gmail.com>
From:   Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH 18/18] arm64: apple: Add initial Mac Mini 2020 (M1)
 devicetree
Message-ID: <f98dc238-6742-455e-3f76-e86ae4c0c838@marcan.st>
Date:   Mon, 8 Feb 2021 23:12:52 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0yBC3dui6vcz+NByWD-3LqRj-2MF89jpjb_k8r5xmNRA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/02/2021 21.40, Arnd Bergmann wrote:
> On Mon, Feb 8, 2021 at 1:13 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>
>> On Mon, Feb 08, 2021 at 08:56:53PM +0900, Hector Martin 'marcan' wrote:
>>> On 08/02/2021 20.04, Krzysztof Kozlowski wrote:
>>>> apple
>>>>
>>>> Don't make things different for this one platform (comparing to all
>>>> other platforms). Apple is not that special. :)
>>>
>>> AAPL is the old vendor prefix used in the PowerPC era. I'm happy to use
>>> `apple`, as long as we're OK with having two different prefixes for the same
>>> vendor, one for PPC and one for ARM64. I've seen opinions go both ways on
>>> this one :)
>>
>> Thanks for explanation. I propose to choose just "apple". Sticking to
>> old vendor name is not a requirement - we have few vendor prefixes which
>> were marked as deprecated because we switched to a better one.
> 
> We've gone back and forth on this a few times already. My current
> preference would also be to go with "apple", not because it's somehow
> nicer or clearer but because it avoids the namespace conflict with
> what the Apple firmware uses:

Ack, I'll use 'apple' for v2.

Amusingly, Apple actually use 'apple,firestorm' and 'apple,icestorm' for 
the CPUs in their devicetrees for these machines, so those will end up 
identical :) (they don't use apple-related prefixes for any other 
compatible strings at all, it's a mess). But we don't care about what 
their ADTs (Apple DTs) do in Linux anyway, the bootloader abstracts all 
that out and we'll be dealing with mantaining proper DTs ourselves.

>> Makes sense. In such case it's indeed your work. Since you introduce it,
>> the DTSes are usually licensed with (GPL-2.0+ OR MIT).
> 
> Indeed, we do want other OSs to use our dts files, so the general
> preference is to have a permissive license, unless you have a strong
> reason yourself to require GPL-only.

Thanks for pointing this out; this was actually unintentional. I based 
it off of an old dts I'd written ages ago and forgot to revisit the 
license. I even have it marked GPL-2.0+ in the copy in our bootloader 
repo, which is otherwise supposed to be MIT for original code...

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
