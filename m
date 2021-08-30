Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5963FBDE0
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 23:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237097AbhH3VGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 17:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236431AbhH3VGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 17:06:50 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE47C061575;
        Mon, 30 Aug 2021 14:05:56 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id s20so21731545oiw.3;
        Mon, 30 Aug 2021 14:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hQMbf1CRju8iVpBFQxPXC0LnaB1HOCwD51tLl7euPGg=;
        b=qNRni3mkoHbKSNIaGvV/2dQggN9ND0Kt+JHpWIMld/Jay0FiCAENHMdpuJR2NMq5EM
         orVk3PwYq3T81iVSVNo3meTZ+YGBBPYIA1x7Epm1nqdZnH7WZQGsy7pD9IVRcZIEQGet
         cQ1LNl8y/v61QZc5cXlWqLFI9CJKfrBwSQFSpF1LA/zginm6QMDWOEjYG5PiUAn48ib2
         avXpNErArz2lSj5XOiYcC+xdvoJy+CxS+c9au+SE8oD2CIdRgtD6iHz4WBPlzZ7Ui66G
         Ob+eeQy27uPuoNeIRPKNdorePjgbeyIPIncn9YsL6IGYC58rgFsXAFsf+sAPbsMfcuaq
         vstg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hQMbf1CRju8iVpBFQxPXC0LnaB1HOCwD51tLl7euPGg=;
        b=POcg8NR75IfNFz/KSdQRU0NKV6S46EfQuvlMMQwHeZFm7ENeJ+933SAHoieWem4o5j
         410+3teAacAA5LD14uOScIL+AbQdYhLfFPara+Tzk7DMVDzaCFR1HgMi11As51NOdKiL
         imv+bY4uq+v5pIy8uJdk8Wl+M16abKzsCyPMS9Kd8k5pJWrylkIVxldMGEDHhK02qiyK
         HlBskTzeqb3dMNoZpIuKqpzzoDJF9XjmJV9aCz0gCD1ukKN60Q+CXk2QL8n7AaBXlx/b
         4/tr2lKbARIuaiNISWHDdVgiPUaK94Oqyb3g1Ri36reUC6rq6u8l9YLtKlLPTkuwNwpv
         5+aw==
X-Gm-Message-State: AOAM533SFlzk3OLqCdJDVhj1Iw0kRqRmljitNrddOYeaxZN4kvXw1vEo
        j10nSB+UcO3bfAOp5/Csnv8xRndRulc=
X-Google-Smtp-Source: ABdhPJxdlMcqsUyXUl6I2ETT9KqFy+FXMxBBJoVGXqDuuDNN7z2v+xJ6Q7gff+etnrk1/eUks+VRwA==
X-Received: by 2002:a54:438a:: with SMTP id u10mr845979oiv.131.1630357555620;
        Mon, 30 Aug 2021 14:05:55 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x4sm1362875ood.2.2021.08.30.14.05.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Aug 2021 14:05:54 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH] hwmon: (pmbus/ibm-cffps) Do not swap max_power_out
To:     Eddie James <eajames@linux.ibm.com>,
        Brandon Wyman <bjwyman@gmail.com>
Cc:     linux-hwmon@vger.kernel.org, openbmc@lists.ozlabs.org,
        Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org
References: <20210827230433.3596370-1-bjwyman@gmail.com>
 <20210828155250.GA820265@roeck-us.net>
 <e9de99d88fb9e2e34552806fa47efa488332325c.camel@linux.ibm.com>
 <e5916b33-8898-a483-bc69-49a08913672c@roeck-us.net>
 <e329beeb2b8efa272d2660fcd253ad5c98a37c50.camel@linux.ibm.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <8433a40f-abbb-a0a9-9227-85363c2a9201@roeck-us.net>
Date:   Mon, 30 Aug 2021 14:05:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <e329beeb2b8efa272d2660fcd253ad5c98a37c50.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/30/21 1:11 PM, Eddie James wrote:
> On Mon, 2021-08-30 at 08:34 -0700, Guenter Roeck wrote:
>> On 8/30/21 6:50 AM, Eddie James wrote:
>>> On Sat, 2021-08-28 at 08:52 -0700, Guenter Roeck wrote:
>>>> On Fri, Aug 27, 2021 at 11:04:33PM +0000, Brandon Wyman wrote:
>>>>> The bytes for max_power_out from the ibm-cffps devices do not
>>>>> need
>>>>> to be
>>>>> swapped.
>>>>>
>>>>> Signed-off-by: Brandon Wyman <bjwyman@gmail.com>
>>>>
>>>> Eddie, can you confirm this ?
>>>
>>> This can't be true for all the power supplies supported by this
>>> driver,
>>> no. I think we need to check the version first. Brandon, I tested
>>> this
>>> on witherspoon (which is psu version 1) and get 3148 watts. If it's
>>> not
>>> swapped, that would be 19468 watts...
>>>
>>
>> Hmm. Eddie, can you also have a look at commit 9fed8fa99334 ("hwmon:
>> (pmbus/ibm-cffps) Fix write bits for LED control") ?
>> We need to make sure that it doesn't mess up some versions of this
>> PS.
> 
> That one looks correct to me. I believe older PSUs didn't enforce this
> so I didn't catch it, but I do see that the older specifications
> mention setting bit 6 to "allow write".
> 

Great, thanks a lot for checking.

Guenter
