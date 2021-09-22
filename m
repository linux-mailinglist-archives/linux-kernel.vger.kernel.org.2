Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36561414245
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 09:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232987AbhIVHHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 03:07:32 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:46005 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233005AbhIVHHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 03:07:31 -0400
Received: (Authenticated sender: peter@casa-korsgaard.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 96B9E10000D;
        Wed, 22 Sep 2021 07:05:59 +0000 (UTC)
Received: from peko by dell.be.48ers.dk with local (Exim 4.92)
        (envelope-from <peter@korsgaard.com>)
        id 1mSwKM-00089u-BY; Wed, 22 Sep 2021 09:05:58 +0200
From:   Peter Korsgaard <peter@korsgaard.com>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v2] MAINTAINERS: usb, update Peter Korsgaard's entries
References: <20210922063008.25758-1-jslaby@suse.cz>
Date:   Wed, 22 Sep 2021 09:05:58 +0200
In-Reply-To: <20210922063008.25758-1-jslaby@suse.cz> (Jiri Slaby's message of
        "Wed, 22 Sep 2021 08:30:08 +0200")
Message-ID: <87r1dhqecp.fsf@dell.be.48ers.dk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Jiri" == Jiri Slaby <jslaby@suse.cz> writes:

 > Peter's e-mail in MAINTAINERS is defunct:
 > This is the qmail-send program at a.mx.sunsite.dk.
 > <jacmet@sunsite.dk>:
 >       Sorry, no mailbox here by that name. (#5.1.1)

 > Peter says:
 > ** Ahh yes, it should be changed to peter@korsgaard.com.

 > However he also says:
 > ** I haven't had access to c67x00 hw for quite some years though, so maybe
 > ** it should be marked Orphan instead?

 > So change as he wishes.

 > Signed-off-by: Jiri Slaby <jslaby@suse.cz>
 > Cc: Peter Korsgaard <peter@korsgaard.com>
 > Cc: Linus Torvalds <torvalds@linux-foundation.org>
 > Cc: linux-usb@vger.kernel.org
 > ---
 > [v2]

 > - Change the e-mail in DM9601 instead of dropping the old one.
 > - Make C67X00 an orphan.

Thanks!

Acked-by: Peter Korsgaard <peter@korsgaard.com>



 >  MAINTAINERS | 5 ++---
 >  1 file changed, 2 insertions(+), 3 deletions(-)

 > diff --git a/MAINTAINERS b/MAINTAINERS
 > index 2b990794ec35..aafc58437abd 100644
 > --- a/MAINTAINERS
 > +++ b/MAINTAINERS
 > @@ -19344,13 +19344,12 @@ S:	Maintained
 >  F:	drivers/usb/misc/chaoskey.c
 
 >  USB CYPRESS C67X00 DRIVER
 > -M:	Peter Korsgaard <jacmet@sunsite.dk>
 >  L:	linux-usb@vger.kernel.org
 > -S:	Maintained
 > +S:	Orphan
 >  F:	drivers/usb/c67x00/
 
 >  USB DAVICOM DM9601 DRIVER
 > -M:	Peter Korsgaard <jacmet@sunsite.dk>
 > +M:	Peter Korsgaard <peter@korsgaard.com>
 >  L:	netdev@vger.kernel.org
 >  S:	Maintained
 >  W:	http://www.linux-usb.org/usbnet
 > -- 
 > 2.33.0


-- 
Bye, Peter Korsgaard
