Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2889E34E439
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 11:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbhC3JXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 05:23:23 -0400
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:41579 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231721AbhC3JWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 05:22:54 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id ABECA17F2;
        Tue, 30 Mar 2021 05:22:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 30 Mar 2021 05:22:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=MlIaANbX0g7R5hO66tttd3MFu5e
        Tiezl/dlSwQ789Fk=; b=obbYYJtIAYkCZ9uivDSjtFcFBTb+4n3pu6VOCyx0oLA
        vpZEwQAMNVUjVTHvuO46xKN54Tew3YKeRG1FGY2Ahtr7gdK69hRKgEsPsou/NAg4
        NIFgf9GunbfIaw60K5MBGzK1DFln4TC2Aw1XgrAM3maXvhwcBt3c8aLV4gqkOZFo
        0m7GJOpIY133kLk+PIrgrw+l96rllLxRgGXFDh9NYMAV3W5wGUmfzKS2tPOMD6uC
        JBlzt175GNtYSk1M9KZ/1OdJon6ovxKMcVqYxhODY2Ge/hLz8hZmEHfY0EwuvP0H
        GoMzP/5uw0T4K6AwzKMaRwIDVlTrnftVaGnFjkC9Hig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=MlIaAN
        bX0g7R5hO66tttd3MFu5eTiezl/dlSwQ789Fk=; b=uZlADrNcGBjpzSMhBwpI1V
        0BNMdOP3oYfAQOeJPwbRnuso5jGxMGJBV9k7lGMZ1ccGLK4RIM/ixwozWRS+600n
        jdKR3El7L1eegFVk78lnNOAriZ8dLaZ5FqKNRk0vbdMcfWHmv71jODHF3hNdJMdh
        4Vg5mhgdJjbTGJrR5Hatu8gnCp2D2VEaBYLkgVx8jH2NQKaXMkkGuI2RQ2FH2Ghv
        cHWOkbeB3+3zVEYd6U5TjQ0CadFnOpZYtAqv8lTmY+gfWLyXjcToZnhdXtpi2/ZU
        gTg2h42C2Sh5w6AYBMX64OB/3faAj1hS8Dsg/Rl0z5ReM3CRPaBqqTNlmlf8mSMw
        ==
X-ME-Sender: <xms:5-1iYFEk09n2aS_BGfBX9QMwQpfXSkv0_8E8dZpTYlhvw_QACpxU3Q>
    <xme:5-1iYKVYKXInEgzf5Bqh7XPNWw15_JXeCWYDdn-8uZQ2Jsi95f3I2vAhuldlms5Oe
    DIUKjVaoShClA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudeitddgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeevueehje
    fgfffgiedvudekvdektdelleelgefhleejieeugeegveeuuddukedvteenucfkphepkeef
    rdekiedrjeegrdeigeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:5-1iYHJUu4arvazT3LhBCwqI9lOvNkUsVKpqX8SBYzuuxlK6jxWB4g>
    <xmx:5-1iYLHMnKWpJlSt__baHPlNkM65QB86UhEIAW9Z3zUscrZVoKbOVg>
    <xmx:5-1iYLXxGdFULGIbnunAu1ZFmiNZQD5CJUZbZD8ovLa83S_VrWwy_A>
    <xmx:6-1iYLV39abz3I5XMpmcniIBvufVw_mXffOyas_gaQuQA0Ot5Qqh1cM_ALU>
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3593A24005D;
        Tue, 30 Mar 2021 05:22:47 -0400 (EDT)
Date:   Tue, 30 Mar 2021 11:22:45 +0200
From:   Greg KH <greg@kroah.com>
To:     sj38.park@gmail.com
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
Subject: Re: [PATCH v26 07/13] mm/damon: Implement a debugfs-based user space
 interface
Message-ID: <YGLt5R1AlgGrPtv4@kroah.com>
References: <20210330090537.12143-1-sj38.park@gmail.com>
 <20210330090537.12143-8-sj38.park@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210330090537.12143-8-sj38.park@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2021 at 09:05:31AM +0000, sj38.park@gmail.com wrote:
> +static int __init __damon_dbgfs_init(void)
> +{
> +	struct dentry *dbgfs_root;
> +	const char * const file_names[] = {"monitor_on"};
> +	const struct file_operations *fops[] = {&monitor_on_fops};
> +	int i;
> +
> +	dbgfs_root = debugfs_create_dir("damon", NULL);
> +
> +	for (i = 0; i < ARRAY_SIZE(file_names); i++)
> +		debugfs_create_file(file_names[i], 0600, dbgfs_root, NULL,
> +				fops[i]);
> +	dbgfs_fill_ctx_dir(dbgfs_root, dbgfs_ctxs[0]);
> +
> +	dbgfs_dirs = kmalloc_array(1, sizeof(dbgfs_root), GFP_KERNEL);

No error checking for memory allocation failures?


> +	dbgfs_dirs[0] = dbgfs_root;
> +
> +	return 0;
> +}
> +
> +/*
> + * Functions for the initialization
> + */
> +
> +static int __init damon_dbgfs_init(void)
> +{
> +	int rc;
> +
> +	dbgfs_ctxs = kmalloc(sizeof(*dbgfs_ctxs), GFP_KERNEL);

No error checking?

> +	dbgfs_ctxs[0] = dbgfs_new_ctx();
> +	if (!dbgfs_ctxs[0])
> +		return -ENOMEM;
> +	dbgfs_nr_ctxs = 1;
> +
> +	rc = __damon_dbgfs_init();
> +	if (rc)
> +		pr_err("%s: dbgfs init failed\n", __func__);

Shouldn't the error be printed out in the function that failed, not in
this one?

thanks,

greg k-h
