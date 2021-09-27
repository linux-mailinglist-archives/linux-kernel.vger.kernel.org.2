Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA91E419141
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 11:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233591AbhI0JFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 05:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233519AbhI0JF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 05:05:29 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14000C061575
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 02:03:52 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id nn5-20020a17090b38c500b0019af1c4b31fso12980625pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 02:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=fsM8DSW8COr9yjZjuQ8R7r+/Zwj6TnS2NlS6vkV0T3s=;
        b=fBt2WUdedT/b+XMGkk9EfRphHxJxR9zHYhs89nFhZkz55W92U7p0NpBfyW0zqGJpwP
         j2uq8q1Lep4fricDOV346ROxvq86TQPcEZEePRftxaqCJRpVgvw6EioiPUj9lgHpl3nl
         nvdxuD8DT/KRXLZiHac9Ej/mAlclfEQpY8qJR3Zg+EYWuXgIezfOpW0gsRo84N79aK6n
         D+hiFRBHY9WWHQYBTSC6InTMCjCKHJ2TiTZP4tGVqZdgg6TurTZjQOU/lwvW9rbieP7m
         rP3aE1d7fSFLu+Tt86nRae96GxyfLif6A1WhY1LAUombcCbd4F/SZUMX8khkc/BABCdC
         x2QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=fsM8DSW8COr9yjZjuQ8R7r+/Zwj6TnS2NlS6vkV0T3s=;
        b=jR6MaMTQNLG11nPgWD0TmEDrmwei7gOxg+7PMSRdI5HZhgYeQjOXdeOQp8v5Z2PTNX
         /mIW8JIwO9IK0uUYW1Umy4eFD79h746kmOrBqZKIwYF7IyDCMH8bKs4M9Xfn7T46CZf2
         +/sJ4FYr9KUelpTl2a5l5PVNQSFjnrwL+1VgmmJ8GTXElsTveG0e8zKCSoIV3inRLBeF
         H3xz6rHH+4pc3IolJBD7fTgbwJZmobd8Ec6mRCSXuzMJ3I70gfw1n57arn3ZhllUcw8x
         NiV0EkJz0p6wRBYLFIf4qBCOvV27g2l6kPgX68dyLyd2G5yaiDXsQukSWZNP14ZZhShT
         0Psw==
X-Gm-Message-State: AOAM531YaruxTDp9YCkOg9aO8Z7ujilXeew/mFX9gUNBw6f40dJWNWUy
        GyKO7gRr5JwX29HHfxM5UyQ=
X-Google-Smtp-Source: ABdhPJzfog+s1xblddJ/ixdQcD4E5XG8K9081mfU4t0av0LFMgspl8yS5uegoma4VNrU8CcaoLZktw==
X-Received: by 2002:a17:90a:9310:: with SMTP id p16mr18418730pjo.204.1632733431683;
        Mon, 27 Sep 2021 02:03:51 -0700 (PDT)
Received: from linux.asia-northeast3-a.c.our-ratio-313919.internal (252.229.64.34.bc.googleusercontent.com. [34.64.229.252])
        by smtp.gmail.com with ESMTPSA id p189sm16352293pfp.167.2021.09.27.02.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 02:03:51 -0700 (PDT)
Date:   Mon, 27 Sep 2021 09:03:47 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     linux-mm@kvack.org
Cc:     42.hyeyoo@gmail.com, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org
Subject: [QUESTION] is SLAB considered legacy and deprecated?
Message-ID: <20210927090347.GA2533@linux.asia-northeast3-a.c.our-ratio-313919.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello there,

I've been working on adding 'lockless cache' on sl[au]b for a while.
But what it actually does is actually adding 'queuing' on slub.

So there is a fundamental question coming into my mind:
	'is SLAB considered legacy and deprecated?'

It seems there are little development on SLAB and people think that
SLAB is legacy and deprecated, so CONFIG_SLUB is used by default.

But I think both has pros and cons for their own:
	SLAB: more temporal locality (cache friendly)
	but high usage of memory, and less spatial locality (TLB misses) than SLUB.

	SLUB: less temporal locality (less cache friendly) than SLAB
	but more spatial locality (TLB hit), and low usage of memory
	and good debugging feature.

Why do people say SLAB is deprecated/legacy?

Thanks,
Hyeonggon
