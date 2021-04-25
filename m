Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDA5F36A85D
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Apr 2021 18:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbhDYQXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Apr 2021 12:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbhDYQXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Apr 2021 12:23:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107EFC061574
        for <linux-kernel@vger.kernel.org>; Sun, 25 Apr 2021 09:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=ZrcYJ0XMzf0bzyes6VZnmvGV1EA+NWdX4Z8T13Kb4ws=; b=cLiHBs1vHIV9pysene5qF2c9aH
        MQSIkrvmR7Ft0EVv8+W0RyqbFE6kvKKIHCBqBeUwuIWYnyxD8Rw0qjfrGh02ZUzXW4OKjNL0rG4ew
        IxUUebbFi70wCuCVQh5gYaTCpsa8NL99mLW2d1HeGbXrtl8WyBHnlfXrZGcaYdLN2fgm9Z9vebq5O
        ZkCBP89Sndkdbl3siWJcGZ6GcTZ/ZHyDehfKi8s4Afxi3JV5Ko0T5o2dYMrKoJc4qExKT6JtmPwH7
        mRUfQwLgWMab+QNViUq5q9ckEVwiAkSgzAxnZJsQA42GcA27+hBqxgXUPtQNZpKiUjtiNtIb2aHwK
        G2WDcUSQ==;
Received: from [2601:1c0:6280:3f0::df68]
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lahVz-004TI5-Lh; Sun, 25 Apr 2021 16:22:00 +0000
Subject: Re: [PATCH] mtd: rawnand: marvell: Minor documentation correction
To:     Souptick Joarder <jrdr.linux@gmail.com>, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1619341721-5580-1-git-send-email-jrdr.linux@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <24534cc6-e6dc-feda-1e2f-b9b3501845d9@infradead.org>
Date:   Sun, 25 Apr 2021 09:21:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <1619341721-5580-1-git-send-email-jrdr.linux@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/25/21 2:08 AM, Souptick Joarder wrote:
> Kernel test robot throws below warning ->
> drivers/mtd/nand/raw/marvell_nand.c:454: warning: This comment starts
> with '/**', but isn't a kernel-doc comment. Refer
> Documentation/doc-guide/kernel-doc.rst
> 
> Minor documentation correction.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> ---
>  drivers/mtd/nand/raw/marvell_nand.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/raw/marvell_nand.c b/drivers/mtd/nand/raw/marvell_nand.c
> index 79da6b0..e7b48d4 100644
> --- a/drivers/mtd/nand/raw/marvell_nand.c
> +++ b/drivers/mtd/nand/raw/marvell_nand.c
> @@ -451,7 +451,7 @@ struct marvell_nfc_timings {
>  };
>  
>  /**
> - * Derives a duration in numbers of clock cycles.
> + * TO_CYCLES*() - Derives a duration in numbers of clock cycles.

Hi--

Did you test that?  I would be surprised if kernel-doc stays quiet
with that change.

[testing]

Yep, kernel-doc doesn't like to see that '*' there.
That doesn't work.

>   *
>   * @ps: Duration in pico-seconds
>   * @period_ns:  Clock period in nano-seconds
> 


-- 
~Randy

