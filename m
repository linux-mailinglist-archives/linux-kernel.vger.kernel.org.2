Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDCEE405EC6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 23:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236578AbhIIVaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 17:30:22 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58085 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229877AbhIIVaV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 17:30:21 -0400
Received: from tazenda.hos.anvin.org ([IPv6:2601:646:8600:3c70:7285:c2ff:fefb:fd4])
        (authenticated bits=0)
        by mail.zytor.com (8.16.1/8.15.2) with ESMTPSA id 189LSmYo232844
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Thu, 9 Sep 2021 14:28:48 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 189LSmYo232844
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2021083001; t=1631222929;
        bh=CI2OZa+9rUBUu0LLPz+5if0syOzPOWKr2yvZ2VEeROU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=mAi6vMFS6DV2JJQThOInHggwyfbcuI0SPc38PY0vjad+WV+6LF0resE7wmFgFjVm0
         JP9RL4i4/xpD0U9V7vJXUjKcnjG/895tA60mQeXWU02aTiWm5Y/7q//0XxRwmBrBxb
         TIdIoFGAV161251msMMeQxcStPmYOG19ECGJ0VynN1GPLTRfLXNCXkQIYOUZYtn5AQ
         aMNVSfdXb0O4ERfElq1qzqm/ZNI3ME+fwlg9e27OvFKqqEViKRUiPp6yWY+JJaJcMq
         syRq81Q+cSCzLQLsQsj4yfuHtuRfwodibjZnRQ5DQYScw6XG13z6ghQnH57HOAiBxL
         E+gxGOmovFVrA==
Subject: Re: [PATCH] x86/asm: pessimize the pre-initialization case in
 static_cpu_has()
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210908171716.3340120-1-hpa@zytor.com>
 <YTo92+0ruBlkcaDf@zn.tnic>
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <1a73e0c2-8efe-fee9-5141-f7e9a95c748d@zytor.com>
Date:   Thu, 9 Sep 2021 14:28:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YTo92+0ruBlkcaDf@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/9/21 10:01 AM, Borislav Petkov wrote:
> On Wed, Sep 08, 2021 at 10:17:16AM -0700, H. Peter Anvin (Intel) wrote:
> 
>> Subject: Re: [PATCH] x86/asm: pessimize the pre-initialization case in static_cpu_has()
> 
> "pessimize" huh? :)
> 
> Why not simply
> 
> "Do not waste registers in the pre-initialization case..."
> 

Because it is shorter and thus can fit more contents

> ?
> 
>> gcc will sometimes manifest the address of boot_cpu_data in a register
>> as part of constant propagation. When multiple static_cpu_has() are
>> used this may foul the mainline code with a register load which will
>> only be used on the fallback path, which is unused after
>> initialization.
> 
> So a before-after thing looks like this here:
> 
> before:
> 
> ffffffff89696517 <.altinstr_aux>:
> ffffffff89696517:       f6 05 cb 09 cb ff 80    testb  $0x80,-0x34f635(%rip)        # ffffffff89346ee9 <boot_cpu_data+0x69>
> ffffffff8969651e:       0f 85 fc 3e fb ff       jne    ffffffff8964a420 <intel_pmu_init+0x14e7>
> ffffffff89696524:       e9 ee 3e fb ff          jmp    ffffffff8964a417 <intel_pmu_init+0x14de>
> ffffffff89696529:       f6 45 6a 08             testb  $0x8,0x6a(%rbp)
> ffffffff8969652d:       0f 85 45 b9 97 f7       jne    ffffffff81011e78 <intel_pmu_lbr_filter+0x68>
> ffffffff89696533:       e9 95 b9 97 f7          jmp    ffffffff81011ecd <intel_pmu_lbr_filter+0xbd>
> ffffffff89696538:       41 f6 44 24 6a 08       testb  $0x8,0x6a(%r12)
> ffffffff8969653e:       0f 85 d3 bc 97 f7       jne    ffffffff81012217 <intel_pmu_store_lbr+0x77>
> ffffffff89696544:       e9 d9 bc 97 f7          jmp    ffffffff81012222 <intel_pmu_store_lbr+0x82>
> ffffffff89696549:       41 f6 44 24 6a 08       testb  $0x8,0x6a(%r12)
> 
> after:
> 
> ffffffff89696517 <.altinstr_aux>:
> ffffffff89696517:       f6 04 25 e9 6e 34 89    testb  $0x80,0xffffffff89346ee9
> ffffffff8969651e:       80
> ffffffff8969651f:       0f 85 fb 3e fb ff       jne    ffffffff8964a420 <intel_pmu_init+0x14e7>
> ffffffff89696525:       e9 ed 3e fb ff          jmp    ffffffff8964a417 <intel_pmu_init+0x14de>
> ffffffff8969652a:       f6 04 25 ea 6e 34 89    testb  $0x8,0xffffffff89346eea
> ffffffff89696531:       08
> ffffffff89696532:       0f 85 37 b9 97 f7       jne    ffffffff81011e6f <intel_pmu_lbr_filter+0x5f>
> ffffffff89696538:       e9 89 b9 97 f7          jmp    ffffffff81011ec6 <intel_pmu_lbr_filter+0xb6>
> ffffffff8969653d:       f6 04 25 ea 6e 34 89    testb  $0x8,0xffffffff89346eea
> ffffffff89696544:       08
> ffffffff89696545:       0f 85 b5 bc 97 f7       jne    ffffffff81012200 <intel_pmu_store_lbr+0x70>
> ffffffff8969654b:       e9 bb bc 97 f7          jmp    ffffffff8101220b <intel_pmu_store_lbr+0x7b>
> ffffffff89696550:       f6 04 25 ea 6e 34 89    testb  $0x8,0xffffffff89346eea
> 
> so you're basically forcing an immediate thing.
> 
> And you wanna get rid of the (%<reg>) relative addressing and force it
> to be rip-relative.
> 
>> Explicitly force gcc to use immediate (rip-relative) addressing for
> 
> Right, the rip-relative addressing doesn't happen here:
> 

Indeed it doesn't (egg on my face), nor does it turn out is there 
currently a way to do so (just adding (%%rip) breaks i386, and there is 
no equivalent to %{pP} which adds the suffix). Let me fix both; will 
have a patchset shortly.

	-hpa

