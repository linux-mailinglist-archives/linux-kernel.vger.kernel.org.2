Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DBD834041F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 12:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbhCRLCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 07:02:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50338 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229914AbhCRLCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 07:02:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616065326;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qT8sXvj00qItqzlYyDhKarkrcjScc1QZn8W/3wkQDsY=;
        b=GOKQyi+iKfT1akjt/pdOK+YM/nsVOdaaiLXfViTqsZOHdhGjBYyLhLczfxTArg040uqpHr
        GTifYBhDNzaakv0rLXaJqG3iDJ5u0P2/n7jbrzfonnTZMx1adO2I9snElkG3nbKOA99qUQ
        zmf1H+6hG9WomZZZcvHMTTauiXO7QM8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-KfFpGw9jMKaeyzJ_HyeT1Q-1; Thu, 18 Mar 2021 07:02:03 -0400
X-MC-Unique: KfFpGw9jMKaeyzJ_HyeT1Q-1
Received: by mail-ej1-f71.google.com with SMTP id a22so14725302ejx.10
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 04:02:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qT8sXvj00qItqzlYyDhKarkrcjScc1QZn8W/3wkQDsY=;
        b=ozStTHYNTm7/mtQe/ow0adcprBolE3wttWVnKQ/Fld/3Ey9aZnUHAWMi4OXq9yKhmE
         1vY7dzp4tV3fsLrF2wVxUGb8plGtJxupnKJceG9IftUiWVcNL7UNBttX17GMjPyhAJEH
         Y22wpUj58CxbyNTutJwu3NUiVakZJ6DkgS/sjvJ9YVaSWdEvTuju3bqymVI7MXn2sKaQ
         HEHpwb5FfP/Fd5M/sHBluCS2dvD+HsitKVdJF73Z0dShIToR43ZXHVxIchNd9kCSMQVW
         w+SFD7gsBtuJAGopNtNjWm5TLrnbMZ5PygPurcoxjtJWO65zWP7ilAYcfMXgms9Ag3bW
         p1fg==
X-Gm-Message-State: AOAM531oN0LqfZktc2HX5OrYmjPOdtf65RwEFCoCjt/OyZ0mPBR6ID3O
        1TapOJsC1FDBz39C3Rr5g+HIP5D6w67P85Y5aU5G+YxRpBPBmd3jq63nB0NekxTl4cZlXXnWvIr
        1wOmgnzcvKSfGMdnkJF3D7Cls
X-Received: by 2002:a17:906:bccc:: with SMTP id lw12mr39741378ejb.268.1616065322778;
        Thu, 18 Mar 2021 04:02:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw4YEOii3XmAv1UFRr9lF62Tb1p12XeAreUyUkh32SNdZLwXapAN5f76EMeu27pU0dsEfkCHA==
X-Received: by 2002:a17:906:bccc:: with SMTP id lw12mr39741365ejb.268.1616065322619;
        Thu, 18 Mar 2021 04:02:02 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id b12sm1691963eds.94.2021.03.18.04.02.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Mar 2021 04:02:02 -0700 (PDT)
Subject: Re: [GIT PULL v2] Immutable branch between MFD and Platform/X86 due
 for the v5.13 merge window
To:     Lee Jones <lee.jones@linaro.org>,
        "David E. Box" <david.e.box@linux.intel.com>
Cc:     mgross@linux.intel.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
References: <20210128172846.99352-1-david.e.box@linux.intel.com>
 <20210224201005.1034005-1-david.e.box@linux.intel.com>
 <20210309181206.GT4931@dell> <20210310105711.GJ701493@dell>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <f72cdea8-cd65-84e5-8dcd-1e94c01c90d1@redhat.com>
Date:   Thu, 18 Mar 2021 12:02:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210310105711.GJ701493@dell>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/10/21 11:57 AM, Lee Jones wrote:
> Rebased onto -rc2
> 
> The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:
> 
>   Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-platform-x86-v5.13
> 
> for you to fetch changes up to aa47ad3f853ae72c32b7e46dfc8bc2c8dc2dbad7:
> 
>   mfd: intel_pmt: Add support for DG1 (2021-03-10 10:48:48 +0000)
> 
> ----------------------------------------------------------------
> Immutable branch between MFD and Platform/x86 due for the v5.13 merge window

Thank you, I've merged this into my review-hans branch now, so this will
soon be in pdx86/for-next.

Regards,

Hans

