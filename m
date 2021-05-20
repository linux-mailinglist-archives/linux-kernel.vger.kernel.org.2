Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDCEB38B6CD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 21:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236652AbhETTN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 15:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233891AbhETTNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 15:13:25 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D8F3C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 12:12:04 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id t11so9670598pjm.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 12:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Vhd+O9ngUiaW+b64VVg6x1FRJZO378mbbVoeuL0y8HI=;
        b=O6RtmzHUaOhU3kzx2I77GM31mowWU/M+bVARMQtGUih16bLB/QCSa8LFs3hOgiGR2r
         1Lqm2r/md5ne/1ILg5CN0pBEkTJQ6tr4F/K822wnq0hcXh4/D93tHS+w9lS/f7SuybA2
         3Y11KtBBkjqRvVXfJfcy2wdCXrZ6l5tZqCNHmLnJCCOmJ+LjiqgSvegrBn6YarmGBaom
         +u4j/CtieI780TFVSWMX/4NimaQ8fghMHWDMKYmm9pXb2Q41FJD59M4NKXQkoRgC6I15
         Wx/DHy6PhruLLYfV7mqP5WES7CsMnwgqNOVUY5Gg7skTVkKl4EI+AAVL8qbHgR2WLk9u
         4jyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Vhd+O9ngUiaW+b64VVg6x1FRJZO378mbbVoeuL0y8HI=;
        b=hrM2tpbcHsiAa+/UpogNPq0pTgzgsoRKUiVYw146luX/Tp+OqEidTe7L7qTvgaiKPk
         ECPbpNfdjt0/F4zpvUeo3YHGUEeTBranPqYiARW9p4e06HoT6UnsfU+AKznTWyYM/c3F
         pmyFCQlh7NgHJUF8DdRFlRNZho0ll7dfCHxSYnMflYA/HjPTBG9JuEkux5sikczJGbaY
         ACwXbz0CAxNJZf0Zu2xplk44NDZNmHbZFRGqi+yXpIDs/9HdZGn2Z+r/H9Q7lxP55QQT
         kkhzvwuHgYSQ42OO1KqjeT3MVOfeNqUkEjcNl0L49rZSY1V0aZXgCiHBjccRki043jgd
         DxpQ==
X-Gm-Message-State: AOAM5303qlEwCLJKszAkhOG2Mn6ksX+rxXHZEuaK5H8eFL5RUp5n+XK/
        b7shmZrNp/r9+ovCd8aoFcsq4IU9t30hW3zj
X-Google-Smtp-Source: ABdhPJyE1ioxdPFgy7HQA/5zNIoOkbdFJUpQxmLfCsfNu/BhgF4FiSlNjprfm9nNfhHvbTuvxJvHSg==
X-Received: by 2002:a17:90b:1e46:: with SMTP id pi6mr6810625pjb.212.1621537923337;
        Thu, 20 May 2021 12:12:03 -0700 (PDT)
Received: from [192.168.1.2] ([103.196.78.23])
        by smtp.gmail.com with ESMTPSA id b9sm2488091pfo.107.2021.05.20.12.12.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 May 2021 12:12:02 -0700 (PDT)
Subject: Re: [PATCH] staging: emxx_udc: Fixed coding style in places where
 lines should not end in '('
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alex Dewar <alex.dewar90@gmail.com>,
        Sean Behan <codebam@riseup.net>,
        Colin Ian King <colin.king@canonical.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20210520174701.8370-1-hridayhegde1999@gmail.com>
 <YKajzaK98SvKfbkm@kroah.com>
From:   Hriday Hegde <hridayhegde1999@gmail.com>
Message-ID: <916de40f-f3eb-a9fc-0588-fe8c91430b47@gmail.com>
Date:   Fri, 21 May 2021 00:41:58 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <YKajzaK98SvKfbkm@kroah.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-05-2021 23:30, Greg Kroah-Hartman wrote:
> On Thu, May 20, 2021 at 10:46:57AM -0700, Hriday Hegde wrote:
>> The fixes were for the following checkpatch outputs:
>>
>> CHECK: Lines should not end with a '('
>> 1076: FILE: drivers/staging/emxx_udc/emxx_udc.c:1076:
>> +				_nbu2ss_writel(
>>
>> CHECK: Lines should not end with a '('
>> 1228: FILE: drivers/staging/emxx_udc/emxx_udc.c:1228:
>> +		length = _nbu2ss_readl(
>>
>> CHECK: Lines should not end with a '('
>> 1465: FILE: drivers/staging/emxx_udc/emxx_udc.c:1465:
>> +			regdata = _nbu2ss_readl(
>>
>> Signed-off-by: Hriday Hegde <hridayhegde1999@gmail.com>
>> ---
>>  drivers/staging/emxx_udc/emxx_udc.c | 10 ++++------
>>  1 file changed, 4 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/staging/emxx_udc/emxx_udc.c b/drivers/staging/emxx_udc/emxx_udc.c
>> index 741147a4f0fe..8364316c1d25 100644
>> --- a/drivers/staging/emxx_udc/emxx_udc.c
>> +++ b/drivers/staging/emxx_udc/emxx_udc.c
>> @@ -1073,8 +1073,8 @@ static int _nbu2ss_epn_in_pio(struct nbu2ss_udc *udc, struct nbu2ss_ep *ep,
>>  		i_word_length = length / sizeof(u32);
>>  		if (i_word_length > 0) {
>>  			for (i = 0; i < i_word_length; i++) {
>> -				_nbu2ss_writel(
>> -					&preg->EP_REGS[ep->epnum - 1].EP_WRITE,
>> +				_nbu2ss_writel(&preg->EP_REGS[ep->epnum - 1]
>> +					.EP_WRITE,
> Please don't break the line at ".", that makes this really hard to
> follow.
>
> thanks,
>
> greg k-h
Ok will keep that in mind. I don't yet see a way to make this into the
proper coding style without losing readability.

Thanks
Hriday
