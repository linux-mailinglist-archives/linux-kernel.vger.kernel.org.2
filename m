Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7604645FEBB
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 14:11:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351270AbhK0NL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Nov 2021 08:11:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55399 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239018AbhK0NJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Nov 2021 08:09:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638018403;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6VQ4eFuFA88Z/vyM544qWCqrvAwEDFB665w5oCGPY18=;
        b=TvAj1MxpYN0lNmbqoxYG21kkqYMtgXxQDwBVOqtVxltGKZfUXz03C86cjN5tFNkihbbpBt
        VJ5fyQCDOdLAqgEW9FbcLUhI9ha9k9Rdi6a6E8GwP9MiJO9Gshvd+GZxPQXga8IwpCzdjy
        2ZnsTH/oljIUKmW3BXHChjIHl9VG+08=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-408-QfjQNCA3P7WOEeGU3qXzvA-1; Sat, 27 Nov 2021 08:06:41 -0500
X-MC-Unique: QfjQNCA3P7WOEeGU3qXzvA-1
Received: by mail-wm1-f72.google.com with SMTP id p12-20020a05600c1d8c00b0033a22e48203so6996154wms.6
        for <linux-kernel@vger.kernel.org>; Sat, 27 Nov 2021 05:06:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6VQ4eFuFA88Z/vyM544qWCqrvAwEDFB665w5oCGPY18=;
        b=iaKxoUMolk6QyZfCXx0WdTxucUVfzY5DJ3hiAgioTzx0Dq1wVD43dF5A4DvZsMWSi7
         /kHIxDMuH4/zkkKmf5IEOt9I7GgydXTuu76vZ5VpPlW8go+yJtuOUlDFAY2jyfwNmmlX
         4qVoib2i3g5InassJ7rfEg4RV4JJw/+Q9ckHmkiLRlyIBQZFMgpiq3uVFQbF3Hw8PmMY
         /3ODN9MLlaxDQo/lKCj/mEmHXKmsVhV+cr2t7h1Ofkcb0Y5tsEy3a7pYfLw0/ZYwdR3L
         7Busd5wKIJdnW5pJDSKZXtTvlQCVS3Ib9prbAS3wjJ2WHyrZvgi65YhM3hRgm/tZMqsA
         En3Q==
X-Gm-Message-State: AOAM530N7RN5o/GpXD39XSEUeC//Ht4JWEBcshSvnT795gAICkDeG9Dm
        aH3C3aiWb3rzHJ8/EKGsIvzq9tlTnYhZzjCJ4iWooetPn5RgitXO5Aig6u+xWqeX30FB2rOR28e
        m9kAXVnGhVcsedWcOUN0lfBJpR+ErU9A8wUr0zlPLpLYkSM9Qwwnv4oBVXu4mo7XlMeaWW1L98A
        A=
X-Received: by 2002:adf:e286:: with SMTP id v6mr20452427wri.565.1638018400534;
        Sat, 27 Nov 2021 05:06:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw73lHUswf1TQ0qSgyrPkATonCL8J2Id2gCMmnoQOXqgBtWVc7cWocX3/6BaLRJF7ZHFuQ1vA==
X-Received: by 2002:adf:e286:: with SMTP id v6mr20452384wri.565.1638018400256;
        Sat, 27 Nov 2021 05:06:40 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id 138sm14206473wma.17.2021.11.27.05.06.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Nov 2021 05:06:39 -0800 (PST)
Message-ID: <8bc41099-9063-94d0-1a5a-a06c265497e4@redhat.com>
Date:   Sat, 27 Nov 2021 14:06:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v5 0/6] Cleanups for the nomodeset kernel command line
 parameter logic
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
Cc:     Jani Nikula <jani.nikula@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Peter Robinson <pbrobinson@gmail.com>,
        =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>,
        dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Pekka Paalanen <pekka.paalanen@collabora.com>
References: <20211112133230.1595307-1-javierm@redhat.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20211112133230.1595307-1-javierm@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/21 14:32, Javier Martinez Canillas wrote:
> There is a lot of historical baggage on this parameter. It is defined in
> the vgacon driver as nomodeset, but its set function is called text_mode()
> and the value queried with a function named vgacon_text_force().
> 
> All this implies that it's about forcing text mode for VGA, yet it is not
> used in neither vgacon nor other console driver. The only users for these
> are DRM drivers, that check for the vgacon_text_force() return value to
> determine whether the driver should be loaded or not.
> 
> That makes it quite confusing to read the code, because the variables and
> function names don't reflect what they actually do and also are not in the
> same subsystem as the drivers that make use of them.
> 
> This patch-set attempts to cleanup the code by moving the nomodseset param
> to the DRM subsystem and do some renaming to make their intention clearer.
> 

I have pushed these patches to the drm-misc-next branch.

Thanks a lot everyone for the help with this series!

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

