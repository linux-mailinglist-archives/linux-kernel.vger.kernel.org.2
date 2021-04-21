Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB33F366ECB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 17:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243821AbhDUPK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 11:10:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:46026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239324AbhDUPK0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 11:10:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0DC01611F2;
        Wed, 21 Apr 2021 15:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619017792;
        bh=cmxYUGxDOvBGJSYYcBEpSIueD8RyRm/a5JTphHyLP8g=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=neqJV3tUVsw0my6WF6hay6B5o5vuqjtXJ9uJxYp5KFAjuZI62jC1yAOz52JutXQoj
         qkIrKP8x6dgQcy8RPxAbfcXQZGQ7mqWP5dPfvlrkve1N+RdkDMBxqKRU5ihoLrvs3h
         5i+nFTaS61KTlWOtMqPcKkm6wC4Rds4YDTDNV6P3ri3EEelAfKtRFmyGQUan6Kdtq0
         /0amjNyhbBvgXRxye7FmdUH+6ljX/VIqgvLP0ZA/CZk0Xd9wIT05EMkcEXE+D+zk9F
         lcijBd81YIe2XxnO8AblKlyBQCcnJVMikygu/QOq5ZFCn4++x1a0CDn4Lvhm4r+A9R
         ekB7bTw0bgDUw==
Date:   Wed, 21 Apr 2021 17:09:45 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Kangjie Lu <kjlu@umn.edu>
cc:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Aditya Pakki <pakki001@umn.edu>, Qiushi Wu <wu000273@umn.edu>,
        x86@kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
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
In-Reply-To: <CAK8KejoGgoWcEUm7gnTw+_5CuZX1+bnHoeY0Ea-pAO+gd8dbcg@mail.gmail.com>
Message-ID: <nycvar.YFH.7.76.2104211707250.18270@cbobk.fhfr.pm>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org> <4afeeb49-620d-5a9d-29fc-453f6118a944@roeck-us.net> <nycvar.YFH.7.76.2104211628560.18270@cbobk.fhfr.pm> <CAK8KejoGgoWcEUm7gnTw+_5CuZX1+bnHoeY0Ea-pAO+gd8dbcg@mail.gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Apr 2021, Kangjie Lu wrote:

> > Therefore I'd like to ask Kangjie Lu (who is CCed here) to consider
> > revising his statement in the attempted public clarification:
> >
> >         "The experiment did not introduce any bug or bug-introducing
> > commit into
> >          OSS."
> >
> > at [1] as it's clearly not true. Missing mutex unlock clearky is a bug
> > introduced by this experiment.
> >
> 
> Hi everyone,
> 
> I am so sorry for the concerns. I fully understand why the community is
> angry. Please allow me to have a very quick response, as Jiri requested. We
> will provide a detailed explanation later.

Thanks.

> These are two different projects. The one published at IEEE S&P 2021 has
> completely finished in November 2020. 

What about 8a94644b440 then? It's from May 2020, it has been committed to 
the tree, and it introduces a NULL pointer dereference on 
kobject_init_and_add() failure.

-- 
Jiri Kosina
SUSE Labs

