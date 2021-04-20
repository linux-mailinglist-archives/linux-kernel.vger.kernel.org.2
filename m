Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19E9F36510F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 05:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbhDTDnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 23:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbhDTDnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 23:43:16 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D4DC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 20:42:45 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4FPTz61kNBz9vDk;
        Tue, 20 Apr 2021 13:42:41 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1618890162;
        bh=dO9ijqum0XbZRHvNMx1Ir45bBqpQfOH8pKy6EjA/0Vs=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=nsmhuMsiUqufy7si0DK/4vPCU6jhDeb6cGiOyWiVvVAkLHt4vBDYqBNB/YUMgQmXO
         3I4f+otHvFsdbT6rPWkTL+kVrKSQJu/tNs6dHhWuqIC0J36JHnEqXvrJJaUYdAH4ul
         5S11zyrfEKQiBJdNDhZiZ9uTTEaprloZmp7SCTFCY21k7THgZtXBk8qS8JHyZ4DgBn
         Sx1VbBms6uZP6qr4RmBSNnYNhAlSRVNPCdGTjv/Bg34oW9d38ttl8QBpoi2n3Edvaj
         Ws33JiRGUp6LeaG3yFJExbV7HOuREF7awx+mVrRodNEU+o3YhwQxJBD+H+/WPyDgNp
         SA1qIDbreGfwA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Tyrel Datwyler <tyreld@linux.ibm.com>
Cc:     benh@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/pseries: Add shutdown() to vio_driver and vio_bus
In-Reply-To: <59bd8028-cb1a-fdf6-74ce-68e868e4f486@linux.ibm.com>
References: <20210402001325.939668-1-tyreld@linux.ibm.com>
 <f326def4-0db0-f924-1700-dd7be3154153@linux.ibm.com>
 <87im4ldrft.fsf@mpe.ellerman.id.au>
 <59bd8028-cb1a-fdf6-74ce-68e868e4f486@linux.ibm.com>
Date:   Tue, 20 Apr 2021 13:42:37 +1000
Message-ID: <87mtttd3ki.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tyrel Datwyler <tyreld@linux.ibm.com> writes:
> On 4/17/21 5:30 AM, Michael Ellerman wrote:
>> Tyrel Datwyler <tyreld@linux.ibm.com> writes:
>>> On 4/1/21 5:13 PM, Tyrel Datwyler wrote:
>>>> Currently, neither the vio_bus or vio_driver structures provide support
>>>> for a shutdown() routine.
>>>>
>>>> Add support for shutdown() by allowing drivers to provide a
>>>> implementation via function pointer in their vio_driver struct and
>>>> provide a proper implementation in the driver template for the vio_bus
>>>> that calls a vio drivers shutdown() if defined.
>>>>
>>>> In the case that no shutdown() is defined by a vio driver and a kexec is
>>>> in progress we implement a big hammer that calls remove() to ensure no
>>>> further DMA for the devices is possible.
>>>>
>>>> Signed-off-by: Tyrel Datwyler <tyreld@linux.ibm.com>
>>>> ---
>>>
>>> Ping... any comments, problems with this approach?
>> 
>> The kexec part seems like a bit of a hack.
>> 
>> It also doesn't help for kdump, when none of the shutdown code is run.
>
> If I understand correctly for kdump we have a reserved memory space where the
> kdump kernel is loaded, but for kexec the memory region isn't reserved ahead of
> time meaning we can try and load the kernel over potential memory used for DMA
> by the current kernel.

That's correct.

>> How many drivers do we have? Can we just implement a proper shutdown for
>> them?
>
> Well that is the end goal. I just don't currently have the bandwidth to do each
> driver myself with a proper shutdown sequence, and thought this was a launching
> off point to at least introduce the shutdown callback to the VIO bus.

Fair enough.

> Off the top of my head we have 3 storage drivers, 2 network drivers, vtpm, vmc,
> pseries_rng, nx, nx842, hvcs, hvc_vio.
>
> I can drop the kexec_in_progress hammer and just have each driver call remove()
> themselves in their shutdown function. Leave it to each maintainer to decide if
> remove() is enough or if there is a more lightweight quiesce sequence they
> choose to implement.

That's OK, you've convinced me. I'll take it as-is.

Eventually it would be good for drivers to implement shutdown in the
optimal way for their device, but that can be done incrementally.

cheers
