Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 473B331533E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 16:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232561AbhBIP4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 10:56:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232419AbhBIP4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 10:56:44 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80CDDC061574
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 07:56:03 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id x9so9981234plb.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 07:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=RLLY3Kifgt8whTtEjTDT7sURhhrgrsnEjHhUvPN+ANU=;
        b=KwLsh6fpusewnWWexKKtZ5jK9Hz+r9MkMVjPSUeOQt4wtQLkbvzuUhMOL5jl7Nfc/3
         3xsV/0Szxzec0zLgWs5FJiiZBR2J+Ggc3YMR5/zAJkSRTQXTR9Jv87X/Hpu5U0+0eP/l
         Ji2WPP0t56jRBYam45Zh/bsvYge+3jkhDuWkWpvYqel0M0e/CdFSHzNDbJiXp4n9Su0Q
         h6CzpVyyFaJNFGF2Z29LXZy/q5g5hxgImllBKNhmM7ea7e+JpoNz6BaCdF8+4DnbU9k9
         0VJ8nL5hznLBuQ1p1YNgK0FyUuRRKZWBw8QZSCW3mv7Ai9IImnMIJVKs8vzBjKAIg7oH
         2/yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=RLLY3Kifgt8whTtEjTDT7sURhhrgrsnEjHhUvPN+ANU=;
        b=Q1YxP0SF+fms75YPPvW5mfYxAX2zkVPmw+uSKHwDx3C3PSFHAz/9SvrEqbfqjTODti
         hATDfl2lfHhMGAXCeii6w2oXvq2lKjs8Wg+SR7rhNCeHFAn+lUk9el1VVJcdbcVOikba
         mge1uZdFlVuUNPnJSxYtHDAexHupqbyls99OV91QMhWuuCFSQ+4fxh47uqJxktQV5mlQ
         4rweT6Z4iJniQ0KAI+EO0/UkF4N3WZACJIezA+RTvl4lDGdva8U9Gm6iqvgaiBvdNnXq
         aaCJZvnYS1tIj4kaMiAvbGe3fc+o1etb2TCXnNkqUtGzxjmQ4EvNr4NrRUd08C4hy/5P
         aEhw==
X-Gm-Message-State: AOAM530RHK9buQXNgcLmhL9tvbsuQpSRj9+p9u4QYy9G1m2nA4xr3MRX
        MEJEc4FXWg8Ztl6GNytwncQ=
X-Google-Smtp-Source: ABdhPJwY1X+a9UW2Q70a0LSbQJhTJ7xRLtjwcPyb7TRVW+yxStYhcyVczMFKyVTddKK48sBpTlWKFw==
X-Received: by 2002:a17:90a:6589:: with SMTP id k9mr4618070pjj.100.1612886163051;
        Tue, 09 Feb 2021 07:56:03 -0800 (PST)
Received: from google.com ([2620:15c:211:201:d107:fbfb:a7c8:913e])
        by smtp.gmail.com with ESMTPSA id 25sm14762989pfh.199.2021.02.09.07.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 07:56:01 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Tue, 9 Feb 2021 07:55:59 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, surenb@google.com,
        joaodias@google.com, willy@infradead.org
Subject: Re: [PATCH v2] mm: cma: support sysfs
Message-ID: <YCKwjz0uDPBhbFr5@google.com>
References: <20210208180142.2765456-1-minchan@kernel.org>
 <e01c111b-fb20-0586-c7a9-dd6d922c0e57@nvidia.com>
 <YCHLAdabGmm7kqSH@google.com>
 <43cd6fc4-5bc5-50ec-0252-ffe09afd68ea@nvidia.com>
 <YCIoHBGELFWAyfMi@kroah.com>
 <7cc229f4-609c-71dd-9361-063ef1bf7c73@nvidia.com>
 <cd33f8b9-89e0-05bd-2b16-85855f7541bb@nvidia.com>
 <YCIyHuOX3E+tP+AO@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YCIyHuOX3E+tP+AO@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 09, 2021 at 07:56:30AM +0100, Greg KH wrote:
> On Mon, Feb 08, 2021 at 10:34:51PM -0800, John Hubbard wrote:
> > On 2/8/21 10:27 PM, John Hubbard wrote:
> > > On 2/8/21 10:13 PM, Greg KH wrote:
> > > > On Mon, Feb 08, 2021 at 05:57:17PM -0800, John Hubbard wrote:
> > > > > On 2/8/21 3:36 PM, Minchan Kim wrote:
> > > > > ...
> > > > > > > >         char name[CMA_MAX_NAME];
> > > > > > > > +#ifdef CONFIG_CMA_SYSFS
> > > > > > > > +    struct cma_stat    *stat;
> > > > > > > 
> > > > > > > This should not be a pointer. By making it a pointer, you've added a bunch of pointless
> > > > > > > extra code to the implementation.
> > > > > > 
> > > > > > Originally, I went with the object lifetime with struct cma as you
> > > > > > suggested to make code simple. However, Greg KH wanted to have
> > > > > > release for kobj_type since it is consistent with other kboject
> > > > > > handling.
> > > > > 
> > > > > Are you talking about the kobj in your new struct cma_stat? That seems
> > > > > like circular logic if so. I'm guessing Greg just wanted kobj methods
> > > > > to be used *if* you are dealing with kobjects. That's a narrower point.
> > > > > 
> > > > > I can't imagine that he would have insisted on having additional
> > > > > allocations just so that kobj freeing methods could be used. :)
> > > > 
> > > > Um, yes, I was :)
> > > > 
> > > > You can not add a kobject to a structure and then somehow think you can
> > > > just ignore the reference counting issues involved.  If a kobject is
> > > > part of a structure then the kobject is responsible for controling the
> > > > lifespan of the memory, nothing else can be.
> > > > 
> > > > So by making the kobject dynamic, you properly handle that memory
> > > > lifespan of the object, instead of having to worry about the lifespan of
> > > > the larger object (which the original patch was not doing.)
> > > > 
> > > > Does that make sense?
> > > > 
> > > That part makes sense, yes, thanks. The part that I'm trying to straighten
> > > out is, why was kobject even added to the struct cma_stat in the first
> > > place? Why not just leave .stat as a static member variable, without
> > > a kobject in it, and done?
> > > 
> > 
> > Sorry, I think I get it now: this is in order to allow a separate lifetime
> > for the .stat member. I was sort of implicitly assuming that the "right"
> > way to do it is just have the whole object use one lifetime management,
> > but as you say, there is no kobject being added to the parent.
> > 
> > I still feel odd about the allocation and freeing of something that seems
> > to be logically the same lifetime (other than perhaps a few, briefly pending
> > sysfs reads, at the end of life). So I'd still think that the kobject should
> > be added to the parent...

sruct cma_stat {
	spinlock_t lock;
	unsigned long pages_attemtp;
	unsigned long pages_fail;
};

struct cma {
	..
	..
	struct kobject kobj;
	struct cma_stat stat;
};

I guess this is what Johan suggested. I agree with it.

> 
> That's fine if you want to add it to the parent.  If so, then the
> kobject controls the lifetime of the structure, nothing else can.

The problem was parent object(i.e., struct cma cma_areas) is
static arrary so kobj->release function will be NULL or just
dummy. Is it okay? I thought it was one of the what you wanted
to avoid it.

> 
> Either is fine with me, what is "forbidden" is having a kobject and
> somehow thinking that it does not control the lifetime of the structure.

Since parent object is static arrary, there is no need to control the
lifetime so I am curious if parent object approach is okay from kobject
handling point of view.

If it's no problem, I am happy to change it.
