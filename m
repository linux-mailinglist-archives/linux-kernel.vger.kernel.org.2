Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5AC531A0D6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 15:45:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbhBLOoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 09:44:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:48264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229583AbhBLOny (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 09:43:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EF24B64DDF;
        Fri, 12 Feb 2021 14:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613140993;
        bh=jdh6AjF6eRVBQzGJuNrW4QcNwQV/jqhkz37tNBHm5AI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wyEWvQVhgL9qJrnkmMF8OsoxdJNVNKvyuGvIpJJ+XaVts9gV6LEUeiLfPwqyG64Aj
         KNQA278q3tJJVdlgany3XpTzSHjkDfXu0ezmPF08lVbwmKQKdt7FMolJXqpWkCYjZc
         Maq7TWxUWV/1apZ3Wi8WSlcjFkni2G3UnRsHx4a8=
Date:   Fri, 12 Feb 2021 15:43:10 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Anirudh Rayabharam <mail@anirudhrb.com>
Cc:     devel@driverdev.osuosl.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, colin.king@canonical.com,
        kuba@kernel.org, johannes@sipsolutions.net, lee.jones@linaro.org
Subject: Re: [PATCH] staging: wimax/i2400m: fix some byte order issues found
 by sparse
Message-ID: <YCaT/qLci4ap1grf@kroah.com>
References: <20210211202908.4604-1-mail@anirudhrb.com>
 <YCWVD34rU5Lu71/S@kroah.com>
 <YCaRAYjiz0TJH+4L@anirudhrb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YCaRAYjiz0TJH+4L@anirudhrb.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 12, 2021 at 08:00:25PM +0530, Anirudh Rayabharam wrote:
> On Thu, Feb 11, 2021 at 09:35:27PM +0100, Greg KH wrote:
> > On Fri, Feb 12, 2021 at 01:59:08AM +0530, Anirudh Rayabharam wrote:
> > > Fix sparse byte-order warnings in the i2400m_bm_cmd_prepare()
> > > function:
> > > 
> > > wimax/i2400m/fw.c:194:36: warning: restricted __le32 degrades to integer
> > > wimax/i2400m/fw.c:195:34: warning: invalid assignment: +=
> > > wimax/i2400m/fw.c:195:34:    left side has type unsigned int
> > > wimax/i2400m/fw.c:195:34:    right side has type restricted __le32
> > > wimax/i2400m/fw.c:196:32: warning: restricted __le32 degrades to integer
> > > wimax/i2400m/fw.c:196:47: warning: restricted __le32 degrades to integer
> > > wimax/i2400m/fw.c:196:66: warning: restricted __le32 degrades to integer
> > > 
> > > Signed-off-by: Anirudh Rayabharam <mail@anirudhrb.com>
> > > ---
> > >  drivers/staging/wimax/i2400m/fw.c | 14 +++++++++-----
> > >  1 file changed, 9 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/drivers/staging/wimax/i2400m/fw.c b/drivers/staging/wimax/i2400m/fw.c
> > > index b2fd4bd2c5f9..bce651a6b543 100644
> > > --- a/drivers/staging/wimax/i2400m/fw.c
> > > +++ b/drivers/staging/wimax/i2400m/fw.c
> > > @@ -189,12 +189,16 @@ void i2400m_bm_cmd_prepare(struct i2400m_bootrom_header *cmd)
> > >  {
> > >  	if (i2400m_brh_get_use_checksum(cmd)) {
> > >  		int i;
> > > -		u32 checksum = 0;
> > > +		__le32 checksum = 0;
> > 
> > __le32 is only for when the data crosses the kernel/user boundry, just
> > use le32 in the kernel for stuff like this.
> > 
> But that throws a compile error.

What error?

> Also, I don't see le32 defined
> in any common header. It is defined in fs/ntfs/types.h but that's not
> accessible here.

Ah, my fault, you are right, nevermind.

> > >  		const u32 *checksum_ptr = (void *) cmd->payload;
> > 
> > Add a blank line here, right?
> It wasn't there before but makes sense. I'll send v2 with this change.

Thanks.

greg k-h
