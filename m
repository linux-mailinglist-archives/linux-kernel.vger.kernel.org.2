Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0085744C1C0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 14:00:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbhKJNCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 08:02:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:40984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231162AbhKJNCt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 08:02:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 602CC610A8;
        Wed, 10 Nov 2021 13:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636549201;
        bh=vRGoovHr51rN6594fQkK0ZFynKTYvUJYr5YGyECiS4w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=TDlY+F0q9dZG8mfukx8en3pae51hU4cL2h+b75RqtaLIDin7jrMPTpBUs5UP00dxp
         lX1r2ZhKZ3WFyzCXSLn6cT9rjYWGC3VfrV/uD4gkhkCuPhSr02yEWUOwoB2WJ/31yW
         F8zMuZhLoCWsVfqulC6wokPb/11Of+eg+WeVHvk++u0FqtHP7wxsmXo4sj7tUnrcru
         QvuNsZYcpUKTBO5xaTTN+gv0/jvLp5fdPjmNFR/c3vr3qweKiI8pKQyIk0qGMFHPjU
         9mRN7kZ4MG9NX6wDjo8nXo9cEexmqTgcIh/8uMfSVwpN1f+hQwfSeygm7wET0se3ir
         wfVX3MNOYC62w==
From:   SeongJae Park <sj@kernel.org>
To:     Xin Hao <xhao@linux.alibaba.com>
Cc:     sjpark@amazon.de, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V1 1/2] mm/damon: Unified access_check function naming rules
Date:   Wed, 10 Nov 2021 12:59:59 +0000
Message-Id: <20211110125959.18141-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <556ab139a12296744d25f76b99f4e6b7ccfaf131.1636546262.git.xhao@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Nov 2021 20:13:13 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:

> In damon/paddr.c file, two functions names start with underscore,
> 	static void __damon_pa_prepare_access_check(struct damon_ctx *ctx,
> 			struct damon_region *r)
> 	static void __damon_pa_prepare_access_check(struct damon_ctx *ctx,
> 			struct damon_region *r)
> In damon/vaddr.c file, there are also two functions with the same function,
> 	static void damon_va_prepare_access_check(struct damon_ctx *ctx,
> 			struct mm_struct *mm, struct damon_region *r)
> 	static void damon_va_check_access(struct damon_ctx *ctx,
> 			struct mm_struct *mm, struct damon_region *r)
> 
> It makes sense to keep consistent, and it is not easy to be confused with
> the function that call them.
> 
> Signed-off-by: Xin Hao <xhao@linux.alibaba.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
