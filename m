Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 532B536F495
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 05:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbhD3DjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 23:39:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:51532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229577AbhD3DjT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 23:39:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A38C6613AD;
        Fri, 30 Apr 2021 03:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619753911;
        bh=62xpBMMoN3AZUrRgY+gs+zkDlkkWnEMVFBR8/hvHmAk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TABji03Yc2Uz5RoeVSnlLiu5JYNByHXM+VxBtmA2AMCMABU2UkZL/cKctsGi2NC9V
         xibHvTMiOp+FB+uHYjLEt47QgseDRkjrt+Clp+sN/si4Ugp/GCV3B4kEQmoQQ9zN4F
         E/eQ+Q6BOetOlwciv9gJZLf9TLjCTfpRCyyTMddsL4qo3uB81jFsIXJlO2xGbrah4h
         KW+OkYFtMfhqH+mXivpPoABPBd+y9+gLYHOo9WpN6LK6xSiZWPo1NwBuPDLhgRuZvt
         xnpNgzxbt0HPRPCDC+GY73NUujxwwJQPl2vYdyOQNmrU4JiNcoX7vB383ZgxeS5+c5
         au/jB5TAA9ljQ==
Date:   Fri, 30 Apr 2021 11:38:26 +0800
From:   Peter Chen <peter.chen@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Souptick Joarder <jrdr.linux@gmail.com>, pawell@cadence.com,
        rogerq@kernel.org, a-govindraju@ti.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: cdns3: Corrected comment to align with
 kernel-doc comment
Message-ID: <20210430033826.GA3842@nchen>
References: <1619338565-4574-1-git-send-email-jrdr.linux@gmail.com>
 <8cbc9ed6-4499-642c-3b49-53e80974f004@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8cbc9ed6-4499-642c-3b49-53e80974f004@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-04-25 08:53:33, Randy Dunlap wrote:
> On 4/25/21 1:16 AM, Souptick Joarder wrote:
> > Minor update in comment.
> > 
> > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> > ---
> > v2:
> > 	Updated change logs and address review comment.
> 
> LGTM. Thanks.
> 
> Acked-by: Randy Dunlap <rdunlap@infradead.org>

Applied, thanks.

Peter

> 
> >  drivers/usb/cdns3/cdns3-gadget.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3-gadget.c
> > index 9b1bd41..21f026c 100644
> > --- a/drivers/usb/cdns3/cdns3-gadget.c
> > +++ b/drivers/usb/cdns3/cdns3-gadget.c
> > @@ -484,7 +484,7 @@ static void __cdns3_descmiss_copy_data(struct usb_request *request,
> >  }
> >  
> >  /**
> > - * cdns3_wa2_descmiss_copy_data copy data from internal requests to
> > + * cdns3_wa2_descmiss_copy_data - copy data from internal requests to
> >   * request queued by class driver.
> >   * @priv_ep: extended endpoint object
> >   * @request: request object
> > 
> 
> 
> -- 
> ~Randy
> 

-- 

Thanks,
Peter Chen

