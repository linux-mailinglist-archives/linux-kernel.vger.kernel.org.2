Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18AC6354296
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 16:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241254AbhDEOIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 10:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232860AbhDEOID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 10:08:03 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ABC7C061756
        for <linux-kernel@vger.kernel.org>; Mon,  5 Apr 2021 07:07:57 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id c8so11024590wrq.11
        for <linux-kernel@vger.kernel.org>; Mon, 05 Apr 2021 07:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=JlbOqM+HKUif9ACJOM3T2e04ay7sz/FxW5cMBM8jD4k=;
        b=ZGVLjSk84lCWVnojhyYzP1r+QhKbwr6wuQt/Rkasuop9Srm7CQuoFEZMqk+8qGevQj
         7Ob6/BT8Pm4wa1+xWRbOsr2Rl2QHIIc1j5bTuEejSTCejh1jQPe76rT9Dx1rG7AhTWLp
         FoDtUGCcd+FaQseLEcXBm36umL4cpJPmc47JnyI74lf/xZNAqKllEYiYpTxwCqTZ5CfK
         68idM1b2kHu5lHEYp+v5kZ5EJPDJATfo9DleD+DaAZMZH9DA13WnUt30j+Qvc9LGlLha
         vXwllPbh7shxYIdcLAphO4OBxA4LYw5ipPCZ1tOgnPw1pYUYnMX4nQ4/zYKwgQE1OB6q
         7vyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=JlbOqM+HKUif9ACJOM3T2e04ay7sz/FxW5cMBM8jD4k=;
        b=SmyiFDmD59O8VDknyDmabXEPvlYzSKxG2gCXh1YKp8offKA+P0FS+qBOYryQQtvoad
         0yc3lchZrDLf2wObhL9Pd4vFhbJcmfDi4Nh40yRpMNT7i380ZTbuPaeXC6Tjs7nWTwc0
         vqjnmhszdz8mJrCKwz8fGarcK57VirAdiGU0VTqiSgtEImn4JO7vkH/zDxH0ZS35tiH8
         bI9NuZahI5sGc2a3HeJFzu4d2R+a8VJeSlNgYzLStCUun1Go14u4mNhrB+aUYTVpedIk
         XCE2Q0sVb49RiZ5o6uby2AueclOlV2uWeRz+2Ct+kcgy096ZgBJif65n0AKGLrzPflMq
         uo/Q==
X-Gm-Message-State: AOAM533JGtVOlqfrfteFQQbjdRr4fPCjVhoza5Vf4ECJr29c9Lw9j8hi
        5khmvhAuXHCRHl/eJmgq3mGQ/0stRs7GwQ==
X-Google-Smtp-Source: ABdhPJxdPOR3HmxvlPuIlDCDtbTwQJhMoUaOz8NP0db4o07Fr7c+h4mgkzm1y8faKJ9cU397p/tQBQ==
X-Received: by 2002:a5d:4884:: with SMTP id g4mr29215748wrq.191.1617631674693;
        Mon, 05 Apr 2021 07:07:54 -0700 (PDT)
Received: from ?IPv6:2001:818:de85:7e00:9a5b:98e6:2174:bf29? ([2001:818:de85:7e00:9a5b:98e6:2174:bf29])
        by smtp.gmail.com with ESMTPSA id 61sm17381191wrn.25.2021.04.05.07.07.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Apr 2021 07:07:53 -0700 (PDT)
Subject: Re: [Outreachy kernel] [PATCH] staging: emxx_udc: Ending line with
 argument
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
References: <20210401195457.24512-1-martinsdecarvalhobeatriz@gmail.com>
 <alpine.DEB.2.22.394.2104012314480.2908@hadrien>
From:   Beatriz Martins de Carvalho <martinsdecarvalhobeatriz@gmail.com>
Message-ID: <82580331-13dc-ed79-72e7-3984fd2f75f9@gmail.com>
Date:   Mon, 5 Apr 2021 15:07:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2104012314480.2908@hadrien>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Em 01/04/21 22:16, Julia Lawall escreveu:
>
> On Thu, 1 Apr 2021, Beatriz Martins de Carvalho wrote:
>
>> Cleans up check of "Lines should not end with a '('"
>> with argument present in next line in file emxx_udc.c
> The coding style documentation encourages remaining within 80 characters.
> I'm not sure that the ( warning is worth increading the excess beyond 80
> characters (or introducing it in the last case).
>
> julia
Thanks, prof Julia, how the checkpath now warning only if line length of 
100 characters, I used it for reference.

I will take the suggestions of checkpatch with more attention.

Beatriz

>> Signed-off-by: Beatriz Martins de Carvalho <martinsdecarvalhobeatriz@gmail.com>
>> ---
>>   drivers/staging/emxx_udc/emxx_udc.c | 11 ++++-------
>>   1 file changed, 4 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/staging/emxx_udc/emxx_udc.c b/drivers/staging/emxx_udc/emxx_udc.c
>> index 741147a4f0fe..20f53cf6e20f 100644
>> --- a/drivers/staging/emxx_udc/emxx_udc.c
>> +++ b/drivers/staging/emxx_udc/emxx_udc.c
>> @@ -1073,9 +1073,8 @@ static int _nbu2ss_epn_in_pio(struct nbu2ss_udc *udc, struct nbu2ss_ep *ep,
>>   		i_word_length = length / sizeof(u32);
>>   		if (i_word_length > 0) {
>>   			for (i = 0; i < i_word_length; i++) {
>> -				_nbu2ss_writel(
>> -					&preg->EP_REGS[ep->epnum - 1].EP_WRITE,
>> -					p_buf_32->dw);
>> +				_nbu2ss_writel(&preg->EP_REGS[ep->epnum - 1].EP_WRITE,
>> +					       p_buf_32->dw);
>>
>>   				p_buf_32++;
>>   			}
>> @@ -1225,8 +1224,7 @@ static void _nbu2ss_restert_transfer(struct nbu2ss_ep *ep)
>>   		return;
>>
>>   	if (ep->epnum > 0) {
>> -		length = _nbu2ss_readl(
>> -			&ep->udc->p_regs->EP_REGS[ep->epnum - 1].EP_LEN_DCNT);
>> +		length = _nbu2ss_readl(&ep->udc->p_regs->EP_REGS[ep->epnum - 1].EP_LEN_DCNT);
>>
>>   		length &= EPN_LDATA;
>>   		if (length < ep->ep.maxpacket)
>> @@ -1462,8 +1460,7 @@ static void _nbu2ss_epn_set_stall(struct nbu2ss_udc *udc,
>>   		for (limit_cnt = 0
>>   			; limit_cnt < IN_DATA_EMPTY_COUNT
>>   			; limit_cnt++) {
>> -			regdata = _nbu2ss_readl(
>> -				&preg->EP_REGS[ep->epnum - 1].EP_STATUS);
>> +			regdata = _nbu2ss_readl(&preg->EP_REGS[ep->epnum - 1].EP_STATUS);
>>
>>   			if ((regdata & EPN_IN_DATA) == 0)
>>   				break;
>> --
>> 2.25.1
>>
>> --
>> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
>> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
>> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20210401195457.24512-1-martinsdecarvalhobeatriz%40gmail.com.
>>
