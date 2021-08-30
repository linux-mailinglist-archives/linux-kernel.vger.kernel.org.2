Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18FCF3FB90C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 17:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237579AbhH3Pfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 11:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237085AbhH3Pfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 11:35:45 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB42C061575;
        Mon, 30 Aug 2021 08:34:51 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id a20-20020a0568300b9400b0051b8ca82dfcso18882646otv.3;
        Mon, 30 Aug 2021 08:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1XlNxUDlSYdSIfCn5vMG2bfoCAnG2qcrn/mF4ovrEYQ=;
        b=SUWFm6ZPc5XlI7RcVOKZlTehfk0U6pG5JhNeR9Pc6VCE5/yuMYtOqEgBCeaJU8VRg9
         4Nb8AmrutoObPOt8y/s6zVKl3VYNFG2dTF8/kKJgSP0iZCoY8YAJ1HegAnfJnxvbb9jp
         DSX5aat2EHE4WbhMDxgMp5d9ySqHzp8DPP33uP+/F16mU/5NLlWnFpYMd3lYdp8wGcFD
         JiYoS029NUT8k7kkjJ/WfDVwl+wQDnuDnywGGKe0qq782FrZWwFmXPT9o4YeWi65HkfA
         tJTVDr3leHoet8wTfOs+1ySrzYHG9vu/bhLaFfMBMa3a7JJxA1J1mh8H9f7oU5ykPvVw
         OC7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1XlNxUDlSYdSIfCn5vMG2bfoCAnG2qcrn/mF4ovrEYQ=;
        b=KBqhmHd0Ywcn4VD0fareaBV9YygC6anrKCgpbhbQD2QsTiv5gy3BAsqXBu1yXig1yf
         UYCTbniXZKEABLmMeYBhoG/JLrm5sxRxTcIXkpudWq7zZ/b9L7pDhTIEF4up4MJagNrs
         s1axEIcfaIza3dayttpTUFxv5khhAQ1JOFKEM/7tROrkvQwT01Vm9FOyCdduYsXupUbm
         SlA6biggkvHE5qB2eSpLVWohlR+M+0M9FChJ0441Lx2G5AR1+KglkNLIQpI54BgmLO/V
         JemjPZU6Z0xYBrsG2E/jc1lysdPR4Locc380hq0kjwN6K1hjnYCdQS2/7faCc+MbiQsR
         LGWQ==
X-Gm-Message-State: AOAM531WUVrZe9IM1SAh7k2DGMH/1hu7heJx9XoW/R3OBdNrflFcbYit
        rUDIwS7LHM8WAzmMVovJJ5ECLUhbLdw=
X-Google-Smtp-Source: ABdhPJx0IwUikcGqVNJ2MaaAq/Qw2INo8sdw/hlIihJVjjdoR6iHCpWFXPbqX1ep8psW5eVEjXAtgA==
X-Received: by 2002:a9d:829:: with SMTP id 38mr19885511oty.342.1630337690526;
        Mon, 30 Aug 2021 08:34:50 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q17sm3283015otc.28.2021.08.30.08.34.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Aug 2021 08:34:49 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     Eddie James <eajames@linux.ibm.com>,
        Brandon Wyman <bjwyman@gmail.com>
Cc:     Joel Stanley <joel@jms.id.au>, openbmc@lists.ozlabs.org,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210827230433.3596370-1-bjwyman@gmail.com>
 <20210828155250.GA820265@roeck-us.net>
 <e9de99d88fb9e2e34552806fa47efa488332325c.camel@linux.ibm.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] hwmon: (pmbus/ibm-cffps) Do not swap max_power_out
Message-ID: <e5916b33-8898-a483-bc69-49a08913672c@roeck-us.net>
Date:   Mon, 30 Aug 2021 08:34:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <e9de99d88fb9e2e34552806fa47efa488332325c.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/30/21 6:50 AM, Eddie James wrote:
> On Sat, 2021-08-28 at 08:52 -0700, Guenter Roeck wrote:
>> On Fri, Aug 27, 2021 at 11:04:33PM +0000, Brandon Wyman wrote:
>>> The bytes for max_power_out from the ibm-cffps devices do not need
>>> to be
>>> swapped.
>>>
>>> Signed-off-by: Brandon Wyman <bjwyman@gmail.com>
>>
>> Eddie, can you confirm this ?
> 
> This can't be true for all the power supplies supported by this driver,
> no. I think we need to check the version first. Brandon, I tested this
> on witherspoon (which is psu version 1) and get 3148 watts. If it's not
> swapped, that would be 19468 watts...
> 

Hmm. Eddie, can you also have a look at commit 9fed8fa99334 ("hwmon:
(pmbus/ibm-cffps) Fix write bits for LED control") ?
We need to make sure that it doesn't mess up some versions of this PS.

Thanks,
Guenter
