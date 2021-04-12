Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6012835C4FB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 13:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240334AbhDLLXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 07:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240210AbhDLLX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 07:23:26 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B40C061574;
        Mon, 12 Apr 2021 04:23:09 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id h7so9573566qtx.3;
        Mon, 12 Apr 2021 04:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to;
        bh=OgUbXuBzSRofrzBQCx4mAQ2LZNbN5PuQPiNdAazw0Ho=;
        b=ZUBD1jGgN6XVnao7IsxZ1I2FDe29dEXCHyjYN0tFkc5/yUMstzOWmWVrdUT6d7JQPe
         cSE9RueHb8pfoYnq9NQZ5giDoEiqPqdSW2XYpQVIagiyw744yfNUfJHpe9shZFRRevWn
         K/RHIfJjEEcm1YossFY3GwkyJoByA1c2Bo6n9Yo3oUTTVrzeOgKJY6moE8xXa1HJ5DRB
         GNQtn+21D2G7DaUMlRB9003dqJDQEtx4WFx89GfuYZhKp3/nokHREDJ25kiHAsywUPr5
         FBbtSGJ8C1l7nsQEAfy+0qme4+ukv6rjrUdLErJy4nf7uhzD2mhkVylVGLYVTUd8Td2C
         a/tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to;
        bh=OgUbXuBzSRofrzBQCx4mAQ2LZNbN5PuQPiNdAazw0Ho=;
        b=Iv/5n+0hkVzzGBW6JJYlPr13B8S2waNnprJks6d3UoMaeQ8TxvYlYCv8LndaVWirex
         1kT/Kav9AqJrsATDnCX4ZeJAFv5mz4IbGPB5syytnGwbFnsyD1MSouiPMPVhUWejYji3
         ptHwR2ng2mPvFckCEJtFxZ8xDQe9sJRhKQRJz41fN9xKd0QcmRSRWj9RpOGb/vKIFr5G
         6nXKuzEq+iJvprTX/51QrJF3CoXEu7NmeALLfM+V2VrXbXpmkpKty1eYG2yPwv+AflL/
         KnmPkhityzKzVWGRMsIatHZHMbTekutZVgZJRqUeATvjA9Ef6nw8hASdekY8HKyJXEQY
         srKQ==
X-Gm-Message-State: AOAM532S4qW3Ug59rYwU7d4t6jV70lY3RhYMrnMCGuN2Q9dbt0/3SF9n
        /WgyvNYDp/yuKdpGsNW5jqM=
X-Google-Smtp-Source: ABdhPJza0U1rYURiE0BCd/YhE0d1DdciEXOiw0jZ9gDdcstOKZKsaeY/CiqAuyLUfzntVD6f/yblcw==
X-Received: by 2002:ac8:4f4b:: with SMTP id i11mr24829182qtw.284.1618226588408;
        Mon, 12 Apr 2021 04:23:08 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id 81sm6651605qkl.121.2021.04.12.04.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 04:23:07 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
X-Google-Original-From: SeongJae Park <sjpark@amazon.de>
To:     SeongJae Park <sj38.park@gmail.com>
Cc:     akpm@linux-foundation.org, SeongJae Park <sjpark@amazon.de>,
        Jonathan.Cameron@Huawei.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, amit@kernel.org,
        benh@kernel.crashing.org, brendanhiggins@google.com,
        corbet@lwn.net, david@redhat.com, dwmw@amazon.com,
        elver@google.com, fan.du@intel.com, foersleo@amazon.de,
        greg@kroah.com, gthelen@google.com, guoju.fgj@alibaba-inc.com,
        mgorman@suse.de, minchan@kernel.org, mingo@redhat.com,
        namhyung@kernel.org, peterz@infradead.org, riel@surriel.com,
        rientjes@google.com, rostedt@goodmis.org, rppt@kernel.org,
        shakeelb@google.com, shuah@kernel.org, snu@amazon.de,
        vbabka@suse.cz, vdavydov.dev@gmail.com, zgf574564920@gmail.com,
        linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v27 07/13] mm/damon: Implement a debugfs-based user space interface
Date:   Mon, 12 Apr 2021 11:22:56 +0000
Message-Id: <20210412112256.880-1-sjpark@amazon.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210408134854.31625-8-sj38.park@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

On Thu,  8 Apr 2021 13:48:48 +0000 SeongJae Park <sj38.park@gmail.com> wrote:

> From: SeongJae Park <sjpark@amazon.de>
> 
> DAMON is designed to be used by kernel space code such as the memory
> management subsystems, and therefore it provides only kernel space API.
> That said, letting the user space control DAMON could provide some
> benefits to them.  For example, it will allow user space to analyze
> their specific workloads and make their own special optimizations.
> 
> For such cases, this commit implements a simple DAMON application kernel
> module, namely 'damon-dbgfs', which merely wraps the DAMON api and
> exports those to the user space via the debugfs.
>
[...]
> +/*
> + * Functions for the initialization
> + */
> +
> +static int __init damon_dbgfs_init(void)
> +{
> +	int rc;
> +
> +	dbgfs_ctxs = kmalloc(sizeof(*dbgfs_ctxs), GFP_KERNEL);
> +	if (!dbgfs_ctxs) {
> +		pr_err("%s: dbgfs ctxs alloc failed\n", __func__);
> +		return -ENOMEM;
> +	}
> +	dbgfs_ctxs[0] = dbgfs_new_ctx();
> +	if (!dbgfs_ctxs[0]) {
> +		pr_err("%s: dbgfs ctx alloc failed\n", __func__);
> +		return -ENOMEM;

My colleague, Stefan found 'dbgfs_ctxs' is not freed here.  Similar in below
'__damon_dbgfs_init()' failure handling.  I will fix these in the next version.

Reported-by: Stefan Nuernberger <snu@amazon.de>


Thanks,
SeongJae Park

> +	}
> +	dbgfs_nr_ctxs = 1;
> +
> +	rc = __damon_dbgfs_init();
> +	if (rc)
> +		pr_err("%s: dbgfs init failed\n", __func__);
> +
> +	return rc;
> +}
> +
> +module_init(damon_dbgfs_init);
> -- 
> 2.17.1
> 
