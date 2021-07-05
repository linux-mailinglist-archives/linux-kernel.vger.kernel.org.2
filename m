Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAEF33BBC4C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 13:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbhGELkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 07:40:03 -0400
Received: from outbound-smtp37.blacknight.com ([46.22.139.220]:37419 "EHLO
        outbound-smtp37.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231286AbhGELkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 07:40:02 -0400
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp37.blacknight.com (Postfix) with ESMTPS id D8208199B
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jul 2021 12:37:24 +0100 (IST)
Received: (qmail 21946 invoked from network); 5 Jul 2021 11:37:24 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.255])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 5 Jul 2021 11:37:24 -0000
Date:   Mon, 5 Jul 2021 12:37:23 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Marco Elver <elver@google.com>
Cc:     akpm@linux-foundation.org, glider@google.com, dvyukov@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com, Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yang Shi <shy828301@gmail.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH] Revert "mm/page_alloc: make should_fail_alloc_page()
 static"
Message-ID: <20210705113723.GN3840@techsingularity.net>
References: <20210705103806.2339467-1-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20210705103806.2339467-1-elver@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 05, 2021 at 12:38:06PM +0200, Marco Elver wrote:
> This reverts commit f7173090033c70886d925995e9dfdfb76dbb2441.
> 
> Commit 76cd61739fd1 ("mm/error_inject: Fix allow_error_inject function
> signatures") explicitly made should_fail_alloc_page() non-static, due to
> worries of remaining compiler optimizations in the absence of function
> side-effects while being noinline.
> 
> Furthermore, kernel/bpf/verifier.c pushes should_fail_alloc_page onto
> the btf_non_sleepable_error_inject BTF IDs set, which when enabling
> CONFIG_DEBUG_INFO_BTF results in an error at the BTFIDS stage:
> 
>   FAILED unresolved symbol should_fail_alloc_page
> 
> To avoid the W=1 warning, add a function declaration right above the
> function itself, with a comment it is required in a BTF IDs set.
> 
> Fixes: f7173090033c ("mm/page_alloc: make should_fail_alloc_page() static")
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Marco Elver <elver@google.com>

Acked-by: Mel Gorman <mgorman@techsingularity.net>

Out of curiousity though, why does block/blk-core.c not require
something similar for should_fail_bio?

-- 
Mel Gorman
SUSE Labs
