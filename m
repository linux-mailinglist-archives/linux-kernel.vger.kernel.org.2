Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD09E32D6DB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 16:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235129AbhCDPki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 10:40:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235254AbhCDPkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 10:40:18 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567A5C061574
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 07:39:38 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id u12so7278874pjr.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 07:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7PEd9K2shZo0+enCRN097OVkI/lutZDfIjtwU/9mChQ=;
        b=a7QvvD+SuagbYbASgQQVDgior6phI4kmHd/ZTbp9NQ264aGh5YRehmfTz5u9B08YUy
         HER9OzPPtcQkU6sTgdUkZAofS3xlNHTqZyvGclnXD3DR2f7YSwJPrdEGpGVXN2ht7cD0
         QaxyvHHse+pdyjiBQ3TOtMIaRGRwB4sfKMSofKloGjxWRWWnE+X0/aGSzHIV9RjKF0dD
         1sS+tBzeKo/n3bKs64syGFA01HClP2RWSdvZiEdXCPEE514XAjrbgD+k6xt2cX7gwlWJ
         8eFFOwJWPHmCkFDch00JakWrFcolX1gSHPCCTW5QVLVki7CnrdwL5VbEX/pgJY5iRriA
         oh1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=7PEd9K2shZo0+enCRN097OVkI/lutZDfIjtwU/9mChQ=;
        b=gxEuR+tBZht5dakY56krMJUeY/G7AsMjoafpaIRZCCoRTYSkF+7+vb/TI5lJwD/mil
         i+tu+5MjeajlOQP5h8nJgPIaiw4QoHKRxh/kjYaOGT1S8TZ09kerjjDyA9Xp+Yub5yvu
         534bSKpq7NrYLZy5VZmGod1F59+vng5uG4b6ljawECXtCEp9jsId8phJe+8OVOHmFSBe
         5Wr1jlVkyjo3/iGY67IJY8A3FaQG8GygCQQIt2JQSN1XP33u45hLdlX5TbtEPnjlgFLz
         zfYMVt1P5GKPsjZDqo2dr5EFtKdRjSBnsN7E8DKpeVuV+SiVZkPlQdYNMCzx3Vg4uJgc
         o+KQ==
X-Gm-Message-State: AOAM532n1nluuHWYnR/PxYLOkXqZ5KIRi2mDKpjH0L3br5ocwCVv2/kK
        yc3JH+sFhNMpv3fhdq7D4Gk=
X-Google-Smtp-Source: ABdhPJzLGzILag6pL7kIk9p896rFsyUTaYOrqB3BoKc35ScpRSS3wRaukfTugRRffJEU4ZZSa+cpyA==
X-Received: by 2002:a17:90a:cd06:: with SMTP id d6mr5084566pju.138.1614872377877;
        Thu, 04 Mar 2021 07:39:37 -0800 (PST)
Received: from google.com ([2620:15c:211:201:edb1:8010:5c27:a8cc])
        by smtp.gmail.com with ESMTPSA id x7sm6842132pjr.7.2021.03.04.07.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 07:39:36 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 4 Mar 2021 07:39:34 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        joaodias@google.com, willy@infradead.org, surenb@google.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v3] mm: cma: support sysfs
Message-ID: <YED/NlZJ9QmMss4I@google.com>
References: <20210303205053.2906924-1-minchan@kernel.org>
 <20210303144449.aa69518bfbaec9c71f799dc7@linux-foundation.org>
 <YEA6BGHO0I1hSjLq@google.com>
 <20210303220957.0525de2aebc2c55ad9435cdc@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210303220957.0525de2aebc2c55ad9435cdc@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2021 at 10:09:57PM -0800, Andrew Morton wrote:
> On Wed, 3 Mar 2021 17:38:12 -0800 Minchan Kim <minchan@kernel.org> wrote:
> 
> > > >  #endif
> > > >  	char name[CMA_MAX_NAME];
> > > > +#ifdef CONFIG_CMA_SYSFS
> > > > +	struct cma_stat	*stat;
> > > > +#endif
> > > >  };
> > > 
> > > Why aren't the stat fields simply placed directly into struct cma_stat?
> > 
> > It have a related long discussion.
> > https://lore.kernel.org/linux-mm/YCIoHBGELFWAyfMi@kroah.com/
> > https://lore.kernel.org/linux-mm/YCLLKDEQ4NYqb5Y5@kroah.com/
> > 
> > TLDR - Greg really want to see kobject stuff working as dynamic
> > property.
> 
> Please add to changelog?

Sure.

> 
> > > 
> > > ?
> > > 
> > > > +	if (!cma_stats) {
> > > > +		pr_err("failed to create cma_stats\n");
> > > 
> > > Probably unneeded - the ENOMEM stack backtrace will point straight here.
> > 
> > I failed to find the point you mentioned to print backtrace.
> > Where code do you mean to dump the backtrace?
> 
> The thing which __GFP_NOWARN disables.

Got the point.
