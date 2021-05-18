Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 617673882C3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 00:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352764AbhERWeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 18:34:12 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59974 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352762AbhERWeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 18:34:07 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 656E513CF92;
        Tue, 18 May 2021 18:32:48 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
        :to:cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=ABZIIlZFzwAkm+46bzuTdkc+sOxWGI8Mc6xsxa
        nGp5A=; b=VKC+dYHv/OkOeoBNyC++NlzH7AuKPxwn1idGF0nwFE+Re1+OtAal0E
        llQl7Oe7HzK8XH6EIgV7TaXY6ob9nPn4M3J0Ol9e6H4nu7NHZPDUOlQpYAhqmwgJ
        8Le61jqgKGWNFi76WDmQInJf6ujevsgixOG/N42PDwF5NCJvf4Cjg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5E0AD13CF8F;
        Tue, 18 May 2021 18:32:48 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=ABZIIlZFzwAkm+46bzuTdkc+sOxWGI8Mc6xsxanGp5A=; b=sVsAbU1r8NKbbuhqgnZnYev1I8QnW5Qp9c92qCGI7UxKKZ6LyScNH+PnjRzWwKw/tqVBESrbd9pe24/SMj7zoxfhqjbaMzK8KJSSclZi9fe0WdVKziMHHP0psmOJElolGCzBQMkkzQYRSMSNFhsUFQELXOdn80nr6IfwmZxePrQ=
Received: from yoda.home (unknown [96.21.170.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4962613CF8E;
        Tue, 18 May 2021 18:32:45 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id 208A32DA0092;
        Tue, 18 May 2021 18:32:43 -0400 (EDT)
Date:   Tue, 18 May 2021 18:32:43 -0400 (EDT)
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
In-Reply-To: <sons6q6-2630-rr8s-18ns-221454n9472@syhkavp.arg>
Message-ID: <8q526rs-853n-5q80-r9pn-87sso759r13@syhkavp.arg>
References: <20210518120633.GW12395@shell.armlinux.org.uk> <E1liyda-0005B4-Kk@rmk-PC.armlinux.org.uk> <CACRpkdbZObW2SXdTUkPrsezjjVU19emts420EN-uhkHWb+4vrA@mail.gmail.com> <sons6q6-2630-rr8s-18ns-221454n9472@syhkavp.arg>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: F75C615E-B828-11EB-A988-E43E2BB96649-78420484!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 May 2021, Nicolas Pitre wrote:

> On Wed, 19 May 2021, Linus Walleij wrote:
> 
> > On Tue, May 18, 2021 at 2:15 PM Russell King (Oracle)
> > <rmk+kernel@armlinux.org.uk> wrote:
> > 
> > > Change the current vmalloc_min, which is supposed to be the lowest
> > > address of vmalloc space including the VMALLOC_OFFSET, to vmalloc_start
> > > which does not include VMALLOC_OFFSET.
> > >
> > > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > 
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > 
> > > +static unsigned long __initdata vmalloc_start = VMALLOC_END - (240 << 20);
> > 
> > When I first read this it took me some time to figure out what was
> > going on here, so if you have time, please fold in a comment
> > with some explanation of that (240 << 20) thing, in some blog
> > post I described it as "an interesting way to write 0x0f000000"
> > but I suppose commit 0536bdf33faf chose this way for a
> > specific reason? (Paging Nico if he can explain it.)
> 
> That's an alternative (and deprecated) way to write MB(240).

And it seems that MB() isn't globally defined either. Oh well.


Nicolas
