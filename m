Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01E78367C60
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 10:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235175AbhDVISj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 04:18:39 -0400
Received: from lb1-smtp-cloud9.xs4all.net ([194.109.24.22]:51561 "EHLO
        lb1-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235317AbhDVISg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 04:18:36 -0400
Received: from cust-b5b5937f ([IPv6:fc0c:c16d:66b8:757f:c639:739b:9d66:799d])
        by smtp-cloud9.xs4all.net with ESMTPA
        id ZUX7lpzxuvTEDZUXBlYAdn; Thu, 22 Apr 2021 10:18:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s2;
        t=1619079481; bh=mTMU/0of4wIoN570cprmA87NZm1WxI2wK8H9SjvtidM=;
        h=Subject:To:From:Message-ID:Date:MIME-Version:Content-Type:From:
         Subject;
        b=hvukjxxRER3z+kHHRCY5mGNZ7woiYyHws1xD6ufCpvCvI+Eot8XaalRcxS7D+/nlv
         wZs9eMMhIv7J81C9QwjB1mVP0xBVV9a3EmPAsDQ0BMSr+lTKpa2BbAMppcHKZDpJ25
         PqvSYHUMDvnna01VyjylzQkKM6yr0f2aKZQ5ZDcwMdKcknCE12PKxoQg4YIrxoRs2b
         m/fGWP6xXTBvjkmjbswzbmTpEf0Z1H+nhOB7I6RfmkstxKT+y2x3pzwquykRPyERsj
         pdNJoAPl1CKIKma5l+SEjYXLhyF2kdYu7Z2/rKvc+SwzVj6g5GXNn8k9hXrTYF9lj7
         KABUCchZ8f6CA==
Subject: Re: [PATCH 002/190] Revert "media: st-delta: Fix reference count leak
 in delta_run_work"
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Aditya Pakki <pakki001@umn.edu>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-3-gregkh@linuxfoundation.org>
 <b6e00864-f28a-ee9a-ea53-d1a8aa8c42fb@xs4all.nl> <YIEwKeINI8VOG+S4@kroah.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
Message-ID: <3336ff98-f5a4-6206-087e-0cbbce4b3b26@xs4all.nl>
Date:   Thu, 22 Apr 2021 10:17:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <YIEwKeINI8VOG+S4@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfCdHmo1iyKzoZ4R2mLJHJyJZ4fsZRdqfRjEmfqteDMU53g0/75wySmoPQNgL2Zg/CJevOe7MyqWZPbv7MXni4Fkd0u611928MkpnpYUyzJS4HnWSfb4m
 rzoRnao4I6Akm2NBSHa9+c2MKuAeYpFmzzkeBhjJQv/ox0J0gJkiSEkML8wnug59anZiptTo5S02THdCbx8zkcaQ+6WgAFBzptTEQNue7e9EFzu0y1R4O2bT
 HqccDAz2QOf3Bws3VVIlUNN1vpBVyXQ6dl2uIXBR2vjzD8L3AB1XFEgtHKmxhIHG84F4/wAw9WBvluO8/8RHmw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 22/04/2021 10:13, Greg Kroah-Hartman wrote:
> On Thu, Apr 22, 2021 at 10:02:32AM +0200, Hans Verkuil wrote:
>> Hi Greg,
>>
>> I re-reviewed all the patches in this series where I was CCed.
>>
>> These are all good and fix real bugs and should be re-reverted:
>>
>> [PATCH 002/190] Revert "media: st-delta: Fix reference count leak in delta_run_work"
>> [PATCH 003/190] Revert "media: sti: Fix reference count leaks"
>> [PATCH 004/190] Revert "media: exynos4-is: Fix several reference count leaks due to pm_runtime_get_sync"
>> [PATCH 005/190] Revert "media: exynos4-is: Fix a reference count leak due to pm_runtime_get_sync"
>> [PATCH 006/190] Revert "media: exynos4-is: Fix a reference count leak"
>> [PATCH 008/190] Revert "media: stm32-dcmi: Fix a reference count leak"
>> [PATCH 009/190] Revert "media: s5p-mfc: Fix a reference count leak"
>> [PATCH 010/190] Revert "media: camss: Fix a reference count leak."
>> [PATCH 011/190] Revert "media: platform: fcp: Fix a reference count leak."
>> [PATCH 012/190] Revert "media: rockchip/rga: Fix a reference count leak."
>> [PATCH 013/190] Revert "media: rcar-vin: Fix a reference count leak."
>> [PATCH 014/190] Revert "media: rcar-vin: Fix a reference count leak."
>> [PATCH 052/190] Revert "media: media/saa7146: fix incorrect assertion in saa7146_buffer_finish"
>> [PATCH 056/190] Revert "media: davinci/vpfe_capture.c: Avoid BUG_ON for register failure"
>> [PATCH 057/190] Revert "media: saa7146: Avoid using BUG_ON as an assertion"
>> [PATCH 058/190] Revert "media: cx231xx: replace BUG_ON with recovery code"
>> [PATCH 102/190] Revert "media: video-mux: fix null pointer dereferences"
>> [PATCH 183/190] Revert "media: isif: fix a NULL pointer dereference bug"
>>

Just to clarify and avoid ambiguities:

>> This one can be dropped since it actually contains a bug, I'm fairly certain

with 'This can be dropped' I meant: this can remain reverted.

>> that was unintentional:
>>
>> [PATCH 007/190] Revert "media: ti-vpe: Fix a missing check and reference count leak"
>>
>> I'll reply to that one separately.
>>
>> This one can be dropped since it is not necessary:

Ditto.

You probably understood what I meant, but I realized it was not very clear.

Regards,

	Hans

>>
>> [PATCH 073/190] Revert "media: rcar_drif: fix a memory disclosure"
>>
>> The V4L2 core already zeroes this. Other drivers that use fmt.sdr also
>> memset this, but that should be dropped in those drivers as well. I'll
>> make a patch for that.
> 
> Wonderful, many thanks for doing this review, I'll be dropping these
> from the series.
> 
> greg k-h
> 

