Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0EE9389CBA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 06:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbhETEgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 00:36:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:33922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229449AbhETEgR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 00:36:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9702D610CC;
        Thu, 20 May 2021 04:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1621485295;
        bh=KJiuXtdPBYbs0Q3wvWX1J2cBytAzfonsO3RA/+c2RmQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aUXuC9rcdS09mfXi702zd909LrcM2sJxlqhkh62LPWAFl3GBtcQiu7pp6BRxPfaMb
         0J5HoY6x6ZvxtTJ2KuWphAoO8ALGwPZhF3dLbSmaSWj9HUSYQ6mO/kwP0mseN9lKkF
         lrIpd4quwLYV9EI6XXVhMtJ9Xa1NtHPBjaC9M52U=
Date:   Wed, 19 May 2021 21:34:55 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Aaron Tomlin <atomlin@redhat.com>
Cc:     linux-mm@kvack.org, vbabka@suse.cz, mhocko@suse.com,
        willy@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm/page_alloc: bail out on fatal signal during
 reclaim/compaction retry attempt
Message-Id: <20210519213455.97ff95f0124b4120787f8314@linux-foundation.org>
In-Reply-To: <20210519201743.3260890-1-atomlin@redhat.com>
References: <YKVn69o1UizH0kJD@casper.infradead.org>
        <20210519201743.3260890-1-atomlin@redhat.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 May 2021 21:17:43 +0100 Aaron Tomlin <atomlin@redhat.com> wrote:

> It does not make sense to retry compaction when a fatal signal is
> pending.

Well, it might make sense.  Presumably it is beneficial to other tasks.

> In the context of try_to_compact_pages(), indeed COMPACT_SKIPPED can be
> returned; albeit, not every zone, on the zone list, would be considered
> in the case a fatal signal is found to be pending.
> Yet, in should_compact_retry(), given the last known compaction result,
> each zone, on the zone list, can be considered/or checked
> (see compaction_zonelist_suitable()). For example, if a zone was found
> to succeed, then reclaim/compaction would be tried again
> (notwithstanding the above).
> 
> This patch ensures that compaction is not needlessly retried
> irrespective of the last known compaction result e.g. if it was skipped,
> in the unlikely case a fatal signal is found pending.
> So, OOM is at least attempted.

What observed problems motivated this change?

What were the observed runtime effects of this change?
