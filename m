Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F26EE40A70F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 09:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240486AbhINHH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 03:07:26 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:37968 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240277AbhINHHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 03:07:24 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 482AB22036;
        Tue, 14 Sep 2021 07:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631603166; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A/1Y7KiDeeaT0dHdPrBGfhWOk81I7NO2b70BCS+BHrs=;
        b=ikIlgBpZyivQEZXzhoOi40OPwAkWSBWdnWYZlYTMoY47xOuDzck5UFpfcDqmEtB5TVyDEY
        dP/BgDGXjeqYybw2BIolssfpfvkxmyL6IMZVnnDRIwmRtQLE27ahOYy/Vo2AgPi7P7AiIa
        nwn8HC9j7wDdOHmUmxRqEKu6OJdYumM=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id F1B76A3B90;
        Tue, 14 Sep 2021 07:06:05 +0000 (UTC)
Date:   Tue, 14 Sep 2021 09:06:05 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, vbabka@suse.cz,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/page_isolation: fix potential missing call to
 unset_migratetype_isolate()
Message-ID: <YUBJ3eA0a+Vk1wm4@dhcp22.suse.cz>
References: <20210913115125.33617-1-linmiaohe@huawei.com>
 <YT9AS6I1Th14mCxh@dhcp22.suse.cz>
 <e1e772b8-b9a7-0182-c469-73f32cda005e@redhat.com>
 <6cb372ff-0b68-2143-913e-04ab3e6b4160@huawei.com>
 <YT9LPoSSTJbmF3eF@dhcp22.suse.cz>
 <1d0e15ab-4a1f-0820-26c2-4b9949164dfa@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d0e15ab-4a1f-0820-26c2-4b9949164dfa@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 14-09-21 11:09:47, Miaohe Lin wrote:
[...]
> So even the Fixes tag should be removed ?

I would keep that one there. Fixes tag is useful to frame the scope of
the fix. For example when somebody is backporting the commit mentioned
in the Fixes tag then a) a lot of follow up patches with Fixes can tell
you this won't be an easy ride and you might want to reconsider risks
vs. benefit b) it helps to collect follow up fixes more easily.

That is a different story from cc: stable which just collects patches
and push them to all consumers of the stable branch if they apply.

To conclude, the Fixes tag is a generaly useful tag to bind patches
together and let people evaluate how important that is while Cc stable
is an indication that a fix is serious enough to push to all stable
users.
-- 
Michal Hocko
SUSE Labs
