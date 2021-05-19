Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7FCF388F30
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 15:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353651AbhESNdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 09:33:04 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:4552 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242071AbhESNdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 09:33:01 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14JDVOKP025604;
        Wed, 19 May 2021 13:31:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=8NveE/aeRumdJdziN2dtSUkgF1aBTwy+02Y/tzFDN/Y=;
 b=e0drf9fSOLs2UhL930iks+qoNRERchyS2FaDb0UtaVLpyD12I7iBr6o5w0DDZ2oqVj9E
 yLInRE2pFg2PdDK7Rmhs6/KRgjk/tZE4ZzQ1r08t6akpSfajfZpFviEYzVfzAtT/r3oA
 nCohjtG2Qa7zR4pu63QgocChEYPodqSWdX0oSN5c2mW0sxuPvnH4qytLM7a3vlg0Qv2f
 FA7DyRIF9/IGMl6O5/d5NUhvONb+H89LAS+G3vUDmeytvTuUqU3XqG/UVMl3zk/kFtfp
 +D4psZ+6EiOqdZUBaQlfNjg8DTR2w/YVnrLkRoG5fHZjBpEm8b/9GErCcGRHiDa4Pi2A jw== 
Received: from oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 38kh0h958e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 May 2021 13:31:24 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 14JDVNOI118313;
        Wed, 19 May 2021 13:31:23 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 38msw1fmde-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 May 2021 13:31:23 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 14JDVNeV118295;
        Wed, 19 May 2021 13:31:23 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 38msw1fmd5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 May 2021 13:31:23 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 14JDVL1N002950;
        Wed, 19 May 2021 13:31:22 GMT
Received: from kadam (/41.212.42.34)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 19 May 2021 06:31:21 -0700
Date:   Wed, 19 May 2021 16:31:08 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Fabio Aiuto <fabioaiuto83@gmail.com>
Cc:     Bryan Brattlof <hello@bryanbrattlof.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: remove if (true) statement
Message-ID: <20210519133108.GW1955@kadam>
References: <20210518144335.1677320-1-hello@bryanbrattlof.com>
 <20210519124438.GA1417@agape.jhs>
 <20210519132529.GV1955@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210519132529.GV1955@kadam>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-GUID: EAMSSZ_S26VWdMfUqxabc9ePWo0Sd-B1
X-Proofpoint-ORIG-GUID: EAMSSZ_S26VWdMfUqxabc9ePWo0Sd-B1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2021 at 04:25:29PM +0300, Dan Carpenter wrote:
> On Wed, May 19, 2021 at 02:44:38PM +0200, Fabio Aiuto wrote:
> > Hi Bryan,
> > 
> > On Tue, May 18, 2021 at 02:45:19PM +0000, Bryan Brattlof wrote:
> > > 'if (true) { ... }' will always evaluate to true. Remove it and
> > > save a few tabs for somewhere else.
> > > 
> > > Signed-off-by: Bryan Brattlof <hello@bryanbrattlof.com>
> > > ---
> > >  drivers/staging/rtl8723bs/core/rtw_ap.c | 159 ++++++++++++------------
> > >  1 file changed, 78 insertions(+), 81 deletions(-)
> > > 
> > > diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
> > > index 9df4476b2e2d..98b1bec67999 100644
> > > --- a/drivers/staging/rtl8723bs/core/rtw_ap.c
> > > +++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
> > > @@ -59,112 +59,109 @@ static void update_BCNTIM(struct adapter *padapter)
> > >
> > 
> > I was wondering why are you using the first patch of a nine patch
> > series as a 'cover letter' of an eight patch patchset.
> > 
> > In other words, why putting the In-Reply-To field of all patches subsequent
> > to the first one ponting to the first patch itself as a cover letter,
> > is it a recommened practice?
> 
> It's fine.  It doesn't matter.  It's not recommended.  I do it normally
> if I have to send patches in certain order.  I never write cover letters
> because my patches are all independent bug fixes and not new features.

Wait, this was just a mistake I think.  It's not a cover letter.  It's
not part of the eight patch series but it probably was intended to be as
you suggest.

The patches are basically okay.  Greg applies patches in the order that
he recieves them so it should all apply fine.  And if it doesn't Greg
will just ask for a resend.  No big deal.

regards,
dan carpenter

