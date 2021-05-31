Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98F6C3959C4
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 13:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbhEaLfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 07:35:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:36568 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231164AbhEaLfN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 07:35:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1622460813; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r3QrY/uDAlxbmSiPcq2dTQZ/GOIjlE9Ied6yDBeJWZY=;
        b=KLXKf6jASDzzfqDTufBEdIPJLOcQ00opaF4Ew8+hoFfymQILtLvpjdGFCQBsoMkyQBscIW
        +oK/mQc04nXjM0KXIYHq7eQlbKziYi2U6sAQ9h2mYlrZqVsS25cAyuqHAaoIvuXH/dyXeL
        0jDefYqIikzS8rPXVV8Rni9kuoIevjk=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 06D08B4C1;
        Mon, 31 May 2021 11:33:33 +0000 (UTC)
Date:   Mon, 31 May 2021 13:33:32 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Aaron Tomlin <atomlin@redhat.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, vbabka@suse.cz,
        willy@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] mm/page_alloc: bail out on fatal signal during
 reclaim/compaction retry attempt
Message-ID: <YLTJjJqemt5Uv9vP@dhcp22.suse.cz>
References: <YKZObDpduqwWi/Zm@casper.infradead.org>
 <20210520142901.3371299-1-atomlin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210520142901.3371299-1-atomlin@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 20-05-21 15:29:01, Aaron Tomlin wrote:
> A customer experienced a low-memory situation and decided to issue a
> SIGKILL (i.e. a fatal signal). Instead of promptly terminating as one
> would expect, the aforementioned task remained unresponsive.
> 
> Further investigation indicated that the task was "stuck" in the
> reclaim/compaction retry loop. Now, it does not make sense to retry
> compaction when a fatal signal is pending.

Is this really true in general? The memory reclaim is retried even when
fatal signals are pending. Why should be compaction different? I do
agree that retrying way too much is bad but is there any reason why this
special case doesn't follow the max retry logic?
-- 
Michal Hocko
SUSE Labs
