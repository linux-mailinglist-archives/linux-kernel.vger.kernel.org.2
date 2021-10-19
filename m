Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BED5432D87
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 07:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233793AbhJSF7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 01:59:10 -0400
Received: from smtprelay0198.hostedemail.com ([216.40.44.198]:35408 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229649AbhJSF7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 01:59:05 -0400
Received: from omf02.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 133CD181116D0;
        Tue, 19 Oct 2021 05:56:53 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf02.hostedemail.com (Postfix) with ESMTPA id 025031D42F8;
        Tue, 19 Oct 2021 05:56:51 +0000 (UTC)
Message-ID: <84f3c940fedb961e6e7e88d47c3d15e598bc32c3.camel@perches.com>
Subject: Re: [PATCH] staging: vt6655: Fix line wrapping in rf.c file
From:   Joe Perches <joe@perches.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Karolina Drobnik <karolinadrobnik@gmail.com>
Cc:     outreachy-kernel@googlegroups.com, forest@alittletooquiet.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Date:   Mon, 18 Oct 2021 22:56:50 -0700
In-Reply-To: <YW2O3wC8wMEKS3Ub@kroah.com>
References: <20211018150526.9718-1-karolinadrobnik@gmail.com>
         <YW2O3wC8wMEKS3Ub@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 025031D42F8
X-Spam-Status: No, score=-2.87
X-Stat-Signature: eeeq9qywtpxqartas58aq67pafcahnmh
X-Rspamd-Server: rspamout01
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/2/phKbIy8pBbM0Z2u8jiNpMM0LZiwe4E=
X-HE-Tag: 1634623011-970353
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-10-18 at 17:12 +0200, Greg KH wrote:
> On Mon, Oct 18, 2021 at 04:05:26PM +0100, Karolina Drobnik wrote:
> > Fix line length warnings raised by checkpatch.pl in
> > rf.c file for `RFvWriteWakeProgSyn`,`RFbRawSetPower`
> > and `RFbAL7230SelectChannelPostProcess`functions.
> > 
> > Signed-off-by: Karolina Drobnik <karolinadrobnik@gmail.com>
> > ---
> >  drivers/staging/vt6655/rf.c | 66 +++++++++++++++++++++++++++----------
> >  1 file changed, 49 insertions(+), 17 deletions(-)
> > 
> > diff --git a/drivers/staging/vt6655/rf.c b/drivers/staging/vt6655/rf.c
> > index a6f17162d017..206d34b555bc 100644
> > --- a/drivers/staging/vt6655/rf.c
> > +++ b/drivers/staging/vt6655/rf.c
> > @@ -699,11 +699,17 @@ bool RFvWriteWakeProgSyn(struct vnt_private *priv, unsigned char byRFType,
> >  			return false;
> >  
> >  		for (ii = 0; ii < CB_AL2230_INIT_SEQ; ii++)
> > -			MACvSetMISCFifo(priv, (unsigned short)(MISCFIFO_SYNDATA_IDX + ii), dwAL2230InitTable[ii]);
> > +			MACvSetMISCFifo(priv,
> > +					(unsigned short)(MISCFIFO_SYNDATA_IDX + ii),
> > +					dwAL2230InitTable[ii]);
> >  
> > -		MACvSetMISCFifo(priv, (unsigned short)(MISCFIFO_SYNDATA_IDX + ii), dwAL2230ChannelTable0[uChannel - 1]);
> > +		MACvSetMISCFifo(priv,
> > +				(unsigned short)(MISCFIFO_SYNDATA_IDX + ii),
> > +				dwAL2230ChannelTable0[uChannel - 1]);
> >  		ii++;
> > -		MACvSetMISCFifo(priv, (unsigned short)(MISCFIFO_SYNDATA_IDX + ii), dwAL2230ChannelTable1[uChannel - 1]);
> > +		MACvSetMISCFifo(priv,
> > +				(unsigned short)(MISCFIFO_SYNDATA_IDX + ii),
> > +				dwAL2230ChannelTable1[uChannel - 1]);
> >  		break;
> >  
> >  		/* Need to check, PLLON need to be low for channel setting */
> > @@ -716,17 +722,28 @@ bool RFvWriteWakeProgSyn(struct vnt_private *priv, unsigned char byRFType,
> >  
> >  		if (uChannel <= CB_MAX_CHANNEL_24G) {
> >  			for (ii = 0; ii < CB_AL7230_INIT_SEQ; ii++)
> > -				MACvSetMISCFifo(priv, (unsigned short)(MISCFIFO_SYNDATA_IDX + ii), dwAL7230InitTable[ii]);
> > +				MACvSetMISCFifo(priv,
> > +						(unsigned short)(MISCFIFO_SYNDATA_IDX
> > +						+ ii), dwAL7230InitTable[ii]);
> 
> You shouldn't put the "+" on the start of a new line.
> 
> Also, these are all just fine as-is for now.  A better way to make these
> lines smaller is to use better variable and function names that are
> shorter and make sense :)

And maybe use temporaries for the multiply used
MISCFIFO_SYNDATA_IDX + ii and a few other changes.

Maybe some refactoring like:
---
 drivers/staging/vt6655/rf.c | 38 ++++++++++++++++++--------------------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/drivers/staging/vt6655/rf.c b/drivers/staging/vt6655/rf.c
index 0dae593c6944f..7beb0cd5a62df 100644
--- a/drivers/staging/vt6655/rf.c
+++ b/drivers/staging/vt6655/rf.c
@@ -680,16 +680,19 @@ bool RFvWriteWakeProgSyn(struct vnt_private *priv, unsigned char byRFType,
 			 u16 uChannel)
 {
 	void __iomem *iobase = priv->PortOffset;
-	int   ii;
+	int i;
+	unsigned short idx = MISCFIFO_SYNDATA_IDX;
 	unsigned char byInitCount = 0;
 	unsigned char bySleepCount = 0;
+	const unsigned long *data;
 
+	uChannel--;
 	VNSvOutPortW(iobase + MAC_REG_MISCFFNDEX, 0);
+
 	switch (byRFType) {
 	case RF_AIROHA:
 	case RF_AL2230S:
-
-		if (uChannel > CB_MAX_CHANNEL_24G)
+		if (uChannel >= CB_MAX_CHANNEL_24G)
 			return false;
 
 		 /* Init Reg + Channel Reg (2) */
@@ -698,12 +701,12 @@ bool RFvWriteWakeProgSyn(struct vnt_private *priv, unsigned char byRFType,
 		if (byInitCount > (MISCFIFO_SYNDATASIZE - bySleepCount))
 			return false;
 
-		for (ii = 0; ii < CB_AL2230_INIT_SEQ; ii++)
-			MACvSetMISCFifo(priv, (unsigned short)(MISCFIFO_SYNDATA_IDX + ii), dwAL2230InitTable[ii]);
+		data = dwAL2230InitTable;
+		for (i = 0; i < CB_AL2230_INIT_SEQ; i++)
+			MACvSetMISCFifo(priv, idx++, *data++);
 
-		MACvSetMISCFifo(priv, (unsigned short)(MISCFIFO_SYNDATA_IDX + ii), dwAL2230ChannelTable0[uChannel - 1]);
-		ii++;
-		MACvSetMISCFifo(priv, (unsigned short)(MISCFIFO_SYNDATA_IDX + ii), dwAL2230ChannelTable1[uChannel - 1]);
+		MACvSetMISCFifo(priv, idx++, dwAL2230ChannelTable0[uChannel]);
+		MACvSetMISCFifo(priv, idx++, dwAL2230ChannelTable1[uChannel]);
 		break;
 
 		/* Need to check, PLLON need to be low for channel setting */
@@ -714,19 +717,14 @@ bool RFvWriteWakeProgSyn(struct vnt_private *priv, unsigned char byRFType,
 		if (byInitCount > (MISCFIFO_SYNDATASIZE - bySleepCount))
 			return false;
 
-		if (uChannel <= CB_MAX_CHANNEL_24G) {
-			for (ii = 0; ii < CB_AL7230_INIT_SEQ; ii++)
-				MACvSetMISCFifo(priv, (unsigned short)(MISCFIFO_SYNDATA_IDX + ii), dwAL7230InitTable[ii]);
-		} else {
-			for (ii = 0; ii < CB_AL7230_INIT_SEQ; ii++)
-				MACvSetMISCFifo(priv, (unsigned short)(MISCFIFO_SYNDATA_IDX + ii), dwAL7230InitTableAMode[ii]);
-		}
+		data = (uChannel < CB_MAX_CHANNEL_24G) ?
+			dwAL7230InitTable : dwAL7230InitTableAMode;
+		for (i = 0; i < CB_AL7230_INIT_SEQ; i++)
+			MACvSetMISCFifo(priv, idx++, *data++);
 
-		MACvSetMISCFifo(priv, (unsigned short)(MISCFIFO_SYNDATA_IDX + ii), dwAL7230ChannelTable0[uChannel - 1]);
-		ii++;
-		MACvSetMISCFifo(priv, (unsigned short)(MISCFIFO_SYNDATA_IDX + ii), dwAL7230ChannelTable1[uChannel - 1]);
-		ii++;
-		MACvSetMISCFifo(priv, (unsigned short)(MISCFIFO_SYNDATA_IDX + ii), dwAL7230ChannelTable2[uChannel - 1]);
+		MACvSetMISCFifo(priv, idx++, dwAL7230ChannelTable0[uChannel]);
+		MACvSetMISCFifo(priv, idx++, dwAL7230ChannelTable1[uChannel]);
+		MACvSetMISCFifo(priv, idx++, dwAL7230ChannelTable2[uChannel]);
 		break;
 
 	case RF_NOTHING:


