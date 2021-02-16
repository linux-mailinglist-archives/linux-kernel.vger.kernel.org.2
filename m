Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB0531CF34
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 18:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbhBPRkp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 16 Feb 2021 12:40:45 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:47134 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229628AbhBPRkd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 12:40:33 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4Dg7X256vfzB09ZP;
        Tue, 16 Feb 2021 18:39:46 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id obuZMT7z7GUL; Tue, 16 Feb 2021 18:39:46 +0100 (CET)
Received: from vm-hermes.si.c-s.fr (vm-hermes.si.c-s.fr [192.168.25.253])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4Dg7X24HVlzB09ZM;
        Tue, 16 Feb 2021 18:39:46 +0100 (CET)
Received: by vm-hermes.si.c-s.fr (Postfix, from userid 33)
        id 769CB1EC; Tue, 16 Feb 2021 18:42:47 +0100 (CET)
Received: from 37-171-22-224.coucou-networks.fr
 (37-171-22-224.coucou-networks.fr [37.171.22.224]) by messagerie.c-s.fr
 (Horde Framework) with HTTP; Tue, 16 Feb 2021 18:42:47 +0100
Date:   Tue, 16 Feb 2021 18:42:47 +0100
Message-ID: <20210216184247.Horde.If3nEUb5zLh4eU_4qXZCAw1@messagerie.c-s.fr>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>
Cc:     Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-kernel@vger.kernel.org,
        Maksym Kokhan <maksym.kokhan@globallogic.com>,
        Daniel Walker <dwalker@fifo99.com>,
        linuxppc-dev@lists.ozlabs.org, xe-linux-external@cisco.com,
        Rob Herring <robh+dt@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Daniel Walker <danielwa@cisco.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/4] add generic builtin command line
References: <20190319232448.45964-2-danielwa@cisco.com>
 <20190320155319.2cd3c0f73ef3cdefb65d5d1e@linux-foundation.org>
 <20190320232328.3bijcxek2yg43a25@zorba>
 <20190320201433.6c5c4782f4432d280c0e8361@linux-foundation.org>
 <20190321151308.yt6uc3mxgppm5zko@zorba>
 <20190321151519.1f4479d92228c8a8738e02cf@linux-foundation.org>
 <1613417521.3853.5.camel@chimera>
In-Reply-To: <1613417521.3853.5.camel@chimera>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.3)
Content-Type: text/plain; charset=UTF-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us> a écrit :

> On Thu, 2019-03-21 at 15:15 -0700, Andrew Morton wrote:
>> On Thu, 21 Mar 2019 08:13:08 -0700 Daniel Walker <danielwa@cisco.com> wrote:
>> > On Wed, Mar 20, 2019 at 08:14:33PM -0700, Andrew Morton wrote:
>> > > The patches (or some version of them) are already in linux-next,
>> > > which messes me up.  I'll disable them for now.
>> >
>> > Those are from my tree, but I remove them when you picked up the  
>> series. The
>> > next linux-next should not have them.
>>
>> Yup, thanks, all looks good now.
>
> This patchset is currently neither in mainline nor in -next. May I ask
> what happened to it? Thanks.

As far as I remember, there has been a lot of discussion around this series.

As of today, it doesn't apply cleanly anymore and would require rebasing.

I'd suggest also to find the good arguments to convince us that this  
series has a real added value, not just "cisco use it in its kernels  
so it is good".

I proposed an alternative at  
https://patchwork.ozlabs.org/project/linuxppc-dev/cover/cover.1554195798.git.christophe.leroy@c-s.fr/ but never got any feedback so I gave  
up.

If you submit a new series, don't forget to copy ppclinux-dev and  
linux-arch lists.

Christophe


