Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC4A358295
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 13:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbhDHMAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 08:00:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:52398 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229803AbhDHMAH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 08:00:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1617883195; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XUNP4Nw5sr24LzcfuQv0sN/hk7neBIq1pmawF1Cb7yg=;
        b=tQptUgx8Yh6OCrueztIsbWC+2bN1wyt5UTv1KiYYlYCoDgJUerCWtq3LwzjIaFNDDGG4id
        YcuwuOUCxqo3EPoVvyOz/jPj0BU/DnkA1cKY/JPS5tFFytTmL67kY3nbI0R6j3Cn9Sktwi
        fhzoLHmyP+2OGdLczeNK28+dU0XWB48=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 51E17B0B6;
        Thu,  8 Apr 2021 11:59:55 +0000 (UTC)
Message-ID: <61df47f6708fc4bc9add8d42aff6edcbad6e9618.camel@suse.com>
Subject: Re: [PATCH 3/3] USB: cdc-acm: fix TIOCGSERIAL implementation
From:   Oliver Neukum <oneukum@suse.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 08 Apr 2021 13:59:43 +0200
In-Reply-To: <YG7vEQa53AhN+piv@hovoldconsulting.com>
References: <20210407102845.32720-1-johan@kernel.org>
         <20210407102845.32720-4-johan@kernel.org>
         <a1a94db2d373c4c7b8841908d8e6133ab022232e.camel@suse.com>
         <YG7RiLoscS6VXG7n@hovoldconsulting.com>
         <0049152ce9da85c50fda91c1b77ca233ba0fef3d.camel@suse.com>
         <YG7vEQa53AhN+piv@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, den 08.04.2021, 13:54 +0200 schrieb Johan Hovold:
> On Thu, Apr 08, 2021 at 01:34:12PM +0200, Oliver Neukum wrote:
> > Am Donnerstag, den 08.04.2021, 11:48 +0200 schrieb Johan Hovold:
> > > On Thu, Apr 08, 2021 at 10:36:46AM +0200, Oliver Neukum wrote:
> > > > Am Mittwoch, den 07.04.2021, 12:28 +0200 schrieb Johan Hovold:
> > > > Well, the devices report it. It is part of the standard.
> > > 
> > > No, the standard doesn't include anything about a baud-base clock
> > > AFAICT.
> > 
> > Unfortunately it does.
> > dwDTERate - chapter 6.3.11 - table 17
> 
> That's not the base clock rate, that's just the currently configured
> line speed which you can read from termios 
> > If we does this wrongly, we should certainly fix it, but just removing
> > the reporting doesn't look right to me.
> 
> The driver got its interpretation of baud_base wrong, and CDC doesn't
> even have a concept of base clock rate so removing it is the right thing
> to do.
> 
> Again, baud_base is really only relevant with legacy UARTs and when
> using the deprecated ASYNC_SPD_CUST.
> 
> And if the user wants to knows the current line speed we have a
> different interface for that.

Hi,

thank you, that clarifies things. I am happy with the patch itself,
but could I ask you to do two things:

1. Edit the commit description
making clear that the difference
between the base clock rate and the line speed.

2. Mark the patch specially to NOT be included in stable. We may
have
users misusing the current API.

	Regards
		Oliver


