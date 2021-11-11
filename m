Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B30E44D1E9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 07:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbhKKGX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 01:23:59 -0500
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:35377 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229674AbhKKGXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 01:23:55 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 903E032019DA;
        Thu, 11 Nov 2021 01:21:06 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 11 Nov 2021 01:21:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=Ird/Co
        1YqQUp1YcWv57cF2bwHWsDv4vjeqtH46VjxBA=; b=aTf8cBpLIhiRsDpBJOw0WA
        L2Z7SdELEychvFNEST6RsawydxZPgy7wzuplZFru5r33/TDRqHG4P6hcfg52jDPM
        usjsnTaWWBg3Hbd1CLHrZOBgQejJ9OwpNaimnqp7tCA3lpD27VkJ9pK9xTc73VKr
        HqS2UuyT8WHxVdEamonl4PwOkhfIo2vo77fh02+gpmp4RDZ8xnLu1LeByoRXxVPm
        qYZgOh8QX5KM0KI9vuLhnfo+7vieEQKZ9VB3A0xlr/sRsroM+B9F2PX16qoeW0rV
        py8VRMT4aMiUqDjcW79/4k2eRdGRfJ8Hw9TmbDZ8rfE4oyFdIsw2HNN/zcT5MYlQ
        ==
X-ME-Sender: <xms:UbaMYYpcrIQdIJs0kfjYUe3lYS5kD2JqtgXrJ4A1-tnPViDwe_W9jg>
    <xme:UbaMYep-tZu90bQ_sDrgy40z3bjyhEkkZlWvAJfvVYIM3HLeqISjxdfoW6Ljp9NiY
    dTcWKVbFI89TJGMap4>
X-ME-Received: <xmr:UbaMYdOdZT_KP9ihbgTRhNacNQAWYHqXBgHcZX1tSUYszXKqf31IdXe_WEC0CQhk7NNOPiaZ6FuF2yPVzRV-ChUR1O_HtFS3k88>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrvddtgdeklecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvufgjkfhfgggtsehttdertddttddvnecuhfhrohhmpefhihhnnhcuvfhh
    rghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrghtth
    gvrhhnpeevudfhheduhfdugeduuddvgefhveeigefhteeguddvkeehgfejjeehhfetvdek
    ieenucffohhmrghinhepshgrmhhmhidrnhgvthenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehfthhhrghinheslhhinhhugidqmheikehkrdho
    rhhg
X-ME-Proxy: <xmx:UbaMYf4wdweHaNPBKs7GZmjcC4m7aQoX9wWT6ICRQHu8vlelONvfGg>
    <xmx:UbaMYX7UL-6CMrEQ50llEEgZXYtRjOFgCzlsQ-bUmPZgj675PoyDBA>
    <xmx:UbaMYfhJVQwNA-CxdWw_tU9jokMnDIKWVewRotoUn8QsU868K3z2pg>
    <xmx:UraMYZn2by6BQUnTFyRMFsE42UyL_1hDGFm21AVnpHJIthYsNleplg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Nov 2021 01:21:02 -0500 (EST)
Date:   Thu, 11 Nov 2021 17:20:56 +1100 (AEDT)
From:   Finn Thain <fthain@linux-m68k.org>
To:     Randy Dunlap <rdunlap@infradead.org>
cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Mike Rapoport <rppt@kernel.org>, Sam Creasey <sammy@sammy.net>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] m68k: Enable memtest kernel parameter
In-Reply-To: <725c0578-d816-f0c9-175a-7400c4a01887@infradead.org>
Message-ID: <fc341bdf-a145-3a6b-5325-eb8dce2f1cf4@linux-m68k.org>
References: <a57524fe38123ea17a6741cdc282f6c84c30a009.1636593047.git.fthain@linux-m68k.org> <725c0578-d816-f0c9-175a-7400c4a01887@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Nov 2021, Randy Dunlap wrote:

> On 11/10/21 5:10 PM, Finn Thain wrote:
> > Enable the memtest feature and rearrange some code to prevent it from
> > clobbering the initrd.
> > 
> > The CONFIG_BLK_DEV_INITRD symbol was conditional on !defined(CONFIG_SUN3).
> > For simplicity, remove that test on the basis that m68k_ramdisk.size == 0
> > on Sun 3.
> > 
> > The SLIME source code athttp://sammy.net/  shows that no BI_RAMDISK entry
> > is ever passed to the kernel due to #ifdef 0 around the relevant code.
> > 
> > Cc: Mike Rapoport<rppt@kernel.org>
> > Cc: Sam Creasey<sammy@sammy.net>
> > Signed-off-by: Finn Thain<fthain@linux-m68k.org>
> > ---
> > Are there any other Linux bootloaders on Sun 3?
> > ---
> >   arch/m68k/Kconfig           |  1 +
> >   arch/m68k/kernel/setup_mm.c | 15 ++++++---------
> >   arch/m68k/mm/motorola.c     |  2 ++
> >   3 files changed, 9 insertions(+), 9 deletions(-)
> 
> Hi Finn,
> 
> Please also update Documentation/admin-guide/kernel-parameters.txt:
> 
> 	memtest=	[KNL,X86,ARM,PPC,RISCV] Enable memtest
> 
> to include "M68K".
> 
> thanks.
> 

Will do.

Thanks for your review.
