Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B421367983
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 07:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbhDVFwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 01:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbhDVFwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 01:52:08 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD23C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 22:51:34 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lZSFL-007EQm-Jb; Thu, 22 Apr 2021 05:51:27 +0000
Date:   Thu, 22 Apr 2021 05:51:27 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Aditya Pakki <pakki001@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        Qiushi Wu <wu000273@umn.edu>, x86@kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Arnd Bergmann <arnd@arndb.de>, David Airlie <airlied@linux.ie>,
        Michael Turquette <mturquette@baylibre.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jiri Kosina <jikos@kernel.org>, Will Deacon <will@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hovold <johan@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH 000/190] Revertion of all of the umn.edu commits
Message-ID: <YIEO3+jdF6FgcWz7@zeniv-ca.linux.org.uk>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 02:57:55PM +0200, Greg Kroah-Hartman wrote:

> I'll take this through my tree, so no need for any maintainer to worry
> about this, but they should be aware that future submissions from anyone
> with a umn.edu address should be by default-rejected unless otherwise
> determined to actually be a valid fix (i.e. they provide proof and you
> can verify it, but really, why waste your time doing that extra work?)

Frankly, the last bit is nonsense.  If nothing else, consider the situation
when somebody from UMN (which is a lot bigger than the group in question,
but hell with it - somebody really from that group) posts an analysis of
a real bug, along with a correct fix.  With valid proof of correctness.
What should we do?  Leave the bug in place?  Unattractive, to put it
mildly.  Write a fix and try to make it different from theirs?  Not always
feasible.  Write a fix without looking at theirs and commit it?  And if it
happens to coincide with theirs, then what?

FWIW, I do believe their claims that they tried to avoid introducing bugs
and creating problems in general.  So did RT[F]M, for that matter.
However, the very nature of their "experiment"[1] required deflecting
review.  With obvious effects...

[1] I won't go into its value, relevance of threat model, etc. at the
moment - proper comments on that paper will take more time than I'm likely
to have during the next couple of weeks.
