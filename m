Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB05360448
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 10:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbhDOIcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 04:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbhDOIcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 04:32:02 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E30C061574
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 01:31:38 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id u17so35610563ejk.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 01:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=o4Zea2wZG0jsu5G4k3ezpPKmStFjRBdkRPNkdtX1oDw=;
        b=s9K8XEuceZ5R1z9qNS5SQi1MT87F79SgDGa62gWJ7QjVHk+u3VvCeNh1thLKc+5NCy
         ku1l5flgVEbncxwZtj9rafq5SuiSqAGEMH4duYsTqBYYlBx8hGE6HIntXU5CVdoDWu4D
         uOSKUucL+BxsrmS/Mi2iRwrL/1MX3SxvyqumCiMFWxHWgx35Ar6GeQweKxVdMBIzQRlq
         /xwqI39SgMkk9AD+ogtmx2Uvrs/GOBhdDPkEHHlT7jRSnCOcV4mAoVy1TKaqD8VwYKUG
         Mgh7VkJS8uHW338xAeVywx3w019jDOcZY2v5g0cxFqgZlRYxV9dT+DZKiae9yAOPFR4m
         2hgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=o4Zea2wZG0jsu5G4k3ezpPKmStFjRBdkRPNkdtX1oDw=;
        b=q5qExifLOvkNsu37O/Tut5ZnFXN3YKgF9UIrfpeNK4ezWKr5c+O2R/bk8NonZAnGBB
         JFpAEpkGwT/HRuwwNLtg1JCZFAD9NQ14402xeoGeGQ7kplZvGwzFCxXD6JKAPgMpUMfN
         RKlcHlb2eyeupj7X5KMvyK0nhe1dxDUVT9xWKix98kVACX1guebc73fpzTs/fWBhMu2l
         NqD5Pi7GkEGtmbR6pBjmTC6W4Tz/cSICdimXto+Y4XQYg3wN7rksJn1KIlmj5LZGA/+S
         Kb7jWZz1hBG8H4AL+RO8SZxCqKEnugaIlaNvTVJYgdThBT4WuRKba8GxV6rkqGGWIz5D
         Pfjg==
X-Gm-Message-State: AOAM532FcRbt+8Cs7a8+I8J5kt7WuIdE7xtzA5xpbvGu6FDZu/SRmVgt
        Qx/sZ9O6aifX4mEpA/41GiQYtg==
X-Google-Smtp-Source: ABdhPJx4EvV1oS5tj/RnxbrOBT69mWMFa9GhvAHb+keKtV3i1VU7aqlMhMwlaGlO2SJTqq3s6sjG4w==
X-Received: by 2002:a17:906:bd2:: with SMTP id y18mr2254929ejg.482.1618475496804;
        Thu, 15 Apr 2021 01:31:36 -0700 (PDT)
Received: from dell ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id g26sm1376062ejz.70.2021.04.15.01.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 01:31:36 -0700 (PDT)
Date:   Thu, 15 Apr 2021 09:31:34 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Fabio Aiuto <fabioaiuto83@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH 15/57] staging: rtl8723bs: core: rtw_security: Demote
 non-conformant kernel-doc header
Message-ID: <20210415083134.GT4869@dell>
References: <20210414181129.1628598-1-lee.jones@linaro.org>
 <20210414181129.1628598-16-lee.jones@linaro.org>
 <20210415080928.GA1431@agape.jhs>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210415080928.GA1431@agape.jhs>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Apr 2021, Fabio Aiuto wrote:

> On Wed, Apr 14, 2021 at 07:10:47PM +0100, Lee Jones wrote:
> > Fixes the following W=1 kernel build warning(s):
> > 
> >  from drivers/staging/rtl8188eu/core/rtw_security.c:10:
> >  drivers/staging/rtl8188eu/core/rtw_security.c:478: warning: Function parameter or member 'p1k' not described in 'phase1'
> >  drivers/staging/rtl8188eu/core/rtw_security.c:478: warning: Function parameter or member 'tk' not described in 'phase1'
> >  drivers/staging/rtl8188eu/core/rtw_security.c:478: warning: Function parameter or member 'ta' not described in 'phase1'
> >  drivers/staging/rtl8188eu/core/rtw_security.c:517: warning: Function parameter or member 'rc4key' not described in 'phase2'
> >  drivers/staging/rtl8188eu/core/rtw_security.c:517: warning: Function parameter or member 'tk' not described in 'phase2'
> >  drivers/staging/rtl8188eu/core/rtw_security.c:517: warning: Function parameter or member 'p1k' not described in 'phase2'
> >  drivers/staging/rtl8723bs/core/rtw_security.c:1937: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
> > 
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: linux-staging@lists.linux.dev
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  drivers/staging/rtl8723bs/core/rtw_security.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/staging/rtl8723bs/core/rtw_security.c b/drivers/staging/rtl8723bs/core/rtw_security.c
> > index 9587d89a6b24e..60b724729900e 100644
> > --- a/drivers/staging/rtl8723bs/core/rtw_security.c
> > +++ b/drivers/staging/rtl8723bs/core/rtw_security.c
> > @@ -1921,7 +1921,7 @@ const u8 rcons[] = {
> >  	/* for 128-bit blocks, Rijndael never uses more than 10 rcon values */
> >  };
> >  
> > -/**
> > +/*
> >   * Expand the cipher key into the encryption key schedule.
> >   *
> >   * @return	the number of rounds for the given cipher key size.
> 
> Hi,
> 
> did you mean 'demote' in subject line?

I did.  Did I spell it incorrectly?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
