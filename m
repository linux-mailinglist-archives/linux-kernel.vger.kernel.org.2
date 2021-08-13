Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBFAA3EAEF7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 05:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238593AbhHMDeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 23:34:16 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:2607 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235909AbhHMDeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 23:34:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1628825628; x=1660361628;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=ZdkYZ2TUnPOD6dioIZVBJukAD6bsH/PEiLAUTGeDQEw=;
  b=BD1EYht4Gn2KQQG6QkGPRUCgTKVCNjRsQ03Vjre0xrCdOwjlzvjOkltI
   UtbvZz/J7b/g/pg5/Ts7Q5yYjtCWhgeJ7AjKIcqj/g7bquHFbwktjFrGQ
   D4XS+j4VfwCchYyEy/E043O5WnYaBjJWps4Mrcxnz3mhOxf2+q9G1Ghvc
   o=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 12 Aug 2021 20:33:48 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2021 20:33:47 -0700
Received: from [10.110.52.231] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.858.15; Thu, 12 Aug
 2021 20:33:47 -0700
Subject: Re: [PATCH 1/1] cfi: Use rcu_read_{un}lock_sched_notrace
To:     Kees Cook <keescook@chromium.org>
CC:     Sami Tolvanen <samitolvanen@google.com>,
        <linux-kernel@vger.kernel.org>,
        Jinlong Mao <jinlmao@codeaurora.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Trilok Soni <tsoni@codeaurora.org>
References: <20210811155914.19550-1-quic_eberman@quicinc.com>
 <202108111306.527943F39@keescook>
From:   Elliot Berman <quic_eberman@quicinc.com>
Message-ID: <2c07a1e7-79b7-b540-e159-a05a4938b6ae@quicinc.com>
Date:   Thu, 12 Aug 2021 20:33:27 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <202108111306.527943F39@keescook>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanexm03a.na.qualcomm.com (10.85.0.103) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,

On 8/11/2021 1:10 PM, Kees Cook wrote:
> On Wed, Aug 11, 2021 at 08:59:14AM -0700, Elliot Berman wrote:
>> If rcu_read_lock_sched tracing is enabled, the tracing subsystem can
>> perform a jump which needs to be checked by CFI. For example, stm_ftrace
>> source is enabled as a module and hooks into enabled ftrace events. This
>> can cause an recursive loop where find_shadow_check_fn ->
>> rcu_read_lock_sched -> (call to stm_ftrace generates cfi slowpath) ->
>> find_shadow_check_fn -> rcu_read_lock_sched -> ...
>>
>> To avoid the recursion, either the ftrace codes needs to be marked with
>> __no_cfi or CFI should not trace. Use the "_notrace" in CFI to avoid
>> tracing so that CFI can guard ftrace.
>>
>> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> 
> Thanks for this patch! While applying it I noticed that the DKIM
> signature failed. This is actually even visible in the lore archive:
> https://lore.kernel.org/lkml/20210811155914.19550-1-quic_eberman@quicinc.com/raw
> (DKIM_INVALID)
> 
> $ b4 am -tls https://lore.kernel.org/lkml/20210811155914.19550-1-quic_eberman@quicinc.com/
> Grabbing thread from lore.kernel.org/lkml/20210811155914.19550-1-quic_eberman%40quicinc.com/t.mbox.gz
> Analyzing 2 messages in the thread
> Checking attestation on all messages, may take a moment...
> ---
>    ✗ [PATCH 1/1] cfi: Use rcu_read_{un}lock_sched_notrace
>      + Reviewed-by: Sami Tolvanen <samitolvanen@google.com> (✓ DKIM/google.com)
>      + Signed-off-by: Kees Cook <keescook@chromium.org>
>      + Link: https://lore.kernel.org/r/20210811155914.19550-1-quic_eberman@quicinc.com
>    ---
>    ✗ BADSIG: DKIM/quicinc.com
> 
> 
> 
> Do you know if qualcomm is mangling outbound emails? (i.e. was the
> trailing body suffix added after calculating the DKIM signature?)

It's possible. I will check with our IT department. You may be aware 
that Qualcomm was previously using @codeaurora.org mails and this is my 
first time using new mail address.

I tried sending a patch to my personal Gmail address and it looked to be 
happy with the DKIM signature provided.

Please let me know if I should resend the patch a different way for you 
to be able to pull it in.

> 
> Thanks!
> 
> -Kees
> 
