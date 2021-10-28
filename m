Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E213A43E03C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 13:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbhJ1LvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 07:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbhJ1LvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 07:51:10 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB3EC061570
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 04:48:43 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 5so23033644edw.7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 04:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oFqtoBu84uWB8xzASyVCnCV1AZJEfiefbpv4BLpVjpM=;
        b=TCUTveglvKDDEt/ik1JrJRQ/hMmJYm3SL9PYaVti2YTY4ZIFfDrOOUojBW+L8EyJKe
         0RF9fbwNuLo5D8ODajEQMJjjCcynLvWtSQfSETZpTJ7LIz1BCKBabYj44gfBH18TWLHu
         eLwgjm6SWwKWWsNigU1HtZaCSgqp2ASOcIAuLhrWf9MPkPO6mrsZRjO6UPq+B3PV1KHF
         5hW3E9UygIiNmU+vAxKyQUAcsE4+DWr/XAbdZvg2eaNPMjWqABliYF4X5erYb2Lnx+vP
         OoEj+6yE9rbv2y0hTsUYxBZ4MhPSYCsgS7y3//a6HY1La2ennBTp8mMh48zgMeQTuAAS
         DAOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oFqtoBu84uWB8xzASyVCnCV1AZJEfiefbpv4BLpVjpM=;
        b=ogxATXqpUEFho0MbBBDkEavvUoI15ZeCMXtRMwrEM7pCdFoM1JhLSdn1olDK7rZ/Lh
         VA+PcOQ6NcpD5U+U/48aR2mzF+uIfxpixDtowkk3LL0tsP/XSnzrwDWPXv7m7EoYX55G
         fPvU1XoVwoDAJa55j18X0Bj3/NUf/br+0nVktGVXJXd7pgOq5mUwmAldrCboIdZ/y4wh
         6l8Q2jskYJy5JHTUTuKEWCX2A5Hc8G5JOhyHFj61HVT/MV63Ay/XyjJGJjZbb311Sf+w
         Qd19hbl4NMag4/knG8pMKUtFdOsm1VTJprbd2Hxn+/uNWgsMD2Sih3Vx99aZYLs+bFwA
         Xk7A==
X-Gm-Message-State: AOAM530jSQ8rWWIcfOIwUzt802IJBYO8+PaTteNyWJ2yMpDcTVXrdtpJ
        8CEJpAIB29i86+N2dgHlMLZxlf8uFtY=
X-Google-Smtp-Source: ABdhPJxkcb8+y8uTCDi/gw/MxEXVIwYyB6EgOMaNOknjyvWc9CI12chRKvBh2ze7FgF5ujq/gdUnxw==
X-Received: by 2002:a05:6402:5c2:: with SMTP id n2mr5437501edx.239.1635421721737;
        Thu, 28 Oct 2021 04:48:41 -0700 (PDT)
Received: from localhost.localdomain (host-79-56-54-101.retail.telecomitalia.it. [79.56.54.101])
        by smtp.gmail.com with ESMTPSA id i15sm1558045edk.2.2021.10.28.04.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 04:48:41 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     outreachy-kernel@googlegroups.com, gregkh@linuxfoundation.org,
        forest@alittletooquiet.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Karolina Drobnik <karolinadrobnik@gmail.com>,
        Karolina Drobnik <karolinadrobnik@gmail.com>
