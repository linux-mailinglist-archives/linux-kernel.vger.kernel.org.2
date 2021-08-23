Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1B8F3F49FE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 13:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236455AbhHWLqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 07:46:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56088 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235508AbhHWLqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 07:46:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629719153;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=14znBkLtAjiyi6UaHmrKrHuYMVExy7PDUZAMCT69QdI=;
        b=GPjJQRazYQJD5+3FqLO2TKgjLnyKBiYEBCV+8ymdhumxc5L0WJRKi8Cltvv3gBggrEAcaY
        +ahskoeaCf9DbsbTChnahpSDOf69dtoxm7oKOeT6JzK3elAxDUBdbg9LDUjt50lOWf6Q/r
        sIFjGwb+W6BD8nxRBNPmBhtSADXUCDE=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-433-vncnSPC5Pp28Foogz4-EaA-1; Mon, 23 Aug 2021 07:45:51 -0400
X-MC-Unique: vncnSPC5Pp28Foogz4-EaA-1
Received: by mail-ed1-f70.google.com with SMTP id r12-20020aa7d14c000000b003c1aa118ad1so2656094edo.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 04:45:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=14znBkLtAjiyi6UaHmrKrHuYMVExy7PDUZAMCT69QdI=;
        b=ckutWduBCVd4IVYnzd4zDRVWcwatlrQlc1g9fvKYECwAbnVLo7P6EnJOBnOagqzafp
         ep5GK00bXKhGC2SMoT9/Bs/HPXUHvi0hpKRXUsV7wwxZfQPCBLr3dsbxQdb1J/qPsx32
         S6QiasdVPjYhuv+nuwzUy1+9rTCalskYJnZ6ue+cXO+PeCJKx69ovMP0XJGKII/yzjzX
         EC2rUHsA1qJz/kHUvYVd7dYbXoxrS5qf0HjLCYhHtw+4iXSa5n2nePNHcioDHI86Mt48
         EPnfsxaNqBwJ3oQ8C/xsgXlreQTR/bKja9q9aPZCUOwqoalpIaCVIEfKF40u3n5qB7oG
         iaEA==
X-Gm-Message-State: AOAM530QsJ6jT6SqpHcI/ZVG68nTxt1OtbrBG3QL6Z6E/bU8kCyYXthJ
        TgJfna5OT3xLb/6XgzEAyifm7PW0VjHRqjsOkNRikL5IkQhofUjducaymFgfFWl02tiP4Tz6bF9
        spCMZYnn6Sq5w7aJJwLt20AcY
X-Received: by 2002:a50:fc8e:: with SMTP id f14mr37126013edq.349.1629719150773;
        Mon, 23 Aug 2021 04:45:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwhyEZxyMYKl8tc+0N3VjfxSymLLOruRlc0AMYWB54fymq73eFwc5jIvuPYS7NizC/7n4S8Fw==
X-Received: by 2002:a50:fc8e:: with SMTP id f14mr37125998edq.349.1629719150635;
        Mon, 23 Aug 2021 04:45:50 -0700 (PDT)
Received: from x1.localdomain ([81.30.35.201])
        by smtp.gmail.com with ESMTPSA id m15sm9261459eds.92.2021.08.23.04.45.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Aug 2021 04:45:50 -0700 (PDT)
Subject: Re: [PATCH v4 1/1] asus-wmi: Add support for custom fan curves
To:     Luke Jones <luke@ljones.dev>, Bastien Nocera <hadess@hadess.net>
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20210820095726.14131-1-luke@ljones.dev>
 <20210820095726.14131-2-luke@ljones.dev>
 <321afe1a293be3a623a9be53feea3a008e044b31.camel@hadess.net>
 <L0W4YQ.ZVWQDLFJE8NR2@ljones.dev>
 <e7fbcf85f61b5c727a93df07b3bfe1624547067f.camel@hadess.net>
 <c19dfdde11754c234ca8a45c4af2187699498ee8.camel@hadess.net>
 <U8X4YQ.79I8GZJ1LDW02@ljones.dev>
 <b20a879dce98f27dfc68b86aaf486be9e623eacf.camel@hadess.net>
 <1EQ5YQ.6O8MNIPTU6V4@ljones.dev>
 <7a8a8d56c4e6addfc41b5dd5262968bd169f538f.camel@hadess.net>
 <GGIAYQ.PS5EB67PH64N@ljones.dev>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <65260602-a1f4-fc8a-a823-ca5a6e4fca60@redhat.com>
