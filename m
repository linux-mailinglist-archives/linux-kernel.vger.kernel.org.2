Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17E183671DF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 19:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244982AbhDURt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 13:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244996AbhDURtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 13:49:47 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 156A5C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 10:49:14 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lZGy2-0075m9-9w; Wed, 21 Apr 2021 17:48:50 +0000
Date:   Wed, 21 Apr 2021 17:48:50 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jiri Kosina <jikos@kernel.org>,
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
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hovold <johan@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH 000/190] Revertion of all of the umn.edu commits
Message-ID: <YIBlggJ2hZ3TYszc@zeniv-ca.linux.org.uk>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <4afeeb49-620d-5a9d-29fc-453f6118a944@roeck-us.net>
 <nycvar.YFH.7.76.2104211628560.18270@cbobk.fhfr.pm>
 <CAK8KejoGgoWcEUm7gnTw+_5CuZX1+bnHoeY0Ea-pAO+gd8dbcg@mail.gmail.com>
 <YIBBt6ypFtT+i994@pendragon.ideasonboard.com>
 <CAK8Kejqq4qUT=2nqvnVM=r7H_P3dF=+3dHa6HWOCP=9GeeTbpA@mail.gmail.com>
 <6406f3ad-141d-5533-c717-e11cea4e179e@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6406f3ad-141d-5533-c717-e11cea4e179e@roeck-us.net>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 08:59:34AM -0700, Guenter Roeck wrote:
> On 4/21/21 8:21 AM, Kangjie Lu wrote:
> 
> > All of the commits sent by my students are in good faith to fix some bugs.


Just to make sure - does that statement cover the following commit?

commit 0c85a7e87465f2d4cbc768e245f4f45b2f299b05
Author: Aditya Pakki <pakki001@umn.edu>
Date:   Tue Apr 6 19:09:12 2021 -0500

    net/rds: Avoid potential use after free in rds_send_remove_from_sock

And is "Ph.D. student in Computer Science" an accurate description of
the gentleman in question?

We all made utterly bonehead mistakes (if you want a fresh example
of mine, take a look at 161aff1d93ab "LOOKUP_MOUNTPOINT: fold
path_mountpointat() into path_lookupat()"; see 035d80695fae for the
merge of the fix and explanation of what was wrong in the original
commit).

However, there's a general expectation that once you become aware of
dumb mistake in something you have published (and merge into mainline
certainly qualifies as publication) you shall retract it as soon
as possible.  If a student is not aware of such expectation, their
advisor really ought to inform them of it.
