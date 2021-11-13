Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAAB444F223
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 09:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235733AbhKMIWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Nov 2021 03:22:25 -0500
Received: from smtprelay0094.hostedemail.com ([216.40.44.94]:50104 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230095AbhKMIWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Nov 2021 03:22:24 -0500
Received: from omf20.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 8A8DA837F24D;
        Sat, 13 Nov 2021 08:19:31 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf20.hostedemail.com (Postfix) with ESMTPA id 7C4B780193D0;
        Sat, 13 Nov 2021 08:19:30 +0000 (UTC)
Message-ID: <f4ac00433f64d0637f5bbcf19b631072bddad097.camel@perches.com>
Subject: Re: [PATCH] Staging: mt7621-dma: reindent to avoid '(' at the end
 of line
From:   Joe Perches <joe@perches.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Liu Junqi <liujunqi@pku.edu.cn>
Cc:     linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Sat, 13 Nov 2021 00:19:29 -0800
In-Reply-To: <YY9xD1K0cUpc5iCW@kroah.com>
References: <20211113052815.358793-1-liujunqi@pku.edu.cn>
         <YY9xD1K0cUpc5iCW@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Stat-Signature: k4wax484oj33isr6s7ng4qkrgrpfxddc
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 7C4B780193D0
X-Spam-Status: No, score=-4.78
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/bjIbunX20jf5R9k4knLoAmPpVgNYPdLo=
X-HE-Tag: 1636791570-751348
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2021-11-13 at 09:02 +0100, Greg KH wrote:
> On Sat, Nov 13, 2021 at 01:28:15PM +0800, Liu Junqi wrote:
> > Fixed a coding style issue.

This isn't really a fix, but instead is a change to make
the code more like typical coding style.

> > diff --git a/drivers/staging/mt7621-dma/hsdma-mt7621.c b/drivers/staging/mt7621-dma/hsdma-mt7621.c
[]
> > @@ -455,9 +455,9 @@ static void mtk_hsdma_issue_pending(struct dma_chan *c)
> >  	spin_unlock_bh(&chan->vchan.lock);
> >  }
> >  
> > -static struct dma_async_tx_descriptor *mtk_hsdma_prep_dma_memcpy(
> > -		struct dma_chan *c, dma_addr_t dest, dma_addr_t src,
> > -		size_t len, unsigned long flags)
> > +static struct dma_async_tx_descriptor
> > +*mtk_hsdma_prep_dma_memcpy(struct dma_chan *c, dma_addr_t dest, dma_addr_t src,
> 
> No, this is now worse looking.  The original was not pretty, but better
> than this.

More typical would be to have the return value on a separate line
as using * on the start of a line is poor form in the kernel.

static struct dma_async_tx_descriptor *
mtk_hsdma_prep_dma_memcpy(struct dma_chan *c, dma_addr_t dest, dma_addr_t src,
			  size_t len, unsigned long flags)
{
	...
}

