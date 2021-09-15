Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43D7540BE59
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 05:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbhIODk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 23:40:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:33630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229980AbhIODk0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 23:40:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 87B2960EB6;
        Wed, 15 Sep 2021 03:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1631677148;
        bh=xKMrIXKlWUMbYFeOIaYSXjiPq9525KARH4WZaBXsyFo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Kblvti+cYDkUWvmMY2Jhhf2qdIZ9c7VOhTNPMrf7SWkP9+2Z5wtB4QHmBOxpo/oK4
         mqoB9taPpAGgOqx1RMMb6/zEfadj+Yg9v2dlJosor78/9dqiAGg3lcfDh//HgmGDIZ
         listw9Ls/QrElHZM3Wd/JLdcfQKpL42S1K6MB1mg=
Date:   Tue, 14 Sep 2021 20:39:08 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yongmei Xie <yongmeixie@hotmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        hannes@cmpxchg.org
Subject: Re: [PATCH] mm/workingset: don't count as refault (file/anon) if
 refault distance is too long
Message-Id: <20210914203908.bdb8fa924dce80e15f149457@linux-foundation.org>
In-Reply-To: <PSAPR02MB48530DF74EC51015F1C3ADACC5D89@PSAPR02MB4853.apcprd02.prod.outlook.com>
References: <PSAPR02MB48530DF74EC51015F1C3ADACC5D89@PSAPR02MB4853.apcprd02.prod.outlook.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Sep 2021 19:54:47 +0800 Yongmei Xie <yongmeixie@hotmail.com> wrote:

> The current implementation count all the pages which have shadow entry in radix tree as
> the event of refault (page or anon). That means all the pages which have ever been
> cached in lru are counted as refault. But I think it's not 100% percent correct.
> 
> Because usually inode has much longer life cycle than the pages belonging to it.
> So if the inode was accessed from time to time, then it won't be reclaimed unless much
> severe memory pressure happens.
> 
> Then if page was reclaimed several days ago, when it's accessed again, it will be marked as
> refault event. Then page was reclaimed an hour ago, when it's accessed again, it will be
> marked as refault event as well. From the refault metric alone, I cannot tell whether the
> previous reclaim process has evicted some useful pages. That makes things worse in situation
> of proactive reclaim. We's like to known whehter the previous policy reclaim too much
> meaningful data other than working set transition. So we'd like see the refault rate, but it
> includes all the historical reclaim.
> 
> >From my point of view, if the refaut distance is larger than file cache size, we don't
> have to count it refault at all. Because it's too long to be memorized down.

Thanks.

Do you have any runtime testing results which demonstrate a benefit?