Subject: Re: [Outreachy kernel] [PATCH 4/7] staging: vt6655: Introduce `data` temporary variable
Date:   Thu, 28 Oct 2021 13:48:40 +0200
Message-ID: <39890856.3BBMun7449@localhost.localdomain>
In-Reply-To: <alpine.DEB.2.22.394.2110281332040.9518@hadrien>
References: <cover.1635415820.git.karolinadrobnik@gmail.com> <2039159.k92FijXA2m@localhost.localdomain> <alpine.DEB.2.22.394.2110281332040.9518@hadrien>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="US-ASCII"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, October 28, 2021 1:32:58 PM CEST Julia Lawall wrote:
> 
> On Thu, 28 Oct 2021, Fabio M. De Francesco wrote:
> 
> > On Thursday, October 28, 2021 12:35:34 PM CEST Karolina Drobnik wrote:
> > > Add a variable to store initialization tables. Use this variable
> > > in AL2230 initialization.
> > >
> > > Signed-off-by: Karolina Drobnik <karolinadrobnik@gmail.com>
> > > ---
> > >  drivers/staging/vt6655/rf.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/staging/vt6655/rf.c b/drivers/staging/vt6655/rf.c
> > > index ea74701917e5..afd202ea3356 100644
> > > --- a/drivers/staging/vt6655/rf.c
> > > +++ b/drivers/staging/vt6655/rf.c
> > > @@ -684,6 +684,7 @@ bool RFvWriteWakeProgSyn(struct vnt_private *priv,
> > unsigned char rf_type,
> > >  	unsigned short idx = MISCFIFO_SYNDATA_IDX;
> > >  	unsigned char init_count = 0;
> > >  	unsigned char sleep_count = 0;
> > > +	const unsigned long *data;
> > >
> > >  	VNSvOutPortW(iobase + MAC_REG_MISCFFNDEX, 0);
> > >  	switch (rf_type) {
> > > @@ -699,8 +700,9 @@ bool RFvWriteWakeProgSyn(struct vnt_private *priv,
> > unsigned char rf_type,
> > >  		if (init_count > (MISCFIFO_SYNDATASIZE - 
sleep_count))
> > >  			return false;
> > >
> > > +		data = al2230_init_table;
> > >  		for (i = 0; i < CB_AL2230_INIT_SEQ; i++)
> > > -			MACvSetMISCFifo(priv, idx++,
> > al2230_init_table[i]);
> > > +			MACvSetMISCFifo(priv, idx++, *(data++));
> >
> > Hi Karolina,
> >
> > I think you are using redundant parentheses in "* (data ++)" but 
understand
> > that those increments and dereferences are equivalent to "* data ++"
> > (according to the C precedence rules).
> >
> > Some time ago I suggested that you use those redundant parentheses 
because
> > Greg Kroah-Hartman had previously explained that he prefers not to see
> > "*foo++" because maintainers and reviewers are not required to remember 
the C
> > precedence rules.
> >
> > I hope my suggestion isn't based on a misunderstanding of what Greg wants
> > here and that your patch can be accepted as is.
> >
> > While we are at it, please notice that Maintainers of different 
subsystems
> > may see this topic from a different point of view and that they might 
very
> > well ask you for removing those redundant parentheses.
> >
> > I'd suggest to use grep and find out what is preferred in other 
subsystems,
> > when you want to contribute to other parts of Linux.
> 
> Would it be better as data[i] ?

In this case, yes for sure. It would be better because we are inside a 'for' 
loop where the code already as an "i" index.

I didn't notice that we are inside the loop and just looked at that increment 
and dereference for checking the proper syntax.

> 
> Could there be a better name than "data"?  Perhaps "table"?

Again, yes if we look at what "data" has been assigned with. 

Thanks,

Fabio

> 
> julia
> 
> 
> >
> > Thanks,
> >
> > Fabio
> >
> > >  		MACvSetMISCFifo(priv, idx++,
> > al2230_channel_table0[channel - 1]);
> > >  		MACvSetMISCFifo(priv, idx++,
> > al2230_channel_table1[channel - 1]);
> > > --
> > > 2.30.2
> > >
> > > --
> > > You received this message because you are subscribed to the Google 
Groups
> > "outreachy-kernel" group.
> > > To unsubscribe from this group and stop receiving emails from it, send 
an
> > email to outreachy-kernel+unsubscribe@googlegroups.com.
> > > To view this discussion on the web visit https://groups.google.com/d/
msgid/
> > outreachy-kernel/dc72a4c3539aed70569f66396ed3b51818bc2aea.
> > 1635415820.git.karolinadrobnik%40gmail.com.
> > >
> >
> >
> >
> >
> > --
> > You received this message because you are subscribed to the Google Groups 
"outreachy-kernel" group.
> > To unsubscribe from this group and stop receiving emails from it, send an 
email to outreachy-kernel+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/
msgid/outreachy-kernel/2039159.k92FijXA2m%40localhost.localdomain.
> >
> 




