Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF1C392499
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 03:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233114AbhE0BzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 21:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbhE0BzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 21:55:16 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3604EC061574;
        Wed, 26 May 2021 18:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=fh/yRMJ1F32aHQNiWA/z1UgKftrEngIdgah6/d6uuZE=; b=Ts7MJv1gUG11Oi6vk5N4467MwP
        P3yaf93tnzSWSpEXiGQZdR7+pyjsW3rcqufLqrbokUzyfu7BMHuIC1u09iQuYpky2lupZHsoCCLZd
        eEbTrLSmYg35IIJYbLtfd3Z3T0AU//6lwZ+ogEbw9CXotS6R8jeKuEqIYSUbaHQ+ndZWq28CVVA0J
        4FonenWk+YSqnrrApIKxw6OZDRV0Gs93tqzKmRP7LDEzwRzJV9njOoaSGK8q6RGvAoARy9CqoDKvb
        nvj7AHzokjsU+0G4DBWo8qIyef3PF9RUvPqZBhvflNts7mB5XOGk0Zq8ECervQ17k9Y5iIRILVHzb
        iavVe2TA==;
Received: from [2601:1c0:6280:3f0::ce7d]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lm5DR-001cfW-Qt; Thu, 27 May 2021 01:53:41 +0000
Subject: Re: [PATCH v2] OF: of_address: clean up OF stub & extern functions
To:     Rob Herring <robh+dt@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        kernel test robot <lkp@intel.com>
References: <20210524190919.2616-1-rdunlap@infradead.org>
 <CAL_JsqLCzFN81vbN=Y5hpvW_u=h9oWPSyK6zrO9kXr9pPArt1Q@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <9e6962f6-5d70-73a0-165b-5a4bfd594b39@infradead.org>
Date:   Wed, 26 May 2021 18:53:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqLCzFN81vbN=Y5hpvW_u=h9oWPSyK6zrO9kXr9pPArt1Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/26/21 12:06 PM, Rob Herring wrote:
> On Mon, May 24, 2021 at 2:09 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>> Adjust <linux/of_address.h> so that stubs are present when
>> CONFIG_OF is not set *or* OF is set but OF_ADDRESS is not set.
>>
>> This eliminates 2 build errors on arch/s390/ when HAS_IOMEM
>> is not set (so OF_ADDRESS is not set).
>> I.e., it provides a stub for of_iomap() when one was previously
>> not provided as well as removing some duplicate externs.
> 
> Personally, I think we should get rid of HAS_IOMEM or at least most of
> its usage in kconfig. It has little purpose beyond hiding drivers in
> kconfig and mainly for UML though I think UML no longer needs that
> IIRC. (I'm not wild about 'depends on OF' either).

There are only over 800 of the latter.

> 
>> s390-linux-ld: drivers/irqchip/irq-al-fic.o: in function `al_fic_init_dt':
>> irq-al-fic.c:(.init.text+0x7a): undefined reference to `of_iomap'
>> s390-linux-ld: drivers/clocksource/timer-of.o: in function `timer_of_init':
>> timer-of.c:(.init.text+0xa4): undefined reference to `of_iomap'
>>
>> Tested with many randconfig builds, but there could still be some
>> hidden problem here.
>>
>> Fixes: 4acf4b9cd453 ("of: move of_address_to_resource and of_iomap declarations from sparc")
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: Frank Rowand <frowand.list@gmail.com>
>> Cc: devicetree@vger.kernel.org
>> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>> Reported-by: kernel test robot <lkp@intel.com>
>> ---
>> v2: handle SPARC as a special case since it provides its own versions of
>>     of_address_to_resource() and of_iomap();
>>     fix build errors reported by lkp/ktr and address comments from Laurent;
>>     do more randconfig build testing;
>>
>>  include/linux/of_address.h |   11 +++++++----
>>  1 file changed, 7 insertions(+), 4 deletions(-)
>>
>> --- linux-next-20210524.orig/include/linux/of_address.h
>> +++ linux-next-20210524/include/linux/of_address.h
>> @@ -106,11 +106,12 @@ static inline bool of_dma_is_coherent(st
>>  }
>>  #endif /* CONFIG_OF_ADDRESS */
>>
>> -#ifdef CONFIG_OF
>> +#ifdef CONFIG_SPARC /* SPARC has its own versions of these */
> 
> The whole point of CONFIG_OF_ADDRESS is really just for SPARC. So I
> don't really like the mixture of the ifdefs here and in kconfig. It
> looks only more fragile.
> 
> Can we drop the HAS_IOMEM dependency from CONFIG_OF_ADDRESS and then
> fix the fallout from that? That would also remove all the other build
> time dependencies on HAS_IOMEM.

so change
config OF_ADDRESS
	def_bool y
	depends on !SPARC && (HAS_IOMEM || UML)

to
config OF_ADDRESS
	def_bool y
	depends on !SPARC


I'll run some builds and see what all breaks.

thanks.
-- 
~Randy

