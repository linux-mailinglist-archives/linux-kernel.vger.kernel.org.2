Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCDB33936A2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 21:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235874AbhE0Ttp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 15:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235790AbhE0Ttj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 15:49:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21540C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 12:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:From:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=aKY5/pZ25eI5CRHO3fjsTiwQYdvDAEtrB/FByVR9LZI=; b=M2b1hgNM/5y6HtxLVTrSeXxCKq
        gB54LyEyvgoKvpjfbcbz9pWsQfCw6v2UzFsc5ueyIqfE2U8Y0V5C4jdGT5ynB3blSgCOre30uugU5
        2f3IYUFNYwJqVLiqW965vNFalkNNpbdkgKmv+61RwzBWtYaGQmd8oJ9UOcgPM590K5DtBkTBNSr4a
        J9gddyKdWk05zCyAGMBrj4wZXyLdFnoicjV/DDI20tCm75xfeJqnZCbHHhphP46UnQfrGPGsRVGyk
        FwBbhR19ydHPqwezzkcjpL0ZH/xnG8JSp/EYnVfvsrngd9WC9qhICmn8txJsVF/DXBgCFrS0AQ+Fe
        QeLUXRLQ==;
Received: from [2601:1c0:6280:3f0::ce7d]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lmLzB-0096QD-7f; Thu, 27 May 2021 19:48:05 +0000
Subject: Re: [PATCH] afs: fix no return statement in function returning
 non-void
From:   Randy Dunlap <rdunlap@infradead.org>
To:     David Howells <dhowells@redhat.com>,
        Zheng Zengkai <zhengzengkai@huawei.com>
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        huawei.libin@huawei.com
References: <20210327121624.194639-1-zhengzengkai@huawei.com>
 <6575.1617890815@warthog.procyon.org.uk>
 <02f8940c-e1af-fffa-8bb3-3bfa96bfafa9@infradead.org>
Message-ID: <2bc0f5fd-2519-7b53-7535-99054607ea4c@infradead.org>
Date:   Thu, 27 May 2021 12:48:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <02f8940c-e1af-fffa-8bb3-3bfa96bfafa9@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/19/21 3:31 PM, Randy Dunlap wrote:
> On 4/8/21 7:06 AM, David Howells wrote:
>> Zheng Zengkai <zhengzengkai@huawei.com> wrote:
>>
>>>  static int afs_dir_set_page_dirty(struct page *page)
>>>  {
>>>  	BUG(); /* This should never happen. */
>>> +	return 0;
>>>  }
>>
>> That shouldn't be necessary.  BUG() should be marked as 'no return' to the
>> compiler.  What arch and compiler are you using?
> 
> How do mark a #define BUG() as __noreturn?
> 
> Several arch-es use #define for BUG() instead of using a function.

Hi David,

So you are counting of BUG() being a function and not a macro?

Doesn't seem like a good idea.

-- 
~Randy

