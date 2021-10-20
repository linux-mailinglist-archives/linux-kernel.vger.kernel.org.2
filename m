Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD969435065
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 18:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbhJTQmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 12:42:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28878 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229952AbhJTQmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 12:42:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634748020;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=StojfAqyeQHDkij+8rTrbPKJcvcUj0fGJk9VVUumXz4=;
        b=HxnvDwE9nIkxOWfvV1AGAVDT1uo/xod7Tmjm1rpk9obAWImJYmCy6L6/g2h/m7Bx07VBoB
        UDldSNZaabOBf4W/5VU0h4RYI0/FxpIGo80mxgd3oaoJEe54q/tazQVo9v4aetbphQB9X3
        1CxYnuvzHwNgaRSh+Zct8OgQhkGyt4A=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395--zfSL2inMl6CygsyatQPKw-1; Wed, 20 Oct 2021 12:40:19 -0400
X-MC-Unique: -zfSL2inMl6CygsyatQPKw-1
Received: by mail-wm1-f71.google.com with SMTP id n189-20020a1c27c6000000b00322f2e380f2so711269wmn.6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 09:40:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=StojfAqyeQHDkij+8rTrbPKJcvcUj0fGJk9VVUumXz4=;
        b=rctquxdlFpxskL5hxP1sb4r7iwLjjZSLdV5r+C/jjlGNZeqk0BZC2wxJ7CU/0abxsT
         eL/nAHC8Oe2eWPWF2NQ5cp17gZMsf4P28auY5q1im2OhnXhi/PSRBiHmXa3zdV56gOOy
         idHTnPnd7V5vT6a08Ybyr/C06KAKxC6FrMYPaor/bplp/ozM07QFlBK5JnToTRxh8gks
         FhFLfh2wLo+FVl3ilO/CtTOf44QJZRD2grYb2Ws9L6eX8RcBMww8vrK254Xq0djTTtpy
         bUG25Sb77NmL92KrFif0IpLJfH2beferFDU5GuMJDiPhg73YEFM/9Ho9aHorqkwaVAWb
         +irA==
X-Gm-Message-State: AOAM533XuP/NhaL28c6qDMAww4OJTuSZtDYYUl66twnkGYqIJZWDcQlW
        u/g2rGDI6nwKLQTqsdD7vo+xlrWF3vkHqGbC1mcXs5tEf4LUQT7x6Ek6mpH4xMIWrsQg1u5SI/6
        EPkgoidnDPyU1FMOVfObKzE8w
X-Received: by 2002:adf:e382:: with SMTP id e2mr421197wrm.90.1634748018372;
        Wed, 20 Oct 2021 09:40:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw4j+FN8dHBAspNShPIfXEQEdqjV+D4OWwFaz88jZoJj1s/iEEzhN8nZO5xV9XP0HqGJTMqgA==
X-Received: by 2002:adf:e382:: with SMTP id e2mr421162wrm.90.1634748018118;
        Wed, 20 Oct 2021 09:40:18 -0700 (PDT)
Received: from [192.168.1.128] ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id g2sm2413587wrq.62.2021.10.20.09.40.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Oct 2021 09:40:17 -0700 (PDT)
Message-ID: <9989e16f-38a0-c76b-0408-d47f120eec7f@redhat.com>
Date:   Wed, 20 Oct 2021 18:40:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH] Revert "drm/fb-helper: improve DRM fbdev emulation device
 names"
Content-Language: en-US
To:     =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        linux-kernel@vger.kernel.org, Johannes Stezenbach <js@sig21.net>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, Ben Skeggs <bskeggs@redhat.com>,
        nouveau@lists.freedesktop.org
References: <20211008071708.1954041-1-javierm@redhat.com>
 <YWAlUBoMlerOGJEV@intel.com> <YWbQrP9blDndQV2F@phenom.ffwll.local>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <YWbQrP9blDndQV2F@phenom.ffwll.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Daniel,

On 10/13/21 14:27, Daniel Vetter wrote:
>>>  
>>>  	info->par = fb_helper;
>>> -	snprintf(info->fix.id, sizeof(info->fix.id), "%s",
> 
> Please add a comment here that drmfb is uapi because pm-utils matches
> against it ...
> 

Sure, I'll do that and send a v2.

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

