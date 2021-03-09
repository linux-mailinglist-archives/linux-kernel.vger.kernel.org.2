Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 251BE3322E0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 11:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbhCIKVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 05:21:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:47244 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230156AbhCIKVR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 05:21:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1615285276; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tF33llBV3uo2QeZ1Jas8yS38WHxztLJqtNt1Cg2HxLU=;
        b=lku1WzWMgrawmbzOPJ1q1Wr4B8eX+9k9chAWJ9OHIBGEvBby/DC4OBnYD/WUcCCRVhbDj8
        pWnW4byNRmKHA75wbozX8JjLdbIPzn/Cnq53H4pIFyXOD6MumYx0RKKYyO6fmX6tMkfhD6
        opri3Ais875Z/NlodZqD4AkEW8cuF1I=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 88AC9AC1F;
        Tue,  9 Mar 2021 10:21:16 +0000 (UTC)
Date:   Tue, 9 Mar 2021 11:21:15 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     andriy.shevchenko@linux.intel.com, david@redhat.com,
        linmiaohe@huawei.com, vbabka@suse.cz, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, joe@perches.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v5 3/3] vsprintf: dump full information of page flags in
 pGp
Message-ID: <YEdMGxNKuz8cqt4f@alley>
References: <20210215155141.47432-1-laoar.shao@gmail.com>
 <20210215155141.47432-4-laoar.shao@gmail.com>
 <YDOluaRK2CHtQyQD@alley>
 <20210222133956.GH2858050@casper.infradead.org>
 <YD+unAF/ed9AbT5K@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YD+unAF/ed9AbT5K@alley>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2021-03-03 16:43:25, Petr Mladek wrote:
> On Mon 2021-02-22 13:39:56, Matthew Wilcox wrote:
> > On Mon, Feb 22, 2021 at 01:38:17PM +0100, Petr Mladek wrote:
> > > Another question where to push this change. It is pity the we
> > > finalized it in the middle of the merge window. It has to spend
> > > at least few days in linux-next.
> > > 
> > > I would like to hear from Andy before I push it into linux-next.
> > > There is still theoretical chance to get it into 5.12 when Linus
> > > prolongs the merge window by one week. it has been delayed by
> > > a long lasting power outage.
> > 
> > Usually new code has to be in linux-next by -rc5 or so.  This is
> > definitely too late for 5.12, but it's nice and early for 5.13!
> 
> OK, I am going to queue it for 5.13 the following week unless anyone
> speaks against it in the meantime.

The patchset is committed in printk/linux.git,
branch for-5.13-vsprintf-pgp.

Best Regards,
Petr
