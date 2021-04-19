Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C38D6364DAE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 00:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbhDSWcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 18:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbhDSWcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 18:32:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD66C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 15:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=UXij9POGHwd862nCcv5OcBX1YCIoYZQmUwQ3iSWIGWk=; b=Dqf+H13jkpe+dCK64S1Zv+lyoT
        AQSASjEQH1JfFijNqCpAAe5XL7+rcdqxKGMaIWV06+gA4SmF1NIk8Rrex6LFm+GORggNgXHaByTrZ
        pK1lPjMwvgcBPpqtZudNkHdN1Qpm0Ns9AHZwC4IKYjj0BCRLNwGgIfJ2oHt1T2r4yBg3el2btb/W4
        P3JBprOiEssi5aV860tZb1J4RBIrPRq3bxjZ1rbkt1giwdtKlY6f1mtcPBPMjfRbKG5fy865Fmm0H
        /AO+2u+kDiq1gjk1uaknce7o1jPAKweO7YscNv6uCJHImpa7+i4aTvnNjcZ0XgnwXlrA3lTixhcbp
        dZdT8EkA==;
Received: from [2601:1c0:6280:3f0::df68]
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lYcQA-00ENaW-SY; Mon, 19 Apr 2021 22:31:19 +0000
Subject: Re: [PATCH] afs: fix no return statement in function returning
 non-void
To:     David Howells <dhowells@redhat.com>,
        Zheng Zengkai <zhengzengkai@huawei.com>
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        huawei.libin@huawei.com
References: <20210327121624.194639-1-zhengzengkai@huawei.com>
 <6575.1617890815@warthog.procyon.org.uk>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <02f8940c-e1af-fffa-8bb3-3bfa96bfafa9@infradead.org>
Date:   Mon, 19 Apr 2021 15:31:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <6575.1617890815@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/8/21 7:06 AM, David Howells wrote:
> Zheng Zengkai <zhengzengkai@huawei.com> wrote:
> 
>>  static int afs_dir_set_page_dirty(struct page *page)
>>  {
>>  	BUG(); /* This should never happen. */
>> +	return 0;
>>  }
> 
> That shouldn't be necessary.  BUG() should be marked as 'no return' to the
> compiler.  What arch and compiler are you using?

How do mark a #define BUG() as __noreturn?

Several arch-es use #define for BUG() instead of using a function.

-- 
~Randy

