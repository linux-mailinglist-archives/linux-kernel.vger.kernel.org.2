Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54B0B343DC5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 11:27:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbhCVK12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 06:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbhCVK1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 06:27:12 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D71C061762
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 03:27:11 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id l1so6309011plg.12
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 03:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+wvdQhVLwLoFosU2KHxQqJGVby7PQnpq6urwRwMBx7A=;
        b=b6WqhwKq/OQDbEMnA7e5IsW2C1eZP0RdD5OqEOz/f7YJnGBe4g45Xf3AZi9FXXlEV9
         NfEi9uJBe65YYGnEf+liwwuh6hcBUKPdE5ByThKU31Gbiva6Ok5UnR1lvo5ZwDqZIHgT
         7FHfBbvCknigoBvrP5OTvm3knCnl3doTyIPas=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+wvdQhVLwLoFosU2KHxQqJGVby7PQnpq6urwRwMBx7A=;
        b=oEUlLPmjvjf6DxVc1jrHe1YsPDdrgM+pApa///kdU+2D//tKR2DYpSEb/MRSG8flkV
         3pWDmee3phjjepU0nktfylfTD9OHOGCg3VZINZwztUfneEG6XdAbTMPDnaDUqwV9gJem
         j/ZQuJK21KtJVQP5JjiAfG3HbAWSJ0VvM1BfxHRXtFKveyDYOVdUDh+Szq4uPDBDnuvP
         QmLbxMmhYdLxTwV6aMW3uiisOwpjafvXFLh18XU+no5tF/zr/RB+pIOloxfjg3ZBaB8H
         JWd0XG2Vypwsrrjmej7degc1WF90dyeI7eHqTAh1p2tVnKuV860nDXimGXjhCwpaqj6o
         lnzA==
X-Gm-Message-State: AOAM531giQH3BxNL6QGOnMrYcF9fBHghqoIEt84mhvjiiQDOY3KH4jFt
        8IkvxKSNojJU9D9ozZFyuMjRjw==
X-Google-Smtp-Source: ABdhPJwLw70xF0T1APO8o5oOg758meoNWyGdI6qKxSFYvxLU3qMkHixXKq8q1LSC6BT/IFVCFO9Ocg==
X-Received: by 2002:a17:902:ce86:b029:e6:b1f6:3c5c with SMTP id f6-20020a170902ce86b02900e6b1f63c5cmr939950plg.13.1616408831429;
        Mon, 22 Mar 2021 03:27:11 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:b1b5:270:5df6:6d6e])
        by smtp.gmail.com with ESMTPSA id j3sm14304223pjf.36.2021.03.22.03.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 03:27:10 -0700 (PDT)
Date:   Mon, 22 Mar 2021 19:27:03 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Namjae Jeon <namjae.jeon@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-cifs@vger.kernel.org,
        linux-cifsd-devel@lists.sourceforge.net, smfrench@gmail.com,
        senozhatsky@chromium.org, hyc.lee@gmail.com,
        viro@zeniv.linux.org.uk, hch@lst.de, hch@infradead.org,
        ronniesahlberg@gmail.com, aurelien.aptel@gmail.com,
        aaptel@suse.com, sandeen@sandeen.net, dan.carpenter@oracle.com,
        colin.king@canonical.com, rdunlap@infradead.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steve French <stfrench@microsoft.com>
Subject: Re: [PATCH 2/5] cifsd: add server-side procedures for SMB3
Message-ID: <YFhw932H8BZalhmu@google.com>
References: <20210322051344.1706-1-namjae.jeon@samsung.com>
 <CGME20210322052206epcas1p438f15851216f07540537c5547a0a2c02@epcas1p4.samsung.com>
 <20210322051344.1706-3-namjae.jeon@samsung.com>
 <20210322083445.GJ1719932@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210322083445.GJ1719932@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/03/22 08:34), Matthew Wilcox wrote:
> > +++ b/fs/cifsd/mgmt/ksmbd_ida.c
> > @@ -0,0 +1,69 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + *   Copyright (C) 2018 Samsung Electronics Co., Ltd.
> > + */
> > +
> > +#include "ksmbd_ida.h"
> > +
> > +struct ksmbd_ida *ksmbd_ida_alloc(void)
> > +{
> > +	struct ksmbd_ida *ida;
> > +
> > +	ida = kmalloc(sizeof(struct ksmbd_ida), GFP_KERNEL);
> > +	if (!ida)
> > +		return NULL;
> > +
> > +	ida_init(&ida->map);
> > +	return ida;
> > +}
>
> ... why?  Everywhere that you call ksmbd_ida_alloc(), you would
> be better off just embedding the struct ida into the struct that
> currently has a pointer to it.  Or declaring it statically.  Then
> you can even initialise it statically using DEFINE_IDA() and
> eliminate the initialiser functions.

IIRC this ida is per SMB session, so it probably cannot be static.
And Windows, IIRC, doesn't like "just any IDs". Some versions of Windows
would fail the session login if server would return the first id == 0,
instead of 1. Or vice versa. I don't remember all the details, the last
time I looked into this was in 2019.

[..]
> > +struct ksmbd_tree_connect *ksmbd_tree_conn_lookup(struct ksmbd_session *sess,
> > +						  unsigned int id)
> > +{
> > +	struct ksmbd_tree_connect *tree_conn;
> > +	struct list_head *tmp;
> > +
> > +	list_for_each(tmp, &sess->tree_conn_list) {
> > +		tree_conn = list_entry(tmp, struct ksmbd_tree_connect, list);
> > +		if (tree_conn->id == id)
> > +			return tree_conn;
> > +	}
>
> ... walk the linked list looking for an ID match.  You'd be much better
> off using an allocating XArray:
> https://www.kernel.org/doc/html/latest/core-api/xarray.html

I think cifsd code predates XArray ;)

> Then you could lookup tree connections in O(log(n)) time instead of
> O(n) time.

Agreed. Not sure I remember why the code does list traversal here.
