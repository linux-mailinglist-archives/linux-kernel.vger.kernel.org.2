Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5AA83A2FE7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 17:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbhFJP5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 11:57:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59902 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230298AbhFJP5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 11:57:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623340523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iZQG49OMdPKGkVDjxzrA9bmQ2IiyK39OfqmeMQ/HNjI=;
        b=CCrksbfaL4+/1wvwbQ/RNMA19QJKIxalUnXr8jl4l+F5CCsH9QdKPuTjRE/ktRTQibg2NU
        e20Vsp6vkGXA2Vl8XycbGrB3fbhBArKq+ugzSFE05N910R+xduRR9wHFW/B65cTDspQV9R
        kdXN3Bz4vM5C0GwNIJyiN6lHEitWWLg=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-f6cVxUn0P4O1UIVpe6ECVQ-1; Thu, 10 Jun 2021 11:55:22 -0400
X-MC-Unique: f6cVxUn0P4O1UIVpe6ECVQ-1
Received: by mail-ej1-f71.google.com with SMTP id w1-20020a1709064a01b02903f1e4e947c9so7720025eju.16
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 08:55:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iZQG49OMdPKGkVDjxzrA9bmQ2IiyK39OfqmeMQ/HNjI=;
        b=OUuYA6D4+kP5Trysz/0z9ZdvpgSx8nZEjZ2AWOqCN1bVSB+dKNvtNepKAovLTH/8US
         Gb5mtVRg90nAZnxY/G+w5VKGSz8BETqbmOKsS/4HBtOuk5PU2CNLZyuNO4tvdj+C5TWC
         UM7dXOXHN5NUEmll9N7/qyd14OLID3xLt6k5SLR6uUJIfLhU/Rflq92m8EgT+vZ+awu/
         i5r9aSxhT+iDdEus6aQ5ys7+5JFy8seKY71ioMn/gIr5Tpln1VNxTRcWpMgRWr4mM15U
         SZwIJ9hqdXLhiLfjxSuSOezE5kfiX7WPs/PSScJfK/hpU4s27NzctlfIJ1zZRDJNZjl2
         3WTg==
X-Gm-Message-State: AOAM532kTQc8ONAR5M7GwV4X0HHFDeopqRq8Av389AhBtm8jgtkEO8W9
        rMoFMFWD3UlUztDOInh3NDSNZ/jlsQKvR2RYYD/ACMpOeIlOyDV4luiSN8VsxLrcKrE7NNvBK0i
        x1ZzeLinTAd+mCH7gnDsYYO3t7kLMiP9wS0XuwVLaJVhEAcLBY7RqpYuh9sNIOHk00XanKDXlbR
        pV
X-Received: by 2002:aa7:c6c2:: with SMTP id b2mr162823eds.8.1623340520930;
        Thu, 10 Jun 2021 08:55:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzegUSmNkouCVxXgL5EpM34N2tl0oLxPr9grZP9q3YInG4mkvVxKvf1gpjZDLfSXaCu5fvtcw==
X-Received: by 2002:aa7:c6c2:: with SMTP id b2mr162805eds.8.1623340520764;
        Thu, 10 Jun 2021 08:55:20 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id jp6sm1224885ejb.85.2021.06.10.08.55.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jun 2021 08:55:20 -0700 (PDT)
Subject: Re: Computation of return value being discarded in get_cpu_power() in
 drivers/platform/x86/intel_ips.c
To:     Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Colin Ian King <colin.king@canonical.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Mark Gross <mgross@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Jesse Barnes <jsbarnes@google.com>
Cc:     platform-driver-x86@vger.kernel.org,
        intel-gfx@lists.freedesktop.org,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <548dd463-3942-00a1-85c3-232897dea1a3@canonical.com>
 <162332615476.15946.17135355064135638083@jlahtine-mobl.ger.corp.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <7e13032d-1472-9c50-1dba-9dcebc76729f@redhat.com>
Date:   Thu, 10 Jun 2021 17:55:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <162332615476.15946.17135355064135638083@jlahtine-mobl.ger.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/10/21 1:55 PM, Joonas Lahtinen wrote:
> (Address for Hans was corrupt in previous message, which confused my mail
> client. Sorry for duplicate message, the other is without From: field).
> 
> + Jesse
> 
> Quoting Colin Ian King (2021-06-09 14:50:07)
>> Hi,
>>
>> I was reviewing some old unassigned variable warnings from static
>> analysis by Coverity and found an issue introduced with the following
>> commit:
>>
>> commit aa7ffc01d254c91a36bf854d57a14049c6134c72
>> Author: Jesse Barnes <jbarnes@virtuousgeek.org>
>> Date:   Fri May 14 15:41:14 2010 -0700
>>
>>     x86 platform driver: intelligent power sharing driver
>>
>> The analysis is as follows:
>>
>> drivers/platform/x86/intel_ips.c
>>
>>  871 static u32 get_cpu_power(struct ips_driver *ips, u32 *last, int period)
>>  872 {
>>  873        u32 val;
>>  874        u32 ret;
>>  875
>>  876        /*
>>  877         * CEC is in joules/65535.  Take difference over time to
>>  878         * get watts.
>>  879         */
>>  880        val = thm_readl(THM_CEC);
>>  881
>>  882        /* period is in ms and we want mW */
>>  883        ret = (((val - *last) * 1000) / period);
>>
>> Unused value (UNUSED_VALUE)
>> assigned_value:  Assigning value from ret * 1000U / 65535U to ret here,
>> but that stored value is not used.
>>
>>  884        ret = (ret * 1000) / 65535;
>>  885        *last = val;
>>  886
>>  887        return 0;
>>  888 }
>>
>> I'm really not sure why ret is being calculated on lines 883,884 and not
>> being used. Should that be *last = ret on line 885? Looks suspect anyhow.

This has already been fixed (yesterday actually) in linux-next:

https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/commit/?h=for-next&id=13c3b4f76073d73dd81e418295902676153f6cb5

Regards,

Hans

