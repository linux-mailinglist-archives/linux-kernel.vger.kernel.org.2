Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5EC93DFA68
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 06:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233429AbhHDE2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 00:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbhHDE2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 00:28:42 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6B1C0613D5
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 21:28:29 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id e13-20020a056830200db02904f06fa2790cso587368otp.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 21:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=V7dlIRAth9sYvaZsn4KNNo84AomPSoot7o917Iory/g=;
        b=fdGDsSmcFrcH5p5qG8Hlu+0IQqB8/i18u3L1FMTKzhkoYJvHcZhTtZ1GsWkW6ozRNF
         uYm7Hgwnnz6PHTnyXlqjOzwUZNo68IXCp0oNqDQyCR2XvLVqq91lxXD6+ZF7bBSejXwT
         LaZjjuPa60hlf2VQEzM3CVFix1k6Fxm0B561vYD7FwEdmHbjJoTJ3eiYOh8aODxiktCP
         KpSlLIXhxjE6l603EQGRWX9FCo4Hkzdjsr6j5D/Xk4W24Agc9RaaviLVsxlbnuGMy4zS
         c64IDF/xcIhoQalKnQ6QSu8KAtQPAlREG6f9vq4pj0fozbJXxOrOraeG5L3NBbdW+VTn
         lT0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=V7dlIRAth9sYvaZsn4KNNo84AomPSoot7o917Iory/g=;
        b=CYbLviw2vWDfAqdQmo862DW0CvBlzcgJ+ETvxYg6mdr/JfvQR0vzgJO23GbpUVTDtw
         m4zCZB+bOe5Rma8PkI+VJ7KYZG5lbYXzz7jGyLl42WCqFr9D8PnUSlqVH3rCkkmBaPEx
         Fk/DpJPdxZjQcyksSdB+glLcHmlDhEfRJKAUX7usyMQdiL5qBBbStz2/glUPQhfVSPP8
         TeWSQ2o6KjZdsazrGux2m6SkUeRqQ9Sm5LLdbqmpk+I+ZYnzWoYeqEThmGu01j+unfVV
         YwLzJ5kOh5PY+/DXsr8N/9ebyaT+5/RWq8+zTL84IgOAwTE0lt/5m2KO/9o6/jB9XVko
         3oGA==
X-Gm-Message-State: AOAM531C8cKms9Q3X3yNPh4GnU0Vb/0TlSkqr+HxA81nrJ0QQKjynAid
        hP75X/8RQwHqsKOnnYKyQltfUA==
X-Google-Smtp-Source: ABdhPJx5Hvw4eV4nN3fhfyM0o21/7qi2IboifgF1R9/Ebp17Hm6CGExEMMDBaHI6FyFurgqcZJvhZg==
X-Received: by 2002:a05:6830:19fa:: with SMTP id t26mr17968231ott.58.1628051309120;
        Tue, 03 Aug 2021 21:28:29 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id u14sm225435oth.73.2021.08.03.21.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 21:28:28 -0700 (PDT)
Date:   Tue, 3 Aug 2021 21:28:13 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     "Huang, Ying" <ying.huang@intel.com>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        David Hildenbrand <david@redhat.com>,
        Yang Shi <shy828301@gmail.com>, Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthew Wilcox <willy@infradead.org>,
        Minchan Kim <minchan@kernel.org>,
        huang ying <huang.ying.caritas@gmail.com>
Subject: Re: [PATCH] mm,shmem: Fix a typo in shmem_swapin_page()
In-Reply-To: <877dh354vc.fsf@yhuang6-desk2.ccr.corp.intel.com>
Message-ID: <e82380b9-3ad4-4a52-be50-6d45c7f2b5da@google.com>
References: <20210723080000.93953-1-ying.huang@intel.com> <24187e5e-069-9f3f-cefe-39ac70783753@google.com> <CAC=cRTNby4GkSJ-pjs6utgHtrQYEdy3XZQ06Qsxgyf1MJSBjrw@mail.gmail.com> <877dh354vc.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Aug 2021, Huang, Ying wrote:
> 
> As Hugh pointed out, EINVAL isn't an appropriate error code for race
> condition.  After checking the code, I found that EEXIST is the error
> code used for race condition.  So I revise the patch as below.  If Hugh
> doesn't object, can you help to replace the patch with the below one?

(I'm sorry that it's so hard to extract responses from me...)

Yes, I'll go along with this version, or Matthew's better commented
version, which Andrew has now taken into his tree.

I won't go so far as to Ack this, because I still want to revert the
original commit; but this will not do actual harm, and I'm too slow
to mess you around further for 5.14.  I'll just have to work through
it and argue it later when/if I have time.

I'll say more on that in answering your earlier mail in this thread.

But should admit right now that I think have somewhat misled us all.
Neither the EINVAL nor the -EINVAL were as dangerous as they looked:
because they were followed immediately by "goto failed", and

failed:
	if (!shmem_confirm_swap(mapping, index, swap))
		error = -EEXIST;

and in the case that get_swap_device() fails, all the swapping off
has been done, so shmem_confirm_swap() will return false, and the
error then be set to -EEXIST anyway.

But let's pretend that I hadn't realized that: what's in Andrew's
tree is better than what was there before.

(And let's pretend that in writing those paragraphs, I did not
realize that get_swap_device() could also fail if entry had got
corrupted - should never happen, of course - and shmem then get
stuck in a repeating -EEXIST loop.  Maybe I'll want to do better
for that case too, but not this time.)

Hugh
