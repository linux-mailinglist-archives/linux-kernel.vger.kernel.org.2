Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5B537121F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 09:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232971AbhECHoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 03:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbhECHoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 03:44:05 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5BAC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 May 2021 00:43:11 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id g14so5187645edy.6
        for <linux-kernel@vger.kernel.org>; Mon, 03 May 2021 00:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hrCmHB7eZzrZs7b3fQrpekvADCkKbdVi0YzMuWkAuxk=;
        b=tuoLBZ2CNndbqSbbL6JAW1hgkKpDXJGKvv9cxbXMO5swkUG5Jh/lFHFVjj8EQCtoDV
         UJY49DvS73BeTjhrlT1gxtXvfdg3nzDitxsUXCqZzw2EcjLBs/z5zzKhtgxxfMsiw9Ju
         WkSPFR1Rp9+FecO+qGpq+WwBAJ6t29B8cF1fNlkn2gHTOMvA/eNqT6AN7ETz9EqmBCTG
         C5ntzK1n0ylSD+/3VsiJSn0IpJryc59oy9qD9xM6NzwgjMEay65pHRZesxQulwwHNcr+
         qteFTiYDFIT9hq49+WgObUfTbwj5B43Dc2ll2nzdLIbeKFWi+aOUYUSR/HcmWG8kjpCA
         xI4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hrCmHB7eZzrZs7b3fQrpekvADCkKbdVi0YzMuWkAuxk=;
        b=mAlY1VGVB8kX9V+Gw3jboBVDncmUKdL8+vmvmXRIBYZC1x9JLocQGhfnuZ04ZBgvhc
         qN/Qw4P2DuAzgN74MSN/NLmME/FIGBc7IYlznk9VagejiRD4M/v954n7MzuWd7maujtY
         iBw297deAU5kHTjI4j4mHvAnWHhJJla2cO4u/1iZDvYv31seSoSbvfRFfxxvNWQpNdHN
         eEZhR+QHCUSzMQVlqG2LYJPv4WOo6n+q/eOjz6mTvCnr5/qODGPX28l8wJIpqswlP5wS
         72w7eufXK1BfbZcDPKnZVF6377rYSf2QS1luwZR3XJjyUCvJYQ3490kcmDAOiPcU41ri
         sOEA==
X-Gm-Message-State: AOAM532wB3xn4+dmhKylxPjfktaHDpj1LPatLe8r3eE4nwJXTpW1ciBL
        9HBJCSJlM/sgWNHLT+hbZsgRwxfYyhKN1A==
X-Google-Smtp-Source: ABdhPJwKnxZuuVMoZ4L4wMs8acOl3yBPwWaS1VUpyA/eIqu5alpYMNuIvu55plEsLwnipKrW3G/yQw==
X-Received: by 2002:a50:d782:: with SMTP id w2mr18436682edi.346.1620027789899;
        Mon, 03 May 2021 00:43:09 -0700 (PDT)
Received: from agape.jhs ([5.171.72.252])
        by smtp.gmail.com with ESMTPSA id r18sm10554881ejd.106.2021.05.03.00.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 00:43:09 -0700 (PDT)
Date:   Mon, 3 May 2021 09:43:07 +0200
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 16/43] staging: rtl8723bs: remove unused ASSERT macro
Message-ID: <20210503074306.GB1557@agape.jhs>
References: <cover.1619794331.git.fabioaiuto83@gmail.com>
 <f13bc57cc3a821c40443dddc38258b87962774a7.1619794331.git.fabioaiuto83@gmail.com>
 <20210503073132.GM1981@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210503073132.GM1981@kadam>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 03, 2021 at 10:31:32AM +0300, Dan Carpenter wrote:
> On Fri, Apr 30, 2021 at 04:56:38PM +0200, Fabio Aiuto wrote:
> > remove unused do nothing ASSERT macro definition.
> > 
> > Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
> > ---
> >  drivers/staging/rtl8723bs/hal/odm_debug.h | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/drivers/staging/rtl8723bs/hal/odm_debug.h b/drivers/staging/rtl8723bs/hal/odm_debug.h
> > index 8ae9948fb0c6..78b9b4548dcb 100644
> > --- a/drivers/staging/rtl8723bs/hal/odm_debug.h
> > +++ b/drivers/staging/rtl8723bs/hal/odm_debug.h
> > @@ -92,7 +92,6 @@
> >  	#define RT_DISP(dbgtype, dbgflag, printstr)
> >  
> >  #ifndef ASSERT
> > -	#define ASSERT(expr)
> >  #endif
> 
> Presumably you're going to delete the #ifndef/endif in the next patch
> but it should have been done in one step here.  (No need to resend.  For
> future reference only).
> 
> regards,
> dan carpenter
> 

ok, thank you,

fabio
