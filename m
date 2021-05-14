Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 598F6380AAC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 15:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbhENNuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 09:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbhENNt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 09:49:57 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FFB7C061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 06:48:44 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id b9-20020a17090a9909b029015cf9effaeaso1689052pjp.5
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 06:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aBsJCV7Cr8ObpfZHI0HCqMDG4XMDO17H2qjX06UEXfE=;
        b=uiHFyMAp5nPz9+TqKF3F/XpDDZzrleMWO+lOHAbyrparjXQBcWtF1gxg06ddLKOBg5
         Wnub3G524S4A9Vkqgtf1JXFY8IIrWZh5hOYriCc7EAsd6QumhVP/pLLdxIaFQCAbhZXC
         cKmIZ1d6Yp/Uicbp1AxtAORa5lZq2T5JK0vwFTRdtpPYkO14vTgnYMMWXAJ2O7FAW046
         duWtpoAlu66NaQnlTYuX5CZQpAvq2vg7HW5hLBz83J1ejyVSbdI1FWLFNBVMR8gU1dNG
         jsKh2zruzpwhLc6MhM+uEldAKY8cKkOn7E3eQxStqRIyexrHvtDjyDMI7SqS3uRF/xU7
         xt5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aBsJCV7Cr8ObpfZHI0HCqMDG4XMDO17H2qjX06UEXfE=;
        b=FyDbZJYbdXwKNT3JUtu5hxAY7rqGxuNb5uyEvIllqSZcpKfxiObuKWD9V90w5gY7Hf
         b9MTfzcq5RFZdbp2VEhkF+/smLZmulP3/OmeYXd4PaDPYmwB8PHKxvSU16ovzAksnOUa
         597XtbDi/cX3z3QZ8O+UQq7ZWD4S71SxOUYEPNZ/SfftWCRUEEyVQEERPCdkOaNxlwdH
         5RXCt+rgNF97S3bspk/8eq9lDonZyQwxPoDSKckS+ZtFY/rqJkqHyLdW+GjyrRCBLl0E
         RvFaOglQlhjvNXe8xP+1z3gzgCA2eInEqK3ab6+NJmdzo8j/VEKluw1MZY6eSym9aRLF
         dp/A==
X-Gm-Message-State: AOAM531R5/wkpW3uoEckbjpr4tLuJEKJ8o+xyv5DspQP/BLh7beyMI6K
        6WjN5qt+BaDBWzGesnICPyI=
X-Google-Smtp-Source: ABdhPJwwsdqxFN33bVHXa97UG3m9ytH0gmGrYB4jrD+zCf17fBVleBgmewPH5HdK0WHrJLMNvNdb4A==
X-Received: by 2002:a17:90b:360f:: with SMTP id ml15mr11164792pjb.26.1621000123937;
        Fri, 14 May 2021 06:48:43 -0700 (PDT)
Received: from fedora ([2405:201:6008:61b4:4e16:5348:d963:c66d])
        by smtp.gmail.com with ESMTPSA id x19sm1269004pfp.153.2021.05.14.06.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 06:48:43 -0700 (PDT)
Date:   Fri, 14 May 2021 19:18:38 +0530
From:   Shreyansh Chouhan <chouhan.shreyansh630@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     pure.logic@nexus-software.ie, johan@kernel.org, elder@kernel.org,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: fix gb_loopback_stats_attrs definition
Message-ID: <YJ5/tqFfcjxOLsF0@fedora>
References: <20210514133039.304760-1-chouhan.shreyansh630@gmail.com>
 <YJ582f3O9K9YD3QA@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJ582f3O9K9YD3QA@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2021 at 03:36:25PM +0200, Greg KH wrote:
> On Fri, May 14, 2021 at 07:00:39PM +0530, Shreyansh Chouhan wrote:
> > The gb_loopback_stats_attrs macro, (defined in loopback.c,) is a
> > multiline macro whose statements were not enclosed in a do while
> > loop.
> > 
> > This patch adds a do while loop around the statements of the said
> > macro.
> > 
> > Signed-off-by: Shreyansh Chouhan <chouhan.shreyansh630@gmail.com>
> > ---
> >  drivers/staging/greybus/loopback.c | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/staging/greybus/loopback.c b/drivers/staging/greybus/loopback.c
> > index 2471448ba42a..c88ef3e894fa 100644
> > --- a/drivers/staging/greybus/loopback.c
> > +++ b/drivers/staging/greybus/loopback.c
> > @@ -162,10 +162,12 @@ static ssize_t name##_avg_show(struct device *dev,		\
> >  }									\
> >  static DEVICE_ATTR_RO(name##_avg)
> >  
> > -#define gb_loopback_stats_attrs(field)				\
> > -	gb_loopback_ro_stats_attr(field, min, u);		\
> > -	gb_loopback_ro_stats_attr(field, max, u);		\
> > -	gb_loopback_ro_avg_attr(field)
> > +#define gb_loopback_stats_attrs(field)					\
> > +	do {								\
> > +		gb_loopback_ro_stats_attr(field, min, u);		\
> > +		gb_loopback_ro_stats_attr(field, max, u);		\
> > +		gb_loopback_ro_avg_attr(field);				\
> > +	} while (0)
> >  
> >  #define gb_loopback_attr(field, type)					\
> >  static ssize_t field##_show(struct device *dev,				\
> > -- 
> > 2.31.1
> > 
> > 
> 
> Did you test build this change?

I built the module using make -C . M=drivers/staging/greybus to test
build it. I didn't get any errors.

Regards,
Shreyansh Chouhan
