Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C100C41620E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 17:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242006AbhIWPas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 11:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241979AbhIWPar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 11:30:47 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA5EC061574
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 08:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=AnEeQ76X0azmr4+uOVT20QGvRc60URiBSo8uDfTzt2g=; b=K/qxyniVuxCWpbQZFwzJnDj0g8
        UD9+E0DJYK+kXB0jVGFVEtRT3fDOSmlX5AjPSX3i/p6iZEaMsEsiS+rGxg6s7IsA+LGfFU/M0KzCJ
        JR8X6lPsjX/odIxhW7K5+Sn1BDLW5g0mO6lA+x4N8wpQOTJxpigQUOXhhf752+1wSeWY7ymbAujyE
        ucoHogmA6JnUmU/HRai/FFTPwLNaX68eVCCKGwQQoE5BSz0/iTa+r0JucFPTlIzPCTZOvrsEH+DZL
        jKkaSQh838yyIhIGQ86lIBA/XyHV2yGEmJUR58NmXFzYYc2AjSe56vAVkqi567Wo0c+0gYiLzilRn
        MaFMkWeg==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mTQet-00C3Wc-7f; Thu, 23 Sep 2021 15:29:11 +0000
Subject: Re: [PATCH] clocksource: arc_timer: eliminate redefined macro error
To:     Shahab Vahedi <Shahab.Vahedi@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Vineet Gupta <vgupta@kernel.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20210923031808.5945-1-rdunlap@infradead.org>
 <61fef534-36df-2ed9-5662-ccebefef494e@synopsys.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <fab5a32c-f33f-d546-0c9e-3673f2160d66@infradead.org>
Date:   Thu, 23 Sep 2021 08:29:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <61fef534-36df-2ed9-5662-ccebefef494e@synopsys.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/23/21 2:42 AM, Shahab Vahedi wrote:
> Hi Randy,
> 
> I have one minor comment.
> 
> On 9/23/21 5:18 AM, Randy Dunlap wrote:
>>
>> --- linux-next-20210917.orig/include/soc/arc/timers.h
>> +++ linux-next-20210917/include/soc/arc/timers.h
>> @@ -17,7 +17,7 @@
>>   #define ARC_REG_TIMER1_CNT	0x100	/* timer 1 count */
>>   
>>   /* CTRL reg bits */
>> -#define TIMER_CTRL_IE	        (1 << 0) /* Interrupt when Count reaches limit */
>> +#define TIMER_CTRL_IEN	        (1 << 0) /* Interrupt when Count reaches limit */
> 
> Could you change the name to "ARC_TIMER_CTRL_IE" instead? and while at it, please rename
> "TIMER_CTRL_NH" to "ARC_TIMER_CTRL_NH" for obvious consistency reasons and saving us
> from future clashes.  Thank you!
> 

OK, no problem.

Thanks for the feedback.

-- 
~Randy
