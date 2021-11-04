Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C62C445590
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 15:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbhKDOrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 10:47:04 -0400
Received: from smtprelay0163.hostedemail.com ([216.40.44.163]:57898 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229505AbhKDOrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 10:47:03 -0400
Received: from omf17.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id B0279100E39D7;
        Thu,  4 Nov 2021 14:44:24 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf17.hostedemail.com (Postfix) with ESMTPA id 7FB8E27DD2E;
        Thu,  4 Nov 2021 14:44:23 +0000 (UTC)
Message-ID: <2fd61a94d8cacd2626364bd25eace6b141ad1766.camel@perches.com>
Subject: Re: [PATCH v2 2/8] staging: vt6655: Use incrementation in `idx`
From:   Joe Perches <joe@perches.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Karolina Drobnik <karolinadrobnik@gmail.com>
Cc:     outreachy-kernel@googlegroups.com, gregkh@linuxfoundation.org,
        forest@alittletooquiet.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Date:   Thu, 04 Nov 2021 07:44:22 -0700
In-Reply-To: <20211104130002.GB2794@kadam>
References: <cover.1635773679.git.karolinadrobnik@gmail.com>
         <c569952d92ba51f32679c2fd87fd48ad8e49e3fc.1635773680.git.karolinadrobnik@gmail.com>
         <20211104130002.GB2794@kadam>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 7FB8E27DD2E
X-Spam-Status: No, score=-4.83
X-Stat-Signature: ep881gbq347uy7ahrk6xgk3dhyd6tu9d
X-Rspamd-Server: rspamout04
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19ixAMsINbAfb1jxWtTpSMffg2+Q5qb+rg=
X-HE-Tag: 1636037063-692601
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-11-04 at 16:00 +0300, Dan Carpenter wrote:
> On Mon, Nov 01, 2021 at 02:32:00PM +0000, Karolina Drobnik wrote:
> > Increment `idx` in a loop instead of adding the loop counter
> > `i` to do so. Thanks to this change, the cast to unsigned short
> > can be removed.
> > 
> > Signed-off-by: Karolina Drobnik <karolinadrobnik@gmail.com>
> > ---
> >  drivers/staging/vt6655/rf.c | 16 ++++++++--------
> >  1 file changed, 8 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/staging/vt6655/rf.c b/drivers/staging/vt6655/rf.c
[]
> > @@ -700,11 +700,11 @@ bool RFvWriteWakeProgSyn(struct vnt_private *priv, unsigned char rf_type,
> >  			return false;
> >  
> >  		for (i = 0; i < CB_AL2230_INIT_SEQ; i++)
> > -			MACvSetMISCFifo(priv, (unsigned short)(idx + i), al2230_init_table[i]);
> > +			MACvSetMISCFifo(priv, idx++, al2230_init_table[i]);
> 
> Of course, idx is no longer a constant so declaring it as a variable
> makes sense here.  But maybe just do it in the same patch because the
> patch 1/1 doesn't make sense as a stand alone patch.
> 
> Also don't declare idx as an unsigned short.  It's better to declare it
> as a int so it just works like a normal number and you don't have to
> think about signedness bugs and wrapping and edge cases.

No, IMO it really should be a u16.
Look at the iowrite16() within the call to MACvSetMISCFifo.


