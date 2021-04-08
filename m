Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B82F635820B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 13:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbhDHLft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 07:35:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:34702 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230434AbhDHLfs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 07:35:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1617881736; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TLv2wklZKx+07GJDwj8lSKlldFfu0OuL4DATSUU4UTo=;
        b=Ex4J5UHICowWdEnJtcvwHILgDp7jyv1CjSrRGnx2victzN91ez7X+zqTqzRex7gdNCw7po
        7A2ZEc4eYXe00e+P4oLnHnnLItu5VI1HmLenakMuRCUYw6FNudcvFyMX1OupdseuxQz9bx
        xjuwvIscegu9QpTYdTCLCJuWG7rvNhk=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A467FAE06;
        Thu,  8 Apr 2021 11:35:36 +0000 (UTC)
Message-ID: <a84e1199ea7534a20ccd313c011b798ee8306472.camel@suse.com>
Subject: Re: [PATCH 2/3] USB: cdc-acm: fix unprivileged TIOCCSERIAL
From:   Oliver Neukum <oneukum@suse.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 08 Apr 2021 13:35:24 +0200
In-Reply-To: <YG7P8EJ1obdM01J8@hovoldconsulting.com>
References: <20210407102845.32720-1-johan@kernel.org>
         <20210407102845.32720-3-johan@kernel.org>
         <8918b0b50068705a865ffc22fe9745dacf0c21e8.camel@suse.com>
         <YG7P8EJ1obdM01J8@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, den 08.04.2021, 11:42 +0200 schrieb Johan Hovold:
> On Thu, Apr 08, 2021 at 09:48:38AM +0200, Oliver Neukum wrote:
> > Am Mittwoch, den 07.04.2021, 12:28 +0200 schrieb Johan Hovold:
> > > TIOCSSERIAL is a horrid, underspecified, legacy interface which for most
> > > serial devices is only useful for setting the close_delay and
> > > closing_wait parameters.
> > > 
> > > A non-privileged user has only ever been able to set the since long
> > > deprecated ASYNC_SPD flags and trying to change any other *supported*
> > > feature should result in -EPERM being returned. Setting the current
> > > values for any supported features should return success.
> > > 
> > > Fix the cdc-acm implementation which instead indicated that the
> > > TIOCSSERIAL ioctl was not even implemented when a non-privileged user
> > > set the current values.
> > 
> > Hi,
> > 
> > the idea here was that you are setting something else, if you are
> > not changing a parameter that can be changed. That conclusion is
> > dubious, but at the same time, this implementation can change
> > only these two parameters. So can the test really be dropped
> > as opposed to be modified?
> 
> The de-facto standard for how to handle change requests for
> non-supported features (e.g. changing the I/O port or IRQ) is to simply
> ignore them and return 0.
> 
> For most (non-legacy) serial devices the only relevant parameters are
> close_delay and closing_wait. And as we need to return -EPERM when a
> non-privileged user tries to change these, we cannot drop the test.
> 
> (And returning -EOPNOTSUPP was never correct as the ioctl is indeed
> supported.)

OK, thanks for clarification. Yes the fix makes sense.

	Regards
		Oliver


