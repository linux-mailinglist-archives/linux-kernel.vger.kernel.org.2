Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9F803DC21C
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 02:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234930AbhGaAsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 20:48:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:51934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234326AbhGaAsY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 20:48:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8589160FED;
        Sat, 31 Jul 2021 00:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627692498;
        bh=UwDj/y8hR/ti9YDi57SbxdxNismgSQMBBvAIDtT+11U=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=bn4prbbocPP1EKdS4jyVAlSadb9WvZxtpgf7NfvCEwkdu0ZAahLuhsSMHg8Nq03WK
         A3r4GCSJwOj7Znl0UZ7d4b+EDd689KuksRAQeGgueKXTfXgkiNbn9xrosh+AkBh02M
         pdasRX//D7zxUIDskxoklFg6aCnD7oV1ro5RQpZs0i/ErIWq7nNv5/kTeMM1Sa6+x6
         FjdVqZBpyPlVsQyOLfnaKBWiOMrs1yVuna7Fs4zwxgo86GUnR488bdlzpxJyveh/PJ
         bucXoH9uiCqW9TOafeXSvdapBJBBcbI98mozKc29rc4UxnEYNykkqS+6IFskqe832p
         g08dm9Reeg6RQ==
Subject: Re: [f2fs-dev] [PATCH] f2fs: introduce nosmall_discard mount option
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Chao Yu <chao.yu@linux.dev>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20210730100530.4401-1-chao@kernel.org>
 <YQREtmDLBNKSQViC@google.com>
 <c0af2126-7383-a579-e020-6480216c46fe@kernel.org>
 <1a540deb-4219-4000-2f8d-a72695f1dfde@kernel.org>
 <YQSckPQWe9b0JfNu@google.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <fe768d28-db69-707a-0f95-4f1bf9f48b1e@kernel.org>
Date:   Sat, 31 Jul 2021 08:48:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YQSckPQWe9b0JfNu@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/7/31 8:42, Jaegeuk Kim wrote:
> On 07/31, Chao Yu wrote:
>> On 2021/7/31 7:41, Chao Yu wrote:
>>> On 2021/7/31 2:28, Jaegeuk Kim wrote:
>>>> how about adding "discard_gran=[small|segment|section]", and keeping discard_map
>>>> in the small case only? And, I think we should set the section mode for zoned
>>>> device automatically.
>>>
>>> Yup, better,
>>>
>>> About the naming, it look discard_gran is not clear here, since there is another
>>> sysfs entry /sys/fs/f2fs/<devname>/discard_granularity has the same name, and
>>> also semantics of newly added mount option is not only control the smallest discard
>>> size, but also indicate discard start offset should be aligned to segment or section.
>>> So how about using: "aligned_discard=[none|segment|section]" instead?
>>
>> Maybe: "aligned_discard=[block|segment|section]"?
> 
> How about discard_unit? I feel that issuing discards in one of those unit
> indicate the offset.

Looks fine to me, let me update the patch.

Thanks,

> 
>>
>>>
>>> Thanks,
>>>
>>>
>>> _______________________________________________
>>> Linux-f2fs-devel mailing list
>>> Linux-f2fs-devel@lists.sourceforge.net
>>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
>>>
