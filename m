Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A419409CBC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 21:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240035AbhIMTPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 15:15:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:39624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229460AbhIMTPD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 15:15:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ED6E3610D2;
        Mon, 13 Sep 2021 19:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631560427;
        bh=KmdY/RcrurEpeFE6+3oVxeC2jaOaMBgou37s+DP3su4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=mIkxzX47RFw1gfvvBuTgHBaMpbrbo1CZTJdSLBiFqLWlYcS8fzb13UmQCs14mhsZr
         Kc/9R/r3XH2U79TubJVBY/j81BqUNGfRCA9HLQHgzkEZxSA2P/sla6qJfcd0sNxCPn
         pAbZWzcv/j5nCKB1OI8ejFr3FEEkF5OesnOb1dJSLH36TsOBR97CD6v1X3Mhvp7NWL
         VB1wQ+fYg8R74xZr5Oyiizt7JaJ4d01qIOm8CiBBAJ1Oh58GO3hyVHPi4qN/dQPO5L
         PYqPfetKri9Q/0nBExTvUg0+H94gAN5ImDme2rOT+7D0Y3OoOoZYJCqgXlv3S1Qzx3
         ryfezWHtZscHw==
Subject: Re: drivers/infiniband/hw/qib/qib_sysfs.c:413:1: error: static_assert
 expression is not an integral constant expression
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
References: <202109112002.NZceUwiC-lkp@intel.com>
 <20210913165317.GX2505917@nvidia.com>
 <CAKwvOdnGaVb1XGwYpNK_3zAEyZ0JC1SDjC1UzzFEH=d_Mdi7Fw@mail.gmail.com>
 <20210913183813.GY2505917@nvidia.com> <YT+eJY4JoobVsKWu@archlinux-ax161>
 <20210913190246.GA4065468@nvidia.com>
From:   Nathan Chancellor <nathan@kernel.org>
Message-ID: <0158604c-8777-51c8-2cb5-b7f016335786@kernel.org>
Date:   Mon, 13 Sep 2021 12:13:45 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210913190246.GA4065468@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/13/2021 12:02 PM, Jason Gunthorpe wrote:
> On Mon, Sep 13, 2021 at 11:53:25AM -0700, Nathan Chancellor wrote:
>> On Mon, Sep 13, 2021 at 03:38:13PM -0300, Jason Gunthorpe wrote:
>>> On Mon, Sep 13, 2021 at 10:00:02AM -0700, Nick Desaulniers wrote:
>>>
>>>>> This macro would like to know that the passed in member name has a u64
>>>>> type, all the things I've come up with fail on clang - but many work
>>>>> fine on gcc. Frankly I think this case is a clang bug myself..
>>>>
>>>> Perhaps, though this assertion looks a bit like offsetof() to me. I
>>>> wonder if that can help here?
>>>
>>> The assertion would logically like to be this:
>>>
>>>           static_assert(typecheck(((struct qib_port *)0)->N, u64))
>>
>> This works for me with both GCC and clang, if that is acceptable to you?
>> It fails if you change one of the variables to 'u32'.
> 
> Yes, thanks. Can't say I've even heard of __same_type before :\ would
> be nice if this was in typecheck.h along with the other variations of
> the same idea. Presumably it is a little bit different from those
> somehow?

Good question... commit d2c123c27db8 ("module_param: add __same_type 
convenience wrapper for __builtin_types_compatible_p") introduced it so 
that it could be used in commit fddd52012295 ("module_param: allow 
'bool' module_params to be bool, not just int."); I am guessing that 
typecheck() could not be used in those cases. Perhaps all instances of 
typecheck() could be converted to __same_type()?

Do you want me to send a formal patch for that diff?

Cheers,
Nathan

