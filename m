Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 231B342E253
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 21:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233889AbhJNT7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 15:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbhJNT7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 15:59:52 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03667C061570
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 12:57:47 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id w10so4711232ilc.13
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 12:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CnPd5ffHv7kCOiuCHD8Ddj4C+YG0wHSoqBcGkQff+i0=;
        b=OVP3kK23uzSKl2wGu3zrecb/FRSn4SMhYQpLuCUWlgh9o4iA/3QW7NjG2NWqfQxtsu
         DdsPQd3aOeleKbdfSn2HO4sBq9EDCTj8S6r4wqdJhNniukJjhGj2pOoSKTQvRcMJchEW
         WZfAXWDw7KrWODMbEX8xsZfj2nkSPmce5L1eo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CnPd5ffHv7kCOiuCHD8Ddj4C+YG0wHSoqBcGkQff+i0=;
        b=yuJSusxGWyrFfkLOkKmYLjhcqXFVtcSHhaS0ALJ9tTmD9G3KxH2iQ3ZIvA52+macL7
         d48XtrG0s/BmgLxjg7FjUMmRjHOvexz58uoc9Ppmc7UAtp1/3oTs2gaViX4lPb1N4j80
         jIjlhFSkdfriLPftEamEToQUMl5m8pqSEuxpKXjOaG4rXvOMChtddGNoHF2EyQtuF0OB
         C+a66ZAjJpCR2C2vzZIz58gBGZhiUdy64U6iayYKPL5rCtZBwUWpgsyHvgZJkMGBawJp
         6WRMEbWA+TjtTsBOiVPhAwGVb+g2KE8JdVZdK7D0HBXywGF9jrzsFYEzrIki25oYucO2
         Iu9A==
X-Gm-Message-State: AOAM532qEyBQAylkNIZ0n5EYRSHq7Cr/ezWyBqqeeQgKVCPVU4xDHAqX
        fmytoqd4xzSja5KSp7qiMh0beQ==
X-Google-Smtp-Source: ABdhPJxHLXcmleX+r+neV56x4NirS8tN9LUygSfBTnGzHjhm+qcJs3c28jEMiV+SHfxHb5shlJJVlw==
X-Received: by 2002:a05:6e02:d86:: with SMTP id i6mr744832ilj.272.1634241466333;
        Thu, 14 Oct 2021 12:57:46 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id w8sm1663169ilo.69.2021.10.14.12.57.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Oct 2021 12:57:45 -0700 (PDT)
Subject: Re: [PATCH] module: fix elf_validity_check() warns seen on 32-bit
 platforms
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     jeyu@kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20211014181044.24365-1-skhan@linuxfoundation.org>
 <YWiKPMKh6025c6dW@bombadil.infradead.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <5456bb23-a170-b0fd-d03f-8efcf7e4f02c@linuxfoundation.org>
Date:   Thu, 14 Oct 2021 13:57:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YWiKPMKh6025c6dW@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/14/21 1:51 PM, Luis Chamberlain wrote:
> On Thu, Oct 14, 2021 at 12:10:44PM -0600, Shuah Khan wrote:
>> Fix the following warnings introduced by
>>
>> commit: 8b1185a4427b ("module: change to print useful messages from elf_validity_check()")
>>
>> warning: format '%llu' expects argument of type 'long long unsigned int',
>> but argument 3 has type 'Elf32_Off' {aka 'unsigned int'}
>>
>> Fix it by tweaking messages to not print ELF64* fields.
>>
>> Fixes: 8b1185a4427b ("module: change to print useful messages from elf_validity_check()")
>> Reported-by: kernel test robot <lkp@intel.com>
>> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> 
> Actually can I trouble you just fold this in with your older patch, I can just
> drop your old patch and merge this one. No point in merging two patches
> if we can just have one.
> 

Yes. I can do that.

thanks,
-- Shuah
