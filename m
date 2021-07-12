Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75BFC3C60C6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 18:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234019AbhGLQvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 12:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232710AbhGLQvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 12:51:44 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E0BC0613DD
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 09:48:55 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id ga14so20864140ejc.6
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 09:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=vrlH/BEa1Ukur1S/mi+PlZ4jOc9+GaUY7xVMMWuoOpw=;
        b=J4Qr591cps0wLoXsvoIBsp3jSfBfxcfDwErbT1PuZNYjwNiimAx672mA29WP/OhGDz
         Q63+87vRFvTywbx1Lj8RLwULv+xQKH7NjidircbWHgyi/XdnHRc2nDSfExHxGbwHqmCu
         RRkwOP4Oqf+OACU4VjVn1F/o0zizlB5FGS5aVAd5EV1zYa1CRx8ogvykHWo57W/721CA
         OzsYWUK5/cK28Wc3MfCxscG7QeWE6/DawTRxw0mkxN2d5WmgcUvQXYh9YXsxDb9P7q1O
         hwKssMpouyS3JtHNYLILnFc4sXWv1aTqIbbZIBlNy7L7fdk/4Gl7ljWKHOZ1u8+FWX9b
         ukyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=vrlH/BEa1Ukur1S/mi+PlZ4jOc9+GaUY7xVMMWuoOpw=;
        b=hQaG1yM7HhRoQy7o7/2+MwcwvqTOAqHT5JGJuJte1KQl61jQKdIxEsA4XUd/G4uqWe
         ZG/lW+LOetojGE3hfwRurULFlVb+3L73unQ/42F0abGF+c9cFJOOP9td+fhLMg1eH/f+
         UOOHID1qraY4UICnZp7kOOti5m4Ek28r1OsQOvJJiih9neNBIfa7PHBtKjBp//E5Izsp
         BJjNwKzfTQpiBrMWmqKDHTajrcnRBDK205dN3xMFjSs+sBJlVch9yBoVmfdnriwsYfVW
         4ZFtzuPUsMWbYmLtcssGtWnMPC1ct6bMZ/6VNvM5CVB8LC2s3BzBQcr3QzDVQg4TdXya
         Bdxw==
X-Gm-Message-State: AOAM531vpT+rp+4HJBj8QZ8OQuZEyoDPLwk2POTG6mzdU3grYdK2fF6g
        qNC9BSPMGSBYZrUYhaMLqJA=
X-Google-Smtp-Source: ABdhPJw5wzm7nkV5hbcp0wvvYc0KhizIN4wu+nWOu8STwwXBFp7/Thq0JtDbr5TMu12lhj0aiXpYBg==
X-Received: by 2002:a17:907:72ce:: with SMTP id du14mr53915938ejc.529.1626108533604;
        Mon, 12 Jul 2021 09:48:53 -0700 (PDT)
Received: from pc ([196.235.212.194])
        by smtp.gmail.com with ESMTPSA id v13sm8815519edl.47.2021.07.12.09.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 09:48:53 -0700 (PDT)
Date:   Mon, 12 Jul 2021 17:48:50 +0100
From:   Salah Triki <salah.triki@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        dave.jiang@intel.com, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dax: replace sprintf() by scnprintf()
Message-ID: <20210712164850.GC777994@pc>
References: <20210710164615.GA690067@pc>
 <10621e048f62018432c42a3fccc1a5fd9a6d71d7.camel@perches.com>
 <20210712122624.GB777994@pc>
 <6fe3c15d985017ad4e7a266bcf214a711326f151.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6fe3c15d985017ad4e7a266bcf214a711326f151.camel@perches.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 12, 2021 at 09:14:53AM -0700, Joe Perches wrote:
> On Mon, 2021-07-12 at 13:26 +0100, Salah Triki wrote:
> > On Sat, Jul 10, 2021 at 10:04:48AM -0700, Joe Perches wrote:
> > > On Sat, 2021-07-10 at 17:46 +0100, Salah Triki wrote:
> > > > Replace sprintf() by scnprintf() in order to avoid buffer overflows.
> > > 
> > > OK but also not strictly necessary.  DAX_NAME_LEN is 30.
> > > 
> > > Are you finding and changing these manually or with a script?
> > > 
> > > > diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
> > > []
> > > > @@ -76,7 +76,7 @@ static ssize_t do_id_store(struct device_driver *drv, const char *buf,
> > > >  	fields = sscanf(buf, "dax%d.%d", &region_id, &id);
> > > >  	if (fields != 2)
> > > >  		return -EINVAL;
> > > > -	sprintf(devname, "dax%d.%d", region_id, id);
> > > > +	scnprintf(devname, DAX_NAME_LEN, "dax%d.%d", region_id, id);
> > > >  	if (!sysfs_streq(buf, devname))
> > > >  		return -EINVAL;
> > > >  
> > > > 
> > > 
> > > 
> > 
> > since region_id and id are unsigned long may be devname should be
> > char[21].
> 
> I think you need to look at the code a bit more carefully.
> 
> 	unsigned int region_id, id;
> 
> Also the output is %d, so the maximum length of each output
> int is 10 with a possible leading minus sign.
> 
> 3 + 10 + 1 + 10 + 1.  So 25 not 21 which is too small.
> 
> The %d uses could be changed to %u to make it 23.
> But really it hardly matters as 30 is sufficent and the
> function call depth here isn't particularly high.
> 
> > I'm finding and changing these manually.
> 
> coccinelle could help.
> https://coccinelle.gitlabpages.inria.fr/website/
> 
> 

Thanx 

