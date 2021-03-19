Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1ED63420F1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 16:28:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbhCSP1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 11:27:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:57142 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229893AbhCSP1G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 11:27:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1616167625; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NnKWTvIsJonhFgfg0n8WV19i2rpTuNx8CHDjSLQe+xA=;
        b=CaRC4s3xWRgWNvyTXzxeXkBUSXd4SbcUvW0KA78+qCNpRXru8FGWrFVdbCUaaXHQ1Il2Yt
        t7DMcOlgl9/fkQpz7Val/eCnMgckK9poPEItgV1bvQ8x7oX3kMSRkTpdPGeAWjsGnAGFOy
        UtuWwKSrCWjmSMCGMKFXJ3xlVd8xVXk=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D9F19AC17;
        Fri, 19 Mar 2021 15:27:04 +0000 (UTC)
Date:   Fri, 19 Mar 2021 16:27:03 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     willy@infradead.org, andriy.shevchenko@linux.intel.com,
        david@redhat.com, linmiaohe@huawei.com, vbabka@suse.cz,
        cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        rostedt@goodmis.org, sergey.senozhatsky@gmail.com, joe@perches.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, lkp@intel.com
Subject: Re: [PATCH v6 resend 3/3] vsprintf: dump full information of page
 flags in pGp
Message-ID: <YFTCxyhssX33R1k6@alley>
References: <20210319101246.73513-1-laoar.shao@gmail.com>
 <20210319101246.73513-4-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319101246.73513-4-laoar.shao@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2021-03-19 18:12:46, Yafang Shao wrote:
> Currently the pGp only shows the names of page flags, rather than
> the full information including section, node, zone, last cpupid and
> kasan tag. While it is not easy to parse these information manually
> because there're so many flavors. Let's interpret them in pGp as well.
> 
> To be compitable with the existed format of pGp, the new introduced ones
> also use '|' as the separator, then the user tools parsing pGp won't
> need to make change, suggested by Matthew. The new information is
> tracked onto the end of the existed one.
> 
> On example of the output in mm/slub.c as follows,
> - Before the patch,
> [ 6343.396602] Slab 0x000000004382e02b objects=33 used=3 fp=0x000000009ae06ffc flags=0x17ffffc0010200(slab|head)
> 
> - After the patch,
> [ 8448.272530] Slab 0x0000000090797883 objects=33 used=3 fp=0x00000000790f1c26 flags=0x17ffffc0010200(slab|head|node=0|zone=2|lastcpupid=0x1fffff)
> 
> The documentation and test cases are also updated. The output of the
> test cases as follows,
> [68599.816764] test_printf: loaded.
> [68599.819068] test_printf: all 388 tests passed
> [68599.830367] test_printf: unloaded.
> 
> [lkp@intel.com: reported issues in the prev version in test_printf.c]
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>

Reviewed-by: Petr Mladek <pmladek@suse.com>

It looks good. And it seems that the selftest should not longer have
that problems on various architectures and configurations.

I am going to push it.

Best Regards,
Petr
