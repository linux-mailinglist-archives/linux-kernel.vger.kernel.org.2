Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 481F7411803
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 17:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241427AbhITPUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 11:20:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:49354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241390AbhITPU0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 11:20:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A7FE161077;
        Mon, 20 Sep 2021 15:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632151139;
        bh=hMqD6PGf8FCPLkuwccE6s/NEp0UTku+p7fu9eNxoeKs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=mD15+EK6ElnKTqCJSIZvB/+ThwMyeQH1d/qhx3ONsRTa4mvHnE7MlwDYOryDPYbeO
         gWNZGw7+khxdrccdIgJzpPGZEhNfpR8DqnsqK08Z8ffENAvi37Trobs2i1RcAGBN1D
         qeD9Sea3HNPW5C/GPQuqpeKVtud40gsihp5K2d4ijX+0nC06k6GROHXKXO0j9QzpAr
         Sir6OFBDFBu7las8I/dHU2b6YFp9y7gUORcDmazMPy3J7cSFlNd7cQZRVyYOqBgeR5
         wup2sATMX5WnQCxoJhZ0sH257nQALMce9l6Z8SVyKdqd/qYH6qjHeeWtZ+/UcZ5GvO
         dzj8l6VavtoxQ==
From:   SeongJae Park <sj@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     SeongJae Park <sjpark@amazon.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon: fix stringop-overread warning in kunit test
Date:   Mon, 20 Sep 2021 15:18:50 +0000
Message-Id: <20210920151850.4433-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210920100132.1390409-1-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Sep 2021 12:01:23 +0200 Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> gcc-11 points out that strnlen() with a fixed length on a constant
> input makes no sense:
> 
> In file included from mm/damon/dbgfs.c:623:
> mm/damon/dbgfs-test.h: In function 'damon_dbgfs_test_str_to_target_ids':
> mm/damon/dbgfs-test.h:23:47: error: 'strnlen' specified bound 128 exceeds source size 4 [-Werror=stringop-overread]
>    23 |         answers = str_to_target_ids(question, strnlen(question, 128),
>       |                                               ^~~~~~~~~~~~~~~~~~~~~~
> mm/damon/dbgfs-test.h:30:47: error: 'strnlen' specified bound 128 exceeds source size 7 [-Werror=stringop-overread]
>    30 |         answers = str_to_target_ids(question, strnlen(question, 128),
>       |                                               ^~~~~~~~~~~~~~~~~~~~~~
> mm/damon/dbgfs-test.h:37:47: error: 'strnlen' specified bound 128 exceeds source size 5 [-Werror=stringop-overread]
>    37 |         answers = str_to_target_ids(question, strnlen(question, 128),
>       |                                               ^~~~~~~~~~~~~~~~~~~~~~
> 
> Use a plain strlen() instead.
> 
> Fixes: 17ccae8bb5c9 ("mm/damon: add kunit tests")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thank you for the patch!  However, a same change has already merged[1] in -mm.
Sorry for that.

[1] https://lore.kernel.org/mm-commits/20210915033531.IdrhacHQk%25akpm@linux-foundation.org/


Thanks,
SJ

[...]
