Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E20E530A975
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 15:16:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbhBAOQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 09:16:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbhBAOQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 09:16:22 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBBCDC061573
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 06:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MWlPy8C+pBGPMz0T1Jum1eQKXQgt1lI/s1CODUeEWFE=; b=BxK1TiUxNkckQMGT+mO4ygmHY8
        Wy3WRlsp3/4/laJL7sfuXoxd+7If/RhRvthiMRRSkonDLcPfjz9AiW1yu6Y+ONdgRrTG3+sXb9mWU
        iaLhAwlfcc2NDNkcWJR2iV8q1p0ZlFVbuQD/kWAW5tqokVDfnmRGv+b7wI9SCWVQo+BYXtpthaCzI
        mdFHd8ZWTgKEOpet3H0ZjxViqrzIMlI9Zbaend4Wn7kg01WX1OJqYgmNZc6ysjgpcoZMhWq5w7aAk
        vm9ZbQupfU8tmn8bzY9bqmGKqq17bCg69da9oZSavjNi9Z16X0aT7HqpunmwxV+2iQu60getI9PWR
        n0V6AVEQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l6Zyr-00Drh0-Gr; Mon, 01 Feb 2021 14:15:05 +0000
Date:   Mon, 1 Feb 2021 14:15:05 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     andriy.shevchenko@linux.intel.com, david@redhat.com,
        vbabka@suse.cz, linmiaohe@huawei.com, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, pmladek@suse.com, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, linux@rasmusvillemoes.dk,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH v2 3/3] vsprintf: dump full information of page flags in
 pGp
Message-ID: <20210201141505.GR308988@casper.infradead.org>
References: <20210201115610.87808-1-laoar.shao@gmail.com>
 <20210201115610.87808-4-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210201115610.87808-4-laoar.shao@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 01, 2021 at 07:56:10PM +0800, Yafang Shao wrote:
> - Before the patch,
> [ 6343.396602] Slab 0x000000004382e02b objects=33 used=3 fp=0x000000009ae06ffc flags=0x17ffffc0010200(slab|head)
> 
> - After the patch,
> [ 6871.296131] Slab 0x00000000c0e19a37 objects=33 used=3 fp=0x00000000c4902159 flags=0x17ffffc0010200(Node 0,Zone 2,Lastcpupid 0x1fffff,slab|head)

I would suggest it will be easier to parse as:

flags=0x17ffffc0010200(slab|head|node=0|zone=2|lastcpupid=0x1fffff)

That should alleviate the concerns about debugfs format change -- we've
never guaranteed that flag names won't change, and they now look enough
like flags that parsers shouldn't fall over them.
