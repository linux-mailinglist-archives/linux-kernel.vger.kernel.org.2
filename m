Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B50DF3F409D
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 19:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbhHVRFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 13:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbhHVRFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 13:05:22 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EEF9C061575
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 10:04:41 -0700 (PDT)
Received: from martin by viti.kaiser.cx with local (Exim 4.89)
        (envelope-from <martin@viti.kaiser.cx>)
        id 1mHqtf-0008Kr-7j; Sun, 22 Aug 2021 19:04:35 +0200
Date:   Sun, 22 Aug 2021 19:04:35 +0200
From:   Martin Kaiser <lists@kaiser.cx>
To:     Phillip Potter <phil@philpotter.co.uk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/10] staging: r8188eu: remove unnecessary cast
Message-ID: <20210822170435.ijsi7ep7rbdu4i3k@viti.kaiser.cx>
References: <20210821164859.4351-1-martin@kaiser.cx>
 <CAA=Fs0mU0bkXPY35fkuudoWfAps2jp1qc3ga53LXgg6d+0bVSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA=Fs0mU0bkXPY35fkuudoWfAps2jp1qc3ga53LXgg6d+0bVSg@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: Martin Kaiser <martin@viti.kaiser.cx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Phillip Potter (phil@philpotter.co.uk):

> On Sat, 21 Aug 2021 at 17:49, Martin Kaiser <martin@kaiser.cx> wrote:

> > name is a const char * by default. This type should be ok for r8188eu.

> > Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> > ---
> >  drivers/staging/r8188eu/os_dep/usb_intf.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)

> > diff --git a/drivers/staging/r8188eu/os_dep/usb_intf.c b/drivers/staging/r8188eu/os_dep/usb_intf.c
> > index e002070f7fba..72556ac10d7d 100644
> > --- a/drivers/staging/r8188eu/os_dep/usb_intf.c
> > +++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
> > @@ -61,7 +61,7 @@ struct rtw_usb_drv {
> >  };

> >  static struct rtw_usb_drv rtl8188e_usb_drv = {
> > -       .usbdrv.name = (char *)"r8188eu",
> > +       .usbdrv.name = "r8188eu",
> >         .usbdrv.probe = rtw_drv_init,
> >         .usbdrv.disconnect = rtw_dev_remove,
> >         .usbdrv.id_table = rtw_usb_id_tbl,
> > --
> > 2.20.1

Hi Phil,

> Looks ok to me, thanks. I would consider using a cover letter style
> [PATCH 00/10] style approach as an addition in future though, just my
> personal opinion.

> Acked-by: Phillip Potter <phil@philpotter.co.uk>

Thanks.

This series is a mixed bag of things I found while poking around in the
code. So I didn't think there was anything useful to say in a cover
letter. Still, I see your point, it makes sense for a patch series to
have a cover letter, I'll add one for future patch series.

Best regards,
Martin