Date:   Mon, 23 Aug 2021 13:45:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <GGIAYQ.PS5EB67PH64N@ljones.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/23/21 1:26 PM, Luke Jones wrote:
> 
> 
> On Mon, Aug 23 2021 at 12:28:21 +0200, Bastien Nocera <hadess@hadess.net> wrote:
>> On Sat, 2021-08-21 at 09:30 +1200, Luke Jones wrote:
>>>
>>>
>>>  On Fri, Aug 20 2021 at 13:39:02 +0200, Bastien Nocera
>>>  <hadess@hadess.net> wrote:
>>>  > On Fri, 2021-08-20 at 23:00 +1200, Luke Jones wrote:
>>>  > >
>>>  > >
>>>  > >  On Fri, Aug 20 2021 at 12:51:08 +0200, Bastien Nocera
>>>  > >  <hadess@hadess.net> wrote:
>>>  > >  > On Fri, 2021-08-20 at 12:43 +0200, Bastien Nocera wrote:
>>>  > >  > >  On Fri, 2021-08-20 at 22:33 +1200, Luke Jones wrote:
>>>  > >  > >  > > Am I going to get bug reports from Asus users that will
>>>  > >  > > complain
>>>  > >  > >  > > that
>>>  > >  > >  > > power-profiles-daemon doesn't work correctly, where I
>>>  > > will
>>>  > >  > > have
>>>  > >  > >  > > to
>>>  > >  > >  > > wearily ask if they're using an Asus Rog laptop?
>>>  > >  > >  >
>>>  > >  > >  > No. Definitely not. The changes to fan curves per-profile
>>>  > > need
>>>  > >  > > to
>>>  > >  > >  > be
>>>  > >  > >  > explicitly enabled and set. So a new user will be unaware
>>>  > > that
>>>  > >  > > this
>>>  > >  > >  > control exists (until they look for it) and their laptop
>>>  > > will
>>>  > >  > >  > behave
>>>  > >  > >  > exactly as default.
>>>  > >  > >
>>>  > >  > >  "The user will need to change the fan curves manually so
>>>  > > will
>>>  > >  > >  definitely remember to mention it in bug reports" is a very
>>>  > >  > > different
>>>  > >  > >  thing to "the user can't change the fan curves to be
>>>  > > nonsensical
>>>  > >  > > and
>>>  > >  > >  mean opposite things".
>>>  > >  > >
>>>  > >  > >  I can assure you that I will eventually get bug reports
>>>  > > from
>>>  > >  > > "power
>>>  > >  > >  users" who break their setup and wonder why things don't
>>>  > > work
>>>  > >  > >  properly,
>>>  > >  > >  without ever mentioning the changes they made changes to
>>>  > > the
>>>  > > fan
>>>  > >  > >  curves, or anything else they might have changed.
>>>  > >  >
>>>  > >  > A way to taint the settings that power-profiles-daemon could
>>>  > > catch
>>>  > >  > would be fine by me. I absolutely don't want to have to
>>>  > > support
>>>  > >  > somebody's tweaks until they undo them.
>>>  > >
>>>  > >  Definitely understood. Do you have something in mind?
>>>  >
>>>  > A sysfs attribute with boolean data that shows whether custom fan
>>>  > curves are used would be enough.
>>>
>>>  The path /sys/devices/platform/asus-nb-wmi/active_fan_curve_profiles
>>>  should be usable like this? I added this as the method for
>>>  controlling
>>>  which fan curves for which profiles are active.
>>>
>>>  If empty, then no custom fan curves are active at all. If it contains
>>>  any combination of strings "quiet, balanced, performance" then those
>>>  associated (named) platform_profiles have an active fan curve and you
>>>  can throw up a general warning, maybe add the contents of that file
>>>  too?
>>
>> That works for me, although I would probably have preferred a way that
>> wasn't specific to the asus-wmi module, I'm sure I can made do with
>> that.
> 
> Oh I see, you were looking to get a more general solution implemented? Maybe something like "/sys/devices/platform/asus-nb-wmi/platform_profile_tainted"? This could be an opportunity to maybe make a standardised naming scheme for it.

That would standardize the name, but not the location (path to the name);
so I'm not sure how helpful that would be. I think that for now
going with /sys/devices/platform/asus-nb-wmi/active_fan_curve_profiles is fine
and if we hit the same situation with a 2nd driver then maybe do
something under the /sys/firmware/acpi/platform_profile* namespace.

Maybe something like:

/sys/firmware/acpi/platform_profile_flags or something which can
communicate a bunch of 0 (keyword not present) / 1 values
by containing a list of space separated keywords like:
"custom-fan-profiles", where "custom-fan-profiles" would only
show up when they are activated ?

Regards,

Hans



