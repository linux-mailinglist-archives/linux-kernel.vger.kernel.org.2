Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30978315FDF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 08:12:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbhBJHMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 02:12:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231802AbhBJHMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 02:12:48 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 350BCC061574
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 23:12:08 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id fa16so610101pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 23:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kFGPNUhhQB50xXVps4vdmynY8SJPZUPtlpbNEOGKZnI=;
        b=hvz/6eGepcGkJDGjKewmyUyoYjjPx8oEQHmRN76zVQIHgO54xWmEBDZc1Q0nxKWvc2
         DKWYmWmibjGgeKZ+vjnA8FBSstdHUjIQLj6KieCBxlRaCnCkRzKMFay/NZjtzXD2vhHW
         K054ovExaimTdT7XuSS3ahxJm40s/WQzcACjK5DLEtMe8mI4hznpIfXrIUyzSHuxs7Ep
         R9ivB81D4mvc8ncfWsyz2e/j1xF0174jSfaWPnkPrlkxdsH8qJv++S+dZJvliA/vJI84
         91KGrDNpU+0QMIZai18zmDQihoTWW4riDa2qDpJRgqUja4mUZECRR5LvWnOxK/E1yWYZ
         hzzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=kFGPNUhhQB50xXVps4vdmynY8SJPZUPtlpbNEOGKZnI=;
        b=O6ClN0g3B6pOVWgGbloYb9/QXM8epNj1GnhgfhtIDZWRtpIFI9WFFPlONQLqeR25Ub
         rUu/ufURv1oszxNKWtRBvD2N3/iy1sVEC8V13tkANXzkflKXF+F+a10SRSXSQebzS/HG
         i05WEPlfuwGRYLVuml4CsIbV6uUTITr4msy6D9h49sjImxUZdb4eGAMf+4l4QyRNDJxn
         Wq73HviSF/Cw9RETAG+TWMCiVsUIS9meVSeLPRruHoXEzMgqKh6aAp8L4VEhy8RDEC1r
         INeYfkrm+MSWZnpJkuSG5oYgOMUMr10rKVJo+86rpvQ+qXBNJyLKSxr1MBfSWwq2HG0s
         A84A==
X-Gm-Message-State: AOAM533d2mMNqBr8FtuFnJ+VPQbYLuUC/1B/wvtD4InSQpb/l8fdFAwz
        jcw6oyfzbivZHeRaybywMmQ=
X-Google-Smtp-Source: ABdhPJxgE5rSIkVWSlwtBljj1PDLeqLxie1+7xXjrWODa/Ih7si7rbXyjvuv/ROAWpDhXgvKlloQ0Q==
X-Received: by 2002:a17:902:6808:b029:e2:b405:fc0d with SMTP id h8-20020a1709026808b02900e2b405fc0dmr1672959plk.10.1612941127647;
        Tue, 09 Feb 2021 23:12:07 -0800 (PST)
Received: from google.com ([2620:15c:211:201:d107:fbfb:a7c8:913e])
        by smtp.gmail.com with ESMTPSA id q15sm899483pfk.181.2021.02.09.23.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 23:12:06 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Tue, 9 Feb 2021 23:12:04 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, surenb@google.com,
        joaodias@google.com, willy@infradead.org
Subject: Re: [PATCH v2] mm: cma: support sysfs
Message-ID: <YCOHRAAijtCbN+pr@google.com>
References: <43cd6fc4-5bc5-50ec-0252-ffe09afd68ea@nvidia.com>
 <YCIoHBGELFWAyfMi@kroah.com>
 <7cc229f4-609c-71dd-9361-063ef1bf7c73@nvidia.com>
 <cd33f8b9-89e0-05bd-2b16-85855f7541bb@nvidia.com>
 <YCIyHuOX3E+tP+AO@kroah.com>
 <YCKwjz0uDPBhbFr5@google.com>
 <YCLLKDEQ4NYqb5Y5@kroah.com>
 <09e60732-6a46-dd00-f9d5-4ef17ee685c8@nvidia.com>
 <YCL67QzPiyRhhbor@google.com>
 <YCOAmXqt6dZkCQYs@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YCOAmXqt6dZkCQYs@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 07:43:37AM +0100, Greg KH wrote:
> On Tue, Feb 09, 2021 at 01:13:17PM -0800, Minchan Kim wrote:
> > On Tue, Feb 09, 2021 at 12:11:20PM -0800, John Hubbard wrote:
> > > On 2/9/21 9:49 AM, Greg KH wrote:
> > > > > > That's fine if you want to add it to the parent.  If so, then the
> > > > > > kobject controls the lifetime of the structure, nothing else can.
> > > > > 
> > > > > The problem was parent object(i.e., struct cma cma_areas) is
> > > > > static arrary so kobj->release function will be NULL or just
> > > > > dummy. Is it okay? I thought it was one of the what you wanted
> > > > > to avoid it.
> > > > 
> > > > No, that is not ok.
> > > > 
> > > > > > Either is fine with me, what is "forbidden" is having a kobject and
> > > > > > somehow thinking that it does not control the lifetime of the structure.
> > > > > 
> > > > > Since parent object is static arrary, there is no need to control the
> > > > > lifetime so I am curious if parent object approach is okay from kobject
> > > > > handling point of view.
> > > > 
> > > > So the array is _NEVER_ freed?  If not, fine, don't provide a release
> > > > function for the kobject, but ick, just make a dynamic kobject I don't
> > > > see the problem for something so tiny and not very many...
> > > > 
> > > 
> > > Yeah, I wasn't trying to generate so much discussion, I initially thought it
> > > would be a minor comment: "just use an embedded struct and avoid some extra
> > > code", at first.
> > > 
> > > > I worry that any static kobject might be copied/pasted as someone might
> > > > think this is an ok thing to do.  And it's not an ok thing to do.
> > > > 
> > > 
> > > Overall, then, we're seeing that there is a small design hole: in order
> > > to use sysfs most naturally, you either much provide a dynamically allocated
> > > item for it, or you must use the static kobject, and the second one sets a
> > > bad example.
> > > 
> > > I think we should just use a static kobject, with a cautionary comment to
> > > would-be copy-pasters, that explains the design constraints above. That way,
> > > we still get a nice, less-code implementation, a safe design, and it only
> > > really costs us a single carefully written comment.
> > > 
> > > thanks,
> > 
> > Agreed. How about this for the warning part?
> > 
> > +
> > +/*
> > + * note: kobj_type should provide a release function to free dynamically
> > + * allocated object since kobject is responsible for controlling lifespan
> > + * of the object. However, cma_area is static object so technially, it
> > + * doesn't need release function. It's very exceptional case so pleaes
> > + * do not follow this model.
> > + */
> >  static struct kobj_type cma_ktype = {
> >         .sysfs_ops = &kobj_sysfs_ops,
> >         .default_groups = cma_groups
> > +       .release = NULL, /* do not follow. See above */
> >  };
> > 
> 
> No, please no.  Just do it the correct way, what is the objection to
> creating a few dynamic kobjects from the heap?  How many of these are
> you going to have that it will somehow be "wasteful"?
> 
> Please do it properly.

Oh, I misunderstood your word "don't provide a release function for the
kobject" so thought you agreed on John. If you didn't, we are stuck again:
IIUC, the objection from John was the cma_stat lifetime should be on parent
object, which is reasonable and make code simple.
Frankly speaking, I don't have strong opinion about either approach.
John?
