Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA69A32A16C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1577300AbhCBF6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 00:58:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1575146AbhCBDxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 22:53:36 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FCD1C061756
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 19:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rnlSDW3mF7NO8UIJXpqSiCxH4+2NNXRWombkw0Aj2Rs=; b=vG9x3+LxcXFEsJc2YB8k1xX3gC
        c2Z3TxmrzmudqJ1H0oVCSPPSMebYI8IBCskQNpqmtDCBSo+VBYc2m+U5RJ1Hj9gs0b2P19sgMtJrt
        qQ1ySu/SIDQOxwC1nQXI0VY94p55chxnuKIr2HX7I5+UAtyeRWTmRe8GgeIgO5zBQYiPnz3kIV6Ds
        0jZIot9SuQAfqpnCuVBN2tP65qhHbasyNtQm5hjO+szqRaVUGEM96OlXg6y7Xbcxzf0VU31CEEbJk
        cuQHuyM1LdBH2jlgtglSOheA4mNgBT4l4rZ9KV/hvQt5ghNnBQnVJ75GY6/b9mtnMdqXv8i+7H7Y4
        GHezC5Uw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lGw5D-00GZfm-V4; Tue, 02 Mar 2021 03:52:33 +0000
Date:   Tue, 2 Mar 2021 03:52:27 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Yejune Deng <yejune.deng@gmail.com>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] include/linux/slab.h: use for() and left shift to
 calculate
Message-ID: <20210302035227.GW2723601@casper.infradead.org>
References: <20210302033908.51706-1-yejune.deng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210302033908.51706-1-yejune.deng@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 02, 2021 at 11:39:08AM +0800, Yejune Deng wrote:
> use for() and left shift to calculate the value that compared with size.

https://lore.kernel.org/linux-mm/339dbb54-b4bc-78e2-e3f0-986814e86d0e@suse.cz/
