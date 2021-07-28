Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE763D877F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 07:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233857AbhG1Fxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 01:53:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:51728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229814AbhG1Fxy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 01:53:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 28F2960F91;
        Wed, 28 Jul 2021 05:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627451633;
        bh=OLVO5xJIhwHiX7AgTyp2l1mNWBfyWHe5OjPiCsJ891k=;
        h=References:From:To:Cc:Subject:In-reply-to:Date:From;
        b=sSZ3Q+zosGSU3L8V950HNs4eIgUXdoiCEfbxfpuvRyspPyZ1jCdh/sljW36z3tT0m
         pTNMGkpLOuT79IrXDEvQy6/dPShiNsJiIgKbUrvURm8YoQP7+ldi9xlNTXZn0XE35m
         Ak/PFwJMn8GZVOiXyJmpwfVc8+aaV/tfg+wNyPv3kTBTdQBDe6bLqgvXLuD1CFmh7m
         GV4+qFcs3uHdaBlq6HDIatibTa++J0A7CHDaqR7AXPYD+mwC9eyt6BCnZGTR9tBX5K
         S/jgHFwDP10Jb6Mu/YLfT7qStpTO2Byaejv/51GD8L1IneifQjW8Esg7wBhZnATYlB
         G0HUf0LUwRWMA==
References: <1620716636-12422-1-git-send-email-wcheng@codeaurora.org>
 <87tun9g01v.fsf@kernel.org>
 <2675db9e-0cab-06b5-2986-0b4456a1f040@codeaurora.org>
 <5156238d-c1d8-a0d3-47af-8b52467fd071@codeaurora.org>
 <fc346f3c-6e3d-b96c-d64a-2ae4cf4218d4@codeaurora.org>
 <87v954xjoz.fsf@kernel.org>
 <3c55dd4f-5ebd-3730-7428-cb15235465a7@codeaurora.org>
User-agent: mu4e 1.4.15; emacs 27.2
From:   Felipe Balbi <balbi@kernel.org>
To:     Wesley Cheng <wcheng@codeaurora.org>
Cc:     gregkh@linuxfoundation.org, peter.chen@kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        jackp@codeaurora.org
Subject: Re: [PATCH v2] usb: dwc3: gadget: Replace
 list_for_each_entry_safe() if using giveback
In-reply-to: <3c55dd4f-5ebd-3730-7428-cb15235465a7@codeaurora.org>
Date:   Wed, 28 Jul 2021 08:53:49 +0300
Message-ID: <87pmv3t24y.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Wesley,

Wesley Cheng <wcheng@codeaurora.org> writes:
>>>>> Sorry for the late response.  So I tried with a list_replace_init() to
>>>>> within the list_for_each_entry_safe() loop to update tmp w/ the
>>>>> cancelled_list list head, but the issue was still observed.  This is
>>>>> because we can't replace the reference the loop already has stored in
>>>>> tmp, which is simply updated as the current item on the next iteration.
>>>>>
>>>>> I believe this is what you were trying to achieve?
>>>>>
>>>> Was wondering if you had any further inputs on this change?  As
>>>> mentioned, I tried a few things with list_replace_init(), which did not
>>>> work.
>>>>
>>>
>>> Sorry for the ping.  Is this change OK to add as is?  We've been running
>>> into this instance pretty frequently during our testing, so just wanted
>>> to close on the proper changes being merged upstream.
>> 
>> The idea is this:
>> 
>> 	struct list_head	local;
>> 
>>         spin_lock_irq(&lock);
>>         list_replace_init(&dwc->cancelled_list, &local);
>>         spin_unlock_irq(&lock);
>> 
>> 	list_for_each_entry_safe(req, tmp, &local, list) {
>>         	/* ... */
>> 	}
>> 
>> It looks to me this should work fine, no? You can also follow what
>> drivers/usb/core/hcd.c is doing in usb_giveback_urb_bh() and restarting
>> if dwc->cancelled_list is not empty after list_for_each_entry_safe().
>> 
>> Can you give that one a shot?
>> 
>
> Great, thanks for this suggestion!  Now I understand what you were
> referring to.  I gave this a try and it works well.  Will prepare a
> change to replace both places with list_replace_init()

this is great news :-) Thanks for trying it out

-- 
balbi
