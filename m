Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3527F3AED01
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 18:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbhFUQFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 12:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbhFUQFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 12:05:41 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E55C061756
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 09:03:26 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id k5so2154804ilv.8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 09:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=eVXRLvzbSMXRfDwdm7VIC+cZ6QdFXq4T0AzqI7GGzAs=;
        b=H+oXpGUARAhVSBoZL2MY8geozptZKKKELgGSVRYNYAvANNFsmktyHvvPOJ6CZuroJM
         olIg2/8ItnwTp2yz6p41I5Mt9gepjty8919y2hc7DLc1tk3Pr5vaGgEvPpMlSqIqsL27
         93aOdH+pMQYKyvb25oXwAzHM8ROWwlAxKZXYkM2iUzoLg5TlfuNJ1oKv7hiUjeRKBYEf
         dEBnlm1kfAvcc71YL+gFBKSf0S/QFAOw/U/r1mYJRgthg3c7l5G39/nZvEcRalWw1J3K
         sxeBCfr2P3Q2E9VtUApMXVSdB8LbdkcuAiUQuKiNK2xPdPCgaYgZUy6ko7aTTLkDwpvv
         CjOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eVXRLvzbSMXRfDwdm7VIC+cZ6QdFXq4T0AzqI7GGzAs=;
        b=Ba4oVnN717E1m+1Qgec7gPWavKD5cp5t2CuW6YlydNBOOyPV1skeiMnsMR38hIofeB
         wfnrxcWVbjoqWok1jkK/hldlHvCnlulqkvT3DN5QMrtzCXvsMGggeu6CjmXXjWLPFo8U
         GYLiC7l7hs6zhdQHT7CNv/ZqdVD4M03prKam8ok91KnJjB28TEKyu9/EClj56cCCefxa
         zLMaTh2DYGQeHNz56Wy29MMmTqtihhiRJTEYZOPceuL2B/kuJl4ZttKngS5ARJygNZtU
         eVbLa5f69fk5velrliv7ahqRH7SgTQ6tyVYsX/M82xKfgXyfHHweIyfrDRC2+9wwd8pp
         dxag==
X-Gm-Message-State: AOAM532IH9RB54PESpS6MBQF1+ewj3Dg9Pa6LflWa+lRER4dZmFG7lS2
        thHG0CkZX3M1EPm9LbWroHn+YYVYwjjj/A==
X-Google-Smtp-Source: ABdhPJwkP8nWk8bySuW3V1xOJ9Rw1HPGvtS6zVwX0bYU4AwIlBDFQLHelmARWU7WL3I5cxJKVsRnfQ==
X-Received: by 2002:a92:364f:: with SMTP id d15mr19206928ilf.26.1624291403552;
        Mon, 21 Jun 2021 09:03:23 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id r6sm9796755ioh.27.2021.06.21.09.03.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 09:03:22 -0700 (PDT)
Subject: Re: [PATCH v2] io_uring: reduce latency by reissueing the operation
To:     Olivier Langlois <olivier@trillion01.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Pavel Begunkov <asml.silence@gmail.com>,
        io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
References: <e4614f9442d971016f47d69fbcba226f758377a8.1624215754.git.olivier@trillion01.com>
 <c5394ace-d003-df18-c816-2592fc40bf08@infradead.org>
 <b0c5175177af0bfd216d45da361e114870f07aad.camel@trillion01.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <766a96fa-1c90-ec3d-abab-16cacdedb44e@kernel.dk>
Date:   Mon, 21 Jun 2021 10:03:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <b0c5175177af0bfd216d45da361e114870f07aad.camel@trillion01.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/20/21 1:28 PM, Olivier Langlois wrote:
> On Sun, 2021-06-20 at 12:07 -0700, Randy Dunlap wrote:
>> On 6/20/21 12:05 PM, Olivier Langlois wrote:
>>> -               return false;
>>> +               return ret?IO_ARM_POLL_READY:IO_ARM_POLL_ERR;
>>
>> Hi,
>> Please make that return expression more readable.
>>
>>
> How exactly?
> 
> by adding spaces?
> Changing the define names??

Not super important, but I greatly prefer:

	if (ret)
		return IO_ARM_POLL_READY;
	return IO_ARM_POLL_ERR;

as that's a lot more readable to me. This is orthogonal to the currently
missing spaces, of course.

For the defines, an enum would be preferable too. And place it near where
it's used.

-- 
Jens Axboe

