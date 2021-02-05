Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF963105AC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 08:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbhBEHOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 02:14:20 -0500
Received: from marcansoft.com ([212.63.210.85]:59618 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231364AbhBEHMo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 02:12:44 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 857B5423AD;
        Fri,  5 Feb 2021 07:11:55 +0000 (UTC)
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     SoC Team <soc@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Ard Biesheuvel <ardb@kernel.org>
References: <20210204203951.52105-1-marcan@marcan.st>
 <20210204203951.52105-19-marcan@marcan.st>
 <CAK8P3a3v6emxavbyjFhY+WdvH1t4EPMZSjEsSx0M+cRqjRCO1g@mail.gmail.com>
 <de236d0c-579d-c0d9-8d60-77f30889f50c@marcan.st>
 <CAK8P3a2DawQA-PD5aqbkVPB7UxuohN0oe9mJPe8488pUryotJQ@mail.gmail.com>
From:   Hector Martin 'marcan' <marcan@marcan.st>
Subject: Re: [PATCH 18/18] arm64: apple: Add initial Mac Mini 2020 (M1)
 devicetree
Message-ID: <3f2001f0-4a90-645e-d016-03907228dc7a@marcan.st>
Date:   Fri, 5 Feb 2021 16:11:53 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2DawQA-PD5aqbkVPB7UxuohN0oe9mJPe8488pUryotJQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/02/2021 08.08, Arnd Bergmann wrote:
> On Thu, Feb 4, 2021 at 10:44 PM Hector Martin 'marcan' <marcan@marcan.st> wrote:
>> On 05/02/2021 06.29, Arnd Bergmann wrote:
>>> On Thu, Feb 4, 2021 at 9:39 PM Hector Martin <marcan@marcan.st> wrote:
>>>
>>> We tend to split the dts file into one file per SoC and one for the
>>> specific board. I guess in this case the split can be slightly different,
>>> but it does feel better to be prepared for sharing a lot of the contents
>>> between the different products.
>>>
>>> In most cases, you'd want the 'aliases' and 'chosen' nodes to be
>>> in the board specific file.
>>
>> I thought about that, but wasn't sure if splitting it up at this early
>> stage made much sense since I'm not sure what the split should be, given
>> all supported hardware is the same for all 3 released devices.
>>
>> I'm happy to throw the aliases/chosen nodes into board specific files if
>> you think that's a good starting point. Perhaps /memory too? Those
>> properties are filled in/patched by the bootloader anyway...
> 
> Yes, I think that would help make it more consistent with other
> platforms even if we don't care too much here.

Ack, I'll split it up for v2.

> We don't really have overlays in the kernel sources (yet), though it
> is something that keeps coming up. For the moment, I'd just
> assume you can have one .dts file for each thing you want to
> support and keep the shared bits in .dtsi files.

No problem. We'll experiment with overlays in m1n1 and see how that goes.

One thing I wanted to ask: is there some kind of "experimental" policy 
for DT bindings? At early platform bring-up stages it seems like it 
could be valuable to allow for breaking DT changes while we flesh out 
the details (this is especially true of a reverse engineered platform 
like this, where we don't have knowledge of all the hardware details a 
priori). The dozen or so users we might have at this stage obviously 
won't complain too much :)

-- 
Hector Martin "marcan" (marcan@marcan.st)
Public Key: https://mrcn.st/pub
