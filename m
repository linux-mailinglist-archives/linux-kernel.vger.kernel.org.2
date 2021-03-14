Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFE2533A272
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 04:11:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234161AbhCNDJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 22:09:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbhCNDJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 22:09:14 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E50C061574
        for <linux-kernel@vger.kernel.org>; Sat, 13 Mar 2021 19:09:14 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id f124so28523698qkj.5
        for <linux-kernel@vger.kernel.org>; Sat, 13 Mar 2021 19:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=d9FM6L9sZAo2rrsIX+LBkCTa7GLlkoS/+ZnZfUaJPW8=;
        b=VpsaiAIWuDHqnqNjIwqWIdgZ3uD96X9TvSKxh2jm8AqRS6twpL3tMOYYyiMPjjyaSX
         X1iZYqFZpd9Ru5UC/aV+3hWz1zhi/EBXS2fbo9aqMqLkW2G8zPBx4j+pnTL5RoSjwoXq
         2nS4KkEguec2wegxlVY60mtloR+mRxUaT/GHPGzVchLzNNRrRZr1jS6kdT3/xyfjX5RK
         G4DyE1rFaWofqZIDLwmBUmRs8dND6RWFbkNxkBHfk2lwXVMXRx97FGGNY4WGvz2l4LIR
         fGip9daBy/n4030RhjMLcDPbLcqdC0rnt8F167J+v5fmsHE6kmeApRIKvCNVbY/GF8cK
         roiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=d9FM6L9sZAo2rrsIX+LBkCTa7GLlkoS/+ZnZfUaJPW8=;
        b=Km+HHt4VILRunCAbAXVhqS5qPdN3uI9Oay3n1NrioVqaqBxDRZO6SCPl6UGUawHjMv
         Ogy30gqjxrOSPoiw4N2m33recfBE6MTB2o5SVBK9xBdHPFQauDAgXFY4xj3hNVe+fh2c
         kHRBJTNVdTPW6StleZ5W2fhGUdFVncvga0JmRq0yUnqlAnK60ARD7aKB0fk5U9yfBVSg
         UxmOfNwplJ9ftnVYnARxeD3vIJK9Ll/TenUZOL8kc9vac/na76/C6Obmy/FAGObhZPjr
         VWbHAuEOCoav92H1ldL1aFtp+S07w3ASxzlUp+xo54B2/1+ic3yyfLUlgj14Rf4vQ3m/
         5ecA==
X-Gm-Message-State: AOAM5338QhIge6J3st6PT5AOQlpfgW2/qBc6QRDj8vRdqsyAN+lZrMkg
        O2XP9kczSz5pVNBOVUjWs8BDaA==
X-Google-Smtp-Source: ABdhPJzdU3lQ5tIu1bVYMh+3OU6wsyRZYbsmX/y79oqjN5rzA3naQ/csu0IRHznx8ME2dAElOZLjgQ==
X-Received: by 2002:a37:5007:: with SMTP id e7mr19793266qkb.184.1615691352628;
        Sat, 13 Mar 2021 19:09:12 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id s2sm7557978qti.54.2021.03.13.19.09.11
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Sat, 13 Mar 2021 19:09:12 -0800 (PST)
Date:   Sat, 13 Mar 2021 19:09:01 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 00/25] Page folios
In-Reply-To: <20210313123658.ad2dcf79a113a8619c19c33b@linux-foundation.org>
Message-ID: <alpine.LSU.2.11.2103131842590.14125@eggly.anvils>
References: <20210305041901.2396498-1-willy@infradead.org> <20210313123658.ad2dcf79a113a8619c19c33b@linux-foundation.org>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Mar 2021, Andrew Morton wrote:
> On Fri,  5 Mar 2021 04:18:36 +0000 "Matthew Wilcox (Oracle)" <willy@infradead.org> wrote:
> 
> > Our type system does not currently distinguish between tail pages and
> > head or single pages.  This is a problem because we call compound_head()
> > multiple times (and the compiler cannot optimise it out), bloating the
> > kernel.  It also makes programming hard as it is often unclear whether
> > a function operates on an individual page, or an entire compound page.
> > 
> > This patch series introduces the struct folio, which is a type that
> > represents an entire compound page.  This initial set reduces the kernel
> > size by approximately 6kB, although its real purpose is adding
> > infrastructure to enable further use of the folio.
> 
> Geeze it's a lot of noise.  More things to remember and we'll forever
> have a mismash of `page' and `folio' and code everywhere converting
> from one to the other.  Ongoing addition of folio
> accessors/manipulators to overlay the existing page
> accessors/manipulators, etc.
> 
> It's unclear to me that it's all really worth it.  What feedback have
> you seen from others?

My own feeling and feedback have been much like yours.

I don't get very excited by type safety at this level; and although
I protested back when all those compound_head()s got tucked into the
*PageFlag() functions, the text size increase was not very much, and
I never noticed any adverse performance reports.

To me, it's distraction, churn and friction, ongoing for years; but
that's just me, and I'm resigned to the possibility that it will go in.
Matthew is not alone in wanting to pursue it: let others speak.

Hugh
