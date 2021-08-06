Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEA323E269C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 10:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243996AbhHFI74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 04:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243725AbhHFI7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 04:59:51 -0400
X-Greylist: delayed 408 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 06 Aug 2021 01:59:36 PDT
Received: from server.lespinasse.org (server.lespinasse.org [IPv6:2001:470:82ab::100:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30783C061798;
        Fri,  6 Aug 2021 01:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-27-ed;
 t=1628239965; h=date : from : to : cc : subject : message-id :
 references : mime-version : content-type : in-reply-to : from;
 bh=UbkOx+RiPeviUAZM//LdNu+blKLz8d3daJ2nJJ8f2Gk=;
 b=ujcPzzSi0eQs+tOluBwExEx4xapFiawvdWeMEKOK9l2O9i7jFH50EpYIQGSWE61KkGIyp
 kRpt1vRDkHF2gYxDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-27-rsa; t=1628239965; h=date :
 from : to : cc : subject : message-id : references : mime-version :
 content-type : in-reply-to : from;
 bh=UbkOx+RiPeviUAZM//LdNu+blKLz8d3daJ2nJJ8f2Gk=;
 b=BiuXknetVFYI6eAD7P9nL2jo5IDPBBGeYkX5mBps6FHhSMhvIKBSez5uEljvljOieduGD
 XGllINGgOUbqi5JHE3XIBJh08h5L4znHaYfPMs+BXZ34bZX+pJaRx9TH8Qw+ctkWUU8HYb1
 I7PRCSnvBlK0TFkHUGdeiifpATKJBLIpthdDVDOe84EMwI2OZeompICcX//lC0u0ss2Only
 4RX1aDK275Kev2pLE1eSIF8jzVGDHOK+xERuNWS1vJDyrfVXLpiN7m/u21cigPXwz1fWmpI
 92HteC63+hJQsn7V7KVaPTGYyRiVnukzZLr+p6O+SEi3XJ1IF3fu61oEUDmQ==
Received: by server.lespinasse.org (Postfix, from userid 1000)
        id A1946160937; Fri,  6 Aug 2021 01:52:45 -0700 (PDT)
Date:   Fri, 6 Aug 2021 01:52:45 -0700
From:   Michel Lespinasse <michel@lespinasse.org>
To:     Mete Polat <metepolat2000@gmail.com>
Cc:     Davidlohr Bueso <dbueso@suse.de>, Arnd Bergmann <arnd@arndb.de>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Michel Lespinasse <michel@lespinasse.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jesper Nilsson <jesper@jni.nu>,
        David Woodhouse <dwmw2@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] rbtree: remove unneeded explicit alignment in struct
 rb_node
Message-ID: <20210806085245.GB14650@lespinasse.org>
References: <20210805133213.700-1-lukas.bulwahn@gmail.com>
 <CAK8P3a3aNuxaEtAiewd+Wjc8hKtca0NrcV2kykkNC-qKT_HhzQ@mail.gmail.com>
 <50ad4c8b848bd371b4b42959167ef03d@suse.de>
 <YQwd2puXiSiUWEE1@precision>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQwd2puXiSiUWEE1@precision>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05, 2021 at 07:20:26PM +0200, Mete Polat wrote:
> On Thu, Aug 05, 2021 at 08:02:28AM -0700, Davidlohr Bueso wrote:
> > On 2021-08-05 07:02, Arnd Bergmann wrote:
> > > The revert would appear to change the alignment to 16 bits instead
> > > of 32 bits on m68k as well (not 8 bits as on cris), but I don't know if
> > > that
> > > can cause problems there.
> > 
> > Yeah I tried this a while back and it broke m68k, so it was a no go:
> > 
> > https://lore.kernel.org/lkml/CAMuHMdXeZvJ0X6Ah2CpLRoQJm+YhxAWBt-rUpxoyfOLTcHp+0g@mail.gmail.com/
> 
> The problem is that the field '__rb_parent_color' in struct rb_node is
> storing the color AND the pointer to the parent node at the same time.
> The color is stored in the least significant bit which is fine when
> rb_node is at least 16-bit aligned. I guess, it does not work on m68k
> because the makro
> 
> #define __rb_parent(pc)    ((struct rb_node *)(pc & ~3))
> 
> used to retrieve the parent pointer zeros the first two bits, not only
> the first one.
> 
> Maybe the effiency to store this one color bit in another field was
> required in the early days but I think moving the color to a seperate
> field is really the better way to go. It also makes reasoning about the
> algorithm easier.
> 
> I will create a patch.

I think moving the color to a separate word would be costly, both in space
(growing the struct rb_node) and in time. Feel free to try it, but I would
expect the rbtree performance tests to regress significantly.

__rb_parent() could probably be modified - it only needs to mask one bit,
I'm not sure why it masks two.

As to what would happen on 68k... hard to say, but I expect it should
be fine (if the compiler cared for the structs to be aligned, it
should do it on its own). Still, not sure how to test that either.

-- 
Michel "walken" Lespinasse
