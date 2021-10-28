Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3F043E8A3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 20:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbhJ1Sxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 14:53:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:54846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229645AbhJ1Sxp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 14:53:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 22A43610D2;
        Thu, 28 Oct 2021 18:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635447077;
        bh=QXYlXZ/XsbqGTREhOhDWkniHowuwQaogvXifIJ8tj40=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=KS/y7VDCoI87IOHlUXdt/mCgArq+2fwsNM9fDLF10UES2E8xLsC1oT3ixDM0zuyHf
         +78GXc8c+VDsxa0CXb/iLGnpWG/AjTXtxCaOmBu7o9ZdDkOh9G3gSeukz2qqkttybV
         fv2teg6bfaUrCTiVWn8wcxOzJmlXQLeSacLn6pDPom//LSWZ+Xzm6jtcAO5jXEI9vb
         lVqTNFWa2FaoiFhfJ6+7QPuCRQdeAhYfHiruUOJp92MQncvlh53KjXxvtX+8PIt/Cl
         0ibiZ1zPH0fWvQorJJck2NJpscF22ID+RZ2CQJvMAPM7csCfAP6DJ+VV35JUIcGuyp
         83cs+O7DkUpgQ==
From:   SeongJae Park <sj@kernel.org>
To:     Colin Ian King <colin.i.king@googlemail.com>
Cc:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] mm/damon: Fix a few spelling mistakes in comments and a pr_debug message
Date:   Thu, 28 Oct 2021 18:51:12 +0000
Message-Id: <20211028185112.16085-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211028184157.614544-1-colin.i.king@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Oct 2021 19:41:57 +0100 Colin Ian King <colin.i.king@googlemail.com> wrote:

> There are a few spelling mistakes in the code. Fix these.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Thank you for the fixes!

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

> ---
>  mm/damon/core.c       | 2 +-
>  mm/damon/dbgfs-test.h | 2 +-
>  mm/damon/vaddr-test.h | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index f37c17b53814..c381b3c525d0 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -959,7 +959,7 @@ static unsigned long damos_wmark_wait_us(struct damos *scheme)
>  	/* higher than high watermark or lower than low watermark */
>  	if (metric > scheme->wmarks.high || scheme->wmarks.low > metric) {
>  		if (scheme->wmarks.activated)
> -			pr_debug("inactivate a scheme (%d) for %s wmark\n",
> +			pr_debug("deactivate a scheme (%d) for %s wmark\n",
>  					scheme->action,
>  					metric > scheme->wmarks.high ?
>  					"high" : "low");
> diff --git a/mm/damon/dbgfs-test.h b/mm/damon/dbgfs-test.h
> index 104b22957616..86b9f9528231 100644
> --- a/mm/damon/dbgfs-test.h
> +++ b/mm/damon/dbgfs-test.h
> @@ -145,7 +145,7 @@ static void damon_dbgfs_test_set_init_regions(struct kunit *test)
>  
>  		KUNIT_EXPECT_STREQ(test, (char *)buf, expect);
>  	}
> -	/* Put invlid inputs and check the return error code */
> +	/* Put invalid inputs and check the return error code */
>  	for (i = 0; i < ARRAY_SIZE(invalid_inputs); i++) {
>  		input = invalid_inputs[i];
>  		pr_info("input: %s\n", input);
> diff --git a/mm/damon/vaddr-test.h b/mm/damon/vaddr-test.h
> index 1f5c13257dba..ecfd0b2ed222 100644
> --- a/mm/damon/vaddr-test.h
> +++ b/mm/damon/vaddr-test.h
> @@ -233,7 +233,7 @@ static void damon_test_apply_three_regions3(struct kunit *test)
>   * and 70-100) has totally freed and mapped to different area (30-32 and
>   * 65-68).  The target regions which were in the old second and third big
>   * regions should now be removed and new target regions covering the new second
> - * and third big regions should be crated.
> + * and third big regions should be created.
>   */
>  static void damon_test_apply_three_regions4(struct kunit *test)
>  {
> -- 
> 2.32.0
> 
> 
