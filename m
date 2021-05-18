Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 676F23882CF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 00:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352792AbhERWjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 18:39:40 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60422 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbhERWji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 18:39:38 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2DB0313D005;
        Tue, 18 May 2021 18:38:20 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
        :to:cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=5j1QweKqXcL61vmqOwGvwHyyoRPXFIgZ5di/bk
        eivc4=; b=SFAUJ2ihK8uJBsyjRofcLHTo18jLrEK1y2qA59nzz7tAwyqCMcirdo
        FUZx2MCEr75sfqMZDm9gJzxgYvV8ISbQEpNej9hdF04XiMasZ5d8xGGZmSLdXAMf
        rix3QgJvw4ybNM5GEehqpEubdp9ytZW/mYhApJS0NqixuTE6OIVo8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 254DA13D004;
        Tue, 18 May 2021 18:38:20 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=5j1QweKqXcL61vmqOwGvwHyyoRPXFIgZ5di/bkeivc4=; b=uCpfa+7iuUeLrgS3q8J0Fh1pqM+Ll6JdYd0HHhkHSP25wqkU1B/SWCYPmMlHFhJERBczQt8PBqnxj7TEULMr02cw69D01hd5CVAAFxdHzhYCwYqThI3gaSSvmF4YkemenTIO/wgkY1ns+W4+oBZWRYXNBMizRg2gwheiprnfyhg=
Received: from yoda.home (unknown [96.21.170.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 217DF13D003;
        Tue, 18 May 2021 18:38:17 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id 639992DA0092;
        Tue, 18 May 2021 18:38:15 -0400 (EDT)
Date:   Tue, 18 May 2021 18:38:15 -0400 (EDT)
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
In-Reply-To: <CACRpkdYkzjAgRGosf5zx6MNzZ9QKa_nAN42iZT0jNPLwJE7Row@mail.gmail.com>
Message-ID: <ss631np-305p-o45-83n4-8noq1on6pp@syhkavp.arg>
References: <20210518120633.GW12395@shell.armlinux.org.uk> <E1liyda-0005B4-Kk@rmk-PC.armlinux.org.uk> <CACRpkdbZObW2SXdTUkPrsezjjVU19emts420EN-uhkHWb+4vrA@mail.gmail.com> <sons6q6-2630-rr8s-18ns-221454n9472@syhkavp.arg> <8q526rs-853n-5q80-r9pn-87sso759r13@syhkavp.arg>
 <CACRpkdYkzjAgRGosf5zx6MNzZ9QKa_nAN42iZT0jNPLwJE7Row@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: BD270060-B829-11EB-9684-E43E2BB96649-78420484!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 May 2021, Linus Walleij wrote:

> On Wed, May 19, 2021 at 12:32 AM Nicolas Pitre <nico@fluxnic.net> wrote:
> > On Tue, 18 May 2021, Nicolas Pitre wrote:
> > > On Wed, 19 May 2021, Linus Walleij wrote:
> > > > please fold in a comment
> > > > with some explanation of that (240 << 20) thing,
> > >
> > > That's an alternative (and deprecated) way to write MB(240).
> >
> > And it seems that MB() isn't globally defined either. Oh well.
> 
> I suppose a comment saying "set vmalloc to be 240 MB" is fair enough.

The comment was some 5 lines below (not ideal I know).


Nicolas
