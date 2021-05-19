Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8B91388F02
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 15:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353653AbhESN1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 09:27:17 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:51572 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346776AbhESN1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 09:27:16 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14JDIc7k031008;
        Wed, 19 May 2021 13:25:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=skJY/1cWBIT0zmPMPraWd81BO4k58B/+Vkm0OfgDe4o=;
 b=nFkK8kjI+15Bezz+GsFtwklua3czt5idR4Wb8aUKXSd+bdFQtwyPDwaosCN5a2rp87u3
 0GlsPcO1N8CNDNxGE7898ksk1Ga6Pkvkpqu/HTKi1XzBub1ibAEjOomhvveuqtF9Q4Uu
 wlsKUsiJ22ArlhHoTEZjUUqKelrJxGngN2Pbs/PaBP0EnDnpxLhX8GDlkdRnLw91etPi
 6zqoLhVlzJgFipT8RROnuTfP0vDUiTQpmzfEY2neYI4Fyf4Awzsmc6xH5ZFjwrM/MZyE
 5vfsTZCGfjzcheuCSoRf70gFEHSMNJ68UbuKuFy+Vu9aOy0dr1FM5gjWHbQ+1SN1v1pw xg== 
Received: from oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 38kffu15k6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 May 2021 13:25:40 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 14JDPda6103711;
        Wed, 19 May 2021 13:25:39 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 38msw1fh7p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 May 2021 13:25:39 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 14JDPdhp103700;
        Wed, 19 May 2021 13:25:39 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 38msw1fh7a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 May 2021 13:25:39 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 14JDPbFe029699;
        Wed, 19 May 2021 13:25:37 GMT
Received: from kadam (/41.212.42.34)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 19 May 2021 06:25:36 -0700
Date:   Wed, 19 May 2021 16:25:29 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Fabio Aiuto <fabioaiuto83@gmail.com>
Cc:     Bryan Brattlof <hello@bryanbrattlof.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: remove if (true) statement
Message-ID: <20210519132529.GV1955@kadam>
References: <20210518144335.1677320-1-hello@bryanbrattlof.com>
 <20210519124438.GA1417@agape.jhs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210519124438.GA1417@agape.jhs>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-ORIG-GUID: LsT8l_1u2-pnreU86A58iiZaIZg6yUbV
X-Proofpoint-GUID: LsT8l_1u2-pnreU86A58iiZaIZg6yUbV
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2021 at 02:44:38PM +0200, Fabio Aiuto wrote:
> Hi Bryan,
> 
> On Tue, May 18, 2021 at 02:45:19PM +0000, Bryan Brattlof wrote:
> > 'if (true) { ... }' will always evaluate to true. Remove it and
> > save a few tabs for somewhere else.
> > 
> > Signed-off-by: Bryan Brattlof <hello@bryanbrattlof.com>
> > ---
> >  drivers/staging/rtl8723bs/core/rtw_ap.c | 159 ++++++++++++------------
> >  1 file changed, 78 insertions(+), 81 deletions(-)
> > 
> > diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
> > index 9df4476b2e2d..98b1bec67999 100644
> > --- a/drivers/staging/rtl8723bs/core/rtw_ap.c
> > +++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
> > @@ -59,112 +59,109 @@ static void update_BCNTIM(struct adapter *padapter)
> >
> 
> I was wondering why are you using the first patch of a nine patch
> series as a 'cover letter' of an eight patch patchset.
> 
> In other words, why putting the In-Reply-To field of all patches subsequent
> to the first one ponting to the first patch itself as a cover letter,
> is it a recommened practice?

It's fine.  It doesn't matter.  It's not recommended.  I do it normally
if I have to send patches in certain order.  I never write cover letters
because my patches are all independent bug fixes and not new features.

regards,
dan carpenter

