Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5EF7313ED1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 20:24:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236266AbhBHTXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 14:23:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:51822 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233744AbhBHSAj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 13:00:39 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F3332AE55;
        Mon,  8 Feb 2021 17:59:52 +0000 (UTC)
Subject: Re: [PATCH v3 2/3] mm, slub: don't combine pr_err with INFO
To:     Matthew Wilcox <willy@infradead.org>,
        Yafang Shao <laoar.shao@gmail.com>
Cc:     andriy.shevchenko@linux.intel.com, david@redhat.com, cl@linux.com,
        linmiaohe@huawei.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        pmladek@suse.com, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, joe@perches.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210208101439.55474-1-laoar.shao@gmail.com>
 <20210208101439.55474-3-laoar.shao@gmail.com>
 <20210208172600.GU308988@casper.infradead.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <1975c1e4-8446-a8a2-12c2-44e8e0fd0beb@suse.cz>
Date:   Mon, 8 Feb 2021 18:59:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210208172600.GU308988@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/8/21 6:26 PM, Matthew Wilcox wrote:
> On Mon, Feb 08, 2021 at 06:14:38PM +0800, Yafang Shao wrote:
>> It is strange to combine "pr_err" with "INFO", so let's remove the
>> prefix completely.
> 
> So is this the right thing to do?  Should it be pr_info() instead?
> Many of these messages do not appear to be error messages, but
> rather informational messages.

They are all part of longer error reports. See
https://lore.kernel.org/linux-mm/0b2f4419-06a9-0b6c-067b-8d0848e78c33@suse.cz/
