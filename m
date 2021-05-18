Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1A83882B6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 00:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242589AbhERW2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 18:28:16 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61547 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232020AbhERW2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 18:28:15 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4E889C94B9;
        Tue, 18 May 2021 18:26:56 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
        :to:cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=uyX7ogXS6ttXtxFCbmbVJP7Uy1ThRGIHklbWlj
        5/1VM=; b=SBb6K/wMjBJmXenq7GziC3+EM1gJaPRLnIzjFL0SSUqdeFGYWAWEsk
        z5Ngawvv2Mrfvwsisgkw3fk5nD0Fi4nughxecFDIEniVhqMKLI3ibuaOhljzhqiL
        X5hAV/UUOR3XV7j/mb9zkODMBiJv5Pm1jjIIoI71N1YGkNIL9oNmg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 44F70C94B8;
        Tue, 18 May 2021 18:26:56 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=uyX7ogXS6ttXtxFCbmbVJP7Uy1ThRGIHklbWlj5/1VM=; b=Kvi1UQ8jAmauFX24SwSRCxgrbHf6aHWfv34aYkbuN1wT/6gUjqZUeUxsqqSXETW4XwN7gCPjkUn1MJ2YqlOJKkDDRfqi/eqO4rlfY8CTza9Bsk/xvnm1l77h5dkuwpz4en9er302gBJZg2cLKrYoraznZ4C2tN+ALRtoxZnYHzw=
Received: from yoda.home (unknown [96.21.170.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BD810C94B7;
        Tue, 18 May 2021 18:26:55 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id C6DEE2DA0092;
        Tue, 18 May 2021 18:26:54 -0400 (EDT)
Date:   Tue, 18 May 2021 18:26:54 -0400 (EDT)
From:   Nicolas Pitre <nico@fluxnic.net>
To:     Linus Walleij <linus.walleij@linaro.org>
cc:     "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Yanfei Xu <yanfei.xu@windriver.com>,
        Mike Rapoport <rppt@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hailong liu <carver4lio@163.com>,
        Tian Tao <tiantao6@hisilicon.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] ARM: change vmalloc_min to vmalloc_start
In-Reply-To: <CACRpkdbZObW2SXdTUkPrsezjjVU19emts420EN-uhkHWb+4vrA@mail.gmail.com>
Message-ID: <sons6q6-2630-rr8s-18ns-221454n9472@syhkavp.arg>
References: <20210518120633.GW12395@shell.armlinux.org.uk> <E1liyda-0005B4-Kk@rmk-PC.armlinux.org.uk> <CACRpkdbZObW2SXdTUkPrsezjjVU19emts420EN-uhkHWb+4vrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: 270766AC-B828-11EB-80B9-D152C8D8090B-78420484!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 May 2021, Linus Walleij wrote:

> On Tue, May 18, 2021 at 2:15 PM Russell King (Oracle)
> <rmk+kernel@armlinux.org.uk> wrote:
> 
> > Change the current vmalloc_min, which is supposed to be the lowest
> > address of vmalloc space including the VMALLOC_OFFSET, to vmalloc_start
> > which does not include VMALLOC_OFFSET.
> >
> > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> > +static unsigned long __initdata vmalloc_start = VMALLOC_END - (240 << 20);
> 
> When I first read this it took me some time to figure out what was
> going on here, so if you have time, please fold in a comment
> with some explanation of that (240 << 20) thing, in some blog
> post I described it as "an interesting way to write 0x0f000000"
> but I suppose commit 0536bdf33faf chose this way for a
> specific reason? (Paging Nico if he can explain it.)

That's an alternative (and deprecated) way to write MB(240).


Nicolas
