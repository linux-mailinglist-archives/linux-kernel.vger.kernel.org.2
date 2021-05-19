Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 184C5388F7C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 15:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345137AbhESNwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 09:52:42 -0400
Received: from mail2.protonmail.ch ([185.70.40.22]:12996 "EHLO
        mail2.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239473AbhESNwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 09:52:39 -0400
Date:   Wed, 19 May 2021 13:51:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bryanbrattlof.com;
        s=protonmail3; t=1621432277;
        bh=SNNcRVOFVpr35EZL4/N+6W9VvKSlRNMPq2xvss0knNw=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=TXaRBf41aHSzJdXeZJS9xYMZ0PEvrSFrt9/P3ojk1QYAkX/XzEDE7EE2lKZONgiDd
         10Nd//LTgMyya0waxBXer36OT8ZUWIdwh48AqjLje6B9fc9hGKbeba3CQ/bxAm/57w
         lzLyiG3Nv5f9wFOnFuUQ+PmL3VP5MOAixqLQPhggapq+1W8zRCrgEyHAF/BinfBnRX
         KjydRyQzaGwAJxOD3xvE4Wf6lMhhoEzsY2iECV0if01hQWwrzmMInfTXlOEtqC63lL
         rUU2h61ZeiE9ixLyBWLi3l7vs3AT0J2nbKySe4PmSXSPKKb3/JiYE1e03Xz3DuYJg4
         3/RTkkmgtFBRQ==
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Fabio Aiuto <fabioaiuto83@gmail.com>
From:   Bryan Brattlof <hello@bryanbrattlof.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Reply-To: Bryan Brattlof <hello@bryanbrattlof.com>
Subject: Re: [PATCH] staging: rtl8723bs: remove if (true) statement
Message-ID: <20210519135020.wm3qi4gv475hg54b@bryanbrattlof.com>
In-Reply-To: <20210519133108.GW1955@kadam>
References: <20210518144335.1677320-1-hello@bryanbrattlof.com> <20210519124438.GA1417@agape.jhs> <20210519132529.GV1955@kadam> <20210519133108.GW1955@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2021 at 04:31:08PM +0300, Dan Carpenter wrote:
> On Wed, May 19, 2021 at 04:25:29PM +0300, Dan Carpenter wrote:
> > On Wed, May 19, 2021 at 02:44:38PM +0200, Fabio Aiuto wrote:
> > > Hi Bryan,
> > >
> > > On Tue, May 18, 2021 at 02:45:19PM +0000, Bryan Brattlof wrote:
> > > > 'if (true) { ... }' will always evaluate to true. Remove it and
> > > > save a few tabs for somewhere else.
> > > >
> > > > Signed-off-by: Bryan Brattlof <hello@bryanbrattlof.com>
> > > > ---
> > > >  drivers/staging/rtl8723bs/core/rtw_ap.c | 159 ++++++++++++--------=
----
> > > >  1 file changed, 78 insertions(+), 81 deletions(-)
> > > >
> > > > diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/stag=
ing/rtl8723bs/core/rtw_ap.c
> > > > index 9df4476b2e2d..98b1bec67999 100644
> > > > --- a/drivers/staging/rtl8723bs/core/rtw_ap.c
> > > > +++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
> > > > @@ -59,112 +59,109 @@ static void update_BCNTIM(struct adapter *pad=
apter)
> > > >
> > >
> > > I was wondering why are you using the first patch of a nine patch
> > > series as a 'cover letter' of an eight patch patchset.
> > >
> > > In other words, why putting the In-Reply-To field of all patches subs=
equent
> > > to the first one ponting to the first patch itself as a cover letter,
> > > is it a recommened practice?
> >
> > It's fine.  It doesn't matter.  It's not recommended.  I do it normally
> > if I have to send patches in certain order.  I never write cover letter=
s
> > because my patches are all independent bug fixes and not new features.
>
> Wait, this was just a mistake I think.  It's not a cover letter.  It's
> not part of the eight patch series but it probably was intended to be as
> you suggest.
>
> The patches are basically okay.  Greg applies patches in the order that
> he recieves them so it should all apply fine.  And if it doesn't Greg
> will just ask for a resend.  No big deal.
>

Yep this is due to my inexperience with git over email :)

I wanted to send the patches in order to avoid conflicts when applying
because they deal with the same area of the file, but didn't feel they
deserved a cover letter to remove some unused definitions.

I was using 'git-series' to manage the patch set which generated an
empty cover letter that I didn't send out. I should have known that
In-Reply-To would have been set for all the remaining emails.

Going forward I'll probably just stick with 'git-send-email' and write a
proper cover letter, especially while I'm still getting used to sending
patches over email. :)

--
~Bryan

> regards,
> dan carpenter
>

