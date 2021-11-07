Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4D044735F
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Nov 2021 15:54:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235529AbhKGO4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Nov 2021 09:56:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbhKGO4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 09:56:48 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE725C061570
        for <linux-kernel@vger.kernel.org>; Sun,  7 Nov 2021 06:54:05 -0800 (PST)
Received: from martin by viti.kaiser.cx with local (Exim 4.89)
        (envelope-from <martin@viti.kaiser.cx>)
        id 1mjjYV-0001fY-SD; Sun, 07 Nov 2021 15:53:59 +0100
Date:   Sun, 7 Nov 2021 15:53:59 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: fix memleak in rtw_wx_set_enc_ext
Message-ID: <20211107145359.immx5fbbzksj3ddb@viti.kaiser.cx>
References: <20211019202356.12572-1-martin@kaiser.cx>
 <20211102133122.GH2794@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211102133122.GH2794@kadam>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: Martin Kaiser <martin@viti.kaiser.cx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Dan Carpenter (dan.carpenter@oracle.com):

> On Tue, Oct 19, 2021 at 10:23:56PM +0200, Martin Kaiser wrote:
> > Free the param struct if the caller sets an unsupported algorithm
> > and we return an error.

> > Fixes: 2b42bd58b321 ("staging: r8188eu: introduce new os_dep dir for RTL8188eu driver")
> > Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> > ---
> >  drivers/staging/r8188eu/os_dep/ioctl_linux.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)

> > diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> > index 4f0ae821d193..4e51d5a55985 100644
> > --- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> > +++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> > @@ -1897,7 +1897,7 @@ static int rtw_wx_set_enc_ext(struct net_device *dev,
> >  	struct ieee_param *param = NULL;
> >  	struct iw_point *pencoding = &wrqu->encoding;
> >  	struct iw_encode_ext *pext = (struct iw_encode_ext *)extra;
> > -	int ret = 0;
> > +	int ret = -1;


> This was in the original code, so it's fine to leave it as -1, but in
> future patches could you change it to -EINVAL instead.  (Or don't.  I'm
> not your boss.  I appretiate all the clean up you have done to this
> driver).

Thanks.

I tried to change as little as possible to allow for backporting to
stable.

Using a standard error code makes more sense. Some of the ioctl
functions do this already, others use -1. This is something we should
fix when cfg80211 support is in place and we know which of the ioctl
functions survive.

Best regards,
Martin
