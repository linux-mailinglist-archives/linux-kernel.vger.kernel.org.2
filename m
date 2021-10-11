Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DFDF4284CA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 03:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232813AbhJKBiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 21:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbhJKBiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 21:38:11 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61CF0C061570
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 18:36:12 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id 5so17857167iov.9
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 18:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0bn13mcQUloSRmo2eFgDJ5AKWLlTB4WVGCyGBhdHi1I=;
        b=PUNzBLN0rAwEjaoY5DFZoIT6PAnDeq2HrcyPBsBdjDMJ+5ssrFHD6zCyoJc4z/zmj4
         pabBnmBUNZyRRmlPNPgboZ3JjUe66pkK44amXWcghmcZEHu97HCVtC56OR1j2eU1VSB+
         lVO3514+6RCocUyjvUJz3NtmM4cIiPWa2HbvR2JGDBzJ8UTCa+MrbQTVDTQPYK/ZRtKc
         TYfAQOWYsH2BAkU8T5d3Y3ezrTgTjLbZ2rmOaa2lCmNQHH3hjztRWyjnWX27Q7pv6Bx7
         NMalo4tJCCq0xjfYEowhJwjcd66AxppFPmZenfdHINg887eJ32+RYxIEHlglSWOHiBD/
         oR6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0bn13mcQUloSRmo2eFgDJ5AKWLlTB4WVGCyGBhdHi1I=;
        b=ZXVkS4ov0ni3KUZcBcBPYYibl0BoVWu+PYHJB7S35IfNmhKHevL/dQCvuzLXSo7T6y
         BfGba2TmsCuD8N7VXtqDl/j0p+Vv1E0unM00ly/bZsdHABygXUdozv+WFEmX0ifffh8b
         lPcdOaSWnlw+jENTifuIMQM2XQGNmVsVlI+s+oJN2z53Yu3xpTQR/FvJe5gHYfi/L2dM
         mMtUwVCjyKGNbAptsltbq/S+FiNrVKmcaVcF6xwiWj/nUOy3zvgFJg+eBtLliUEqE/uU
         KVnPLx6660K6uQqmH3O4o9knirRdTTCK0BjDSv7f8ro7lNJqrEFJRpnWfDRSkMzFsPgP
         Bqxw==
X-Gm-Message-State: AOAM533gtOsqghjtSF/B+W/Tw6VqUkOmrYO71OICRDByF5roXQ2M6jTj
        xVDplK5yZGwVCV9nMmmEZ8XYPNHlRQN/9Q==
X-Google-Smtp-Source: ABdhPJxeONXJBLUs5vdfEPp0jHJoYSLvOIByQwSY9dL/Y1x8XfIolodZeK4pX3H1ag+3tXak4KjDeA==
X-Received: by 2002:a6b:7107:: with SMTP id q7mr8454iog.63.1633916171678;
        Sun, 10 Oct 2021 18:36:11 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id w23sm3121563iot.30.2021.10.10.18.36.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Oct 2021 18:36:11 -0700 (PDT)
Subject: Re: [PATCH] cdrom: docs: reformat table in
 Documentation/userspace-api/ioctl/cdrom.rst
To:     Phillip Potter <phil@philpotter.co.uk>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     hch@infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, lumip@lumip.de
References: <20211007231720.31997-1-phil@philpotter.co.uk>
 <464a0b2f-c556-ccda-aa3c-26733fba4617@infradead.org>
 <YWOC2Iyszh7WAgzf@equinox>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d9a0177b-f6aa-c03b-0925-9858703d6607@kernel.dk>
Date:   Sun, 10 Oct 2021 19:36:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YWOC2Iyszh7WAgzf@equinox>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/21 6:18 PM, Phillip Potter wrote:
> On Thu, Oct 07, 2021 at 04:34:13PM -0700, Randy Dunlap wrote:
>> On 10/7/21 4:17 PM, Phillip Potter wrote:
>>> Add extra space to the first column of ioctl values table, and also realign
>>> the text in the second column, to fix a documentation build warning
>>> introduced by: commit 67f1e027c270 ("drivers/cdrom: improved ioctl for
>>> media change detection")
>>>
>>> Suggested-by: Randy Dunlap <rdunlap@infradead.org>
>>> Fixes: 67f1e027c270 ("drivers/cdrom: improved ioctl for media change detection")
>>> Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
>>
>> Looks good. Thanks.
>>
>> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
>>
>>
>>> ---
>>>   Documentation/userspace-api/ioctl/cdrom.rst | 116 ++++++++++----------
>>>   1 file changed, 58 insertions(+), 58 deletions(-)
>>>
>>> diff --git a/Documentation/userspace-api/ioctl/cdrom.rst b/Documentation/userspace-api/ioctl/cdrom.rst
>>> index bac5bbf93ca0..682948fc88a3 100644
>>> --- a/Documentation/userspace-api/ioctl/cdrom.rst
>>> +++ b/Documentation/userspace-api/ioctl/cdrom.rst
>>
>>
>>
>> -- 
>> ~Randy
> 
> Thank you for the review Randy.

Applied.

-- 
Jens Axboe

