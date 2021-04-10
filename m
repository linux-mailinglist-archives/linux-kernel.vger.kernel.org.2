Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D641135AC05
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 10:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234245AbhDJIzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 04:55:24 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:47811 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229632AbhDJIzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 04:55:22 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id CA907580837;
        Sat, 10 Apr 2021 04:55:07 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Sat, 10 Apr 2021 04:55:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=5uGzC6LNv+sAq4wwCUhA+ZWu3IK
        7ZSq0aFCqAf14d0Q=; b=HvEYZVKwKybrc+hwpLOCV+3kvgyZcCQBYLg58PghLeW
        IMOEZPNGoMnr25CBiUYz1hn9InOHocNBB2g6xAKJJ5axfLc63pifdZdbvF0Oz7tw
        Ao65ZccGjGnWmdRrqEitT9yDuzOjyS/y1UZ455gTrzu9V95E9J7gF4i7Cf1UNfcH
        ehLHpZvN2GlIWntBcdiUlnigpdCjRJymqkV2LUDwi9GtxOl6g78/3tlKZhfEa3HE
        QhguJhj2sl+8S3QcLrXMq8bEF3ny0foTx3/46eplso4PdCAjj+A11TENwvZdmkzC
        5cRepQVGyuGRQdWgdTzOyP9WskGFu1L07b6mCIGte/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=5uGzC6
        LNv+sAq4wwCUhA+ZWu3IK7ZSq0aFCqAf14d0Q=; b=mx0MeMsxHvtgYZV3LIeuBu
        eHQUZaRqosNpEDt0qOm1Bse4BLOXyrEpNuPUrrqJy6ajjh+54SBIbrmpA8MvKVmf
        L/g4hNy+ku9uzklKEkPojfoUQ1kSIAHN6n2r0g1EVUk/aILzHX3v2zTTT2zrFLK3
        38ykYJ2jHuav+i8ERK4JhMj1fmEFq09BjvMdruQFEHPmsOkXEOjHXfn1XPc5D9uU
        CLdavAbKvR/JD3+oQ1ouH9mp11bwQSflo7mwUESF+tV0W1wQdpekHXe0xFdvcj6U
        T5/Ge8A15F80aEKQFRyvT19rSDf4b/vc8OEp++Egj96A7I8K6M1rVC9dOWOg6WYA
        ==
X-ME-Sender: <xms:6GdxYBDse1rPZPrI3VsS_BaCc_W8xH1jLrVrInuo5Z1MtqCURr8Fog>
    <xme:6GdxYPj-j6PJShry4lVzicG674J9tTkY903ypzgb1hbTyAx-5kLWSko_87lyOfBW-
    vhMBdE8vARzZg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudekfedguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeevueehje
    fgfffgiedvudekvdektdelleelgefhleejieeugeegveeuuddukedvteenucfkphepkeef
    rdekiedrjeegrdeigeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:6GdxYMm3YhftpsiX78d2fv4y5btEgLgnk-_N3SSDkZYOwQfksUDBQg>
    <xmx:6GdxYLxCVqZXbFqU11X36ZNv6CMADoDwn9JaMDDDVtQnuTaz8A677g>
    <xmx:6GdxYGQWQxyTizoLTcsX4hF3SD9wpN36FfjrccXyhPRZGMWeTLKMZA>
    <xmx:62dxYKAV02l7-F86dfgl2lFZh-rC7eI3LyjIQiC9LIVPf9jWkXBN7A>
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        by mail.messagingengine.com (Postfix) with ESMTPA id CCA9B24005D;
        Sat, 10 Apr 2021 04:55:03 -0400 (EDT)
Date:   Sat, 10 Apr 2021 10:55:01 +0200
From:   Greg KH <greg@kroah.com>
To:     SeongJae Park <sj38.park@gmail.com>
Cc:     akpm@linux-foundation.org, SeongJae Park <sjpark@amazon.de>,
        Jonathan.Cameron@huawei.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, amit@kernel.org,
        benh@kernel.crashing.org, brendanhiggins@google.com,
        corbet@lwn.net, david@redhat.com, dwmw@amazon.com,
        elver@google.com, fan.du@intel.com, foersleo@amazon.de,
        gthelen@google.com, guoju.fgj@alibaba-inc.com, mgorman@suse.de,
        minchan@kernel.org, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, riel@surriel.com, rientjes@google.com,
        rostedt@goodmis.org, rppt@kernel.org, shakeelb@google.com,
        shuah@kernel.org, snu@amazon.de, vbabka@suse.cz,
        vdavydov.dev@gmail.com, zgf574564920@gmail.com,
        linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v27 07/13] mm/damon: Implement a debugfs-based user space
 interface
Message-ID: <YHFn5fOTIQQ4TXHA@kroah.com>
References: <20210408134854.31625-1-sj38.park@gmail.com>
 <20210408134854.31625-8-sj38.park@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210408134854.31625-8-sj38.park@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2021 at 01:48:48PM +0000, SeongJae Park wrote:
> +static int dbgfs_fill_ctx_dir(struct dentry *dir, struct damon_ctx *ctx)
> +{
> +	const char * const file_names[] = {"attrs", "target_ids"};
> +	const struct file_operations *fops[] = {&attrs_fops, &target_ids_fops};
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(file_names); i++)
> +		debugfs_create_file(file_names[i], 0600, dir, ctx, fops[i]);
> +
> +	return 0;
> +}

Why do you have a function that can only return 0, actually return
something?  It should be void, right?

thanks,

greg k-h
