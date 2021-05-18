Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF433881E7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 23:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240878AbhERVOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 17:14:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:42280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236427AbhERVOX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 17:14:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DB49D61209;
        Tue, 18 May 2021 21:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1621372385;
        bh=WZ6+AhG6U6Yfu+E7678PCLi0l7LujFMPm60OW6qUaIE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=W9L+kUErfhLxipuT/UDg1ikUzK27i1y47XwP01AV00GqyEQrxhw4WaHencntRT3I7
         yoGOZou31pZS5auDremCye+WEFydAiPZEY5oBjbF1dyU4s+Myb3gWx152uwRZ4gkyO
         uDxer5Jh0Uhka94ZjupN6aTLNJkV9x68BZuu6VGk=
Date:   Tue, 18 May 2021 14:13:04 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Miaohe Lin <linmiaohe@huawei.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 5/5] mm/swap: simplify the code of
 find_get_incore_page()
Message-Id: <20210518141304.c09cd8762e3f3d16a722444c@linux-foundation.org>
In-Reply-To: <YKPQUjjdC3mP5f/P@casper.infradead.org>
References: <20210518135352.3705306-1-linmiaohe@huawei.com>
        <20210518135352.3705306-6-linmiaohe@huawei.com>
        <YKPQUjjdC3mP5f/P@casper.infradead.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 May 2021 15:33:54 +0100 Matthew Wilcox <willy@infradead.org> wrote:

> On Tue, May 18, 2021 at 09:53:52PM +0800, Miaohe Lin wrote:
> > pagecache_get_page() can do find_subpage() for us if we do not specify
> > FGP_HEAD. No functional change intended.
> 
> Please, no.  This interferes with the folio work.

In what way?  Can't the folio patches simply revert this or suitably
alter it?
