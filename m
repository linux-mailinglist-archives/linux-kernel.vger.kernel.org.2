Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88F5C3471F2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 07:58:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235612AbhCXG5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 02:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbhCXG53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 02:57:29 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93FFC061763
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 23:57:28 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id ha17so11245682pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 23:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OnGKpgIvLuYM7scx4oRxksHU+RCOWiPa3dXT8Vz5QQ4=;
        b=t88tXejx64fTCDwm9tyjz18zKydYQ53MTdOrzdVa6DFMiArNYbCivM9Y3RTmtNd5z0
         Xkb6ltRUaqNl/qs+y9mDZr1h4zRI0mye5kv1uZx5r9hAjhSsjs/y+C+Vlhz+e+tWXRYO
         /OUJXFOTPWyhprR+qOTL4CaX5/qChk71rnk04tjzfAL2yTeQSCiPfEXj+bJonQq2Akxm
         otdKv9oVpGu5YxcVTPd70QXMyxjIMbIVYyE2WQUQM3E7wlK1uingHsPTDGkpQtI31bGx
         uV2589ExFzo9iu68DDnlRpP0TEU7OK8fxY6pY6FagrvMFx/vJ87FpIVEDfpEB8N9IoIN
         gv+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=OnGKpgIvLuYM7scx4oRxksHU+RCOWiPa3dXT8Vz5QQ4=;
        b=SQ0yO62hwwjINXNmPdRYoyhOsF5RbVhmsoOwcYMwkoPNOtT1hm9YVK2p1+mG4aH5oT
         QbeX81/VOVGOOuZGQ9O5a3BejnG7myRZNq09mKnKH/owGklox6RAirRlDucSjkPjkp2a
         wZq9apl/NGz4olXmTHVNXmZWAAris9Jx379kzjCUVSNMIvpxSZ0AQuxYhW904F95FM3J
         4iKvxBEFxWp02ydWrXE0V7dmEr5ojR60AVTS1VSzSxMTiQRp1Vqst14qdxW+Th+wABIq
         /b9vkrCZPV6XHy53P8j1+72fZzTFXvXspvGN+9FePD1+RXGgDe+pEko1wm8UGXUL5h0A
         cgbA==
X-Gm-Message-State: AOAM531Xhsa2Epj3XNWw+i69XxbcgHCH4ILeSf3WyM7yCELV8CqqBmAn
        lSUhSgTEj+c3FVS03WsfeSU=
X-Google-Smtp-Source: ABdhPJyV6LTIV3eQhlgRvDRng5tA3Ts5Kxk4NUa62fM11thJhBU9qJbpTyV/DZ9TiMeGjTn2MX6IfQ==
X-Received: by 2002:a17:90a:ff0f:: with SMTP id ce15mr1996245pjb.15.1616569048481;
        Tue, 23 Mar 2021 23:57:28 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:7dfa:1e53:536:7976])
        by smtp.gmail.com with ESMTPSA id a65sm1268299pfb.116.2021.03.23.23.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 23:57:27 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Tue, 23 Mar 2021 23:57:25 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, gregkh@linuxfoundation.org,
        surenb@google.com, joaodias@google.com, willy@infradead.org,
        digetx@gmail.com
Subject: Re: [PATCH v6] mm: cma: support sysfs
Message-ID: <YFri1Qn1YorOPvsM@google.com>
References: <20210324010547.4134370-1-minchan@kernel.org>
 <cbe10402-6574-6e46-9fd9-98b503bd26a4@nvidia.com>
 <YFqxm7UQBtWqH6VU@google.com>
 <d224c6bd-f5b1-74f6-2afc-c3d5b0519ba4@nvidia.com>
 <YFrRugjVLlazTNPy@google.com>
 <71b7914d-d9ff-2200-d6c9-6eab28499887@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71b7914d-d9ff-2200-d6c9-6eab28499887@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 11:26:08PM -0700, John Hubbard wrote:
