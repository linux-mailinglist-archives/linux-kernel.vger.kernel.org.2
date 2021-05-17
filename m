Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 271D73825F0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 09:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233826AbhEQH56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 03:57:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:38530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231482AbhEQH55 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 03:57:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8ACC9600D4;
        Mon, 17 May 2021 07:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621238201;
        bh=Wqz88rsyx5loDebf/0f8TjMH001yyZ9yBPXBriVk+14=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rmy2En7GXq7FJJ8ijNZSkU2j5oFf8dfd+3xtLvw3J6lL1Gr/yvJ3Q8Atf7+YNiw0N
         DJe+IIJBc5s5d6Cyj916u+i063Iz9fJt//dF9hyv0ZKv0Bo8gGjL0s08vMWUQcwt11
         /ZRnW3dAyso9ko4Esw83Ra56hRvht/viGVisYVPJcuu2B8WK2GMtA5in06robQwvLj
         mS4H6d20lSZid0dG7AX+Xd6bDsFfCh1VdROFLnTHWURjXCIuSDocVqvU1qIt99LWf+
         yWejoUEnuFOyvlZC4gNcN6xTFUPWJ8D8k/4EDs7A3cZEitfYmAcv87ZlL5/d8Q+MuY
         wt/7/t5qvps6g==
Date:   Mon, 17 May 2021 09:56:37 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2] module: check for exit sections in layout_sections()
 instead of module_init_section()
Message-ID: <YKIhtYArH24372TZ@p200300cbcf361a0029e37a38368d6727.dip0.t-ipconnect.de>
References: <20210514160904.21989-1-jeyu@kernel.org>
 <20210514170930.GE12395@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210514170930.GE12395@shell.armlinux.org.uk>
X-OS:   Linux p200300cbcf361a0029e37a38368d6727.dip0.t-ipconnect.de
 5.12.0-2-default x86_64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Russell King (Oracle) [14/05/21 18:09 +0100]:
>On Fri, May 14, 2021 at 06:09:04PM +0200, Jessica Yu wrote:
>> Previously, when CONFIG_MODULE_UNLOAD=n, the module loader just does not
>> attempt to load exit sections since it never expects that any code in those
>> sections will ever execute. However, dynamic code patching (alternatives,
>> jump_label and static_call) can have sites in __exit code, even if __exit is
>> never executed. Therefore __exit must be present at runtime, at least for as
>> long as __init code is.
>>
>> Commit 33121347fb1c ("module: treat exit sections the same as init
>> sections when !CONFIG_MODULE_UNLOAD") solves the requirements of
>> jump_labels and static_calls by putting the exit sections in the init
>> region of the module so that they are at least present at init, and
>> discarded afterwards. It does this by including a check for exit
>> sections in module_init_section(), so that it also returns true for exit
>> sections, and the module loader will automatically sort them in the init
>> region of the module.
>>
>> However, the solution there was not completely arch-independent. ARM is
>> a special case where it supplies its own module_{init, exit}_section()
>> functions. Instead of pushing the exit section checks into
>> module_init_section(), just implement the exit section check in
>> layout_sections(), so that we don't have to touch arch-dependent code.
>>
>> Fixes: 33121347fb1c ("module: treat exit sections the same as init sections when !CONFIG_MODULE_UNLOAD")
>> Signed-off-by: Jessica Yu <jeyu@kernel.org>
>
>Looks good!
>
>Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
>
>Thanks!

Queued, thanks for the review Russell!

Jessica
