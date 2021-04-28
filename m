Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A368F36D4F5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 11:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238220AbhD1JsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 05:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbhD1JsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 05:48:23 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C955FC061574
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 02:47:38 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id k4-20020a7bc4040000b02901331d89fb83so8416189wmi.5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 02:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=kCEJkDjUldkGqpI2Ey6ungf76uryF6iJHDXmu3GitbA=;
        b=V488IdhAmD7JJk26f2oLEFm5EDhW/yMdOp5MGvjrv8vSXbLvV0uUVxRmvTBEA/ZzK/
         BuQ5pyb07laXNxWGyuyxXNYqr0XBxghg1iP+3WsvaGqEj9nZ0/mbhTr9qNr2rPNw0WsE
         m6i8/hNY0iyDu9MT/2oandgCKiK09Bw8dcB39RvymMINFM3BiGsHKx1EnUickpRyptb1
         BDHakCr5h3yvJkrRqvEMUiVJPZ5iKsS/x89hdgkt1zGuRIHIrQdmoPZo64JucMGZOpWV
         C4qfwskeT85Gcfif1LhyOFc7qdXkV2n2GOfjoKqZaZQTwDDWe0lsuLs9PiE5kR3Je/la
         hdvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=kCEJkDjUldkGqpI2Ey6ungf76uryF6iJHDXmu3GitbA=;
        b=Fq7KGFgPkCT8wpZVWd+CRUWLoHMGQFhgGnokt5MWRBsdL8ofyRMm/4mjRqIDjO3z5w
         YciD5XsuyqqPXNOSBTUsM1yRFnWZFzBlR6KlAKG+Ux8F/tMLppCPamacR2i0+1BsxnFE
         OHOwZgedn+yDTP8PHQJj0hhXZcEkCHxcjAR+RDRNgwC6oB7B7B2QhSUX1PIQjPi3cILw
         Tc+OATCvHOM6LwixVcN8ek/zArsko79yjHWSWaFWnmv5W1cPxPS0DxNEKSX+/1ij/OHs
         zdBujM4R4Hy/ZKCh0Py+0H/Zp0xdp/qdF7dZ1vdM3u8QeL9vdiS7ZJR6r1l8bbt4rp5a
         NiJw==
X-Gm-Message-State: AOAM532fNp6X51QnpIGeyIlvmpMUXbqDGmbKPKhBuvfgQ4hRu4nzt3uq
        rks15uIRpWnZBJZ2qKGAYRQrF9iFXeCAfg==
X-Google-Smtp-Source: ABdhPJzh7DMabp5UV8qga875WMkAqhF4SIchYnA/7/qnzV8GDCDZa8XIhpZs+qS11n5mR7seS7CnmA==
X-Received: by 2002:a7b:c047:: with SMTP id u7mr3494159wmc.98.1619603257592;
        Wed, 28 Apr 2021 02:47:37 -0700 (PDT)
Received: from agape.jhs ([5.171.72.119])
        by smtp.gmail.com with ESMTPSA id m11sm7609619wri.44.2021.04.28.02.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 02:47:37 -0700 (PDT)
Date:   Wed, 28 Apr 2021 11:47:34 +0200
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Joe Perches <joe@perches.com>, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/49] staging: rtl8723bs: replace DBG_871X_SEL log macro
 with netdev_dbg()
Message-ID: <20210428094733.GA1427@agape.jhs>
References: <cover.1619189489.git.fabioaiuto83@gmail.com>
 <9e6a1e4dc8962bfd58375be98619c76e8e28febe.1619189489.git.fabioaiuto83@gmail.com>
 <0a68fbfffba4cc801814e3af1e3a7571928c1921.camel@perches.com>
 <20210423165249.GA1419@agape.jhs>
 <20210428092842.GQ1981@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210428092842.GQ1981@kadam>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2021 at 12:28:42PM +0300, Dan Carpenter wrote:
> On Fri, Apr 23, 2021 at 06:52:49PM +0200, Fabio Aiuto wrote:
> > On Fri, Apr 23, 2021 at 08:27:58AM -0700, Joe Perches wrote:
> > > On Fri, 2021-04-23 at 16:57 +0200, Fabio Aiuto wrote:
> > > > replace DBG_871X_SEL log macro with the net device driver
> > > > recommended netdev_dbg().
> > > > 
> > > > This macro by default does a raw printk, and the alternative
> > > > behaviour, never triggered is a seq_print() call.
> > > []
> > > > diff --git a/drivers/staging/rtl8723bs/core/rtw_debug.c b/drivers/staging/rtl8723bs/core/rtw_debug.c
> > > []
> > > > @@ -23,9 +23,10 @@ void mac_reg_dump(void *sel, struct adapter *adapter)
> > > >  	for (i = 0x0; i < 0x800; i += 4) {
> > > >  		if (j%4 == 1)
> > > >  			netdev_dbg(adapter->pnetdev, "0x%03x", i);
> > > > -		DBG_871X_SEL(sel, " 0x%08x ", rtw_read32(adapter, i));
> > > > +		netdev_dbg(adapter->pnetdev, " 0x%08x ",
> > > > +			   rtw_read32(adapter, i));
> > > >  		if ((j++)%4 == 0)
> > > > -			DBG_871X_SEL(sel, "\n");
> > > > +			netdev_dbg(adapter->pnetdev, "\n");
> > > >  	}
> > > 
> > > This makes a mess of the output as each netdev_dbg call
> > > is a separate line.
> > > 
> > > Dumping 1000 register lines into output logs seems impolite
> > > at best, even for debugging.
> > > 
> > > This _might_ be rewritten to something like:
> > > 
> > > void dump_4_regs(struct adapter *adapter, int offset)
> > > {
> > > 	u32 reg[4];
> > > 	int i;
> > > 
> > > 	for (i = 0; i < 4; i++)
> > > 		reg[i] = rtw_read32(adapter, offset + i);
> > > 
> > > 	netdev_dbg(adapter->pnetdev, "0x%03x 0x%08x 0x%08x 0x%08x 0x%08x\n",
> > > 		   i, reg[0], reg[1], reg[2], reg[3]);
> > > }
> > > 
> > > void mac_reg_dump(...)
> > > {
> > > 	...
> > > 
> > > 	for (i = 0; i < 0x800; i += 4)
> > > 		dump_4_regs(adapter, i);
> > > 
> > > 
> > > 
> > 
> > interesting, sure that will be matter of another patch series,
> > the ugly output was already there, old macro used to wrap a raw
> > printk...
> 
> The raw printk doesn't automatically add a new line at the end but a
> netdev_dbg() does.  (You're still supposed to add a manual \n to those
> but if you don't the lower layers will do it automatically.)
> 
> regards,
> dan carpenter

got it,

thank you,

fabio
