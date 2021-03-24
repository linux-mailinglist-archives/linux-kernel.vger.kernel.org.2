Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B464E347BEF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 16:19:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236486AbhCXPSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 11:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236428AbhCXPST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 11:18:19 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AAF0C061763
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 08:18:18 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id 11so17554803pfn.9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 08:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Wy41lOcDMCqF1sv7i74oJ72JYgkzMqX69KL4UTQ3RaY=;
        b=gi4Zq9MNODzEniAx1PvyRTVY4L5pUwLMxbEGAbSMoNIdNX77rB/rRDvhKInxND0x+b
         UWYFSU0QNv5ZTVwAfqEmLJb2AZgIixB4SmhksptlKFNA/kOrdIXmpB35Ip8BPkW0n1l+
         uH9fnYxLxLEgxoTt2knBGIdU1g7Mh8/HPnBtFvMPfzX0yY6pLmSE2YOSTafiE6tCe8bs
         iFDU1qVgY6w0BgC394S4QTdwtrudeIJPIRjVdzI3De7WAx2xuOtpyK/Ee/hAJNUdSdvi
         rr81Vxrw+Hfn7iVz8Zui81H6Netl8hWxJEehGGyS5LJ0ddrf9fue6/F0zJKHmBb5mH6c
         3S0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=Wy41lOcDMCqF1sv7i74oJ72JYgkzMqX69KL4UTQ3RaY=;
        b=XvJfJVfPWKqqRADMWyM8ileuRpSOQxfQ/GMmKwPMe5vFu/5BIng7CpTr2yUe9OOIdL
         qc9irIAt1FR36RTFb8UC7EyTD1rfij8ovDEKt5L4FVjNYU5DvQ8V9rrcmFAhGtj3Mtzo
         2pY1ohpy8sQ82wpAPUrwRUL/o1LQnYMjUHs10zjNL0W/GW2vEpXF/2APXsopzUNJQVDp
         WpeKw1EoMFdwCHA887Us6/zzXhYJfQhEI33unvG3rvOhtHyHcolWPQewXHfYRwReAoRC
         8TkBSscqSaFqPIsXxPANRMAj+OV4yXVeQQq7hSXEt8osJ8fsFFd+lcquvcNxMDYxDY/7
         9rkg==
X-Gm-Message-State: AOAM532QZyPvYHcNsCKwakvRRZ971ygBOiMAQeek0R/13EzcuLLk938r
        RnMnDk8Mn1taCsmJUlVxL5k=
X-Google-Smtp-Source: ABdhPJx5vSCPCDw5fhRbyz3+gnLHOxVcg3Y1Toojiu4kcopw/kEAkm+KFKuY5ei6SdgJrwPQmRHpog==
X-Received: by 2002:a62:82cb:0:b029:1f6:213b:6590 with SMTP id w194-20020a6282cb0000b02901f6213b6590mr3612705pfd.17.1616599097674;
        Wed, 24 Mar 2021 08:18:17 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:7dfa:1e53:536:7976])
        by smtp.gmail.com with ESMTPSA id v2sm2818164pjg.34.2021.03.24.08.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 08:18:16 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Wed, 24 Mar 2021 08:18:14 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, gregkh@linuxfoundation.org,
        surenb@google.com, joaodias@google.com, willy@infradead.org
Subject: Re: [PATCH v6] mm: cma: support sysfs
Message-ID: <YFtYNtAQiRDr9+TC@google.com>
References: <20210324010547.4134370-1-minchan@kernel.org>
 <cbe10402-6574-6e46-9fd9-98b503bd26a4@nvidia.com>
 <YFqxm7UQBtWqH6VU@google.com>
 <d224c6bd-f5b1-74f6-2afc-c3d5b0519ba4@nvidia.com>
 <YFrRugjVLlazTNPy@google.com>
 <5b1a9f6c-ea7b-6e90-1c77-a49a10896f08@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5b1a9f6c-ea7b-6e90-1c77-a49a10896f08@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2021 at 03:37:02PM +0300, Dmitry Osipenko wrote:
> 24.03.2021 08:44, Minchan Kim пишет:
> > On Tue, Mar 23, 2021 at 09:47:27PM -0700, John Hubbard wrote:
> >> On 3/23/21 8:27 PM, Minchan Kim wrote:
> >> ...
> >>>>> +static int __init cma_sysfs_init(void)
> >>>>> +{
> >>>>> +	unsigned int i;
> >>>>> +
> >>>>> +	cma_kobj_root = kobject_create_and_add("cma", mm_kobj);
> >>>>> +	if (!cma_kobj_root)
> >>>>> +		return -ENOMEM;
> >>>>> +
> >>>>> +	for (i = 0; i < cma_area_count; i++) {
> >>>>> +		int err;
> >>>>> +		struct cma *cma;
> >>>>> +		struct cma_kobject *cma_kobj;
> >>>>> +
> >>>>> +		cma_kobj = kzalloc(sizeof(*cma_kobj), GFP_KERNEL);
> >>>>> +		if (!cma_kobj) {
> >>>>> +			kobject_put(cma_kobj_root);
> >>>>> +			return -ENOMEM;
> >>>>
> >>>> This leaks little cma_kobj's all over the floor. :)
> >>>
> >>> I thought kobject_put(cma_kobj_root) should deal with it. No?
> >>>
> >> If this fails when i > 0, there will be cma_kobj instances that
> >> were stashed in the cma_areas[] array. But this code only deletes
> >> the most recently allocated cma_kobj, not anything allocated on
> >> previous iterations of the loop.
> > 
> > Oh, I misunderstood that destroying of root kobject will release
> > children recursively. Seems not true. Go back to old version.
> > 
> > 
> > index 16c81c9cb9b7..418951a3f138 100644
> > --- a/mm/cma_sysfs.c
> > +++ b/mm/cma_sysfs.c
> > @@ -80,20 +80,19 @@ static struct kobj_type cma_ktype = {
> >  static int __init cma_sysfs_init(void)
> >  {
> >         unsigned int i;
> > +       int err;
> > +       struct cma *cma;
> > +       struct cma_kobject *cma_kobj;
> > 
> >         cma_kobj_root = kobject_create_and_add("cma", mm_kobj);
> >         if (!cma_kobj_root)
> >                 return -ENOMEM;
> > 
> >         for (i = 0; i < cma_area_count; i++) {
> > -               int err;
> > -               struct cma *cma;
> > -               struct cma_kobject *cma_kobj;
> > -
> >                 cma_kobj = kzalloc(sizeof(*cma_kobj), GFP_KERNEL);
> >                 if (!cma_kobj) {
> > -                       kobject_put(cma_kobj_root);
> > -                       return -ENOMEM;
> > +                       err = -ENOMEM;
> > +                       goto out;
> >                 }
> > 
> >                 cma = &cma_areas[i];
> > @@ -103,11 +102,21 @@ static int __init cma_sysfs_init(void)
> >                                            cma_kobj_root, "%s", cma->name);
> >                 if (err) {
> >                         kobject_put(&cma_kobj->kobj);
> > -                       kobject_put(cma_kobj_root);
> > -                       return err;
> > +                       goto out;
> >                 }
> >         }
> > 
> >         return 0;
> > +out:
> > +       while (--i >= 0) {
> > +               cma = &cma_areas[i];
> > +
> > +               kobject_put(&cma->kobj->kobj);
> > +               kfree(cma->kobj);
> > +               cma->kobj = NULL;
> > +       }
> > +       kobject_put(cma_kobj_root);
> > +
> > +       return err;
> >  }
> >  subsys_initcall(cma_sysfs_init);
> 
> Since we don't care about the order in which kobjects are put, I'd write it in this way, which I think looks cleaner:
> 

Hmm, preference matter. That kinds of goto error handling for unwinding is
familiar in kernel code and simple enough for me. I don't think readbility
is bad enough to need another cleanup function at this moment.

> static void cma_sysfs_cleanup(struct kobject *cma_kobj_root)
> {
> 	struct cma *cma = cma_areas;
> 	unsigned int i;
> 
> 	for (i = 0; i < cma_area_count; i++, cma++) {
> 		if (!cma->kobj)
> 			break;
> 
> 		kobject_put(&cma->kobj->kobj);
> 	}
> 
> 	kobject_put(cma_kobj_root);
> }
> 
> static int __init cma_sysfs_init(void)
> {
> 	struct kobject *cma_kobj_root;
> 	unsigned int i;
> 
> 	cma_kobj_root = kobject_create_and_add("cma", mm_kobj);
> 	if (!cma_kobj_root)
> 		return -ENOMEM;
> 
> 	for (i = 0; i < cma_area_count; i++) {
> 		struct cma_kobject *cma_kobj;
> 		struct cma *cma;
> 		int err;
> 
> 		cma_kobj = kzalloc(sizeof(*cma_kobj), GFP_KERNEL);
> 		if (!cma_kobj) {
> 			cma_sysfs_cleanup(cma_kobj_root);
> 			return -ENOMEM;
> 		}
> 
> 		cma = &cma_areas[i];
> 		cma->kobj = cma_kobj;
> 		cma_kobj->cma = cma;
> 		err = kobject_init_and_add(&cma_kobj->kobj, &cma_ktype,
> 					   cma_kobj_root, "%s", cma->name);
> 		if (err) {
> 			cma_sysfs_cleanup(cma_kobj_root);
> 			return err;
> 		}
> 	}
> 
> 	return 0;
> }
> subsys_initcall(cma_sysfs_init);
