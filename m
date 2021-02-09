Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB8EC315B7F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 01:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234323AbhBJAnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 19:43:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233236AbhBIVOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 16:14:14 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7CF5C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 13:13:20 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id e9so2438783pjj.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 13:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ieB/biVTY4vKrZAPByaxJHrLYUL6onrueziYKauUuSU=;
        b=tZyzAnPrQGc1sFSnWIDCRC0EgY3zJnF4QDlcn2s5oqdg9vyIvmZDz3Pu49Pbcc+sdk
         sVeLcMlzjNxwEakd6+kVHpACDecZUmJxmkS/4PFB3t37tVIA9KD8mIHWGJ/fUza211Ba
         PlvlwOBAlHvJZME0EVbA07AjcsHrDfq33F7oBAjHA2sVfMOpWhVU4dFhBe2m0Bz2SURA
         dqrUkYh4d7+XsEuehMC+Qcr7Qmq40DitzbnFCxXs9BP5+EJZrlgPVo4iJmwULEc2T1nb
         uaumwo1iLkrJuX9CR9YHAUkv1TGoqlpLfVrp6E+bvJsuYY49s6ob6WTrkjtilEW+Xwo6
         +RXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=ieB/biVTY4vKrZAPByaxJHrLYUL6onrueziYKauUuSU=;
        b=bOx8LqTbQEbAmvCTSSMXQxccdKnfcf+EoYP0iF3qFibKuyPZJlNvJt2jz5DbcIGnIP
         VUGIW7290FfU8+0ImnKT5g/fTjp7K/Kn2JPz/Nyed7TaOld57xvJ1uuWuYlYn4W5zoPz
         EMpXWHYzeymYJjR74uIH0yVvZXNHZkxYSCK9d7ftj05qYjniDJyhieXu4Z7hg3w8u61M
         XRu3b1JM/8/f0cXEvElpY87Z67VpXzxiqayF7mxH3SSU+A2/F6YjE6tBVo9xalEUc4KX
         dtpk58dw2aWtzioe3oxTn+lMOQIJLMvY6krLYdNpwZAexws8kaIC5Jk2W/1b3V7Yg69I
         WgzA==
X-Gm-Message-State: AOAM53224ICKiqC4qfjQ4/6MP6UrDlPSIhRFMevVYW9DFYWbp9iU50c9
        q7fUhpApqMU9SWrsKP3RE6o=
X-Google-Smtp-Source: ABdhPJw+i7IlVhVSpYlxESYFw3ZKOS7c/pZzlfqzzXVHQ5uOP/aFC9oaDeHKCjREo1S5a5Pzzl6j5g==
X-Received: by 2002:a17:902:464:b029:e2:ebb4:9251 with SMTP id 91-20020a1709020464b02900e2ebb49251mr7812750ple.29.1612905200252;
        Tue, 09 Feb 2021 13:13:20 -0800 (PST)
Received: from google.com ([2620:15c:211:201:d107:fbfb:a7c8:913e])
        by smtp.gmail.com with ESMTPSA id b15sm160998pfi.38.2021.02.09.13.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 13:13:19 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Tue, 9 Feb 2021 13:13:17 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, surenb@google.com,
        joaodias@google.com, willy@infradead.org
Subject: Re: [PATCH v2] mm: cma: support sysfs
Message-ID: <YCL67QzPiyRhhbor@google.com>
References: <e01c111b-fb20-0586-c7a9-dd6d922c0e57@nvidia.com>
 <YCHLAdabGmm7kqSH@google.com>
 <43cd6fc4-5bc5-50ec-0252-ffe09afd68ea@nvidia.com>
 <YCIoHBGELFWAyfMi@kroah.com>
 <7cc229f4-609c-71dd-9361-063ef1bf7c73@nvidia.com>
 <cd33f8b9-89e0-05bd-2b16-85855f7541bb@nvidia.com>
 <YCIyHuOX3E+tP+AO@kroah.com>
 <YCKwjz0uDPBhbFr5@google.com>
 <YCLLKDEQ4NYqb5Y5@kroah.com>
 <09e60732-6a46-dd00-f9d5-4ef17ee685c8@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09e60732-6a46-dd00-f9d5-4ef17ee685c8@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 09, 2021 at 12:11:20PM -0800, John Hubbard wrote:
> On 2/9/21 9:49 AM, Greg KH wrote:
> > > > That's fine if you want to add it to the parent.  If so, then the
> > > > kobject controls the lifetime of the structure, nothing else can.
> > > 
> > > The problem was parent object(i.e., struct cma cma_areas) is
> > > static arrary so kobj->release function will be NULL or just
> > > dummy. Is it okay? I thought it was one of the what you wanted
> > > to avoid it.
> > 
> > No, that is not ok.
> > 
> > > > Either is fine with me, what is "forbidden" is having a kobject and
> > > > somehow thinking that it does not control the lifetime of the structure.
> > > 
> > > Since parent object is static arrary, there is no need to control the
> > > lifetime so I am curious if parent object approach is okay from kobject
> > > handling point of view.
> > 
> > So the array is _NEVER_ freed?  If not, fine, don't provide a release
> > function for the kobject, but ick, just make a dynamic kobject I don't
> > see the problem for something so tiny and not very many...
> > 
> 
> Yeah, I wasn't trying to generate so much discussion, I initially thought it
> would be a minor comment: "just use an embedded struct and avoid some extra
> code", at first.
> 
> > I worry that any static kobject might be copied/pasted as someone might
> > think this is an ok thing to do.  And it's not an ok thing to do.
> > 
> 
> Overall, then, we're seeing that there is a small design hole: in order
> to use sysfs most naturally, you either much provide a dynamically allocated
> item for it, or you must use the static kobject, and the second one sets a
> bad example.
> 
> I think we should just use a static kobject, with a cautionary comment to
> would-be copy-pasters, that explains the design constraints above. That way,
> we still get a nice, less-code implementation, a safe design, and it only
> really costs us a single carefully written comment.
> 
> thanks,

Agreed. How about this for the warning part?

+
+/*
+ * note: kobj_type should provide a release function to free dynamically
+ * allocated object since kobject is responsible for controlling lifespan
+ * of the object. However, cma_area is static object so technially, it
+ * doesn't need release function. It's very exceptional case so pleaes
+ * do not follow this model.
+ */
 static struct kobj_type cma_ktype = {
        .sysfs_ops = &kobj_sysfs_ops,
        .default_groups = cma_groups
+       .release = NULL, /* do not follow. See above */
 };

