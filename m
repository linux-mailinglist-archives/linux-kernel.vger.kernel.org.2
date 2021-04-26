Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7208C36B797
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 19:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235356AbhDZRKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 13:10:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:54124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233736AbhDZRKj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 13:10:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7E0D461026;
        Mon, 26 Apr 2021 17:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619456996;
        bh=0DtIjKbT5cNEEEoUmNwaG+zZZDDXeNGrUajhPm5odIQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aezKdNKttizMiVMxT2jRoZnkFY3x0RSl/eL8yuEEM/KnMgtPidmL/8gZiP3gkIRN6
         n/iXymsTXEWnnCNcvoNtNswlUvk5KV9jXXzJCq2dp8HUNWHhydNbTxRyp1dVI9TAbK
         x8uvoP0rlRe/t18ySBtIUhnkf6bSkDULG3AurXSY=
Date:   Mon, 26 Apr 2021 19:09:53 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Aditya Pakki <pakki001@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        Qiushi Wu <wu000273@umn.edu>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Arnd Bergmann <arnd@arndb.de>, David Airlie <airlied@linux.ie>,
        Michael Turquette <mturquette@baylibre.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
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
Message-ID: <YIbz4YGCNK+3NyRU@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <CACRpkdbw_sF2FO0jjq47KStUjvhKvWRLF_sZHGpRFuB72-13zg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdbw_sF2FO0jjq47KStUjvhKvWRLF_sZHGpRFuB72-13zg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 01:30:17AM +0200, Linus Walleij wrote:
> On Wed, Apr 21, 2021 at 3:01 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> 
> >   Revert "pinctrl: axp209: Fix NULL pointer dereference after
> >     allocation"
> 
> There is nothing wrong with this patch that I can see.
> It's pretty trivial to inspect.

Now dropped.

> 
> >   Revert "gpio: aspeed: fix a potential NULL pointer dereference"
> 
> I don't see the problem with this either.

Also now dropped from my tree, thanks for the review!

greg k-h
