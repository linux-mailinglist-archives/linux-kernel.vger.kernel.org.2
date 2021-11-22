Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49365459460
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 18:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239672AbhKVR6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 12:58:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbhKVR6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 12:58:39 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF411C061574;
        Mon, 22 Nov 2021 09:55:32 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id t23so39377985oiw.3;
        Mon, 22 Nov 2021 09:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=A3/GZswFZkAIstso6YZ0M3u2bPkXBpTewgmCnfB9rd4=;
        b=AhwjdRjBupoQ1rkrWr0DPJoZkZWqqfwpGfIA+ZzO2LB/8F4QWG4lidalXHwbWVgZWb
         HrqvxVavVxLw6e2nCEnUINMQr1OPBdDjVYrUzJlVKYy3QjeKxxo89G07WufAe9884btr
         S8qdz36OZhoDIXb8Y/izRD72ESqQ7uskDqkhtvZZBtdqnoHmHHyMJBWYAMAlk0/SSfHI
         0V0S1pSi31jc3aJYMhVeJyp+N0nkLKGE7nvMk2RjosXbkjNJIreH/O0OUBiCoHak7AKP
         t7ATKwud9WTqndG+EBTLLyFMu6WqOEwzn81rAXm9i2wAqJ5wOfMYk6LzeqVoZ/Lv6ruv
         c6/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A3/GZswFZkAIstso6YZ0M3u2bPkXBpTewgmCnfB9rd4=;
        b=MfrwWTAWUaKcsee5+xkdJaOkI9QdK0KQ1A/d4pTapsNzCgk3y9QbTtOxyhRLf3mbvE
         J4SwGeUoWsZzhd2fcoHQ9rNMlm0Up4F6aLp7ZgiMVKZ5qbHlu9fzaTMCoqHBNaByF+w7
         PgxLnM3Qv7nuII9TbbgpSoZ7hqnEqsal61EbLf3yd+KLgcKNx15MzNcLtK5QvrG58MP6
         5Pvv95TuQhBq+tXY61EfF9dst4MEtqQAfqpp/sJUzfmuWCnffKbU10pBOvgzB0GZ9xf+
         zhN05Gppddt569ac4nLQJxvEhed80kDtKXaNQKNjwpABf8wG8D1E5GWFBdPst7vNWPCj
         f8pw==
X-Gm-Message-State: AOAM5332HGSiLMCsa6RaTvXFgCld35cnhCjWKYLivQpk6KHvhlJRtSC2
        8xotFHO1A7Ys9eHjgT4KA/HtNMuacNc=
X-Google-Smtp-Source: ABdhPJzsjywB7pHSYU5CCgNdn7Y6FVaSVQH49xrsoIO0XVEOcy2khmcJsAHgs1VWIASzI1BDRn6uiQ==
X-Received: by 2002:a05:6808:4d2:: with SMTP id a18mr23199608oie.99.1637603731857;
        Mon, 22 Nov 2021 09:55:31 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i3sm1500922ooq.39.2021.11.22.09.55.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Nov 2021 09:55:31 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH 2/2] hwmon: (dell-smm) Unify i8k_ioctl() and
 i8k_ioctl_unlocked()
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Armin Wolf <W_Armin@gmx.de>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211120170319.72369-1-W_Armin@gmx.de>
 <20211120170319.72369-3-W_Armin@gmx.de>
 <20211122160122.gf6i3qj6dnwi6wla@pali>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <c23caeab-dd27-4c95-2e25-9eb0ff7b33f6@roeck-us.net>
Date:   Mon, 22 Nov 2021 09:55:29 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211122160122.gf6i3qj6dnwi6wla@pali>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22/21 8:01 AM, Pali Rohár wrote:
> On Saturday 20 November 2021 18:03:19 Armin Wolf wrote:
>> The only purpose of i8k_ioctl() is to call i8k_ioctl_unlocked()
>> with i8k_mutex held. Judging from the hwmon code, this mutex
>> only needs to be held when setting the fan speed/mode.
> 
> Really? I think that there is no difference between setting and getting
> fan speed/mode. At least I do not see why 'set' needs mutex and 'get' do
> not need it. Some more explanation is needed...
> 
I8K_SET_FAN sets the fan speed and returns the current status. Without
locking, the returned status may not match or be associated with the previous
set operation.

Maybe that doesn't matter, and the synchronization is not needed. If so,
you can probably remove the locking entirely.

Guenter
