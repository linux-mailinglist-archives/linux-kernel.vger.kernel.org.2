Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71601434D1F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 16:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbhJTOMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 10:12:09 -0400
Received: from smtprelay0072.hostedemail.com ([216.40.44.72]:42508 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230061AbhJTOMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 10:12:08 -0400
Received: from omf10.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 61572180AA4FF;
        Wed, 20 Oct 2021 14:09:53 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf10.hostedemail.com (Postfix) with ESMTPA id 3F9FA2351F8;
        Wed, 20 Oct 2021 14:09:52 +0000 (UTC)
Message-ID: <157ee66fd0e3304c238e7ad8123277892e0d1132.camel@perches.com>
Subject: Re: [PATCH] staging: vt6655: Rename `dwAL2230InitTable` array
From:   Joe Perches <joe@perches.com>
To:     Karolina Drobnik <karolinadrobnik@gmail.com>,
        outreachy-kernel@googlegroups.com
Cc:     gregkh@linuxfoundation.org, forest@alittletooquiet.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Date:   Wed, 20 Oct 2021 07:09:51 -0700
In-Reply-To: <16db455b46f130300b5c346160aa434616e4f6b4.camel@perches.com>
References: <20211020132811.417341-1-karolinadrobnik@gmail.com>
         <16db455b46f130300b5c346160aa434616e4f6b4.camel@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 3F9FA2351F8
X-Spam-Status: No, score=-1.33
X-Stat-Signature: db47h45kcto3uyubc3dswmuqu1udcaas
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+7ZtfCGaoXFuHrrNFph+R13YjosvH3o3c=
X-HE-Tag: 1634738992-128745
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-10-20 at 06:44 -0700, Joe Perches wrote:
> trivial suggestion:
> 
> > diff --git a/drivers/staging/vt6655/rf.c b/drivers/staging/vt6655/rf.c
> []
> > @@ -33,7 +33,7 @@
> >  #define SWITCH_CHANNEL_DELAY_AL7230 200 /* us */
> >  #define AL7230_PWR_IDX_LEN    64
> >  
> > -static const unsigned long dwAL2230InitTable[CB_AL2230_INIT_SEQ] = {
> > +static const unsigned long al2230_init_table[CB_AL2230_INIT_SEQ] = {
> >  	0x03F79000 + (BY_AL2230_REG_LEN << 3) + IFREGCTL_REGW,
> >  	0x03333100 + (BY_AL2230_REG_LEN << 3) + IFREGCTL_REGW,
> >  	0x01A00200 + (BY_AL2230_REG_LEN << 3) + IFREGCTL_REGW,
> 
> In this file there are more than 100 uses of
> 
> 	(BY_AL2230_REG_LEN << 3) + IFREGCTL_REGW
> 
> Maybe add a define for it and substitute the uses for the define.

Look at the code too.

It looks as if every use of IFRFbWriteEmbedded() has this added to
the 2nd argument and that the 2nd argument isn't used anywhere else.

Maybe remove it altogether and add it to IFRFbWriteEmbedded().

And it looks as if the + uses for these should logically be |

Something like:

diff --git a/drivers/staging/vt6655/rf.c b/drivers/staging/vt6655/rf.c
index 0dae593c6944f..26803f6f9a27b 100644
--- a/drivers/staging/vt6655/rf.c
+++ b/drivers/staging/vt6655/rf.c
@@ -498,7 +498,8 @@ bool IFRFbWriteEmbedded(struct vnt_private *priv, unsigned long dwData)
        unsigned short ww;
        unsigned long dwValue;
 
-       VNSvOutPortD(iobase + MAC_REG_IFREGCTL, dwData);
+       VNSvOutPortD(iobase + MAC_REG_IFREGCTL,
+                    dwData | (BY_AL2230_REG_LEN << 3) | IFREGCTL_REGW);
 
        /* W_MAX_TIMEOUT is the timeout period */
        for (ww = 0; ww < W_MAX_TIMEOUT; ww++) {


