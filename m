Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 966774441B6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 13:40:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232096AbhKCMn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 08:43:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36707 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230472AbhKCMn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 08:43:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635943249;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=86yCH/OVG3pSr7RmE9wnrNBrQ+Y9LKjBABnyUAkmKCg=;
        b=P94vuO9sHTzJtLK7AjgdI0KfPB9U90DcqXpisa87lJpriQvUJVsAPzWU0FDh63kUlLEFvo
        3YjcmXv7CgssKMfPuQgXoGSEzw1XOnM2pq5FnbDlnW/10LMJvy0CZcJz70AWwHvWwvgYeb
        Df5A8QdcHw67jUDIuus/XiLOf07Ri+s=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-V8S6SQBAMOOUESxNFtMA5w-1; Wed, 03 Nov 2021 08:40:48 -0400
X-MC-Unique: V8S6SQBAMOOUESxNFtMA5w-1
Received: by mail-wm1-f71.google.com with SMTP id j25-20020a05600c1c1900b00332372c252dso1044865wms.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 05:40:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=86yCH/OVG3pSr7RmE9wnrNBrQ+Y9LKjBABnyUAkmKCg=;
        b=Wu5lnfAlttV/iT8oHmnKUzMgV4Ciopf/w7iw9zr2LnDTabfEb2MXF3LVVKTzgUkeAC
         Ei+CKKQfTqMeu3KkH30HG5Aw2hyMKBPzj5rAVBKk/65Hw2dDhJHswnTdG8EG7/BdGf0q
         W3gITFhqC1j0w0zcWk4+cBL/Y6Vv/7t31FvPW9But3gUvA/STTG/Rr9JEtiEefZGXL8U
         5V4p+vuFxM3J851cCqWT0msRagyGbjdcWWYwG/jc2fWLWQOxS3TpmmDqXguxTb6Vttky
         9ZkV6xeZuj9JmmsR3YosLJo4KuZIqR3NhdjrqCdRfiZv3DWqQ9oIFONqr/qzKmo7BE2N
         Jjgw==
X-Gm-Message-State: AOAM533jJt2EWREYK3eIWzAz8uQQmoY+ytHFoNe+KIAs9Q8/ytep5CGU
        BbrBjPeuW4v4w5orvsNnS5J1ZXG1PW/cUCEfk5RK8eSwvixOUruMgbux+W7rQtaUJO8yANvUUdr
        vih2+RzzeKLy2tF0bdZkRBcGV
X-Received: by 2002:adf:ebd0:: with SMTP id v16mr55142919wrn.291.1635943246888;
        Wed, 03 Nov 2021 05:40:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy9p3ajjrmozN/5H1CYzpVtKTEU6Rn2GsDXhViUxdhh7IFRVOX7YWWd1zwGUzzUQtNlh0ZbfA==
X-Received: by 2002:adf:ebd0:: with SMTP id v16mr55142897wrn.291.1635943246729;
        Wed, 03 Nov 2021 05:40:46 -0700 (PDT)
Received: from [192.168.1.128] ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id g18sm1696539wmq.4.2021.11.03.05.40.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Nov 2021 05:40:45 -0700 (PDT)
Message-ID: <3522e2b2-026a-3fbf-7ff3-b5e5faf61074@redhat.com>
Date:   Wed, 3 Nov 2021 13:40:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 0/5] Cleanups for the nomodeset kernel command line
 parameter logic
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Cc:     Pekka Paalanen <pekka.paalanen@collabora.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Neal Gompa <ngompa13@gmail.com>,
        =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
References: <20211103104812.1022936-1-javierm@redhat.com>
 <787cc49f-bcba-e58e-9b20-f16f42b45c73@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <787cc49f-bcba-e58e-9b20-f16f42b45c73@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/3/21 13:37, Thomas Zimmermann wrote:
> Hi,
> 
> dri-devel is missing. Please resubmit with dri-devel in cc.
>

Done, sorry about that.

I had `diff noprefix true` in my git config which seems to confuse
the get_maintainer.pl script. 
 
> Best regards
> Thomas
> 
Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

