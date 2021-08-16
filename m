Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40BB43ED2AE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 12:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236162AbhHPK6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 06:58:19 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:53754 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235731AbhHPK6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 06:58:19 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R491e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UjAnU8b_1629111463;
Received: from 30.21.164.71(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0UjAnU8b_1629111463)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 16 Aug 2021 18:57:44 +0800
Subject: Re: [PATCH v2 1/4] mm: migrate: Move the page count validation to the
 proper place
To:     Matthew Wilcox <willy@infradead.org>
Cc:     akpm@linux-foundation.org, apopple@nvidia.com, shy828301@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1629008158.git.baolin.wang@linux.alibaba.com>
 <644a666e1e177c57a39a4c37c6e2ca64052b9d7e.1629008158.git.baolin.wang@linux.alibaba.com>
 <YRjtquPEpsked951@casper.infradead.org>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
Message-ID: <6f1b616a-d67c-7580-a3b2-fcb621917063@linux.alibaba.com>
Date:   Mon, 16 Aug 2021 18:58:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YRjtquPEpsked951@casper.infradead.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/8/15 18:34, Matthew Wilcox wrote:
> On Sun, Aug 15, 2021 at 02:23:03PM +0800, Baolin Wang wrote:
>> We've got the expected count for anonymous page or file page by
>> expected_page_refs() at the beginning of migrate_page_move_mapping(),
>> thus we should move the page count validation a little forward to
>> reduce duplicated code.
>>
>> Moreover the i_pages lock is not used to guarantee the page refcount
>> safety in migrate_page_move_mapping(), so we can move the getting page
>> count out of the i_pages lock. Since now the migration page has
>> established a migration pte under the page lock now, with the page
>> refcount freezing validation, to ensure that the page references
>> meet the migration requirement.
> 
> I remain unconvinced by this.
> 
> Looking at folio_migrate_mapping() a little more deeply, I don't
> understand why we first check folio_ref_count() and then attempt
> to free the refcount.  Why not just try to freeze it directly?
> 
> ie instead of your patch, this:
> 
> +++ b/mm/migrate.c
> @@ -403,13 +403,8 @@ int folio_migrate_mapping(struct address_space *mapping,
>          newzone = folio_zone(newfolio);
> 
>          xas_lock_irq(&xas);
> -       if (folio_ref_count(folio) != expected_count ||
> -           xas_load(&xas) != folio) {
> -               xas_unlock_irq(&xas);
> -               return -EAGAIN;
> -       }
> -
> -       if (!folio_ref_freeze(folio, expected_count)) {
> +       if (xas_load(&xas) != folio ||
> +           !folio_ref_freeze(folio, expected_count)) {
>                  xas_unlock_irq(&xas);
>                  return -EAGAIN;
>          }

I think this is reasonable, like what we've done in __remove_mapping().

> And since we've got the lock on the page, how can somebody else be
> removing it from the page cache?  I think that xas_load() can be
> removed too.  So even more simply,

Good point, this is more simply.

> 
> +++ b/mm/migrate.c
> @@ -403,12 +403,6 @@ int folio_migrate_mapping(struct address_space *mapping,
>          newzone = folio_zone(newfolio);
> 
>          xas_lock_irq(&xas);
> -       if (folio_ref_count(folio) != expected_count ||
> -           xas_load(&xas) != folio) {
> -               xas_unlock_irq(&xas);
> -               return -EAGAIN;
> -       }
> -
>          if (!folio_ref_freeze(folio, expected_count)) {
>                  xas_unlock_irq(&xas);
>                  return -EAGAIN;
> 
> but I'm not really set up to test page migration.  Does your test suite
> test migrating file-backed pages?

Yes, I've tested above changes, and the mapped file pages migration 
works well. So can I resend this patch set with your Suggested-by tag? 
Thanks.
