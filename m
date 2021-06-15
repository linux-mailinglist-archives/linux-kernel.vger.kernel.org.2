Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D14343A8AE1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 23:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbhFOVRg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 17:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbhFOVRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 17:17:35 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78DCCC061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 14:15:30 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id n7so149247wri.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 14:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6hvY4p5FF5eRnjuVWtkxhk1sjqpIeEICM36lTpspsRo=;
        b=UNOtbmg8IykFWJLTe3LZrUM4+emn9ygP8Nv4M3/uEvjow42Pcb416HxY+4EHahSdUU
         tC559WSm7kLd8z6ITAzHvA1XM08bIpw9z9CW4fqEWt614jnc2B6mIhsawAyI0e7/8owk
         l92MiF/aan37AdvW06wh4j+2s12JAyL96I0/J4uZHB97CpieJ4JhoidZ1kR9U8mIvtsd
         EwN8x3rRq3RPYw907Cev0iP/DhVhhstIcxe7x3cXbdJMIexmeNhHYipaPG0CjEEAyWu+
         LZcBm3eIsF95JPoyv/47eX7K+oeR386PDpjeMLJp45+TWRD19IBaAQPktB9hK6JHliAJ
         Pn1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6hvY4p5FF5eRnjuVWtkxhk1sjqpIeEICM36lTpspsRo=;
        b=XsmkMqZUqoqU2RD+hcDQ+ZkcVKzgYs65CKW3CqwYMECNQmUy5DLC8e8Lo6R+Ld3rVX
         PkofKORpZOXGF8BqX2JCq8r4ZCcCKo9lTifkklUXWfcYQohzPbF8reLR6XMdvkCmE2PL
         FuX6ZJo+Em2doPBJuNFZces89mDVEiTAZRgfeObZ1hVYoIXz7RN1VPQ7ihRpGuYmQxQK
         oxeCFg/m7lo4RzWO53by7Hz2H9JT6yT2tsI0fctzz0O60r4SvK2/kNxOXaaNCwfbQSuF
         NLZd/OdmkXbjK9h7Zni0c8f15iQcvSpoKc1YFUg0LrOri4/xsLsYcQhJiTYmOhse0Qc8
         vD4A==
X-Gm-Message-State: AOAM533rWY4mohf4eo+q4VRSz+ij8cInGiNNqqyp3Y7VHe0TcAhpFT+h
        5koLi967yrCMVQ2YTUqQKH3TFrCUMYhLOyyB2mI=
X-Google-Smtp-Source: ABdhPJztyfH6kHtajiE7qiBm6RgPWmSj0Q+K26uQGnvOp3Fi0OO9sbkUR3pRTNVBepiTBY7SFOuYmw==
X-Received: by 2002:adf:de91:: with SMTP id w17mr1256773wrl.352.1623791729144;
        Tue, 15 Jun 2021 14:15:29 -0700 (PDT)
Received: from KernelVM (2.0.5.1.1.6.3.8.5.c.c.3.f.b.d.3.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16:0:3dbf:3cc5:8361:1502])
        by smtp.gmail.com with ESMTPSA id u15sm3032636wmq.48.2021.06.15.14.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 14:15:28 -0700 (PDT)
Date:   Tue, 15 Jun 2021 22:15:26 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH 03/28] staging: rtl8188eu: remove all DBG_88E calls from
 core/rtw_mlme_ext.c
Message-ID: <YMkYbs9pV7IbZnMo@KernelVM>
References: <20210615001507.1171-1-phil@philpotter.co.uk>
 <20210615001507.1171-4-phil@philpotter.co.uk>
 <20210615103213.GA1861@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210615103213.GA1861@kadam>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2021 at 01:32:13PM +0300, Dan Carpenter wrote:
> On Tue, Jun 15, 2021 at 01:14:42AM +0100, Phillip Potter wrote:
> > @@ -4510,8 +4311,7 @@ void mlmeext_joinbss_event_callback(struct adapter *padapter, int join_res)
> >  	rtw_lps_ctrl_wk_cmd(padapter, LPS_CTRL_CONNECT, 0);
> >  
> >  exit_mlmeext_joinbss_event_callback:
> > -
> > -	DBG_88E("=>%s\n", __func__);
> > +	return;
> >  }
> 
> You'll have to delete the return and the exit_mlmeext_joinbss_event_callback
> label in a follow on patch because it introduces a checkpatch warning.
> 
> (I'm not concerned about introducing checkpatch warnings in this patch
> too much because fixing them in one got makes the patch a little more
> complicated to review.  So it's not necessarily even a wrong thing to
> introduce a checkpatch warning.  Just remember to remove it later.  Or
> don't remember because eventually someone else will take care of it).
> 
> regards,
> dan carpenter
> 
> >  
> >  void mlmeext_sta_add_event_callback(struct adapter *padapter, struct sta_info *psta)
>  

Dear Dan,

Thanks, I'll get this done.

Regards,
Phil
