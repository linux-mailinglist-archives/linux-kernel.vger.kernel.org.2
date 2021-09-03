Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CCFB40011C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 16:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238926AbhICOQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 10:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235544AbhICOQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 10:16:31 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2078CC061575
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 07:15:31 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id a1so5352962ilj.6
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 07:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=J0l36O22rtSaNKlEh+9yr2ZLOnpE6/bHZrA7Wk9c5KY=;
        b=AXgHJlhKbGd6PS6EETb9unE/owTREgOtkmB83MG4n86/6XXgKGjuMHCVygrAFy6upF
         uBL5GcwltLLRaxn57DShS1b9+qjvX9UzL7VMmXuzCNppoHhzeSz80aL3bPi+RUoVj1t1
         Tyamb9AWBpn5JRw1/RI3GutR8IqqBXWZTkvNz8a1rzh0GXPp4Xlx5BNc4do3juyYRxhI
         8zRl2kwPY3Bc5K/C+nk/8qxgGuwe2ORwVL2yPwwgWga8QT///iasfzCia3KQEYLo3Kvi
         4FpPqQKSva+ZMRAsPkAl5rcP5Z9Xv0hw9aFWBNbsIZYxtp7jxuxe4rroeNwsMi5Lg/Za
         yTtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=J0l36O22rtSaNKlEh+9yr2ZLOnpE6/bHZrA7Wk9c5KY=;
        b=KoMmOvOknjHHP3KpmaxHvdYrVMgv6pcswG1J3DmfqpEfWAqJKt7afLA7TpTA4SK593
         NVuSZJxWTNApv3vgfpNqM+3uoFR/oCS41b7MSyDb9dJVPdHHAYeQl8kmUB/tDL0rupri
         obRAfwyRBErvWNbpBUekcwHIRjIE2aUOzvcExe2Qj8VJZQktJVYEY2sn2pZChz4strk9
         wlXcWJ5xa1KimfLZ8t36tzfTt3upBkcH6y6c0S1cDLNOHQQjOmLYHUM0f/+vU/Iu12kD
         gFonzZBkwxe/GExx6CerO9hKBIOxdra0SqLCa9bHtyHXJHY2gp8m2abicRsOHr2DooiS
         YJqg==
X-Gm-Message-State: AOAM533LYS+jSIGMLO98cg1CXw/OZ1wXi+ivgeR2ClBOREWzMlca/qDV
        HHY+Q3aLg7yyBgj2lylwl94brw==
X-Google-Smtp-Source: ABdhPJzMDF7QnyHExczYeNG1QRodEtrt10krOLe2b0YUw+9VYMNP9Q8zn+le2Q0tkn6dGv9LAE/oaQ==
X-Received: by 2002:a05:6e02:b48:: with SMTP id f8mr2880199ilu.25.1630678530507;
        Fri, 03 Sep 2021 07:15:30 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id g13sm2715409ile.68.2021.09.03.07.15.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Sep 2021 07:15:30 -0700 (PDT)
Subject: Re: Bug: d0e936adbd22 crashes at boot
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>, inux-pm@vger.kernel.org
References: <942f4041-e4e7-1b08-3301-008ab37ff5b8@kernel.dk>
 <c56cde110210bec6537fe69b495334c6c70c814e.camel@linux.intel.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3ac87893-55ba-f2d4-bb1e-382868f12d4c@kernel.dk>
Date:   Fri, 3 Sep 2021 08:15:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <c56cde110210bec6537fe69b495334c6c70c814e.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/3/21 8:13 AM, Srinivas Pandruvada wrote:
> Hi Axboe,
> 
> Thanks for reporting.
> On Fri, 2021-09-03 at 07:36 -0600, Jens Axboe wrote:
>> Hi,
>>
>> Booting Linus's tree causes a crash on my laptop, an x1 gen9. This was
>> a bit
>> difficult to pin down as it crashes before the display is up, but I
>> managed
>> to narrow it down to:
>>
>> commit d0e936adbd2250cb03f2e840c6651d18edc22ace
>> Author: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
>> Date:   Thu Aug 19 19:40:06 2021 -0700
>>
>>     cpufreq: intel_pstate: Process HWP Guaranteed change notification
>>
>> which crashes with a NULL pointer deref in notify_hwp_interrupt() ->
>> queue_delayed_work_on().
>>
>> Reverting this change makes the laptop boot fine again.
>>
> Does this change fixes your issue?

I would assume so, as it's crashing on cpudata == NULL :-)

But why is it NULL? Happy to test patches, but the below doesn't look like
a real fix and more of a work-around.

-- 
Jens Axboe

