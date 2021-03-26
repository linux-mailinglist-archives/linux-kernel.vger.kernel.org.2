Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 717C934AB2C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 16:13:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbhCZPNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 11:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbhCZPMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 11:12:49 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169DFC0613B3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 08:12:49 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id t5-20020a1c77050000b029010e62cea9deso3196463wmi.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 08:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vJD63yjhBQ/6qYwEetX6fhqse6jdADR22GvZycMU1kg=;
        b=h0hbKyyF+cz/P5CbiOOmWKzwR06PsSPq55Ngy4fgoALtC8yuEaEK9doN+YeSVlmXW7
         B5lHRN88SDNUGzyEq5lgbxDHGRdQLgTnbIj1LAt3TbE/CvkUGy+ZvReX8GRwSLk+W3cU
         gNQ8Is9QE3RKW6y5gW6MURu0sX249kNivRQfFVyyfWgBZrtOIngY/ahyw3zYH23k6Za8
         pRbAXDn7/nGJAO9/FGgLl0y7M3rF0pWi89oM5lf9hdTWX1qB0tuwK6fPXcVNooucHvlb
         ziw7h/BTS4zTad0L05dW3NDH3hnAUwCOjTKO17HS0RhIe09iUfYZdQHWLIJAuzdfKfVt
         O5hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vJD63yjhBQ/6qYwEetX6fhqse6jdADR22GvZycMU1kg=;
        b=YyD7Kufi18oEdwZFUnp7HmJ4vlWiwZs7hFTciL8Liz0J3IPf8WthP/dYlKxEt48xKm
         9VTausOC4e9vW49QqADSNUcrJERyi0eSJbOH6iNBso3CsAKkyeO29cK8bjoFmAhunBuV
         bEoGpkrzGZ47PqhpuKNtS6IU36+8FZ/sMQNVMJf3svHJg1QhcgWD5ruKR45fS/+shA0a
         RKW9unM4avzjI/OlWlQ3h57QyLVjQ4RfK7rzFS/dkqtLN1OLRB4AGzn4LWwkzTAwIkzG
         KGEtm4tCCbU2N1tvyG9+klNrRG0rYVGjG06hhhtw3lA0ML7bzclknJmlv6YPBHxxJpQ6
         fGkw==
X-Gm-Message-State: AOAM5334XdX7B7yGZjH+0LV3o+SKVZy1t378jhM8INrSB+AD2SVoD11w
        MXHFNm0kn/h/bBr3pVY1GtQ=
X-Google-Smtp-Source: ABdhPJw8EeC9Q8VHNqjHEsGlaY++EiB5170/0PwXVd9gGya6NS6wd71RY1bFBzzeTOfZGpRZEWE3sw==
X-Received: by 2002:a05:600c:3796:: with SMTP id o22mr5872060wmr.139.1616771567854;
        Fri, 26 Mar 2021 08:12:47 -0700 (PDT)
Received: from agape.jhs ([5.171.80.141])
        by smtp.gmail.com with ESMTPSA id a67sm2558576wme.33.2021.03.26.08.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 08:12:47 -0700 (PDT)
Date:   Fri, 26 Mar 2021 16:12:45 +0100
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     gregkh@linuxfoundation.org, david.laight@aculab.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/15] staging: rtl8723bs: put parentheses on macros with
 complex values in include/drv_types.h
Message-ID: <20210326151244.GB1952@agape.jhs>
References: <cover.1616748885.git.fabioaiuto83@gmail.com>
 <fea98d1b0260494dc5cb0dfb7fc03d6f74d9acdf.1616748885.git.fabioaiuto83@gmail.com>
 <20210326142257.GF1717@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210326142257.GF1717@kadam>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2021 at 05:22:57PM +0300, Dan Carpenter wrote:
> On Fri, Mar 26, 2021 at 10:09:12AM +0100, Fabio Aiuto wrote:
> > fix the following checkpatch warning:
> > 
> > ERROR: Macros with complex values should be enclosed in parentheses
> > 279: FILE: drivers/staging/rtl8723bs/include/drv_types.h:279:
> > +#define KEY_ARG(x) ((u8 *)(x))[0], ((u8 *)(x))[1],
> > ((u8 *)(x))[2], ((u8 *)(x))[3], ((u8 *)(x))[4], ((u8 *)(x))[5], \
> > 
> > Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
> > ---
> >  drivers/staging/rtl8723bs/include/drv_types.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/staging/rtl8723bs/include/drv_types.h b/drivers/staging/rtl8723bs/include/drv_types.h
> > index 1658450b386e..ead4cb9c1e5a 100644
> > --- a/drivers/staging/rtl8723bs/include/drv_types.h
> > +++ b/drivers/staging/rtl8723bs/include/drv_types.h
> > @@ -276,9 +276,9 @@ struct cam_entry_cache {
> >  };
> >  
> >  #define KEY_FMT "%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x"
> > -#define KEY_ARG(x) ((u8 *)(x))[0], ((u8 *)(x))[1], ((u8 *)(x))[2], ((u8 *)(x))[3], ((u8 *)(x))[4], ((u8 *)(x))[5], \
> > +#define KEY_ARG(x) (((u8 *)(x))[0], ((u8 *)(x))[1], ((u8 *)(x))[2], ((u8 *)(x))[3], ((u8 *)(x))[4], ((u8 *)(x))[5], \
> >  	((u8 *)(x))[6], ((u8 *)(x))[7], ((u8 *)(x))[8], ((u8 *)(x))[9], ((u8 *)(x))[10], ((u8 *)(x))[11], \
> > -	((u8 *)(x))[12], ((u8 *)(x))[13], ((u8 *)(x))[14], ((u8 *)(x))[15]
> > +	((u8 *)(x))[12], ((u8 *)(x))[13], ((u8 *)(x))[14], ((u8 *)(x))[15])
> 
> KEY_ARG() isn't used anywhere that I can see.  Just delete it.
> 
> Please take your time when you re-write this series and think about each
> change clearly and fix the underlying badness instead of just making
> checkpatch happy.  I would really just throw out the patchset and start
> over from scratch.
> 
> regards,
> dan carpenter
> 

Hi Dan,

KEY_FMT is unused as well. I'm rewriting the whole series, will send
v2.

thank you,

fabio
