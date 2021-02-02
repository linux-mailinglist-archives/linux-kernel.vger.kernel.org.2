Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C41B730C4A3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 16:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235899AbhBBP6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 10:58:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:49034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235889AbhBBPzY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 10:55:24 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CA59C64E9C;
        Tue,  2 Feb 2021 15:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612281282;
        bh=InUcpyv9LzxfCng6N9RmMwMFNFkinqM1iArVPnn5MFI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pzo6vtcGFu0iTLJhtnw/GC9gfLhd/iSrx0pnWN5zZWqTqeROcs72U6JXyDF0CRuJT
         dVadJGDie8yR32MPoayZRRM3e/YWZCXyaGBqwbWWahx+tHm3smadSR5UFIkvXdsoRF
         gI4v4q8XPWRwuLDTq4oU40m6jusVHiAtg/gLRAC8K7Qcoh9utVCrvIw8LYHAzdKt75
         bAp/d3EEqKyoYZ2sjQk5c2aJdz0/h6VPuAcfVNSinMbpYMavzJVvPbWkO9TWvbXHP0
         p45iL79adOQ7viO3pQFRX5r3ECiIDS8L0SBgiXDMThzZGF7hK4TsVRwETqkx8ErqXq
         DNu4GLhEbTmCg==
Received: by mail-oi1-f180.google.com with SMTP id w124so23218603oia.6;
        Tue, 02 Feb 2021 07:54:42 -0800 (PST)
X-Gm-Message-State: AOAM532eP+b7OOw5iPbTpcQJbT0HYn7uPQg1voiUc6NRO5iUK1GmPs1k
        yMLCEX+y9KErBg7UVDi4XJUfVvRW7KXc9n5UmYo=
X-Google-Smtp-Source: ABdhPJwS3LkYij3FBY6AdP3IZVmOxavIQah+JyozDz34zcdjBEuLK7+tqgdUE55rvCDzAXiCPw3xmD7gmdArNWBoeH8=
X-Received: by 2002:aca:e103:: with SMTP id y3mr3095862oig.11.1612281282086;
 Tue, 02 Feb 2021 07:54:42 -0800 (PST)
MIME-Version: 1.0
References: <20210202071648.1776-1-thunder.leizhen@huawei.com>
 <20210202071648.1776-5-thunder.leizhen@huawei.com> <CAK8P3a1HuXx7qpOPAdcGadtWCkNOp75bgO8cLSpXnobULHU6ZQ@mail.gmail.com>
 <99b8672c-467c-9698-40e7-aed7dc5d2ee2@huawei.com>
In-Reply-To: <99b8672c-467c-9698-40e7-aed7dc5d2ee2@huawei.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 2 Feb 2021 16:54:25 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1NoKbRxU8xg4OT-N+hn-0MrSsxno5vH-8RGj7r9a1PJA@mail.gmail.com>
Message-ID: <CAK8P3a1NoKbRxU8xg4OT-N+hn-0MrSsxno5vH-8RGj7r9a1PJA@mail.gmail.com>
Subject: Re: [PATCH v7 4/4] ARM: Add support for Hisilicon Kunpeng L3 cache controller
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     Russell King <rmk+kernel@arm.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 2, 2021 at 1:18 PM Leizhen (ThunderTown)
<thunder.leizhen@huawei.com> wrote:
> On 2021/2/2 16:44, Arnd Bergmann wrote:
> >
> > To have a more useful performance number, try mentioning the
> > most performance sensitive non-coherent DMA master on one
> > of the chips that has this cache controller, and a high-level
> > performance number such as "1.2% more network packets per
> > second" if that is something you can measure easily.
>
> It's not easy. My board only have debugging NIC, only the downstream
> products have high-speed service NIC. Software needs to be packaged
> layer by layer.
>
> >
> > Of course, if all high-speed DMA masters on this chip are
> > cache coherent, there is no need for performance numbers, just
> > mention that we don't care about speed in that case.
>
> It's not cache coherent, otherwise, the L3 cache does not need to be
> operated.

Ok, I see. In this case, just explain that the high-speed NIC is not
cache-coherent, so this is expected to make a difference, even if you
can't quantify it exactly.

       Arnd
