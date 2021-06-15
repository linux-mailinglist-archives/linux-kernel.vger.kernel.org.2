Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77CE33A8AA6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 23:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbhFOVK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 17:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbhFOVKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 17:10:24 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86188C061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 14:08:17 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id a20so174872wrc.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 14:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VVilFD7y7XJejzpH0dguw8CgGpWDGbcVyEGSIt/+L/0=;
        b=Sp55F63FpaNCjVBgeIiILm/pKsGhhnGfS1BqQvCs1A0ekSVqblDqmV4hbxfNtDhA6Z
         XlE6ztG4YhYH70x62JPhRdGPqNlgYI5DNcHpB3q1w1bhKM07RsOTwQx1CqWAhkpzUawp
         rhao60vZ3ziTOCtGdbvI2Cf1kgVt/J6AWMz7zfWBAlZmx+GC2h+Us9CVdoHlS5Ix3ptn
         YvSlggo/y7tHmN49kDgzgY8FiEfrLcoMSOjP/L72piExJgZ6jOJeMK48PzhB8aIdbG1x
         yVZoJA+S5tGutFdBPcjhfK82LFwmpHVNIuEjFTfS6hcUsG5puQB53tkMagqmcFqQ8JIF
         X13w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VVilFD7y7XJejzpH0dguw8CgGpWDGbcVyEGSIt/+L/0=;
        b=JBkkHLaU97Ayo26ahY1JraJabsKjImCn1T1S4rIrVbHn1MTOwPYlSgQZcTYE1kk7uo
         LDN87tfPTm1zbE6pd753xuP96FBt2bDsyaahAVbhAfFjSJjJ+lZP05bcXgBAUYkV2cFU
         Gx/NdT4MOAVKElNIYlGYVGdv9GI4aHXsh7Xkby9EoMXZlXgYhpVcuOH5Y6SFEm1ArSAK
         zVmJ22t+QS5mbfjBZ3R/MX9S9HVnOPbLiu8+lhmx1f0GCFEi0NiaNjy1ejdfKEHmXNhh
         ohoHc1oEi24r+Szt6zcILGvVR3gMLKIgzdiJbVdtMP3h5XTu8AlUiX3Bg0zEfEi40sG7
         NWNg==
X-Gm-Message-State: AOAM5315OQTvvtfiOt2jqm/OUPxObNA18ss0R5bLK1cQREoIIMoEpUEC
        MuQqzNFLLu1x5mXxiSKPZIoaj4RWFqOt7j/LtMA=
X-Google-Smtp-Source: ABdhPJw7VMsg6uxlox3QcHexz7/bh6T5pRad1ldjJQIVvm6lwhiMyQ63+s3lgV0J4TqYHzS81MXVSQ==
X-Received: by 2002:a05:6000:188:: with SMTP id p8mr1214773wrx.296.1623791296196;
        Tue, 15 Jun 2021 14:08:16 -0700 (PDT)
Received: from KernelVM (2.0.5.1.1.6.3.8.5.c.c.3.f.b.d.3.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16:0:3dbf:3cc5:8361:1502])
        by smtp.gmail.com with ESMTPSA id x7sm82755wrn.3.2021.06.15.14.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 14:08:15 -0700 (PDT)
Date:   Tue, 15 Jun 2021 22:08:14 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH 22/28] staging: rtl8188eu: remove all DBG_88E calls from
 hal/usb_halinit.c
Message-ID: <YMkWviuAT/U/hbc3@KernelVM>
References: <20210615001507.1171-1-phil@philpotter.co.uk>
 <20210615001507.1171-23-phil@philpotter.co.uk>
 <20210615124159.GB1861@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210615124159.GB1861@kadam>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2021 at 03:41:59PM +0300, Dan Carpenter wrote:
> On Tue, Jun 15, 2021 at 01:15:01AM +0100, Phillip Potter wrote:
> > @@ -1685,8 +1658,6 @@ void rtw_hal_set_hwreg(struct adapter *Adapter, u8 variable, u8 *val)
> >  					if (!(usb_read32(Adapter, REG_RXPKT_NUM) & RXDMA_IDLE))
> >  						break;
> >  				} while (trycnt--);
> > -				if (trycnt == 0)
> > -					DBG_88E("Stop RX DMA failed......\n");
> 
> Not related to your patch but this loop will exit with trycnt == -1 not
> 0.
> 
> There should be a Smatch warning for this.  Also Smatch doesn't handle
> while count down loops very well...  It takes the short cut of
> assuming that all do while loops have a break statement.
> 
> regards,
> dan carpenter
> 
> >  
> >  				/* RQPN Load 0 */
> >  				usb_write16(Adapter, REG_RQPN_NPQ, 0x0);
> 

Dear Dan,

Thanks for your feedback, I will try and take a look at this.

Regards,
Phil
