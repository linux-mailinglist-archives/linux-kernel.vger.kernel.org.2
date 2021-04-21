Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D540E366F64
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 17:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244051AbhDUPrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 11:47:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:36344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240048AbhDUPrv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 11:47:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F30A261445;
        Wed, 21 Apr 2021 15:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619020037;
        bh=ADTV+2h6AZ8fKKS3l4lFTCAnpRDEK/9+OLIwZNY1akQ=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=Or58hK3bVfF84OafrCR9LKKSSklvRg0tJwSU2jAAiLddYluGkozt4YNXM5HfY9+/l
         IysiIshJHG650Sch09e0oUh1wOjFN0tDHPJUoY01qFmeETcDKuxi6A8xahnv4Dn9PO
         K4ledSjyCfIH+tFQmqyjxdtc9/H4xKKIgvvwnMU5TThSnVBQb9jsm3UoQZ5XRH2BIU
         VVLB06Izd+mryp2JC3EncqfrwuqFxClGvhaj6Bb4cawO7oUaAxsF3MseoMWnbGoQRV
         r8PBIVnzX9nELU6esiZ4vFyh1RO7yCM5vvRHLwgVnU1zCZF7cB+QaWnlFgAQw8iXnO
         Rn/4OVpR7/0aw==
Date:   Wed, 21 Apr 2021 17:47:10 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Qiushi Wu <wu000273@umn.edu>
cc:     Kangjie Lu <kjlu@umn.edu>, Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Aditya Pakki <pakki001@umn.edu>, x86@kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Arnd Bergmann <arnd@arndb.de>, David Airlie <airlied@linux.ie>,
        Michael Turquette <mturquette@baylibre.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jean Delvare <jdelvare@suse.com>,
        Will Deacon <will@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hovold <johan@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH 000/190] Revertion of all of the umn.edu commits
In-Reply-To: <CAMV6ehGWOB5ENV2Z0QpjQ=rpF9GC=22QTTY-Win+Jd928LbC-A@mail.gmail.com>
Message-ID: <nycvar.YFH.7.76.2104211743010.18270@cbobk.fhfr.pm>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org> <4afeeb49-620d-5a9d-29fc-453f6118a944@roeck-us.net> <nycvar.YFH.7.76.2104211628560.18270@cbobk.fhfr.pm> <CAK8KejoGgoWcEUm7gnTw+_5CuZX1+bnHoeY0Ea-pAO+gd8dbcg@mail.gmail.com>
 <nycvar.YFH.7.76.2104211707250.18270@cbobk.fhfr.pm> <CAMV6ehGWOB5ENV2Z0QpjQ=rpF9GC=22QTTY-Win+Jd928LbC-A@mail.gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Apr 2021, Qiushi Wu wrote:

> The function description of "kobject_init_and_add()" mentioned that "If 
> this function returns an error, kobject_put() must be called to properly 
> clean up the memory associated with the object." (see 
> https://elixir.bootlin.com/linux/v5.12-rc8/source/lib/kobject.c#L464) So 
> we use this patch to fix the issue, and I may miss some context here, 
> but I don't see why this cause some issue like NULL dereferences.
> 
> The identification methodology for this bug and other similar bugs that
> are error-handling related, is shown in "Understanding and Detecting
> Disordered Error Handling with Precise Function Pairing."
> (https://www.usenix.org/conference/usenixsecurity21/presentation/wu-qiushi)

You are calling kobject_put() if kobject_init_and_add() fails. That will 
in turn invoke pci_slot_release() which will try to delete slot->list, but 
that hasn't been initialized yet. 

Fixed in 4684709bf8, present in two major Linux kernel releases.

-- 
Jiri Kosina
SUSE Labs

