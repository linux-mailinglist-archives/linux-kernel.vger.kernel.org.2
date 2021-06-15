Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E30903A73E2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 04:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231931AbhFOC1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 22:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231922AbhFOC12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 22:27:28 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5FD6C0613A2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 19:25:24 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id c12so12104951pfl.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 19:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bb+UZyvF103OTFB+0oPWDOXa4REu4kZb3WG5Dmt+tLs=;
        b=djhNl/bpEcNYfgOtTfUrpPCUBgvF5eX69I7/ZWGqOVvSpEWM6gcZ0URW4tIVQQnhWC
         6SVFL5enr0JvmIqakrJWdsfNkQFFp9mlZ1pgp2NWAz/R+gIdABlQkbKe9MBtNV6hO7Tz
         tny8vYeBX8DFxcRNA71AlLIKkm8+F3IEAw9JnxyX1pdZcplCm6J3r0/jJjvh/wQXWoQL
         EVQoWohGLrQRT4xc2bv3StU7lOYi71HGdQo3OkAU90H3NnGvrp9hPZv2kuEFubIHOEZL
         gi5FxCspuhjq3QTuLxAbzwQJdI1BO4n4G2OZ9wu4yDzhTcfpQXGtNi4irnwT3r8+sZHm
         qerA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bb+UZyvF103OTFB+0oPWDOXa4REu4kZb3WG5Dmt+tLs=;
        b=UOqww1Ir9moLSRJd38FwBN+TT/KyyC5SlMB/0eLYVpQcd2nGVda37FurUHk7cIqxYS
         XgqlT7z49B0VAUJ5fwzWuYZ7eI465/gDbF3dWFlIYOSMrLNp6Jgb9+DeC0dx+is+Q0pH
         syLn00+BxTX4cNnAYsCDFDYvgjpOPd8JOrjNIPsgHYrZGV7ciNc5Ikjt9FgeOqu8z0HF
         KgSNqCNoWuF/6Za7k67IqVGzN8eyGWzSAKzdVZGAzUsfW7y+9N6UePNIAVtebnRLlLBa
         R71jKUdINkKP5LGnfQzqJP0YtWeJcPLqbISjyBF9Gty0+kQxAARKNBU/8wgwYFybK6nc
         dI+A==
X-Gm-Message-State: AOAM533ERO0+pA5709LU95VU1/0F7bKXP6V/eRxC4Ihy8KWIsMlTL7dR
        oCBmfQDIzVDF4evjtfuCfS6rC3B4H5iIXDcIw4s=
X-Google-Smtp-Source: ABdhPJzbMNp+OJh6qTIIxfA2u8gNSm96l1xJmy6ecfpAeYhxlOm0wk0kQKK7cE5allybroyVbt6jag==
X-Received: by 2002:a63:d511:: with SMTP id c17mr1255540pgg.219.1623723334490;
        Mon, 14 Jun 2021 19:15:34 -0700 (PDT)
Received: from [192.168.1.237] ([118.200.190.93])
        by smtp.gmail.com with ESMTPSA id a9sm628494pjm.51.2021.06.14.19.15.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jun 2021 19:15:33 -0700 (PDT)
Subject: Re: [PATCH 2/2] drm: Protect drm_master pointers in drm_lease.c
To:     Emil Velikov <emil.l.velikov@gmail.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <20210612125426.6451-1-desmondcheongzx@gmail.com>
 <20210612125426.6451-3-desmondcheongzx@gmail.com>
 <CACvgo51r3NK_ddQPPD9vBzkJq7A4CcYS4nawxZqqDB8FXK5gcA@mail.gmail.com>
From:   Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
Message-ID: <7bd0d514-efc6-8118-0b28-dfa0bcf5d842@gmail.com>
Date:   Tue, 15 Jun 2021 10:15:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CACvgo51r3NK_ddQPPD9vBzkJq7A4CcYS4nawxZqqDB8FXK5gcA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/6/21 3:41 am, Emil Velikov wrote:
> On Sat, 12 Jun 2021 at 13:55, Desmond Cheong Zhi Xi
> <desmondcheongzx@gmail.com> wrote:
>>
>> This patch ensures that the device's master mutex is acquired before
>> accessing pointers to struct drm_master that are subsequently
>> dereferenced. Without the mutex, the struct drm_master may be freed
>> concurrently by another process calling drm_setmaster_ioctl(). This
>> could then lead to use-after-free errors.
>>
>> Reported-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>> Signed-off-by: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
>> ---
> 
> <snip>
> 
>> @@ -578,6 +594,7 @@ int drm_mode_create_lease_ioctl(struct drm_device *dev,
>>          /* Hook up the fd */
>>          fd_install(fd, lessee_file);
>>
>> +       mutex_unlock(&dev->master_mutex);
> 
> I was going to suggest pushing the unlock call further up - after the
> drm_lease_create call. Although that would make the error path rather
> messy, so let's keep it as-is.
> 
> <snip>
> 
>> @@ -662,7 +684,7 @@ int drm_mode_get_lease_ioctl(struct drm_device *dev,
>>          struct drm_mode_get_lease *arg = data;
>>          __u32 __user *object_ids = (__u32 __user *) (uintptr_t) (arg->objects_ptr);
>>          __u32 count_objects = arg->count_objects;
>> -       struct drm_master *lessee = lessee_priv->master;
>> +       struct drm_master *lessee;
>>          struct idr *object_idr;
>>          int count;
>>          void *entry;
>> @@ -678,8 +700,10 @@ int drm_mode_get_lease_ioctl(struct drm_device *dev,
>>
>>          DRM_DEBUG_LEASE("get lease for %d\n", lessee->lessee_id);
>>
>> +       mutex_lock(&dev->master_mutex);
> 
> As-is we're dereferencing an uninitialised pointer in DRM_DEBUG_LEASE.
> Move the lock and assignment before the DRM_DEBUG_LEASE, just like
> you've done in the list ioctl.
> 
> With this fix, the patch is;
> Reviewed-by: Emil Velikov <emil.l.velikov@gmail.com>
> 
> -Emil
> 


Good catch, thanks for the feedback Emil. I'll fix this up in a v2 patchset.

Best wishes,
Desmond
