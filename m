Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76485401EB1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 18:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234245AbhIFQwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 12:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbhIFQwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 12:52:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49372C061575
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 09:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wiD2AcN785WWBM0bTHn9B8Epeoow+GpyloPCBFHVPJw=; b=SUdKJuF5ikJNwHDq7TwMPG3OlT
        tYTaGhMenbVeeul3ysFha0UHmyhfP0sUrmXuxCdF1zddfliFeDBvtAj6j4QoeKw8c9QEXhzvX+cda
        GzKVjxJ/jx43saH6WYwp3JmoNgketgXedOx2UNR3C9ZfJM5wZcoc4E+fRMv9kKIu29UlcDV0k4HnZ
        tZ6yoNxxTLWPZ+srKjjx5FoePvurTID5I9+DBuBkUCS+xH+C7lt6a3hA+gM/amsDu933i2GhFom+S
        y0jFsQrgXVc/zr1T/hvgGyH1H9l7ihynOzi0qQB1814UXgeQ73vGDblY1OSEN0CztQYE99agaYnMm
        uUgr0GCQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mNHp8-0077vR-BF; Mon, 06 Sep 2021 16:50:33 +0000
Date:   Mon, 6 Sep 2021 17:50:22 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Yu Xu <xuyu@linux.alibaba.com>
Cc:     Hao Sun <sunhao.th@gmail.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: kernel BUG in truncate_inode_page
Message-ID: <YTZGziPzpTZP+cnn@casper.infradead.org>
References: <CACkBjsbtF_peC7N_4mRfHML_BeiPe+O9DahTfr84puSG_J9rcQ@mail.gmail.com>
 <23adb5bc-13f6-7550-2ec1-b19b713639d6@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23adb5bc-13f6-7550-2ec1-b19b713639d6@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 06, 2021 at 08:59:17PM +0800, Yu Xu wrote:
> Hi, we also reproduce such bug recently, and have sent out our patch[1].
> 
> In addition, another issue related with xfs and file THP is also
> fixed[2].
> 
> Looking forward to reviews.
> 
> [1]https://patchwork.kernel.org/project/linux-mm/patch/20210906121200.57905-2-rongwei.wang@linux.alibaba.com/
> [2]https://patchwork.kernel.org/project/linux-mm/patch/20210906121200.57905-3-rongwei.wang@linux.alibaba.com/

I had a quick look, and there are some problems with both patches.
I don't have time to do a detailed review; as I said I'm on holiday.
I'll be back in two weeks.
