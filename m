Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A46836044C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 10:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbhDOId1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 04:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbhDOId0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 04:33:26 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C96FC061574
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 01:33:03 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id r9so35588385ejj.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 01:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ta4DOoQfotI6/6OYzxK4iRgaCenuWMEwER+QwKb27qA=;
        b=F83TF5UgmXH8ivsdcLN2gbs3xtBscWEMTQCnizq3HWS6u9a9X5wRqabTv2sr5uyuo8
         aJmAYtq1T9GF/Cbi933SJ8Y1Z3h3SGaSjqeU1mIBqcSu3tgaL9I7fR1Sd5Rg32a4j0ob
         ukKyF/gAFhHDGY55WYrGn17n46t0WVfj5Fw6/4xElg+PCkoBo0SUgrrzRCzhUm39E2fL
         a5avRb+ysVoVNUhn50tWzZvfzRjNU6ymEVd5JiAuUyozuy+DfqXoab8MPqyrGkai1VEY
         Dk8KKBsii2E6jCTcX1urvtWoK28zVBXB+rqzOk9XqshTdIHUPmTLceBBz1hCIQY2WGfV
         KSpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ta4DOoQfotI6/6OYzxK4iRgaCenuWMEwER+QwKb27qA=;
        b=UQ128VUPciLqx66Q7MK7ewVsjX2eyNL8BIm0P8pDaOi1Cc0N5qCJ36W0eY9gvGxVVi
         XonTpeGJlElFcbx4NMvFvn1LJ046XtRShMUGWNG+mk30PZWK1xSK9cTSzqmAOVEbFI6T
         6MzkA8p/MuDwnui8AvsrnnQpO7iqBzvX75iAhI94p3aW9CFiFHWMDzHUHstkbcujzRXK
         Hyndzk4PrTdlHJjyJs/0pTUYHiPn/Ps73PW5UKrSUWgwl/oUy0USe6m9N42OOcM/jSgS
         vYQApCNoGWQCsEscmNuibxm81eBuCEaDz0JhZIQqNSicj/nuFrATGI4Aj5ON8TIR+4JF
         DVRw==
X-Gm-Message-State: AOAM533SCoHrJnGnatiUzMmSvJCI1TTxSpYuP/yU4VZjads8GCs7HbVt
        PYR6z50PmTlFOdRRgRscFUrGsA==
X-Google-Smtp-Source: ABdhPJxY/zx/kTydsS38v9oJRlLcTDz7PLq/ACTkPxUT9u7QhsMMiJi2oheRDyCOuzA3Xwbg/5XIHg==
X-Received: by 2002:a17:906:37da:: with SMTP id o26mr2323866ejc.413.1618475582234;
        Thu, 15 Apr 2021 01:33:02 -0700 (PDT)
Received: from dell ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id cz2sm1802839edb.13.2021.04.15.01.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 01:33:01 -0700 (PDT)
Date:   Thu, 15 Apr 2021 09:32:59 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH 37/57] staging: rtl8188eu: os_dep: ioctl_linux: Move 2
 large data buffers into the heap
Message-ID: <20210415083259.GU4869@dell>
References: <20210414181129.1628598-1-lee.jones@linaro.org>
 <20210414181129.1628598-38-lee.jones@linaro.org>
 <20210415051835.GY6021@kadam>
 <20210415055325.GB6021@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210415055325.GB6021@kadam>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Apr 2021, Dan Carpenter wrote:

> I screwed up my last email and dropped Lee and Arnd from the To: headers.
> Resending.
> 
> On Thu, Apr 15, 2021 at 08:20:16AM +0300, Dan Carpenter wrote:
> > On Wed, Apr 14, 2021 at 07:11:09PM +0100, Lee Jones wrote:
> > > ---
> > >  drivers/staging/rtl8188eu/os_dep/ioctl_linux.c | 12 +++++++++++-
> > >  1 file changed, 11 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c b/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
> > > index c95ae4d6a3b6b..cc14f00947781 100644
> > > --- a/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
> > > +++ b/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
> > > @@ -224,7 +224,7 @@ static char *translate_scan(struct adapter *padapter,
> > >  	/* parsing WPA/WPA2 IE */
> > >  	{
> > >  		u8 *buf;
> > > -		u8 wpa_ie[255], rsn_ie[255];
> > > +		u8 *wpa_ie, *rsn_ie;
> > >  		u16 wpa_len = 0, rsn_len = 0;
> > >  		u8 *p;
> > >  
> > > @@ -232,6 +232,14 @@ static char *translate_scan(struct adapter *padapter,
> > >  		if (!buf)
> > >  			return start;
> 
> Arnd added this return.  I think it should be -ENOMEM, though?

Will fix, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
