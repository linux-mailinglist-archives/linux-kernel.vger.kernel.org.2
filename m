Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19A1C3E2324
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 08:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240914AbhHFGBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 02:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbhHFGBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 02:01:46 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A4F9C061798
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 23:01:31 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id kl2so4334295qvb.11
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 23:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=rYW2lp+YlCkYaFQsLGYV50O1Jv3vvw2P23Ygq/Hbf54=;
        b=TyXLgnG6qOCb6hdG0un177KMfdXwg8nIhbxm0OYyTLmyhmCe4WQJfvM+wnl/ns81dT
         jG0Ijj5xMNrXwEhYL3bihTMNtQGJt0Ykac90w5p9uJDexGUiYR1jekduXR9Zej2/t2UV
         9UpqAph4Zm0ymxEWX/ny+02dADxgLLSZOSN66bmKKkUL836Lvw5yxS6oVLFmVMs4ss9v
         F9pEXBpGm6B4iPdHLn9xdF6cumRuYxjg2I2beh96XYv9UUXB/D72+s4FuY5lZ/3KbDJX
         ohN3hbzkqGw31uSZx3LXgMbTi7HrzJykHRlwxkkzxa1YBSMECfImwcLgxqacso0t06/G
         DT5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=rYW2lp+YlCkYaFQsLGYV50O1Jv3vvw2P23Ygq/Hbf54=;
        b=Xhl1GADvgqBvKWf3NpgKJ9M1uKd9my+nM2zPkCedFoMIScU64+WxYRbowqcUIL/48U
         CxIa6hQP3PpDlQfrblCIflW0/cu63RGAxbhE1F8qBdt+M39h1LSsdu5UvCo4kieVeXfl
         7OvTTWw2SuEi169e9otQUR5uUQgOpUMqR7w5lfuANvHqasNT8Y3JaTgIwY556HZcz+RF
         ZxfCGduSdz+H05DaKt8d3i0/nxA2KuM670gnpwabWfnOcADbYtO/5mLwvgayt0diSjuy
         dP7AsRqd2dYf57QN1CNfbwQP+1rfCG9v+1fuqg52vorcKO+EYq7ClOGXPkQMReHupqzR
         SUWQ==
X-Gm-Message-State: AOAM531Ik0YtNrJUFNdOc2aJUCrzyJqQ1ngHJOz1hUiBRxOSp97JxJOA
        AAWvyxjzKfXIZBT++g7qJ0N43A==
X-Google-Smtp-Source: ABdhPJwchWtiDg11Sau4o6X6Q7QZuqIRXOFe3PIhO6ceFRV4TArzBIv0fYLLnnR9cBODdfaZei3Q0g==
X-Received: by 2002:ad4:4ea8:: with SMTP id ed8mr9377522qvb.2.1628229690105;
        Thu, 05 Aug 2021 23:01:30 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id o63sm4219675qkf.4.2021.08.05.23.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 23:01:29 -0700 (PDT)
Date:   Thu, 5 Aug 2021 23:01:27 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Yang Shi <shy828301@gmail.com>
cc:     Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Huang, Ying" <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH] mm,shmem: Fix a typo in shmem_swapin_page()
In-Reply-To: <CAHbLzkrShKORwU-Zrf5_5c6_o_iVwoXRTT+7ABZALLj7p0w-Ug@mail.gmail.com>
Message-ID: <d1c768c-8b6-6a9d-ddde-39ac51286927@google.com>
References: <20210723080000.93953-1-ying.huang@intel.com> <24187e5e-069-9f3f-cefe-39ac70783753@google.com> <YPs6cQo7iG1JcOn8@casper.infradead.org> <8735rr54i9.fsf@yhuang6-desk2.ccr.corp.intel.com> <YQkwBdpWTPjv4xIx@casper.infradead.org>
 <704d597-443b-32f-84eb-524a58dd8ef@google.com> <CAHbLzkrShKORwU-Zrf5_5c6_o_iVwoXRTT+7ABZALLj7p0w-Ug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Aug 2021, Yang Shi wrote:
> On Tue, Aug 3, 2021 at 10:34 PM Hugh Dickins <hughd@google.com> wrote:
> >
> > I've never seen the swapoff race claimed by Miaohe, and don't expect to;
> > but he's probably right, given the current code.  I just dislike adding
> > unnecessary complexity, and siting it in the wrong place (mm/shmem.c).
> >
> > Yang, is it possible that 5.1 commit 8fd2e0b505d1 ("mm: swap: check if
> > swap backing device is congested or not") was actually developed and
> > measured on 4.1 or earlier, which still had blk_set_queue_congested()?
> 
> I forgot the exact version, but definitely not 4.1 or earlier. Maybe
> 4.19 or earlier. I'm not familiar with how block layer detect
> congestion, if the logic was changed, hence the optimization doesn't
> stand anymore nowadays, I'm totally fine to remove it.

You drove me back to look more closely.  blk_set_queue_congested()
vanished from include/linux/blkdev.h in 4.2, but blk_set_congested()
appeared then in block/blk-core.c to replace it.  blk_set_congested()
vanished (along with all references to "congested" in blk-core.c) in
5.0, then your commit (most probably tested on 4.19) went into 5.1 -
just after it had become redundant!

Thanks, yes, let's revert that and Miaohe's and Huang's, later on.

Hugh
