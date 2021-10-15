Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9648342FA7C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 19:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241942AbhJORsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 13:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241633AbhJORsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 13:48:08 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6887DC061570
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 10:46:01 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id t2so27789198wrb.8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 10:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=027NmG7SxN43bQ3NJ7Xe8XTAw3Hktg9KvhltDxaKWa4=;
        b=qqxArlmdGWvOwmGlPmJKRPR2K/rfWvTHtJOEKdYjbEPuFl+0vzUMo1Zg3iC5ele9Q5
         Lpr8k1UNHkYdVD8BdzkWtPg3Tm3Dt6FRMwKe13CRRQv+wqpIqroBEI2IDJnIWavhDwr2
         cpazL8+iKi8Xozg8Bh5lOSlv4AEpK5qYEzts/mDQF9/RvWIpxQ6igTIkVE9fSi25HLd4
         S6Ty2yYjpaPdY8PZfXjFWa8n0U8It0omUmodVDu7QVRsPLlzGIP4DARKjimfBT7ek+mA
         f8V0DPT/tiVM4pfhBPSCXzxMeew1i4gEsuccIswyJhVVpaBIBmI9OjEQ+9MixgY3lwHB
         8W5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=027NmG7SxN43bQ3NJ7Xe8XTAw3Hktg9KvhltDxaKWa4=;
        b=6MGstrCU4aleS2zoas8OBasuK2vIgBuRxkMvAuPDu8rq4TeD0PYBF2SvoxF19H0252
         1Z874cdsqq2ZRGBW+FXgdInfvndaBYFPh1Cu35Umj67QCnX3IPNBvq64uv9LhegFSRg7
         RR/EsJ4yeSeg+xSI+2Awn/04QzFOCzkDoI15+ZR4N6TmKvCEmmCqiDokE8GHcQV1YXpU
         68M1c/b2jIK44485QSvS3bINXQw29IUDa3rkPz5w+fhTAed3DmzKSN+rCWRowM/V3YDz
         VyCI5wS//TTfPD8h1UKsxlAynJBVqfhgmgJwEDOyqw2rzAFD0HymnWlU4gbDwn05I3Ip
         ou5g==
X-Gm-Message-State: AOAM532ML4QOLcx0xadE9qVo+Fe/k7MdY6XHjkCU9rnOIkphryKv3Koi
        +P/TZlqINkuxNurYZzUjzlXe4eqJU6bUZA==
X-Google-Smtp-Source: ABdhPJwxwWkxYs0wnHMsVIq3CPnVRhSzhNiR6Mgrega5zw8pQS1wmDgBRKO6CuTAQXu1LTgL83zteg==
X-Received: by 2002:adf:fa8f:: with SMTP id h15mr16116630wrr.323.1634319960050;
        Fri, 15 Oct 2021 10:46:00 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id c17sm5631231wrq.4.2021.10.15.10.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 10:45:59 -0700 (PDT)
Date:   Fri, 15 Oct 2021 18:45:57 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Michael Straube <straube.linux@gmail.com>
Cc:     Larry.Finger@lwfinger.net, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH] staging: r8188eu: remove MSG_88E calls from
 hal/usb_halinit.c
Message-ID: <YWm+VUQmSbLB5yZn@equinox>
References: <20211015000233.842-1-phil@philpotter.co.uk>
 <6c637ef5-79dd-5503-d445-e7a768f528a6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c637ef5-79dd-5503-d445-e7a768f528a6@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2021 at 09:55:21AM +0200, Michael Straube wrote:
> On 10/15/21 02:02, Phillip Potter wrote:
> > Remove both MSG_88E calls from hal/usb_halinit.c, as these calls serve
> > no purpose other than to print the name of the function they are in
> > (_ReadAdapterInfo8188EU) on entry and on exit, with a timing of the
> > function, which is better accomplished by other means. Also remove
> > the jiffies assignment at the start of the function, as it is no
> > longer used.
> > 
> > Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
> > ---
> >   drivers/staging/r8188eu/hal/usb_halinit.c | 6 ------
> >   1 file changed, 6 deletions(-)
> > 
> > diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
> > index f6db5b05e6e7..abbd107ad3c1 100644
> > --- a/drivers/staging/r8188eu/hal/usb_halinit.c
> > +++ b/drivers/staging/r8188eu/hal/usb_halinit.c
> > @@ -1073,15 +1073,9 @@ static void _ReadRFType(struct adapter *Adapter)
> >   static int _ReadAdapterInfo8188EU(struct adapter *Adapter)
> >   {
> > -	u32 start = jiffies;
> > -
> > -	MSG_88E("====> %s\n", __func__);
> > -
> >   	_ReadRFType(Adapter);/* rf_chip -> _InitRFType() */
> >   	_ReadPROMContent(Adapter);
> > -	MSG_88E("<==== %s in %d ms\n", __func__, rtw_get_passing_time_ms(start));
> > -
> >   	return _SUCCESS;
> >   }
> > 
> 
> Looks good to me.
> 
> Acked-by: Michael Straube <straube.linux@gmail.com>
> 
> Thanks,
> Michael

Dear Michael,

Thanks for this, much appreciated.

Regards,
Phil
