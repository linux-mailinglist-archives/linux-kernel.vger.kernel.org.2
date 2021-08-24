Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9F933F61D3
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 17:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238304AbhHXPkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 11:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237906AbhHXPkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 11:40:19 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A60ECC061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 08:39:34 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id lc21so12838417ejc.7
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 08:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=MklQtxppJU9/wteD80SlasLjW5xkfDSiebnSUSQ19Hw=;
        b=NdFXObAT+ku/DrVpXPIXU7LcZvcTC60Tji//NsqcC7EjQav0KCjYjEOlsxFUc2RdnP
         H9WXkQb1bzwUwwWASnZ2+G7H7d1hisEb39dLU/eU/ltgsAFPERezcNV01th6C1bSRNwW
         UtAv1QUOeQj+QPjo2hwQOn5GG1cHQuaxgCx1jNzphLM/h/6BsTHyGU74nvv9kcch3KMp
         oQb1CaYjXNB9p46osJwOgnkzUCkfTUDH6THFke5pgQpDXx91U5MYP/NQ46URlCq4dTcV
         RFRHjxADZ/VHaR/seEpHOTShw/RiRRB9WVuJsdtfx+HVVyqQGkoIV2CNUDUTokttdfO+
         1ydg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MklQtxppJU9/wteD80SlasLjW5xkfDSiebnSUSQ19Hw=;
        b=ElxZUSKnSWxqzAGVwDEwGGrLwF7sku8KJ6HJkODfQ48PJmG1UYUFyhM6rpCx/MH59c
         RrKAUDU5CwKzaDiDy70fmQXl5OAS4UQxWSC3+dEZJA0xpzaqx3PSsVBMBj5PFNYjosG5
         TnTcEv9fXOn+6QHhY+xhhXkQpmEz0oKo7e20rcKsoI8G70vbCotbHKj0xng/d9e9biOv
         IeGITGjWWZjWmoBOw6zlTL4QPkiyn4RouvkqlGfWESbHk/Z/zkbcdvpoXdKw2vGFA4om
         eVCWDkYk2Ebfg1+DvrKq3ALNpsZm6l73Djqxb4od85i5Y2TAWqZaUq8glCil8Tz+plcI
         7M8Q==
X-Gm-Message-State: AOAM533PqrEAhBEEV5SDhH16DvPAwaOmzfMYpniq4FmXcE+ZuIHeKlXG
        fT1jRXW5ffaoFJcLfN/v2IY=
X-Google-Smtp-Source: ABdhPJyhJbCRpOLdpDsYxJGNDvVtIZaz+q8IB+LCJoMpYUjbCzqnQeeebrW1hRWWI7rjhH0MIZMfNA==
X-Received: by 2002:a17:906:4bd6:: with SMTP id x22mr42306139ejv.270.1629819573325;
        Tue, 24 Aug 2021 08:39:33 -0700 (PDT)
Received: from localhost.localdomain (host-79-22-100-164.retail.telecomitalia.it. [79.22.100.164])
        by smtp.gmail.com with ESMTPSA id t5sm9498113ejr.37.2021.08.24.08.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 08:39:32 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Pavel Skripkin <paskripkin@gmail.com>
Subject: Re: [PATCH 2/2] staging: r8188eu: Make some clean-ups in usbctrl_vendorreq()
Date:   Tue, 24 Aug 2021 17:39:31 +0200
Message-ID: <2327592.S5L5zkRU50@localhost.localdomain>
In-Reply-To: <17234f07-debc-5b6c-244d-472a3f33bc3f@gmail.com>
References: <20210824142823.16845-1-fmdefrancesco@gmail.com> <3740714.KPokl01s95@localhost.localdomain> <17234f07-debc-5b6c-244d-472a3f33bc3f@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, August 24, 2021 5:26:23 PM CEST Pavel Skripkin wrote:
> I found the problem:
> 
> >  	mutex_lock(&dvobjpriv->usb_vendor_req_mutex);
> >  
> >  	/*  Acquire IO memory for vendorreq */
> > -	pIo_buf = dvobjpriv->usb_vendor_req_buf;
> > +	io_buf = dvobjpriv->usb_vendor_req_buf;
> 
> 
> I don't know from where mutex_lock() comes from. In staging-next I have
> 
> _enter_critical_mutex(&dvobjpriv->usb_vendor_req_mutex, NULL);
> 
> instead of
> 
> mutex_lock(&dvobjpriv->usb_vendor_req_mutex);
> 
Oh, I know where it comes from... :)

It's a patch of mine that is in the queue, waiting to be reviewed and applied.
Please see: https://lore.kernel.org/lkml/20210819221241.31987-1-fmdefrancesco@gmail.com/

Thanks,

Fabio
> 
> With regards,
> Pavel Skripkin
> 




