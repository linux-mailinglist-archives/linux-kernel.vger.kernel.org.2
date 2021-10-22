Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2724378E0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 16:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233011AbhJVOSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 10:18:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:42832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232977AbhJVOSm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 10:18:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 527A76128B;
        Fri, 22 Oct 2021 14:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634912184;
        bh=2XwGIQYCd7BXFm91WrDjKRyoGcOSgGsahM3gwQctWP8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=nkacMeC0kiWKbUgOEuxGwqJE/r1TV7R29e4Pe51KjlfF76dXCKhDppgPEMJcx6Gjw
         gXpUTJ5d7jmAPgrwC4BNm+rchMzvH7wr3lf+RfFEyQdO2CVIwcKyoRTvwQixAIsUb5
         Op0FMOI8j5tz1aApE3KU78ZE3t6bxLvkLTytY6XPL8QGKPa5MGcnDyzFKGWHeLk/JW
         OSu7KW+8y9Oo+v9mjgHVEvIHiwlSaInMEbrTWBvRQJsyW5Q7Rr9toR07buEeoP+xOD
         huLXkRrU8a0A+B3n6BW1iqcL0c2Qj9ul8/7/nrhL4rbJUt16Od9nALLKU2hvb+NrmF
         1h5/sATv1ltSA==
Message-ID: <d22bad26-266b-fc5f-efe8-cdad9fd4c1ce@kernel.org>
Date:   Fri, 22 Oct 2021 22:16:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [f2fs-dev] [PATCH] f2fs: include non-compressed blocks in
 compr_written_block
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Daeho Jeong <daeho43@gmail.com>
Cc:     Daeho Jeong <daehojeong@google.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20211006174910.2964885-1-daeho43@gmail.com>
 <5743eeca-a6e8-87d4-5799-c622fbada429@kernel.org>
 <CACOAw_zfDZMB4pLEuHWU5YcKnAtfBBTSuXwXy+L2rNJxXC3ysg@mail.gmail.com>
 <16840026-35ba-cce6-4e0b-3332b0902d2a@kernel.org>
 <CACOAw_xW7MZi8BVi-2Zo-=LruZr6k7fC7huYiYuWyaDDDti6WA@mail.gmail.com>
 <02abeeba-c359-cae3-4759-ee2087f21cc9@kernel.org>
 <CACOAw_xh2HSQDjb_tGopvssipDJYnpi4O1X5_eJqSOLpLebqsw@mail.gmail.com>
 <YXHZN5J2jyPG5tcx@google.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <YXHZN5J2jyPG5tcx@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/10/22 5:18, Jaegeuk Kim wrote:
> On 10/21, Daeho Jeong wrote:
>>> Okay, shouldn't we Cc stable mailing list for this patch? otherwise
>>> userspace tool may get different stat number with the same compressed
>>> file in different kernel?
>>>
>>
>> Oh, could you let me know what the address of the "stable" mailing list is?
> 
> Added Fixes and -stable. :)

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

> 
>>
>> Thanks,
>>
>>
>> _______________________________________________
>> Linux-f2fs-devel mailing list
>> Linux-f2fs-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
