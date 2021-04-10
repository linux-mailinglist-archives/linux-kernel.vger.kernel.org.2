Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D11335ACC8
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 12:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234595AbhDJK6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 06:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234507AbhDJK6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 06:58:31 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A6FC061762;
        Sat, 10 Apr 2021 03:58:16 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id r22so9378006edq.9;
        Sat, 10 Apr 2021 03:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to;
        bh=rXYsHG3mre/V1Rg4udvEnf6Zyhecq0scL5Z8jX06kJE=;
        b=ejFKL3jofImx/+4W0WfCPMDVP9qon0V8sVEmSSrzDl+mN+CFVeLw+Ccojknv+GEVSb
         4FQBxrp+0hG62BC79GScl9tYP4gxbToBy9xJM3FXuzE/7CGeQwJN0YOAGUiGgsMtk3ay
         j3soYxvidxwpRKaEuHBmNSIwyweUMOz31QYMjE5daL0oTRKnIvHdJ0KTUfTViHr1+Umz
         22ud7RMUhSfNcDQzA8ZC4abiyXCPFewq+Vemow3N8zAn1r/ZfaEk+lkBiv/m2+ogCMoQ
         K8VEDtAjHVJUIQVPAORgdxRfWc5MpPsXE6WVqnbxYgf32r6ejAihkAtJMkA45OnCWd3D
         G9QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to;
        bh=rXYsHG3mre/V1Rg4udvEnf6Zyhecq0scL5Z8jX06kJE=;
        b=ffumJx2PJyfUuRr5mP3RROBcM1mjWcVJaF8OyJezT9RQHMnbyUzl6VWu43ehDKv4Wy
         DxRoNeCFcPNchZuro7g8m00Ddzlr32zKLvUMYCWZVaBMKYYwST9IamtL/LEt327tV9oB
         1s1xJfJKZZ8pW+mAqnrCXbcDd1ac6QKLS2vqAqhNA0sfTdqbwjsz50IRp0xId+voOubX
         aYauFmkbEUBVixblffUfZZ0oN6XpclPx060aeyBcY+HaLSk8arZmyA5pGDQawc5pJLx2
         kWAFy9P1LEu76/9Kif0S7/DpCTZrZ9CvMEQzkur8XC4+zKR+Ve0x52Luds+61POyGR50
         th+A==
X-Gm-Message-State: AOAM532lyR3UsqxuR13wLCL9a5pPlLYPWsy+hVbp5ghQdSyOX1OavByJ
        Vtv5ycKcKeiYwAwkqVEzIxo=
X-Google-Smtp-Source: ABdhPJwD2huBIGY1JQUImXC1zPdJeA0+yCL5ahszNVf+Orz2fpn1/PZjAa1tREwuaIn/ooYQXATB9g==
X-Received: by 2002:a05:6402:350b:: with SMTP id b11mr20899457edd.288.1618052295285;
        Sat, 10 Apr 2021 03:58:15 -0700 (PDT)
Received: from localhost.localdomain ([2a02:2454:826:3e00:ced:ed1a:293:c96])
        by smtp.gmail.com with ESMTPSA id o17sm2888503edt.10.2021.04.10.03.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Apr 2021 03:58:14 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
To:     Greg KH <greg@kroah.com>
Cc:     SeongJae Park <sj38.park@gmail.com>, akpm@linux-foundation.org,
        SeongJae Park <sjpark@amazon.de>, Jonathan.Cameron@huawei.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        amit@kernel.org, benh@kernel.crashing.org,
        brendanhiggins@google.com, corbet@lwn.net, david@redhat.com,
        dwmw@amazon.com, elver@google.com, fan.du@intel.com,
        foersleo@amazon.de, gthelen@google.com, guoju.fgj@alibaba-inc.com,
        mgorman@suse.de, minchan@kernel.org, mingo@redhat.com,
        namhyung@kernel.org, peterz@infradead.org, riel@surriel.com,
        rientjes@google.com, rostedt@goodmis.org, rppt@kernel.org,
        shakeelb@google.com, shuah@kernel.org, snu@amazon.de,
        vbabka@suse.cz, vdavydov.dev@gmail.com, zgf574564920@gmail.com,
        linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v27 07/13] mm/damon: Implement a debugfs-based user space interface
Date:   Sat, 10 Apr 2021 12:57:59 +0200
Message-Id: <20210410105759.12611-1-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <YHFn5fOTIQQ4TXHA@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

On Sat, 10 Apr 2021 10:55:01 +0200 Greg KH <greg@kroah.com> wrote:

> On Thu, Apr 08, 2021 at 01:48:48PM +0000, SeongJae Park wrote:
> > +static int dbgfs_fill_ctx_dir(struct dentry *dir, struct damon_ctx *ctx)
> > +{
> > +	const char * const file_names[] = {"attrs", "target_ids"};
> > +	const struct file_operations *fops[] = {&attrs_fops, &target_ids_fops};
> > +	int i;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(file_names); i++)
> > +		debugfs_create_file(file_names[i], 0600, dir, ctx, fops[i]);
> > +
> > +	return 0;
> > +}
> 
> Why do you have a function that can only return 0, actually return
> something?  It should be void, right?

You're right, I will make it return void in the next spin.


Thanks,
SeongJae Park

> 
> thanks,
> 
> greg k-h
> 
