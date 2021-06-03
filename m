Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97D39399770
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 03:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbhFCBSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 21:18:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:39104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229568AbhFCBSy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 21:18:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D9BE360FE4;
        Thu,  3 Jun 2021 01:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622683030;
        bh=ZZSgtz1O7vXnB7wNRF8Y8LlDQZi1WwpqQfJvHz5bu6E=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=qoch9BCdyC8kVv3yCNZkT1g36Sdj2yVjowUBaB07sk59NmRiIwdrkIh/25EE5mAOP
         iqi95KyHpggyg/BpN+p2NOklidv5unS9kehBQadAMqd/omAjHhF5lMHdt3rBvMRFIz
         HXPuCWLQBiFrICQnvoHkI6RZvBkpGgfgAP0VSxXBLpgUQys0BTVYW8YXeQiLNlC9E3
         I2tM4BZjKWGaeRkK3LE/IsafAlNYLdk0zSQsXBMEQ5aXV5xz5HBXmest/guXTL9tTj
         gHyKGk0W3uSfY9hi+dbREBUEI7w7b5oQHaDyXBmcT977PcxtpuqfuLP1vYOJpe0HJu
         SqMVFUR98+7Mw==
Subject: Re: [PATCH 0/3] hexagon: Fix build error with CONFIG_STACKDEPOT and
 select CONFIG_ARCH_WANT_LD_ORPHAN_WARN
To:     Brian Cain <bcain@codeaurora.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
References: <20210521011239.1332345-1-nathan@kernel.org>
From:   Nathan Chancellor <nathan@kernel.org>
Message-ID: <0f3ac242-d187-57b5-e715-ea25933dbd52@kernel.org>
Date:   Wed, 2 Jun 2021 18:17:09 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210521011239.1332345-1-nathan@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/20/2021 6:12 PM, Nathan Chancellor wrote:
> Hi all,
> 
> This series fixes an error with ARCH=hexagon that was pointed out by
> the patch "mm/slub: use stackdepot to save stack trace in objects",
> which is in -mm/-next.
> 
> The first patch fixes that error by handling the '.irqentry.text' and
> '.softirqentry.text' sections.
> 
> The second patch switches Hexagon over to the common DISCARDS macro,
> which should have been done when Hexagon was merged into the tree to
> match commit 023bf6f1b8bf ("linker script: unify usage of discard
> definition").
> 
> The third patch selects CONFIG_ARCH_WANT_LD_ORPHAN_WARN so that
> something like this does not happen again.
> 
> Nathan Chancellor (3):
>    hexagon: Handle {,SOFT}IRQENTRY_TEXT in linker script
>    hexagon: Use common DISCARDS macro
>    hexagon: Select ARCH_WANT_LD_ORPHAN_WARN
> 
>   arch/hexagon/Kconfig              | 1 +
>   arch/hexagon/kernel/vmlinux.lds.S | 9 +++------
>   2 files changed, 4 insertions(+), 6 deletions(-)
> 
> 
> base-commit: 7a42b92b6d30c3f09629c7d5ada9e3de2aba01af
> 

Brian, did you have any comments on this series? ARCH=hexagon defconfig 
is currently broken in -next, it would be a real shame if this continued 
to regress after you just got Hexagon building in mainline. These 
patches seem like they would be worthy of a 5.13 pull request. 
Otherwise, Andrew could pick them up with your ack and stick them in 
front of "mm/slub: use stackdepot to save stack trace in objects" so 
that there is no build regression.

Cheers,
Nathan
