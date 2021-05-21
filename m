Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C74D38C1DB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 10:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232003AbhEUIdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 04:33:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:46270 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230480AbhEUIdQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 04:33:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1621585912; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=28GoOb877FxgY/kal9UemrUq1jqCtsgKxMcdYw6lGQo=;
        b=BDlmrNJQ3DEV3Qw0kh9pLNJnf+uq8JL7GSyaiPIXfZiBK7L/4HQDqqyhiGs6kYJ1+fSvlE
        rSluxUnNzioHyMbTC7NFZZQ/H3FQpFABrxVQ/k2aib1JuyuEXO6cfRcDZipDMnXzmnqay2
        tYOM6cHkqjsH4UtH1/G20XQX7p8hcNQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1EBE5ABE8;
        Fri, 21 May 2021 08:31:52 +0000 (UTC)
Date:   Fri, 21 May 2021 10:31:50 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     =?utf-8?B?6ZmI5Yag5pyJ?= <chenguanyou9338@gmail.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, Kees Cook <keescook@chromium.org>,
        lukas.bulwahn@gmail.com, vbabka@suse.cz, gpiccoli@canonical.com,
        chenguanyou <chenguanyou@xiaomi.com>
Subject: Re: [PATCH] hungtask: add filter kthread/check comm
Message-ID: <YKdv9hmRh+VxJrnH@dhcp22.suse.cz>
References: <20210519121325.22083-1-chenguanyou@xiaomi.com>
 <26c6c7a7-4c85-7487-6dd6-1e66b41a2a27@infradead.org>
 <CAHS3RMVYbHTzD6JnOmE331qSbcnvuYnBe0jraNuuLc0Z2NnStg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS3RMVYbHTzD6JnOmE331qSbcnvuYnBe0jraNuuLc0Z2NnStg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 21-05-21 14:38:06, 陈冠有 wrote:
> when we no skip kthread, exp log:
> 3,25164,832483138,-; (1)[67:khungtaskd]INFO: task amms_task:51 blocked for
> more than 120 seconds.
> 3,25165,832483169,-; (1)[67:khungtaskd]      Tainted: P S      W  O
>  4.14.186-g9d5f2ff-dirty #4
> 3,25166,832483186,-; (1)[67:khungtaskd]"echo 0 >
> /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> 6,25167,832483205,-; (1)[67:khungtaskd]amms_task       D    0    51      2
> 0x00000000
> 4,25168,832483232,-; (1)[67:khungtaskd]Call trace:
> 4,25169,832483268,-; (1)[67:khungtaskd] __switch_to+0x134/0x150
> 4,25170,832483297,-; (1)[67:khungtaskd] __schedule+0xd5c/0x1100
> 4,25171,832483318,-; (1)[67:khungtaskd] schedule+0x70/0x90
> 4,25172,832483343,-; (1)[67:khungtaskd] kthread+0xfc/0x18c
> 4,25173,832483365,-; (1)[67:khungtaskd] ret_from_fork+0x10/0x18
> 3,25174,832483482,-; (1)[67:khungtaskd]INFO: task mdrt_thread:123 blocked
> for more than 120 seconds.
> 3,25175,832483501,-; (1)[67:khungtaskd]      Tainted: P S      W  O
>  4.14.186-g9d5f2ff-dirty #4
> 3,25176,832483516,-; (1)[67:khungtaskd]"echo 0 >
> /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> 6,25177,832483533,-; (1)[67:khungtaskd]mdrt_thread     D    0   123      2
> 0x00000000
> 4,25178,832483555,-; (1)[67:khungtaskd]Call trace:
> 4,25179,832483574,-; (1)[67:khungtaskd] __switch_to+0x134/0x150
> 4,25180,832483595,-; (1)[67:khungtaskd] __schedule+0xd5c/0x1100
> 4,25181,832483615,-; (1)[67:khungtaskd] schedule+0x70/0x90
> 4,25182,832483635,-; (1)[67:khungtaskd] kthread+0xfc/0x18c
> 4,25183,832483655,-; (1)[67:khungtaskd] ret_from_fork+0x10/0x18
> 3,25184,832483737,-; (1)[67:khungtaskd]INFO: task scp_power_reset:227
> blocked for more than 120 seconds.

What are all these kernel threads doing and why it is ok to inhibit them
in the report.
-- 
Michal Hocko
SUSE Labs
