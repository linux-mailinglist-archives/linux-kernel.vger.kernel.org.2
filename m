Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1882A34822C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 20:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237914AbhCXTuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 15:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238014AbhCXTtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 15:49:36 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEAE0C061763
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 12:49:36 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id j6-20020a17090adc86b02900cbfe6f2c96so1770409pjv.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 12:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=REq/3z6pobNdfYBuuoG456AWgVOTbPT0o3Axmb0eQnU=;
        b=EQom7EY91nsoHrk6i+8Z4HSRLQUvIqpEXmT0vMrTK51fD2N4RreS32PXSNRAzz4R9I
         HrRlXTZFEOGH0+ls+8Qt1eBAQ4u7UoEOsHaAwvVOfEu+dg6gd3POhtudd12XTwJyS3Jg
         dYsnTdZukhlrYmuqkoegp0sdX0B5vT9MMvnEvvdXdjCaZXooe5V0wi5gwvvFCT2mYSTf
         g48MWGkaWtfU6oIpM4MRfWbCEhuufEUbSOuVCXx6zHAZRWBuOS1jWig6x0UI9sZH+yQG
         0yqiPwC8TnTMJdtEw6mExrlZiG2BUU9iGtf7h5KAIt+apl44NpMNrcidaWiwLJsJDgAH
         uXrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=REq/3z6pobNdfYBuuoG456AWgVOTbPT0o3Axmb0eQnU=;
        b=gm1BpsMWtyFielNjV6QY2goPSag5BoSo4d7Kma5D1+BvCW1g/MN6rSXPsKE4ODYzKR
         EDR5jgZP78i1c2o5YRITrqIQM4LDyGFX5m5DDi5I0Gg4s3kpP/NcU0fDqWUYJUoOt1+M
         zCU03jZ1k1av8zK/VxjpBKtXRhuBrIrIWoFEQR3WZqkFLmILuvgvjCUJICV95dXdr0D3
         N+0diOrYqd/vEq4w/5yyQe2lAO8mPFSHRnV0gJfIjfMd7Ki4VGsOeio87+0bHBCWJcWP
         6NtGHWx5+D/SntQpnkZ/+kwhWlG5ygc1cqhD2ABMAm22nacFxycm7Q5mtk4Ao2nGcbFV
         H2Ag==
X-Gm-Message-State: AOAM532ZtE40rJU1/MJxjIfqVgwcZ3XVfWx66OGckpLEMCrQJrl/yVax
        Czk/ir8PJu5B5ACABOvRLGE=
X-Google-Smtp-Source: ABdhPJwhzepoIT3F1qAMeeqs+MljdVAM7ut/h3OckEKGP12PVKFk4ACW7o4mzdWAT/k5z38vEgl62Q==
X-Received: by 2002:a17:90a:840a:: with SMTP id j10mr4840404pjn.97.1616615376345;
        Wed, 24 Mar 2021 12:49:36 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:7dfa:1e53:536:7976])
        by smtp.gmail.com with ESMTPSA id u24sm3620158pfm.214.2021.03.24.12.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 12:49:35 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Wed, 24 Mar 2021 12:49:32 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, gregkh@linuxfoundation.org,
        surenb@google.com, joaodias@google.com, jhubbard@nvidia.com,
        willy@infradead.org
Subject: Re: [PATCH] mm: cma: fix corruption cma_sysfs_alloc_pages_count
Message-ID: <YFuXzC1cKqJzhwA4@google.com>
References: <20210324192044.1505747-1-minchan@kernel.org>
 <18ee5c3e-fba2-0d8d-bd93-5fb8d0dd7a01@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <18ee5c3e-fba2-0d8d-bd93-5fb8d0dd7a01@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2021 at 10:43:49PM +0300, Dmitry Osipenko wrote:
> 24.03.2021 22:20, Minchan Kim пишет:
> >  static int __init cma_sysfs_init(void)
> >  {
> > -	int i = 0;
> > +	struct kobject *cma_kobj_root;
> > +	struct cma_kobject *cma_kobj;
> >  	struct cma *cma;
> > +	unsigned int i;
> 
> >  	while (--i >= 0) {
> 
> Do you realize that this doesn't work anymore?
> 
> >  		cma = &cma_areas[i];
> > -		kobject_put(&cma->stat->kobj);
> > -	}
> >  
> > -	kfree(cma_stats);
> > -	kobject_put(cma_kobj);
> > +		kobject_put(&cma->cma_kobj->kobj);
> > +		kfree(cma->cma_kobj);
> 
> Freeing a null pointer?

Need coffee.
 
diff --git a/mm/cma_sysfs.c b/mm/cma_sysfs.c
index a670a80aad6f..73463be08df7 100644
--- a/mm/cma_sysfs.c
+++ b/mm/cma_sysfs.c
@@ -79,8 +79,7 @@ static int __init cma_sysfs_init(void)
        struct kobject *cma_kobj_root;
        struct cma_kobject *cma_kobj;
        struct cma *cma;
-       unsigned int i;
-       int err;
+       int i, err;

        cma_kobj_root = kobject_create_and_add("cma", mm_kobj);
        if (!cma_kobj_root)
@@ -108,10 +107,7 @@ static int __init cma_sysfs_init(void)
 out:
        while (--i >= 0) {
                cma = &cma_areas[i];
-
                kobject_put(&cma->cma_kobj->kobj);
-               kfree(cma->cma_kobj);
-               cma->cma_kobj = NULL;
        }
        kobject_put(cma_kobj_root);


