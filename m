Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25F523FD635
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 11:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243420AbhIAJJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 05:09:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27139 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243389AbhIAJJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 05:09:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630487294;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sb1gUtd0hXcMtoF0AKF7BtNjs4zgBEQQbBwZxit0nlE=;
        b=KdLQSo9D0hjJ6eNw4tN7+hFOy11F84dl5i/2/SwFopCGlWwEROf9cv8imVwGxXG5xpVAZZ
        iMN6DwNervBAHa6vWPKFeaOC4oJnV46NQZRDBr7f/m9B0SU04vedKCbRrtfsI2wtYei1Nx
        PhIX5yFCDLUM/bLH86Ck6ceLPcElspk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-kwPaahEzOWSple_tzvm7vA-1; Wed, 01 Sep 2021 05:08:13 -0400
X-MC-Unique: kwPaahEzOWSple_tzvm7vA-1
Received: by mail-wr1-f69.google.com with SMTP id h6-20020a5d4fc6000000b00157503046afso569169wrw.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 02:08:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sb1gUtd0hXcMtoF0AKF7BtNjs4zgBEQQbBwZxit0nlE=;
        b=MmFtkZCEI6+npRR2qK3CN2NVSRIezpQwbF0q1fnj4SKGYsj+1r/FaVyiy5heDJpLAO
         SrNLh/GhRNyri/ShH7dKKzQLq94VM8ng7/BujihXQlXW0pclTJgoil6aUb8zoAXR9Vvj
         3b/DcmNZ5u0Qm/fklV6/wuVMGCpqR4VuEo2IuWffM7mDExx2A0E/EsV+xgYGHwgTUgjj
         OYkA9iDn3Z4IS1X0MCMef7QdBTjkAQPu/2i+mfD57obt85FDTGqEYM3LSamyQl2VHuDU
         TGEEcf73DefuepRSdxVX6yvnNu9PEIqf7IVAfMaOJQlD4jxgmX7L8Tj6fwJnf1lvHvYK
         Jt1g==
X-Gm-Message-State: AOAM532ynY2Lr1PBtTqNHrzkYdEKMG2xt2aJcGWP/ah8B47QSGIQME2C
        UPAtBDXxnOnQn06GcQ6Zmg0kurBYvXSwGgxlXHKgFMY3fXxx9fOEdQdFVH27E7AAc20msm831oU
        lIY6CN1MHG/kV97Uaqteg6IZr
X-Received: by 2002:a05:6000:23a:: with SMTP id l26mr35782793wrz.369.1630487292143;
        Wed, 01 Sep 2021 02:08:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxJVpF+a4RLY2ojCpEsLP4x9qa6h6EWAkPZshm1oL9/N1tpkEHx6iVx4+dMTAUDoMkqzH46XA==
X-Received: by 2002:a05:6000:23a:: with SMTP id l26mr35782773wrz.369.1630487291925;
        Wed, 01 Sep 2021 02:08:11 -0700 (PDT)
Received: from [192.168.1.101] ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id i68sm21120783wri.26.2021.09.01.02.08.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Sep 2021 02:08:11 -0700 (PDT)
Subject: Re: [RFC PATCH 0/4] Allow to use DRM fbdev emulation layer with
 CONFIG_FB disabled
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        x86@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fbdev@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Maxime Ripard <mripard@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Peter Robinson <pbrobinson@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        dri-devel@lists.freedesktop.org, Ingo Molnar <mingo@redhat.com>,
        David Airlie <airlied@linux.ie>
References: <20210827100027.1577561-1-javierm@redhat.com>
 <bb5d045c-c9de-b6df-cf45-32b1a866264a@suse.de>
 <YSlI+ryYqoRxM7aB@phenom.ffwll.local>
 <a7395626-f022-5c89-07cd-c30d0d52d3dd@redhat.com>
 <YS4iIR689bAZ4QT9@phenom.ffwll.local>
From:   Javier Martinez Canillas <javierm@redhat.com>
Message-ID: <b6ba8f6b-4f0c-53cc-e384-ecea3af78410@redhat.com>
Date:   Wed, 1 Sep 2021 11:08:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YS4iIR689bAZ4QT9@phenom.ffwll.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/31/21 2:35 PM, Daniel Vetter wrote:
> On Sat, Aug 28, 2021 at 12:02:21AM +0200, Javier Martinez Canillas wrote:

[snip]

>>
>> We talked about a drmcon with Peter Robinson as well but then decided that a
>> way to disable CONFIG_FB but still having the DRM fbdev emulation could be a
>> intermediary step, hence these RFC patches.
>>
>> But yes, I agree that a drmcon would be the proper approach for this, to not
>> need any fbdev support at all. We will just keep the explicit disable for the
>> fbdev drivers then in the meantime.
> 
> I think the only intermediate step would be to disable the fbdev uapi
> (char node and anything in sysfs), while still registering against the
> fbcon layer so you have a console.
>

Right, $subject disabled the sysfs interface but left the fbdev chardev. I can
try to do a v2 that also disables that interface but just keep the fbcon part.
 
> But looking at the things syzbot finds the really problematic code is all
> in the fbcon and console layer in general, and /dev/fb0 seems pretty
> solid.
>

Yes, but still would be an improvement in the sense that no legacy fbdev uAPI
will be exposed and so user-space would only depend on the DRM/KMS interface.

> I think for a substantial improvement here in robustness what you really
> want is
> - kmscon in userspace
> - disable FB layer
> - ideally also disable console/vt layer in the kernel

Earlier in the thread it was mentioned that an in-kernel drmcon could be used
instead. My worry with kmscon is that moving something as critical as console
output to user-space might make harder to troubleshoot early booting issues.

And also that will require user-space changes. An in-kernel drmcon could be a
drop-in replacement though.

> - have a minimal emergency/boot-up log thing in drm, patches for that
>   floated around a few times
>

Interesting. Do you have any pointers for this? My search-fu failed me when
trying to find these patches.

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

