Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 924B331A09B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 15:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbhBLOba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 09:31:30 -0500
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21303 "EHLO
        sender4-of-o53.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbhBLOb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 09:31:28 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1613140236; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=Ondve+616aga3AP+JJu9qmuv9Y4zDGq37O7hDNUoa5d/GbqXgPHlhsFJHf8P0o/Vu0S1eZBTMK3Mr28sASaFggYICAveYCwPU75K4fhX5vV/F7BZpAR5UaPg1dD/fzsxik3sbdfsR7Jv54HO9Xo+273OKkJVLwFpKWBxwq4/L9w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1613140236; h=Content-Type:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=Q8O5Qs3111yoIb9wYiJMFK7cbtbsKWkl/sUb8tdzYTg=; 
        b=bw1doOuHka2+cOHF/fO3vFUdGUR/LSQAWM2GNzy0/rAkMpOkq8ibsHuAQGwosA+ATf0OdY1BJgO/YomsGQqACzztSSD4IizUD4HfpcikQFb584SAlt7TolOWkKlr2bKi2wFNH10APcCwEDn3YyV0JOd9Jy0foprnhHLmVY83Q5k=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=anirudhrb.com;
        spf=pass  smtp.mailfrom=mail@anirudhrb.com;
        dmarc=pass header.from=<mail@anirudhrb.com> header.from=<mail@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1613140236;
        s=zoho; d=anirudhrb.com; i=mail@anirudhrb.com;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To;
        bh=Q8O5Qs3111yoIb9wYiJMFK7cbtbsKWkl/sUb8tdzYTg=;
        b=oErKEv2OVnJC35kqOKFhd3R34X/1p7jVTlqT5SgD1C1AwVG/91y4GktQEOer9nUa
        +sK8sQ0JGs8abhekaaSHJHtIqQPuzwHD/4slS6L+9R7QL6XukmLK2GIntUsyfGoB+B4
        svfOdOq00JOtITE39F9JQNk+9m0zehNH87FA5Ldo=
Received: from anirudhrb.com (106.51.107.38 [106.51.107.38]) by mx.zohomail.com
        with SMTPS id 1613140233736897.9350951376649; Fri, 12 Feb 2021 06:30:33 -0800 (PST)
Date:   Fri, 12 Feb 2021 20:00:25 +0530
From:   Anirudh Rayabharam <mail@anirudhrb.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     lee.jones@linaro.org, kuba@kernel.org, johannes@sipsolutions.net,
        colin.king@canonical.com, arnd@arndb.de,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: wimax/i2400m: fix some byte order issues found
 by sparse
Message-ID: <YCaRAYjiz0TJH+4L@anirudhrb.com>
References: <20210211202908.4604-1-mail@anirudhrb.com>
 <YCWVD34rU5Lu71/S@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YCWVD34rU5Lu71/S@kroah.com>
X-ZohoMailClient: External
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 11, 2021 at 09:35:27PM +0100, Greg KH wrote:
> On Fri, Feb 12, 2021 at 01:59:08AM +0530, Anirudh Rayabharam wrote:
> > Fix sparse byte-order warnings in the i2400m_bm_cmd_prepare()
> > function:
> > 
> > wimax/i2400m/fw.c:194:36: warning: restricted __le32 degrades to integer
> > wimax/i2400m/fw.c:195:34: warning: invalid assignment: +=
> > wimax/i2400m/fw.c:195:34:    left side has type unsigned int
> > wimax/i2400m/fw.c:195:34:    right side has type restricted __le32
> > wimax/i2400m/fw.c:196:32: warning: restricted __le32 degrades to integer
> > wimax/i2400m/fw.c:196:47: warning: restricted __le32 degrades to integer
> > wimax/i2400m/fw.c:196:66: warning: restricted __le32 degrades to integer
> > 
> > Signed-off-by: Anirudh Rayabharam <mail@anirudhrb.com>
> > ---
> >  drivers/staging/wimax/i2400m/fw.c | 14 +++++++++-----
> >  1 file changed, 9 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/staging/wimax/i2400m/fw.c b/drivers/staging/wimax/i2400m/fw.c
> > index b2fd4bd2c5f9..bce651a6b543 100644
> > --- a/drivers/staging/wimax/i2400m/fw.c
> > +++ b/drivers/staging/wimax/i2400m/fw.c
> > @@ -189,12 +189,16 @@ void i2400m_bm_cmd_prepare(struct i2400m_bootrom_header *cmd)
> >  {
> >  	if (i2400m_brh_get_use_checksum(cmd)) {
> >  		int i;
> > -		u32 checksum = 0;
> > +		__le32 checksum = 0;
> 
> __le32 is only for when the data crosses the kernel/user boundry, just
> use le32 in the kernel for stuff like this.
> 
But that throws a compile error. Also, I don't see le32 defined
in any common header. It is defined in fs/ntfs/types.h but that's not
accessible here.

> >  		const u32 *checksum_ptr = (void *) cmd->payload;
> 
> Add a blank line here, right?
It wasn't there before but makes sense. I'll send v2 with this change.

Thanks!

	- Anirudh.
