Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D32A31164C
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 00:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232157AbhBEXA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 18:00:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232763AbhBEOjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 09:39:22 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33900C061797
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 08:16:48 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id z9so4056517pjl.5
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 08:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3BGzFlUAQdb1rouZCpkNsxXA0DwY6aSbrdFUF09uTgk=;
        b=UEUHugPHt7HM5ez2N8d9x9dAAFqBvDucpyjjQbVkjb7bR4rK6VDphQ2J9y+pbC9vdH
         sUQnI63HiuYHVsEbOG/Q0rFsogRHrWArLz4pJr3DbjVOuHOvCRCa7Dm4+3HSwLNvEaKi
         offUyYMV9mxbkG341DTJi6e2dfpVf6wzht4TulMGyblGBFquBlU20QdH2rnClBVW7Vge
         6Z9hc5Ms2RAKFLWudPodlYviI+cTgxeqiroEbPMgF+G1SMc/xE/D0+wNIyOXcDXcQ7aG
         F0Kvyg56omgdbM5ijD1Gugq56gm0hlM7P7nIelV0JFId47hkfGe+fAjD0tlA73epV1dC
         V2pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=3BGzFlUAQdb1rouZCpkNsxXA0DwY6aSbrdFUF09uTgk=;
        b=Djf/fzE+Pfg68vlCWmEEwrvVNsx3xhnn25d5tYMqISql6nssOR2qifMplg2LV7RrB5
         ifFANZMRwXpB7rkMv4vOb1c8s2Mm2ibedO6gvO2tWAVPX8MC6/bo7CwaH4p2Ta3BHNjo
         5ZCJ/NjwCfamtWD5Mu09aTi76Fs6DVRXG3EzAZq7TCvqZfJ+WWf+/bkpjdb/CaEgQ3hQ
         d/OLGU5eqq/sXoej0VDPBCP5MW6jVYEl1mSb4JQDQUnpuV8RVWomjkoVRBiwtB2kUJXk
         1roXsFA8VfBkD4F42XtEcfZ3HqGlVE2C+1Yg4Xxr7zKNc0cMs108OymI1nsFLgnqQXEv
         1Oqw==
X-Gm-Message-State: AOAM532P+sWw1p8iihvJduwyE+d4vawIByCNG0NOsf270DwT5lVkxjSa
        OVOEZKSbF3uUeY8iiFFN6lE=
X-Google-Smtp-Source: ABdhPJyDkSNH4sKUDDak8FNJ06tWlmYRWP6ZBa73o7N8S/t0LdosidciNj0HF3pD738fnTtIYeNgDg==
X-Received: by 2002:a17:902:bd97:b029:de:abc4:fec7 with SMTP id q23-20020a170902bd97b02900deabc4fec7mr4619076pls.7.1612541807800;
        Fri, 05 Feb 2021 08:16:47 -0800 (PST)
Received: from google.com ([2620:15c:211:201:708b:34cf:3e70:176d])
        by smtp.gmail.com with ESMTPSA id q15sm703709pja.22.2021.02.05.08.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 08:16:46 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Fri, 5 Feb 2021 08:16:44 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        gregkh@linuxfoundation.org, surenb@google.com, joaodias@google.com,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Subject: Re: [PATCH] mm: cma: support sysfs
Message-ID: <YB1vbGJFJM3eLzOo@google.com>
References: <20210203155001.4121868-1-minchan@kernel.org>
 <20210205025526.GG308988@casper.infradead.org>
 <YBzWCl0MVNWntyUZ@google.com>
 <20210205121217.GH308988@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210205121217.GH308988@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 05, 2021 at 12:12:17PM +0000, Matthew Wilcox wrote:
> On Thu, Feb 04, 2021 at 09:22:18PM -0800, Minchan Kim wrote:
> > > > +	for (i = 0; i < cma_area_count; i++) {
> > > > +		cma = &cma_areas[i];
> > > > +		stat = kzalloc(sizeof(*stat), GFP_KERNEL);
> > > > +		if (!stat)
> > > > +			goto out;
> > > 
> > > How many cma areas are there going to be?  do we really want to allocate
> > > their stat individually?
> > 
> > I am not sure what could be in the end but at least, I have
> > 5+ candidates (but could be shrink or extend) and yes,
> > want to keep track them individually.
> 
> I meant, wouldn't it be better to:
> 
> 	cma_stats = kzalloc(array_size(sizeof(*stat), cma_area_count),
> 				GFP_KERNEL);
> 

Definitely.
Thanks, Matthew.