> On 3/23/21 10:44 PM, Minchan Kim wrote:
> > On Tue, Mar 23, 2021 at 09:47:27PM -0700, John Hubbard wrote:
> > > On 3/23/21 8:27 PM, Minchan Kim wrote:
> > > ...
> > > > > > +static int __init cma_sysfs_init(void)
> > > > > > +{
> > > > > > +	unsigned int i;
> > > > > > +
> > > > > > +	cma_kobj_root = kobject_create_and_add("cma", mm_kobj);
> > > > > > +	if (!cma_kobj_root)
> > > > > > +		return -ENOMEM;
> > > > > > +
> > > > > > +	for (i = 0; i < cma_area_count; i++) {
> > > > > > +		int err;
> > > > > > +		struct cma *cma;
> > > > > > +		struct cma_kobject *cma_kobj;
> > > > > > +
> > > > > > +		cma_kobj = kzalloc(sizeof(*cma_kobj), GFP_KERNEL);
> > > > > > +		if (!cma_kobj) {
> > > > > > +			kobject_put(cma_kobj_root);
> > > > > > +			return -ENOMEM;
> > > > > 
> > > > > This leaks little cma_kobj's all over the floor. :)
> > > > 
> > > > I thought kobject_put(cma_kobj_root) should deal with it. No?
> > > > 
> > > If this fails when i > 0, there will be cma_kobj instances that
> > > were stashed in the cma_areas[] array. But this code only deletes
> > > the most recently allocated cma_kobj, not anything allocated on
> > > previous iterations of the loop.
> > 
> > Oh, I misunderstood that destroying of root kobject will release
> > children recursively. Seems not true. Go back to old version.
> > 
> > 
> > index 16c81c9cb9b7..418951a3f138 100644
> > --- a/mm/cma_sysfs.c
> > +++ b/mm/cma_sysfs.c
> > @@ -80,20 +80,19 @@ static struct kobj_type cma_ktype = {
> >   static int __init cma_sysfs_init(void)
> >   {
> >          unsigned int i;
> > +       int err;
> > +       struct cma *cma;
> > +       struct cma_kobject *cma_kobj;
> > 
> >          cma_kobj_root = kobject_create_and_add("cma", mm_kobj);
> >          if (!cma_kobj_root)
> >                  return -ENOMEM;
> > 
> >          for (i = 0; i < cma_area_count; i++) {
> > -               int err;
> > -               struct cma *cma;
> > -               struct cma_kobject *cma_kobj;
> > -
> >                  cma_kobj = kzalloc(sizeof(*cma_kobj), GFP_KERNEL);
> >                  if (!cma_kobj) {
> > -                       kobject_put(cma_kobj_root);
> > -                       return -ENOMEM;
> > +                       err = -ENOMEM;
> > +                       goto out;
> >                  }
> > 
> >                  cma = &cma_areas[i];
> > @@ -103,11 +102,21 @@ static int __init cma_sysfs_init(void)
> >                                             cma_kobj_root, "%s", cma->name);
> >                  if (err) {
> >                          kobject_put(&cma_kobj->kobj);
> > -                       kobject_put(cma_kobj_root);
> > -                       return err;
> > +                       goto out;
> >                  }
> >          }
> > 
> >          return 0;
> > +out:
> > +       while (--i >= 0) {
> > +               cma = &cma_areas[i];
> > +
> > +               kobject_put(&cma->kobj->kobj);
> 
> 
> OK. As long as you are spinning a new version, let's fix up the naming to
> be a little better, too. In this case, with a mildly dizzying mix of cma's
> and kobjects, it actually makes a real difference. I wouldn't have asked,
> but the above cma->kobj->kobj chain really made it obvious for me just now.
> 
> So instead of this (in cma.h):
> 
> struct cma_kobject {
> 	struct cma *cma;
> 	struct kobject kobj;
> };
> 
> struct cma {
> ...
> 	struct cma_kobject *kobj;
> };
> 
> , how about approximately this:
> 
> struct cma_kobject_wrapper {
> 	struct cma *parent;
> 	struct kobject kobj;
> };
> 
> struct cma {
> ...
> 	struct cma_kobject_wrapper *cma_kobj_wrapper;
> };
> 
> 
> ...thus allowing readers of cma_sysfs.c to read that file more easily.

I agree cma->kobj->kobj is awkward but personally, I don't like the
naming: cma_kobject_wrapper parent pointer. cma_kobject is alredy
wrapper so it sounds me redundant and it's not a parent in same
hierarchy.

Since the kobj->kobj is just one line in the code(I don't imagine
it could grow up in cma_sysfs in future), I don't think it would
be a problem. If we really want to make it more clear, maybe?

   cma->cma_kobj->kobj

It would be consistent with other variables in cma_sysfs_init.
