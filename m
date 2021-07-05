Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85A303BC127
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 17:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbhGEPqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 11:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231807AbhGEPqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 11:46:05 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C09DC061574
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jul 2021 08:43:28 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id e3so16726942ljo.6
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jul 2021 08:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2I5OKuYkuayNi3jHus1jYSAwzTCOsFOu/KrA6yZe8wQ=;
        b=UwdjJmRC2FPpEevnGhbuOw8NfdenTTA5NuAYSOYRBGGZyzkiNBu9flp8dnM/L3c+7W
         tn44osMbt1E7x3ikTawc2+hef7gL+U0mhsA4UTCqnoQMRSZSJfion5EWCzJVEVj2k/Iv
         +3yytyfgzON+MSikkOdTdFoYMfvzYujBJZwKRmlPlxxZkB7NpM+FSmnWszX/x9vt2wSJ
         Qr1h/JV9JckqEHatGNs8Urm5Co6StHOQLoNIuJ99GMcveIjICpNaNln6i5BX60p6mdkv
         ID/MRdwNvSiqiVFPb3TcAft6yMTIRAza4cuVmetNvDP2ewWM8IJ4TBDklknriN4s57Xa
         SLZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2I5OKuYkuayNi3jHus1jYSAwzTCOsFOu/KrA6yZe8wQ=;
        b=lzu+h0C39ILqc4TPx0Zm54G3lQecZzZ4GrNxC5HbByEsnsXmfGWwXkBbyTfBjPdchg
         OOkGmOgst4d1iN+hpBXImw/kddT1Fp78GU0hS66EWtAK83g6xwB/nwN1cT+ECcMAAVwZ
         h9pP0cySLIV+nkqLlBp2zZYVHJc/w0zPMLLbxUF4+rfC5oKglVkanoG2ZIjKY4YD2mJ4
         ekIKuY2bUpp+Ee7v+LQaKxX7Apj9rOEwbawDQ85HgaCti1xAsG9+iDK7IMGjSv6EvqHY
         ekzNDVdQtgVSOtktljSsbZI9+Z9XRvOgUK2IGNpRTXVSmqh+f19Pcn6RDQjrq1hFp2Fb
         SXGg==
X-Gm-Message-State: AOAM532mptyrKqMR6yseN4250DiKnBecJSG/lwmLpBikUcIXE3Nl33Y6
        SU1OShkUz4u6XBstnlcIF2sYZIhD6P4fDQ==
X-Google-Smtp-Source: ABdhPJx231U6ypU1O4mZwtPAtUZFzUu5GDqICu5JX6qZcz3iV7wQ9IusC0/Q9rboDx05O31nh/kvdQ==
X-Received: by 2002:a05:651c:1689:: with SMTP id bd9mr11250046ljb.373.1625499806661;
        Mon, 05 Jul 2021 08:43:26 -0700 (PDT)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id i130sm1112860lfd.304.2021.07.05.08.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 08:43:26 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Mon, 5 Jul 2021 17:43:24 +0200
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Christoph Hellwig <hch@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] mm/vmalloc: Use batched page requests in bulk-allocator
Message-ID: <20210705154324.GA41292@pc638.lan>
References: <20210705145547.41206-1-urezki@gmail.com>
 <YOMmKo1FMNz048zV@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YOMmKo1FMNz048zV@casper.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, Jul 05, 2021 at 04:55:47PM +0200, Uladzislau Rezki (Sony) wrote:
> > +			if (gfpflags_allow_blocking(gfp))
> > +				cond_resched();
> 
> How does one call vmalloc() with gfp flags that _don't_ allow blocking?
> They have to allow a GFP_KERNEL allocation of the page tables.
> So I think this should be an unconditional cond_resched().
Historically it is there. I decided to align with below code. But i agree
vmalloc is sleepable anyway, so blocking is supposed.

OK, i will respin and send out two patches. 

--
Vlad Rezki
