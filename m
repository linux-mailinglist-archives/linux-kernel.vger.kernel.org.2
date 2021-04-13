Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA6B35DF1C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 14:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244124AbhDMMoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 08:44:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:48722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242649AbhDMMnP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 08:43:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C6813611CE;
        Tue, 13 Apr 2021 12:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618317773;
        bh=DyUmwNhpXMdsOI3cyerl65s6TqAzbtvBayxAyHLmjRw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GBSiHaQvO6iLOwVNCPe9i+i5LW7JJRp/S+WokBi9PchSnbtV+izlDbVruz76LQ7L6
         xJom0RmzeGN/qIzXE0bPAa3DkZBYWGMsfwofQFTKMEFBaoXNYhntR908uY1H/hVNhp
         p6xrYkLzwYthd1P2KA4be+Va+hR7rL8mfkRUn7uPTi8N05KyR5fUZ6SjRd//Vo9AkQ
         Y+2lh/01Iu36T4aLifjOJyMXLVUTsGTPBeGHvFXGCF7d89sxGnL7e12whV6/lD64lW
         IkkbKxMhH6vwz20cYMj6NHMbJnbJMfSmvQPiYA8aGD5aM2gALVfso1nUmXczExe3J7
         GZkqxyCUgdxMg==
Date:   Tue, 13 Apr 2021 14:42:49 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     =?utf-8?B?5ZGo5Lyg6auY?= <zhouchuangao@vivo.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] kernel/module: Use BUG_ON instead of if condition
 followed by BUG.
Message-ID: <YHWRyZHkwH3F/Lr2@gunter>
References: <YHRFegmoOURrmHp3@gunter>
 <AFgAhgByDjWe0vX7lAC2-Ko-.3.1618298474446.Hmail.zhouchuangao@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AFgAhgByDjWe0vX7lAC2-Ko-.3.1618298474446.Hmail.zhouchuangao@vivo.com>
X-OS:   Linux gunter 5.11.6-1-default x86_64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ 周传高 [13/04/21 15:21 +0800]:
>
>>+++ zhouchuangao [30/03/21 05:07 -0700]:
>>>It can be optimized at compile time.
>>>
>>>Signed-off-by: zhouchuangao <zhouchuangao@vivo.com>
>>
>>Hi,
>>
>>Could you please provide a more descriptive changelog? I.e., Is this
>>a fix for a cocinelle warning? What are the optimization(s)?
>>
>>Thanks,
>>
>First,
>This patch comes from cocinelle warning.
>
>Second,
>#define BUG_ON(condition) do { if (unlikely(condition)) BUG(); } while (0)
>
>BUG_ON uses unlikely in if(). Through disassembly, we can see that
>brk #0x800 is compiled to the end of the function.
>As you can see below:
>    ......
>    ffffff8008660bec:   d65f03c0    ret
>    ffffff8008660bf0:   d4210000    brk #0x800
>
>Usually, the condition in if () is not satisfied. For the multi-stage pipeline,
>we do not need to perform fetch decode and excute operation on brk
>instruction.
>
>In my opinion, this can improve the efficiency of the multi-stage pipeline.

Thanks. Could you please modify your commit/changelog message to
include this information (including the coccinelle warning) and resend
the patch?
