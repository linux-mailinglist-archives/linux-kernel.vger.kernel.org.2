Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51411361112
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 19:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233407AbhDORZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 13:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231726AbhDORZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 13:25:52 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEAE3C061574
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 10:25:26 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id b10so24982657iot.4
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 10:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GsOuPPXVW4w5SaKrHkuMOlALa3wJPeUiMP2AEL1u7RQ=;
        b=eR+MqiJAciFex4xEzDJOxPmcm+q5i26BkgezRf1x0fEQl3NHSgBLa5TP9pR1npDIV5
         Yf7CxrFd9udDLyWpBXidSszqjF4yCcJ8OgP2xzlTsWBmBqCdjoKaYCu9QurjwYwXGUbN
         ANMBU5zoI2Uha5/2D9YnRWL4btVeSg+eINYkM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GsOuPPXVW4w5SaKrHkuMOlALa3wJPeUiMP2AEL1u7RQ=;
        b=YkVtlzQRVAkGkSRh6yJdZbOnzEDxn8qqry+TnCM0TSHlKdsKFOla1ZifLQ04z0iWL4
         wG5PPnb2qgEZ0LcAOHc2x4XkWqdHaSmGJ5S5scp+p0K47OIEbZ9JQC7BPMdu/r+hzw+7
         Xo9QNiOp6K7FdZjxlDGUhjMvOa7JRHe4LRoMjSzB4R+u2hYLmmNGJONDhuSx9Qv+EWe1
         UkzbCo+tJELTKSrRGGkJvFb9/5DIwmt7WZ3o/QqEZWXGG31AcGHl1IN4t+JZiTvZv7w2
         j2Qvt5VXcSk9cH+G+LC0JqAuhTnAgEFfWVyfrfZ2NDTP3sywKi3YV2IGK9tgnZfgGOGn
         PY8Q==
X-Gm-Message-State: AOAM5337ZOGOICa5z0pvv9egVAM3cxRdJlcZcsSFg7Ge80R8MBkCgBuR
        6h2kcdfmoMpckfbCrV14rPR0Fw==
X-Google-Smtp-Source: ABdhPJzgOh/139WOD+rz5V+xMN7wmmK6v8ZYRYPnJaypimqhkKwPfTv427lLvsMaBebjSO5kLG45pA==
X-Received: by 2002:a5d:9659:: with SMTP id d25mr280546ios.146.1618507526027;
        Thu, 15 Apr 2021 10:25:26 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id h18sm1346069ioh.42.2021.04.15.10.25.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Apr 2021 10:25:25 -0700 (PDT)
Subject: Re: [PATCH RFC v3] media: em28xx: Fix race condition between open and
 init function
To:     Igor Matheus Andrade Torrente <igormtorrente@gmail.com>,
        mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        kernel test robot <lkp@intel.com>,
        syzbot+b2391895514ed9ef4a8e@syzkaller.appspotmail.com,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210415140724.15398-1-igormtorrente@gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <d254bf85-5185-6b21-afc6-fb00a9278186@linuxfoundation.org>
Date:   Thu, 15 Apr 2021 11:25:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210415140724.15398-1-igormtorrente@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/15/21 8:07 AM, Igor Matheus Andrade Torrente wrote:
> Fixes a race condition - for lack of a more precise term - between
> em28xx_v4l2_open and em28xx_v4l2_init, by detaching the v4l2_dev,
> media_pad and vdev structs from the em28xx_v4l2, and managing the
> lifetime of those objects more dynamicaly.
> 
> The race happens when a thread[1] - containing the em28xx_v4l2_init()
> code - calls the v4l2_mc_create_media_graph(), and it return a error,
> if a thread[2] - running v4l2_open() - pass the verification point
> and reaches the em28xx_v4l2_open() before the thread[1] finishes
> the deregistration of v4l2 subsystem, the thread[1] will free all
> resources before the em28xx_v4l2_open() can process their things,
> because the em28xx_v4l2_init() has the dev->lock. And all this lead
> the thread[2] to cause a user-after-free.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-and-tested-by: syzbot+b2391895514ed9ef4a8e@syzkaller.appspotmail.com
> Signed-off-by: Igor Matheus Andrade Torrente <igormtorrente@gmail.com>
> ---
> 
> V2: Add v4l2_i2c_new_subdev null check
>      Deal with v4l2 subdevs dependencies
> 
> V3: Fix link error when compiled as a module
> 
> ---
>   drivers/media/usb/em28xx/em28xx-camera.c |   4 +-
>   drivers/media/usb/em28xx/em28xx-video.c  | 300 +++++++++++++++--------
>   drivers/media/usb/em28xx/em28xx.h        |   6 +-
>   3 files changed, 209 insertions(+), 101 deletions(-)
> 

The changes looks good to me. Have you tried building as a modules and
running modprobes and rmmods? You can do that without a device.

thanks,
-- Shuah


