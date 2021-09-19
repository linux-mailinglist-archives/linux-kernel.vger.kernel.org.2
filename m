Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19CFB410A19
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Sep 2021 06:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbhISErg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 00:47:36 -0400
Received: from mx20.pku.edu.cn ([162.105.129.183]:7710 "EHLO pku.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229558AbhISErf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 00:47:35 -0400
X-Greylist: delayed 374 seconds by postgrey-1.27 at vger.kernel.org; Sun, 19 Sep 2021 00:47:34 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pku.edu.cn; s=dkim; h=Received:Message-ID:Subject:From:To:Cc:
        Date:In-Reply-To:Content-Type:User-Agent:MIME-Version:
        Content-Transfer-Encoding; bh=85t6yqqNE/Vrx8HG2DuwJ8LV7217ypghY0
        qAy8RQMHw=; b=tUJ92pSUltdxKMGI9UlaZq4KzlhhhovW3Betsh1Kal6vXCdmLd
        YO+aGgpGThfDb1H1LHKiHP5yg85tHLZzLSCKOkZBYJRsEUq/pR3/zPFKf+4icQIS
        O8nyyAOfUH39PsBC9gtGnwrNFzAECJqtqyVyWTZLwzk7QeFKY60Club3w=
Received: from [10.8.0.4] (unknown [222.29.156.242])
        by front01 (Coremail) with SMTP id 5oFpogDn+7j_vkZhAwVFAA--.15701S2;
        Sun, 19 Sep 2021 12:39:27 +0800 (CST)
Message-ID: <01b7d4575faf616fafd3c1569e351f6f10b1fe10.camel@pku.edu.cn>
Subject: Re: [PATCH v2] x86/fault: Fix wrong signal when vsyscall fails with
 pkey
From:   Jiashuo Liang <liangjs@pku.edu.cn>
To:     dave.hansen@intel.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org, luto@kernel.org,
        mingo@redhat.com, peterz@infradead.org, tglx@linutronix.de,
        x86@kernel.org
Cc:     liangjs@pku.edu.cn
Date:   Sun, 19 Sep 2021 12:39:27 +0800
In-Reply-To: <d8105e66-8e67-889a-5762-47506e0cb393@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.3 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: 5oFpogDn+7j_vkZhAwVFAA--.15701S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZry7Jw17CFy8JF15AFWUArb_yoWkZrb_Gr
        4xurn29a1jvFs2yF13tr4SqrWftF18XrW8JFs8tFy3Kr13ZrWkWFn0kFWvgF10qay8WFnI
        9rs0qrsa9w129jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb3AFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AK
        wVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20x
        vE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E
        87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c
        8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_
        Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrw
        ACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc2xSY4AK67AK
        6r45MxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_Kr1UJr1l4I8I3I0E4IkC6x
        0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
        zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
        4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
        CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
        nIWIevJa73UjIFyTuYvjfUe89NUUUUU
X-CM-SenderInfo: isqqijqrtqmio6sn3hxhgxhubq/1tbiAwEFBVPy7swMsgACs9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-08-23 at 07:55 -0700, Dave Hansen wrote:
> On 7/29/21 8:01 PM, Jiashuo Liang wrote:
>> The function __bad_area_nosemaphore() calls kernelmode_fixup_or_oops() with
>> parameter "signal" being "pkey", which will send a signal numbered "pkey".
>>
>> This bug appears when the kernel fail to access user-given memory pages
>> that are protected by pkey, so it can go through the do_user_addr_fault()
>> path and pass the !user_mode() check in __bad_area_nosemaphore(). Most
>> cases will simply run the kernel fixup code to make an -EFAULT. But when
>> another condition current->thread.sig_on_uaccess_err is met, which is
>> only used to emulate vsyscall, we will generate the wrong signal.
>>
>> A new parameter "pkey" is added to kernelmode_fixup_or_oops() to fix it.
>>
>> Fixes: 5042d40a264c ("x86/fault: Bypass no_context() for implicit kernel faults from usermode")
>> Signed-off-by: Jiashuo Liang <liangjs@pku.edu.cn>
>
> This is pretty obscure, only affecting vsyscall emulation, but:
>
> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>

Ping... Is there anyone reviewing/committing this patch?

Thanks!

