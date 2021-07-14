Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 857303C822E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 11:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238969AbhGNJ6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 05:58:47 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:59205 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238797AbhGNJ6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 05:58:46 -0400
Received: from fsav118.sakura.ne.jp (fsav118.sakura.ne.jp [27.133.134.245])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 16E9tp5M096146;
        Wed, 14 Jul 2021 18:55:51 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav118.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav118.sakura.ne.jp);
 Wed, 14 Jul 2021 18:55:51 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav118.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 16E9tpqe096143
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 14 Jul 2021 18:55:51 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [5.14-rc1] kbuild: stdout from cmd should not be discarded
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <c4d2f929-9a1f-d816-5a24-e2bf8a64fa8f@i-love.sakura.ne.jp>
 <CAK7LNAT4Jznx5_Tr8jWbdcmJ6zwqAoF9Jcvn89a5+wsGNd9G1Q@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <4fec4181-864c-bb0a-1038-03868019bc36@i-love.sakura.ne.jp>
Date:   Wed, 14 Jul 2021 18:55:49 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAK7LNAT4Jznx5_Tr8jWbdcmJ6zwqAoF9Jcvn89a5+wsGNd9G1Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/07/14 13:33, Masahiro Yamada wrote:
> On Mon, Jul 12, 2021 at 10:40 AM Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>
>> Commit 174a1dcc96429efc ("kbuild: sink stdout from cmd for silent build")
>> confuses users by sending prompt messages from
>>
>>   scripts/kconfig/conf -s --syncconfig
>>
>> to /dev/null before start waiting for response to prompt messages
>> when building with "make -s". Reverting that commit fixes this problem.
> 
> 
> Thanks for catching this.
> 
> Instead of reverting it,
> I'd like to fix the syncconfig part.
> 
> https://patchwork.kernel.org/project/linux-kbuild/patch/20210714042349.219199-1-masahiroy@kernel.org/

OK, that patch works for me.

Thank you.
