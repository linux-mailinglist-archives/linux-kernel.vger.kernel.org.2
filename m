Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE8F2438FBB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 08:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbhJYGtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 02:49:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:50748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229727AbhJYGtv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 02:49:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9C69D6058D;
        Mon, 25 Oct 2021 06:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635144449;
        bh=LsXtv9HyPGe2c5XGf0mh7df2bubKWF3ZGkYZMLJK768=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=b5vNJWItaViQ6fW2BBXXwZ78uR8NDgIG4PMN3vEMnLeqUbtSRKhR3gbzUQVYURtVs
         fZdJcQ0Yngu4lsO0w4LxgdAFrZgf0xSHZqfiU38g7PEuWjTOqAjGge+FgJsKD7/wDF
         61A+a5D3mY9edrz8gwRJBTtgwnuB8kQ1N/Qv39WfpGp/vaTibAubv4WhGZW1/pgrwZ
         v5GhwQkB70t5RzMRIX28BJG6kEAG/QQl/ck1hP+ow47fLltKO0snIqRTtnQFf3eyGK
         0crcdAcbLyxqAGWs9Yf5R5pudZjMHTLee3b2uncJuMMy0RSY+VrXrLvSaeW9AAYPzr
         yKjmMr0LWFxug==
From:   SeongJae Park <sj@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     SeongJae Park <sj@kernel.org>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [hnaz-mm:master 251/366] mm/damon/paddr.c:216:5: error: no previous prototype for 'damon_pa_apply_scheme'
Date:   Mon, 25 Oct 2021 06:47:25 +0000
Message-Id: <20211025064725.14071-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <202110250029.5rftt73s-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Oct 2021 00:07:32 +0800 kernel test robot <lkp@intel.com> wrote:

> [-- Attachment #1: Type: text/plain, Size: 2384 bytes --]
> 
> tree:   https://github.com/hnaz/linux-mm master
> head:   468edaa91589af9aebd54b32f019bf309cf67e78
> commit: ccd554f15bb1cd977d740c1ea8241ecf95108c94 [251/366] mm/damon/paddr: support the pageout scheme
> config: arc-allyesconfig (attached as .config)
> compiler: arceb-elf-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/hnaz/linux-mm/commit/ccd554f15bb1cd977d740c1ea8241ecf95108c94
>         git remote add hnaz-mm https://github.com/hnaz/linux-mm
>         git fetch --no-tags hnaz-mm master
>         git checkout ccd554f15bb1cd977d740c1ea8241ecf95108c94
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross ARCH=arc 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
> >> mm/damon/paddr.c:216:5: error: no previous prototype for 'damon_pa_apply_scheme' [-Werror=missing-prototypes]
>      216 | int damon_pa_apply_scheme(struct damon_ctx *ctx, struct damon_target *t,
>          |     ^~~~~~~~~~~~~~~~~~~~~
>    cc1: all warnings being treated as errors

Thank you for this report!  I sent a fix:
https://lore.kernel.org/linux-mm/20211025064220.13904-1-sj@kernel.org/


Thanks,
SJ

[...]
