Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 701F0363958
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 04:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237282AbhDSCSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Apr 2021 22:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237263AbhDSCSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Apr 2021 22:18:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043ECC06174A;
        Sun, 18 Apr 2021 19:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UjpqjMCrIGMyLyWXrKKEIi83eI9lOlLa5ChPgwASCRU=; b=pf7Dp8QMDHT0GG612OJzd69BUq
        7mown/OOX7XmTNuFtlPwyqEvk35YuGBG87guxPMe8ADFxXk3ajJUrUGTYIpXgmzf3yPneCqvd1+5J
        boMSiZ6tF8XuJQVNxCWGe7kpsa3pIWHpW4zTYV1zZamga5J5YbEbseqAbzNOJ0sNHWDz6wth4BK/I
        SvnqNtP5tv4gEfYqqDaYhrU6ePSHrhbVCYz2ff2+E7MbE2o5PYlds5HFwJWyWBEZzwDe6BczwVbhm
        pWNhKHRPUh2MxF3a2hF9+V0KObvna0Q8o5NSNqMnYoMOU/v6LAMqaNUMZFI1T/hs+UUUfL9NJzgBk
        hEE6LLtg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lYJTe-00D678-9g; Mon, 19 Apr 2021 02:17:33 +0000
Date:   Mon, 19 Apr 2021 03:17:30 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Fox Chen <foxhlchen@gmail.com>
Cc:     neilb@suse.de, corbet@lwn.net, vegard.nossum@oracle.com,
        viro@zeniv.linux.org.uk, rdunlap@infradead.org,
        grandmaster@al2klimov.de, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Subject: Re: [PATCH v2 01/12] docs: path-lookup: update follow_managed() part
Message-ID: <20210419021730.GV2531743@casper.infradead.org>
References: <20210316054727.25655-1-foxhlchen@gmail.com>
 <20210316054727.25655-2-foxhlchen@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210316054727.25655-2-foxhlchen@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021 at 01:47:16PM +0800, Fox Chen wrote:
> -In the absence of symbolic links, ``walk_component()`` creates a new
> +As the last step of ``walk_component()``, ``step_into()`` will be called either

You can drop ``..`` from around function named which are followed with
().  d74b0d31ddde ("Docs: An initial automarkup extension for sphinx")
marks them up automatically.

