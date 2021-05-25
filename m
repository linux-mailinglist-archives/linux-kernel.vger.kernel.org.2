Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA677390135
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 14:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232819AbhEYMqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 08:46:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21968 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232785AbhEYMqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 08:46:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621946674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SB3TFcBYe+oh//M+r+JgvvKsJxvRHIyMt9IEethbGxM=;
        b=ccR6HSQ41Z+9UmTOpLmAVeI9h1EGOZtJtB5kZKOX5/Xkc6JJvnTCAR3LzezylmAIw/Ge27
        6iS7tZAFfx6Wss+RYBcMlzBqRbqSgH5c7TBOdRrQsVcboB89zwa+bHiPzSrapCdPznPC60
        XbqDZ5PwbbdWkeRwkD3+dL5PUP6wMJo=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-vLI67VV5MZyPRfSdLessUw-1; Tue, 25 May 2021 08:44:32 -0400
X-MC-Unique: vLI67VV5MZyPRfSdLessUw-1
Received: by mail-ed1-f69.google.com with SMTP id y17-20020a0564023591b02903886c26ada4so17258434edc.5
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 05:44:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SB3TFcBYe+oh//M+r+JgvvKsJxvRHIyMt9IEethbGxM=;
        b=pZNpEFyfPOYGJU3W1ORH1o3fsT310F0PEqJdIDLDp+ryPJcrMfFPDlmqWDDupB6HIA
         CbmZGDzHxMZz0/zOyYRGHicPXHEnzTMHd7VmsS512nBz6gaMQymD4bwxiWaXQtfx+8jC
         ypvURWPwJDEfSu4eMX+t20rywcGsb/LitrXan7pQ6P5Zpifz22pHAsjgtMLwU2C6GE1R
         IJuO2/yFctQwfj2EzbCkVTXuFTV93joyvu3y0Ktx9sE78UL5HNuybZv6VVUm5ok9psDJ
         Z6SH175RT7mOarm6VeBYZ4EuWbYa87h0dVzDGqnZq9dbETWwXhCJuKfz+DIMFgDEk/pQ
         k/hw==
X-Gm-Message-State: AOAM530niMbw96IbRvOOP+Ioug8zsnM1UFTr+ubdFoFN15hn2JyrIXVk
        pb1NdAMav61riyA9YBsaeFSg16XwPYN4SQMHLPZK8gYQ1bWvdhY5jlFHWXcY3RtTM8thHzXHbFh
        K1M2mZ0bHnwFbfA0yl/Cx2WI1CtDFQ5fjwjfD8WQPIyKcJ3zFMELrv3JyvT6qwLHscUfRGgpczY
        Ur
X-Received: by 2002:a05:6402:2788:: with SMTP id b8mr27872714ede.335.1621946671259;
        Tue, 25 May 2021 05:44:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzDroG1SU+C7kU4bJ4egpv1PDlQFVhmcJcYrV2lM7cK6onj4JtCKssQlefxcJjGWDv85TbZZA==
X-Received: by 2002:a05:6402:2788:: with SMTP id b8mr27872699ede.335.1621946671113;
        Tue, 25 May 2021 05:44:31 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id x13sm9165601ejs.93.2021.05.25.05.44.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 May 2021 05:44:30 -0700 (PDT)
Subject: Re: [PATCH 0/3] platform/surface: aggregator_registry: Support for
 Surface Laptop 4 and cleanup
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210523134528.798887-1-luzmaximilian@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <899ed5ac-30bb-000c-cdd4-78a4b9625467@redhat.com>
Date:   Tue, 25 May 2021 14:44:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210523134528.798887-1-luzmaximilian@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/23/21 3:45 PM, Maximilian Luz wrote:
> Hi,
> 
> this series adds support for the 13" Intel and 15" AMD versions of the
> Surface Laptop 4 and does some small cleanup regarding duplicate node
> groups in the registry.
> 
> Unfortunately I haven't heard anything of the 15" Intel version and 13"
> AMD version yet.
> 
> Hans, can you apply patches 1 and 2 as fixes for v5.13? That way we'd
> have decent support for the SL4 (at least the aforementioned versions)
> in v5.13.

Thank you for the patches, I've added these to my review-hans branch
now. I'll also cherry-pick 1 and 2 into the fixes branch as requested,

I plan to send out a second pdx86/fixes pull-req to Linus the week that
5.13-rc5 is released.

Regards,

Hans

