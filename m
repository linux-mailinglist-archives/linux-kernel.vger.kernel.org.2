Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E586310479
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 06:24:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbhBEFXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 00:23:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbhBEFXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 00:23:02 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC7DC0613D6
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 21:22:22 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id s15so2967966plr.9
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 21:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AA+EJ1DjR2UJlhMyg3jCqq7pLGLJIui+Tm0/F/N50RE=;
        b=VW4FAjhh23HGT0GktpAHoyl8uJVfA2jFqXTAsfULb123Whqw92I4cM8GYp/LEJ1Hn5
         LJWxLATRNupVhw9H+ZW51MkTTNZJ9US75lB9Kr5608XBmwHC/hF6ZjfW+5uEoAH1KPgk
         bGRcadJ/80CjaKlH39hvSvCYnbmwW4aZpn3BKAQ6FUNfFHkfOiIWB38pLsJPAsawTCw/
         M41hOjD3PZVoR5XvaHNNWtR1HfSeAqjdU19G/C7mv+SGaItzk5f7wJ9G+3G1L1Y+A5S3
         eFBT+vQli6GaPsHImk+i3hFc/NdkmMzGn+CSgmKEIilqnk+LiG0U/yJBJ9AlLc0IaIOu
         yikg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=AA+EJ1DjR2UJlhMyg3jCqq7pLGLJIui+Tm0/F/N50RE=;
        b=QfkZGRV4Hm0pq8sYt6+fxw4d/u5IR5d+wILwPa9JwHW5UcVsbe2y8KRsNogNjCVh+X
         7ocUlhqnmDanxoKi1DiCDRmg9arM2Ue9mwOwUd8NPdWFj2Th9fARNWIhI97g38+klkg1
         oohY2ANNsV6et08DVE+xU+BQzrpPW74CKD6FFMmY5Q0FG4QKrfJCntJbpPRHL6BTvXWw
         PCpFuZvi3LXMhDIVDMW2xI6yVZKyYP8P8oToXqJKGQ9OxMQvs7wwQZmlrWxJxcrCWQta
         GXSboZ7j5NI9vCKUpZT3jKcm9fh17uDR+GdFZy+oT939vyZpzYe1tT1Hh7TAmoj79dS3
         OyTw==
X-Gm-Message-State: AOAM533eWOtwKlC9wM5bTV4/b+ZE9AdOzIKwslXlHrDqYK6agQuL8b3Q
        WPVDPq+PBqG4/qHgEVq8DiA=
X-Google-Smtp-Source: ABdhPJys67NVmEqSbIl8og6tjRZm9jYGtF8RdQpOly2Vpaii2/8Rd2t/nZrQ31HnhnJfjD+1X7KWaQ==
X-Received: by 2002:a17:90b:1b4f:: with SMTP id nv15mr2522992pjb.105.1612502541767;
        Thu, 04 Feb 2021 21:22:21 -0800 (PST)
Received: from google.com ([2620:15c:211:201:598:57c0:5d30:3614])
        by smtp.gmail.com with ESMTPSA id x184sm8612789pfb.199.2021.02.04.21.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 21:22:20 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 4 Feb 2021 21:22:18 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        gregkh@linuxfoundation.org, surenb@google.com, joaodias@google.com,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Subject: Re: [PATCH] mm: cma: support sysfs
Message-ID: <YBzWCl0MVNWntyUZ@google.com>
References: <20210203155001.4121868-1-minchan@kernel.org>
 <20210205025526.GG308988@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210205025526.GG308988@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 05, 2021 at 02:55:26AM +0000, Matthew Wilcox wrote:
> On Wed, Feb 03, 2021 at 07:50:01AM -0800, Minchan Kim wrote:
> > +++ b/mm/Makefile
> > @@ -106,6 +106,7 @@ obj-$(CONFIG_ZSMALLOC)	+= zsmalloc.o
> >  obj-$(CONFIG_Z3FOLD)	+= z3fold.o
> >  obj-$(CONFIG_GENERIC_EARLY_IOREMAP) += early_ioremap.o
> >  obj-$(CONFIG_CMA)	+= cma.o
> > +obj-$(CONFIG_SYSFS)     += cma_sysfs.o
> 
> ehh ... if we have a kernel build with CMA=n, SYSFS=y, we'll get
> cma_sysfs built in with no cma to report on.

OMG. Let me fix it.

> 
> > +static ssize_t cma_alloc_attempt_show(struct kobject *kobj,
> > +			struct kobj_attribute *attr, char *buf)
> > +{
> > +	unsigned long val;
> > +	struct cma_stat *stat = container_of(kobj, struct cma_stat, kobj);
> > +
> > +	val = stat->alloc_attempt;
> > +
> > +	return sysfs_emit(buf, "%lu\n", val);
> 
> Why not more simply:
> 
> {
> 	struct cma_stat *stat = container_of(kobj, struct cma_stat, kobj);
> 	return sysfs_emit(buf, "%lu\n", stat->alloc_attempt);

It's a legacy when I used the lock there but removed finally.
Will follow your suggestion.

> }
> 
> > +	for (i = 0; i < cma_area_count; i++) {
> > +		cma = &cma_areas[i];
> > +		stat = kzalloc(sizeof(*stat), GFP_KERNEL);
> > +		if (!stat)
> > +			goto out;
> 
> How many cma areas are there going to be?  do we really want to allocate
> their stat individually?

I am not sure what could be in the end but at least, I have
5+ candidates (but could be shrink or extend) and yes,
want to keep track them individually.
