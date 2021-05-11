Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4279E37A6F7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 14:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbhEKMoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 08:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbhEKMoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 08:44:11 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54397C061574
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 05:43:05 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id b7so24931332ljr.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 05:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/gumHvNEpc1nJPYB2ZuwIChFIQ8bIFdIers85eOwvkQ=;
        b=T4KJQj2WH+Er8/Ehrytm2qxTVOzlSNvDURXiOB6xEn+TFsvRlb85p1bGeLhAPF6vI2
         zSThknurOtcuHK/8smbDBJSclZ2FOwvi2QmCJirGSFCgXKI4LqjCmcya8dW20uK4Sv0L
         SOn7ZgD3WfkEysYbn7rNz7LF4NKyR+LrPaIR6XaGoLCrbDx2PiFPRkLC9ZIJZy07QFSs
         6DEmG1rH7B8iDpCmSL+/11Ck3nCeU+sfm0tdpn/KoxvAKbvVbxoslh+Y8cxOlayr+ie0
         ugWZThQ/ARqXbti0pwqysne5TjLUvwRhgV+rfsa3/e+LrmXKZ870hqbnQyBJ79e7rUwJ
         V/DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/gumHvNEpc1nJPYB2ZuwIChFIQ8bIFdIers85eOwvkQ=;
        b=IAPuiSjyfCYardw6PI5PRxTF0/mI9BRoq6g9ZqeN9nKqJqN35Wdwk7/q/p0n9nNd5H
         8OpVweK/MjvQoxSvUtTdwgsA5UPycBCuZ05WFk6n5m1TzSfRhAbeS+VIiPuHuuSCUP6X
         Gh4EtswCkf34MdlDpDTA7B7J2zR2bGhvHq+Y4lhsds91huojym//rQu0tt4dQr1yNw4d
         2tw29JSk69T28gahl0DB0VlOVEDxWoaKSKYl5TJoVFSXUbm4rqsJQmPr/isUUxaEKsdW
         9RK67iUcU8OTE67DcCypJg0Z84BC8Z2pJZ94eoQhNt1L4vBoH0hny8/4fnUpyzhVFwvZ
         dd9g==
X-Gm-Message-State: AOAM5320P4GfRgF+V3ygZImRldcyrDz8alpOul3an8Xi1a3sl/aGQYAV
        i5MtOA7UgUKlqsY10igz2UV9psdgjexy9Q==
X-Google-Smtp-Source: ABdhPJwR9kobPCnS7ONfYw5OImQ3RMIaMNymPrVOMmTAV3mMZGZbIEinw0TGspacatyMq9Ubti/sUg==
X-Received: by 2002:a05:651c:485:: with SMTP id s5mr24752636ljc.364.1620736983819;
        Tue, 11 May 2021 05:43:03 -0700 (PDT)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id k13sm2587742lfu.136.2021.05.11.05.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 05:43:03 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Tue, 11 May 2021 14:43:01 +0200
To:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Mel Gorman <mgorman@suse.de>, Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 2/2] mm/vmalloc: Print a warning message first on
 failure
Message-ID: <20210511124301.GA1897@pc638.lan>
References: <20210509193844.2562-1-urezki@gmail.com>
 <20210509193844.2562-2-urezki@gmail.com>
 <YJg8QO2JXm0+8UH6@casper.infradead.org>
 <20210509200519.GA3016@pc638.lan>
 <YJhDpkpdUKiNEAnt@casper.infradead.org>
 <20210509212641.GA3220@pc638.lan>
 <20210510103342.GA2169@pc638.lan>
 <20210510185238.787adc7378bc6d82262399d2@linux-foundation.org>
 <YJnkurvLPolj+RHU@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJnkurvLPolj+RHU@casper.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2021 at 02:58:18AM +0100, Matthew Wilcox wrote:
> On Mon, May 10, 2021 at 06:52:38PM -0700, Andrew Morton wrote:
> > On Mon, 10 May 2021 12:33:42 +0200 Uladzislau Rezki <urezki@gmail.com> wrote:
> > 
> > > Please find the v4 version of the patch that is in question:
> > > 
> > > >From 7e27e4ac8f299ae244e9e0e90e0292ae2c08d37d Mon Sep 17 00:00:00 2001
> > > From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
> > > Date: Sat, 8 May 2021 23:41:21 +0200
> > > Subject: [PATCH v4 1/1] mm/vmalloc: Print a warning message first on failure
> > 
> > Added, thanks.
> > 
> > Matthew has a point of course, but I do think that any console driver
> > which tries to allocate memory within the cotext of printk() is so
> > pathetic that it isn't worth compromising core code to cater for it...
> 
> I'm fine with v4 of this patch, fwiw.  I saw no advantage to the earlier
> version, but now that the advantage has been explained, the advantage
> outweighs the disadvantage.

Thanks!

The point about an extra memory for printk is correct. From the other
hand i am not able to recall issues related to lack of memory for
printk() to emit a message. At least on our mobile devices i have not
seen such scenarios.

--
Vlad Rezki
