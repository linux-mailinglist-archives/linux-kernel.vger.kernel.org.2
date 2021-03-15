Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A52C33BEA9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 15:52:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241242AbhCOOsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 10:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232798AbhCOOVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 10:21:02 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 398C4C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 07:21:02 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id 7so8788224wrz.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 07:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=yXnZm6S8DMwvdx14QT3npP9EnE8hKWLhG/dmEzKd1wA=;
        b=CU7c5HsMOuoVK1dk1HhDvHOg6BbOdtAdnMjl1fNaXTucr09MitDsvZGJTiOGZtWD4+
         Oab00YwyBzhUDkjATHoRFq/HtUfDlhCFXPR2eyeCRM2ARb4j2JPW/9pd1JLorSexginT
         V+5MuhVaUR5wJTMYLpzECadWbKLgg1zQ1UbREpT2vUVEo+pgcIu4DjIHUy748cu5UVDn
         UHdt60ehicTxNuuIVkTVnkdQP/5uoUjSMSlha8Yx36hzN/ighi21B+PN8HYXrRGmwmqO
         VDH3XP83lA+jq35eb3btrdRTTOcJDvRO8UbWwyFMvu+FHq5MuGfa/zTthHAUcVjGJQ96
         zwgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=yXnZm6S8DMwvdx14QT3npP9EnE8hKWLhG/dmEzKd1wA=;
        b=isoUmlp6vNTZfPytA5eHFUtu9qQZ7R1QXdWKOOk5TyOQnN1bH3vfR1ae6tXBElNG9t
         zFTVPm9Cthlig2LfdfNnFSEmRkXnZlN52QLME6Utn7FbPqdDefnuEsYrr9tPeyieG7wi
         B+L3eT8O3hOJLPhB5tQvvWG09EkjYDzMCH68bJVo8qdNqZcgXCKS5w7GCdwmXLvAhTlv
         X8CcEW8Yie3rwdL4sU7MMl0dL8XsXRNUBklNZ7Kjw8lXfiDmAXhSbztBC67uD0EJSybK
         7oLgnfYkBj7w2TDVhrtKqotK1+EbVtftdUEEsE50s1sGDI8XQWJQcei+n04NWcXAaa2K
         kjxA==
X-Gm-Message-State: AOAM5322A+2KEhd+by8skpSl9SPuiLxCrM6bWSpDa/2Y09z8FJMCgKcK
        BYFw/yq6UdUq/QKrCCLRmFbPC69d6W8pOA==
X-Google-Smtp-Source: ABdhPJzHkMrRe4xkRd9j5uXbHWnKESZxutyaG8Wjl0SyDmxfqZfoQPG4RuAGtdUMaYnq+RqGYpqKdg==
X-Received: by 2002:a5d:6b84:: with SMTP id n4mr27633958wrx.402.1615818060917;
        Mon, 15 Mar 2021 07:21:00 -0700 (PDT)
Received: from dell ([91.110.221.243])
        by smtp.gmail.com with ESMTPSA id p14sm12314768wmc.30.2021.03.15.07.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 07:21:00 -0700 (PDT)
Date:   Mon, 15 Mar 2021 14:20:58 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     j.neuschaefer@gmx.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mfd: ntxec: Support for EC in Tolino Shine 2 HD
Message-ID: <20210315142058.GY701493@dell>
References: <20210313104258.17111-1-andreas@kemnade.info>
 <20210315081231.GX701493@dell>
 <20210315132819.0970d493@aktux>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210315132819.0970d493@aktux>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Mar 2021, Andreas Kemnade wrote:

> On Mon, 15 Mar 2021 08:12:31 +0000
> Lee Jones <lee.jones@linaro.org> wrote:
> 
> [...]
> > >  static int ntxec_probe(struct i2c_client *client)
> > >  {
> > >  	struct ntxec *ec;
> > >  	unsigned int version;
> > >  	int res;
> > > +	const struct mfd_cell *subdevs = ntxec_subdev;
> > > +	size_t n_subdevs = ARRAY_SIZE(ntxec_subdev);  
> > 
> > This is a little confusing.  I had to re-read to figure it out.
> > 
> > In my mind, it would be clearer to explicitly set these in the
> > switch, rather than have a default which can be over-written.
> > 
> yes, it is clearer. I was just afraid that your compiler cannot
> figure it out that things get initialized and getting comments like
> "This code has never seen a compiler."
> But I will throw it against several ones.

Don't think so.  Just ensure you error out in the default case.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
