Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31436341CB9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 13:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbhCSMWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 08:22:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:38644 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231645AbhCSMWD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 08:22:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1616156522; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tLrllxn0SsgM950Jz5SlkRc8QZbU9CbHhsQpx+bP79s=;
        b=iEYJhvMSySpozXlnyPVUDD+549fVPcIqNzpKkIC83jCO8znH918tAZO2deFYrD45Jle99z
        25Zpwl8i4DOVxnyJaeh4fQOmR++n0iJV5/3tMEbVbxhelGFVqAUqxpcKeQAwC81t9O8rZ6
        Jt3KYM99nRqfMNkK9MJ7Fzp8CtzScds=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 22908AE56;
        Fri, 19 Mar 2021 12:22:02 +0000 (UTC)
Date:   Fri, 19 Mar 2021 13:22:00 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Lameter <cl@linux.com>, penberg@kernel.org,
        David Rientjes <rientjes@google.com>, iamjoonsoo.kim@lge.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Joe Perches <joe@perches.com>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH v6 resend 0/3] mm, vsprintf: dump full information of
 page flags in pGp
Message-ID: <YFSXaMUyjnH2CSKT@alley>
References: <20210319101246.73513-1-laoar.shao@gmail.com>
 <CALOAHbAO+2ZHjF8RH4aGFh2Zh9y0-Uwu+rv-NrQjF49YjA-j2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALOAHbAO+2ZHjF8RH4aGFh2Zh9y0-Uwu+rv-NrQjF49YjA-j2w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2021-03-19 18:15:19, Yafang Shao wrote:
> On Fri, Mar 19, 2021 at 6:13 PM Yafang Shao <laoar.shao@gmail.com> wrote:
> Hi Petr,
> 
> Any comments on this version ?

I have been busy this week with some other work. I am going to review
the original v6 either later today or the following week.

Best Regards,
Petr

PS: I usually react quickly but it is not always possible. There was
no need to resend the entire patchset twice within one week.
