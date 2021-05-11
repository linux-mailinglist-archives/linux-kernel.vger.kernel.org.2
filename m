Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78B4937A9BB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 16:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbhEKOnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 10:43:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50414 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231728AbhEKOnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 10:43:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620744123;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k/z7NrUJTKIBdoAINSyBpZ9NunsNsM6n4BDyTwrTstY=;
        b=CEU9bA4oAX1zOyq2nwJM3WWSt4ghcxxhh3LYBcPRXEERkcvnaAoblJQu2dkfPWaHk3Ob/n
        G3P2+txI/yackUUV5tyrQX0Aw72RfoM13RGsKqcitOck+S9zKDEIajAwjoRxYn8HdyKfh9
        jHmXR0BUwLOVIP14lMyAYej3oV9JxXg=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-556-CY8m1caGPR2pz8DScuZglw-1; Tue, 11 May 2021 10:42:01 -0400
X-MC-Unique: CY8m1caGPR2pz8DScuZglw-1
Received: by mail-oo1-f70.google.com with SMTP id i13-20020a4ad68d0000b0290204d5557d50so6702483oot.12
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 07:42:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=k/z7NrUJTKIBdoAINSyBpZ9NunsNsM6n4BDyTwrTstY=;
        b=eKQYRm60blACtJXzQKV1QdbD4MzW6e9bJPVW22QCMDkZn86+Vo+trBsopuaL5Uc5qW
         Qahvzw0xk2esRaHqU6/3C/VXk282CTlr7u6ZRBfLsJo22ixhkHZW/snHyRIAtn0CYaAQ
         fdxTmf5CmjWFnnD2QwcHtEGrOhJ/GqlDHOO2bR8MzUdr0Q6Kl8RPg+Mw6q6m4zdOgtgk
         sxKY0UKjLpg8ScYfkKON3fokQt6NsnlsrWiIDrvqiALK10CRi9QP5bVU0nvjvjxhemsc
         fNWfIj/5KKmzfQfN8SwA5q1Eq+WM250y1ys4uzbq24yRhFuyOuw/FmPbP+UGActRUB8V
         IgMg==
X-Gm-Message-State: AOAM533LPBMuNusQ/cuDDxq8Ek3QLgTpaaE2U+L+gx8dlh1Sa5KIeHDs
        5lIuxbQ4xpeupgTi6IJlaQNAHab1/QSN1mPZuTgE/JAYrU2vwz2IkR9whUMTRONFFcdNaqvYpIA
        EEfrSGugJEOyo0JcLIpLH2Won
X-Received: by 2002:a4a:ab83:: with SMTP id m3mr10122762oon.2.1620744120814;
        Tue, 11 May 2021 07:42:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyiqcX0afnpWZRWy60CV/jDkD2+4bdEWed+5anrz6ezPzlAoWGMEGtTJiX4q+FFlUrQrMxegg==
X-Received: by 2002:a4a:ab83:: with SMTP id m3mr10122743oon.2.1620744120577;
        Tue, 11 May 2021 07:42:00 -0700 (PDT)
Received: from [192.168.0.173] (ip68-103-222-6.ks.ok.cox.net. [68.103.222.6])
        by smtp.gmail.com with ESMTPSA id o6sm3917266ote.14.2021.05.11.07.41.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 May 2021 07:42:00 -0700 (PDT)
Subject: Re: [PATCH] virtiofs: Enable multiple request queues
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     virtio-fs@redhat.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Miklos Szeredi <miklos@szeredi.hu>,
        Vivek Goyal <vgoyal@redhat.com>
References: <20210507221527.699516-1-ckuehl@redhat.com>
 <YJpbEMePhQ88EWWR@stefanha-x1.localdomain>
From:   Connor Kuehl <ckuehl@redhat.com>
Message-ID: <290eaac8-45d9-0bfb-94f5-9fb41e5a3e42@redhat.com>
Date:   Tue, 11 May 2021 09:41:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YJpbEMePhQ88EWWR@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/11/21 5:23 AM, Stefan Hajnoczi wrote:
> On Fri, May 07, 2021 at 05:15:27PM -0500, Connor Kuehl wrote:
>> @@ -1245,7 +1262,8 @@ __releases(fiq->lock)
>>  		 req->in.h.nodeid, req->in.h.len,
>>  		 fuse_len_args(req->args->out_numargs, req->args->out_args));
>>  
>> -	fsvq = &fs->vqs[queue_id];
>> +	fsvq = this_cpu_read(this_cpu_fsvq);
> 
> Please check how CPU hotplug affects this patch. If the current CPU
> doesn't have a vq because it was hotplugged, then it may be necessary to
> pick another vq.

I'll fix this in the next revision.

Thanks,

Connor

