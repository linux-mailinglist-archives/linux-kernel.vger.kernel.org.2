Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 292EA370751
	for <lists+linux-kernel@lfdr.de>; Sat,  1 May 2021 15:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbhEANLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 May 2021 09:11:07 -0400
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21351 "EHLO
        sender4-of-o53.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232129AbhEANLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 May 2021 09:11:07 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1619874614; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=G0fLoottJfClpiGHND3lXJB5oSzfIOTtRAieLbHQHVU8pRdjNRMzsv8CDo2HnN0JKdh2HgTEbe2DaIwiF/PJDYRx1qminEUh/4h81vU9IwF+POaBdrv6Z6ANLbB85GMLENg1QmdLTlkimw/EUxGMDNafTope5Qgq2Fz6kLnA3LI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1619874614; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=aeVb9tMtN8VP+qEMHO0j4WwukXcb48yCZRdEb9bMQYU=; 
        b=eb8SDlX02QzYFdxZCQ7HxT1BXAA912qnTO7kS/0fihv4lzIXMpFGhhpjmqWqtcOeHrW12H2MqMy+Jccmx1uYRLQF3Jv5Szhz84dy7ZOKoY/tWT6lgPoY9EGQdcZFCFTQg7uazv4decjcygLumf0mfQOolR9Yd/uBYB/UCkcGjhY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=anirudhrb.com;
        spf=pass  smtp.mailfrom=mail@anirudhrb.com;
        dmarc=pass header.from=<mail@anirudhrb.com> header.from=<mail@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1619874614;
        s=zoho; d=anirudhrb.com; i=mail@anirudhrb.com;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To;
        bh=aeVb9tMtN8VP+qEMHO0j4WwukXcb48yCZRdEb9bMQYU=;
        b=oyoMkL+eiS8SxK/h+JHxBeyZF4UM/bPruSmjD+vR7sO8TIhpgLl/sLO4PBQWmHkz
        chlSSTPWM4S45ENS+6Tc9+cODRrHG5oigHYokwci2jj2n3mZf64yElnPjUdrfThhV35
        fIQ4vjAP/a1bmbyNyV4FP13AIdqCU1HI94QNRpUU=
Received: from anirudhrb.com (49.207.211.62 [49.207.211.62]) by mx.zohomail.com
        with SMTPS id 1619874611701231.35758212814903; Sat, 1 May 2021 06:10:11 -0700 (PDT)
Date:   Sat, 1 May 2021 18:40:04 +0530
From:   Anirudh Rayabharam <mail@anirudhrb.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Matt Porter <mporter@kernel.crashing.org>,
        Alexandre Bounine <alex.bou9@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, mail@anirudhrb.com
Subject: Re: [PATCH] rapidio: remove unused variable in rio_cm.c
Message-ID: <YI1TLAOXoQozBa1M@anirudhrb.com>
References: <20210501055018.9244-1-mail@anirudhrb.com>
 <YI0sIoDv6H+aSyNE@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YI0sIoDv6H+aSyNE@kroah.com>
X-ZohoMailClient: External
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 01, 2021 at 12:23:30PM +0200, Greg KH wrote:
> On Sat, May 01, 2021 at 11:20:17AM +0530, Anirudh Rayabharam wrote:
> > Remove unused variable 'rc' to fix gcc warning:
> > 
> > 	drivers/rapidio/rio_cm.c: In function ‘rio_txcq_handler’:
> > 	drivers/rapidio/rio_cm.c:673:7: warning: variable ‘rc’ set but
> > 	not used [-Wunused-but-set-variable]
> > 
> > Signed-off-by: Anirudh Rayabharam <mail@anirudhrb.com>
> > ---
> >  drivers/rapidio/rio_cm.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/drivers/rapidio/rio_cm.c b/drivers/rapidio/rio_cm.c
> > index 50ec53d67a4c..545693bd86a3 100644
> > --- a/drivers/rapidio/rio_cm.c
> > +++ b/drivers/rapidio/rio_cm.c
> > @@ -670,12 +670,11 @@ static void rio_txcq_handler(struct cm_dev *cm, int slot)
> >  	 */
> >  	if (!list_empty(&cm->tx_reqs) && (cm->tx_cnt < RIOCM_TX_RING_SIZE)) {
> >  		struct tx_req *req, *_req;
> > -		int rc;
> >  
> >  		list_for_each_entry_safe(req, _req, &cm->tx_reqs, node) {
> >  			list_del(&req->node);
> >  			cm->tx_buf[cm->tx_slot] = req->buffer;
> > -			rc = rio_add_outb_message(cm->mport, req->rdev, cmbox,
> > +			rio_add_outb_message(cm->mport, req->rdev, cmbox,
> >  						  req->buffer, req->len);
> 
> Why not handle the potential error sent here?

I don't know how it should be handled (these functions don't return anything).
I assumed that since it is not currently being handled, it's probably not
useful.

I'll look into it though. I guess we could simply log it at the very least.

Thanks!

	- Anirudh.
