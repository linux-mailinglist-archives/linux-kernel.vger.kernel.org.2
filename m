Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3465C3AD8DF
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 11:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232598AbhFSJWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Jun 2021 05:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbhFSJWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jun 2021 05:22:40 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED693C061574
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jun 2021 02:20:28 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id u18so4289823pfk.11
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jun 2021 02:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=h6U+ip6SC6pAZmxuTxatgMsO1k4mn3H80WDAN7mFMJs=;
        b=crcjxWRSpdvPpetfG0nkbWH+v91CS1lUwNKLPPEwAdAGd2dtrYT95d5SQ513CnPgHp
         Rvo21FuClNdZjUQPLdmqm0iGyh7SSfXnsKx7hSxOwu0vfrDXOuci2eQZGHhGDakR/az9
         8WdSod8wdu6MhVFqojuhkgOqIIwpCiINkOsGf8RNQwETMkpXA7Cp3AoZEYr5ZF0UQGC9
         ZIBLY3xQKqWw3FRLT/lNgTLxXhHxA0iEzh6dt4Yq8CSSuNqv+x9Dmzl3qOl8fG2xnCZ6
         0uCp56ttlWvUTE3xMQSZ0i5zFdnTnZiL+X/BKxBQfODrky79HHm74WDwU2EN/7GrfABK
         ZncQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=h6U+ip6SC6pAZmxuTxatgMsO1k4mn3H80WDAN7mFMJs=;
        b=Q+CSK2BuDEd3bgtF3VBF6HJIBPrnDYurpfMuXTzPkPjNhSgTI/07S6sJ6zWc3PQ3pn
         ok4BvmrYFdsJ9KMx6sgMN4o4TAVUBxqWQUXTbmxRKjRhnYu5eVTZ0RuQEN1nED4IjrIB
         Wv1QSb1EqxLeL369xJ1aE+8Armxfz03hl/02EDqYdzNcuBClbfEm9qpfL3NINNg68C8W
         81ptBtKqAsm/QXBZC7t0T8/aLmojXSTXJi3h53JynYei3zY32gvHkqVuUn9EI2sjxa2J
         d0mIoguCWaJ02UZauDNcXF3T8/cZpyzfh+SXc3XhQsyzBj8KY64rTvYTv3/t1MWnhl+N
         Cg6A==
X-Gm-Message-State: AOAM533tcUsSikM5VsXrkPTFYqFoni/ftgX0xVwtQKjnSMTOEIq82Fa/
        xY05zMzBAjxhOqJS6NAo4tK5cBW73rUBUr+A
X-Google-Smtp-Source: ABdhPJxQlvy+JcPrTtU6zHgtBPggP9b+H+ilYSKFGCdlfjIR/HGkWFssR1ZJuuYJf0N8m5PMCHQ7vw==
X-Received: by 2002:a63:5005:: with SMTP id e5mr14257769pgb.340.1624094428284;
        Sat, 19 Jun 2021 02:20:28 -0700 (PDT)
Received: from gmail.com (1-171-85-235.dynamic-ip.hinet.net. [1.171.85.235])
        by smtp.gmail.com with ESMTPSA id 35sm9564939pjo.16.2021.06.19.02.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jun 2021 02:20:27 -0700 (PDT)
Date:   Sat, 19 Jun 2021 17:20:24 +0800
From:   Jhih-Ming Huang <fbihjmeric@gmail.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     gregkh@linuxfoundation.org, fabioaiuto83@gmail.com,
        ross.schm.dev@gmail.com, maqianga@uniontech.com,
        marcocesati@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] rtw_security: fix cast to restricted __le32
Message-ID: <20210619092024.i6aunzyd24cmr5cs@gmail.com>
References: <YMeL7PjstV601pbN@zeniv-ca.linux.org.uk>
 <20210618181751.95967-1-fbihjmeric@gmail.com>
 <YMz0DH0+v39xsCYU@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMz0DH0+v39xsCYU@zeniv-ca.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2021 at 07:29:16PM +0000, Al Viro wrote:
> On Sat, Jun 19, 2021 at 02:17:51AM +0800, Jhih-Ming Huang wrote:
> > This patch fixes the sparse warning of fix cast to restricted __le32.
> > 
> > There was a change for replacing private CRC-32 routines with in kernel
> > ones.
> > However, the author used le32_to_cpu to convert crc32_le(), and we
> > should cpu_to_le32.
> > 
> > Ths commit also fixes the payload checking by memcmp instead of checking element
> > by element.
> > 
> > Signed-off-by: Jhih-Ming Huang <fbihjmeric@gmail.com>
> > ---
> >  drivers/staging/rtl8723bs/core/rtw_security.c | 7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/staging/rtl8723bs/core/rtw_security.c b/drivers/staging/rtl8723bs/core/rtw_security.c
> > index a99f439328f1..97a7485f8f58 100644
> > --- a/drivers/staging/rtl8723bs/core/rtw_security.c
> > +++ b/drivers/staging/rtl8723bs/core/rtw_security.c
> > @@ -121,7 +121,7 @@ void rtw_wep_decrypt(struct adapter  *padapter, u8 *precvframe)
> >  		arc4_crypt(ctx, payload, payload,  length);
> >  
> >  		/* calculate icv and compare the icv */
> > -		*((u32 *)crc) = le32_to_cpu(~crc32_le(~0, payload, length - 4));
> > +		*crc = cpu_to_le32(~crc32_le(~0, payload, length - 4));
> 
> Huh?  crc is u8[4]; that assignment will truncate that le32 to u8 and store it in
> the first byte of your 4-element array.  How the hell does sparse *not* complain
> on that?
facepalm... fixed in v4 PATCH.

thanks for your help.
> 
> Either make crc __le32 (and turn assignment into crc = cpu_to_le32(...)), or
> make that *(__le32 *)crc = ...
> 
> > @@ -618,10 +618,9 @@ u32 rtw_tkip_decrypt(struct adapter *padapter, u8 *precvframe)
> >  			arc4_setkey(ctx, rc4key, 16);
> >  			arc4_crypt(ctx, payload, payload, length);
> >  
> > -			*((u32 *)crc) = le32_to_cpu(~crc32_le(~0, payload, length - 4));
> > +			*crc = cpu_to_le32(~crc32_le(~0, payload, length - 4));
> 
> Ditto.  Declare crc as __le32 and use
> 			crc = cpu_to_le32(~crc32_le(~0, payload, length - 4));
> here.
