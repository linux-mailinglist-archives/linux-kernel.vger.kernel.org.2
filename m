Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B70B38CBEA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 19:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbhEURUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 13:20:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50613 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230446AbhEURUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 13:20:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621617517;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CZxY6gPOjujl6azNJ5rnxxGSboX/vJcO0KuSjkOnGMY=;
        b=RjrCWXW62aHlalPMPifiLimmQWbPp96tF+oqQNG6vsqWBR64QrGRt0sKOm7ToCHXPNePst
        i6NPIETx8ngrONm91DDnS2iSC72rITUb2xZ0vRn8fYPKIhFH0qGkUB3+yh5EpK3E7iPD+c
        z/K9sIx9f8qqQBAFnWN97Vj/oNv+hNA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-VPt83UMEORaZUVw9cSddtA-1; Fri, 21 May 2021 13:18:35 -0400
X-MC-Unique: VPt83UMEORaZUVw9cSddtA-1
Received: by mail-wm1-f71.google.com with SMTP id 129-20020a1c02870000b0290176ef5297e3so4312893wmc.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 10:18:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CZxY6gPOjujl6azNJ5rnxxGSboX/vJcO0KuSjkOnGMY=;
        b=DeK3pKXwdWA39WU0J4sjky8h0KvKyHRGG3kRLkpmnD1IPDYJcyAYKyfiHxbDMcFaTU
         SPt9T4lMWbuBz1BpVbetFCu+cCMlmF0aTFAKJxOa+DptcFsg4wnvaNpVgLMlg5jP41r2
         9+RATG1QPD2ZJVRsf0HdRgJH6oV8qKhrZMD9xb8791qohSkf28QmfZEzAfccBwRNwlM5
         Ht+fFg47uXOo6d5KFKClo7CaIYWy/uhI0tXTjhiMIYKsn0luNbkTMfPp6tk+hgvmrFti
         Dn8HbvrLWdJ/bbq4vqUsD08nRFJ8HuzY0sq8tn6Jz32suUIyuN4CdHmx4XyLGN9UmyhI
         Yh/g==
X-Gm-Message-State: AOAM530u1dZWgnoNmYDbyn6HyVfdntN5gRO2QqT33N3UicDOJLFRNtKA
        2mCoEwguWuVxzeOIHSmBqF5nipugGMIRIzMN1Vwcyv+803sIxTgVyYCbqeMXPrz2V2HyyOgLZ3r
        8wfMmiL8NGxa2RM8Jfq2fwVbm
X-Received: by 2002:a1c:7313:: with SMTP id d19mr9774060wmb.14.1621617514752;
        Fri, 21 May 2021 10:18:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzZyQtu9iEGMpJ0S3a0JWqqR0byevLKia/IKV/16dxFDBFhV9cKNPQxR/LHh0d9mGj4x1h9Pg==
X-Received: by 2002:a1c:7313:: with SMTP id d19mr9774041wmb.14.1621617514584;
        Fri, 21 May 2021 10:18:34 -0700 (PDT)
Received: from [192.168.1.101] ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id o11sm2821711wrq.93.2021.05.21.10.18.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 May 2021 10:18:34 -0700 (PDT)
Subject: Re: [PATCH] drm/fb-helper: improve DRM fbdev emulation device names
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org,
        Peter Robinson <pbrobinson@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        dri-devel@lists.freedesktop.org
References: <20210521131910.3000689-1-javierm@redhat.com>
 <YKfS2GDCXPJ/q8gT@phenom.ffwll.local>
 <3a6f9235-5375-b2cb-2d63-a47c5f9752bb@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
Message-ID: <bfd6fa47-497a-64bc-c2fc-a081bd41d5ec@redhat.com>
Date:   Fri, 21 May 2021 19:18:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <3a6f9235-5375-b2cb-2d63-a47c5f9752bb@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/21/21 6:53 PM, Thomas Zimmermann wrote:

[snip]

>>
>> So what with all the drivers which do _not_ have drm in their name? Also
>> I'm never sure how much these are uapi or not ...
>

That someone could threat as an uapi is a fair point indeed.
 
> Why do we need a suffix anyway?
> 

Yes, I thought the same and was torn about posting a patch to just remove
the suffix. I don't think users care that much if is a fb device from a
fbdev driver or a DRM driver using the fbdev emulation.

>> -Daniel
>>

Best regards,
-- 
Javier Martinez Canillas
Software Engineer
New Platform Technologies Enablement team
RHEL Engineering

