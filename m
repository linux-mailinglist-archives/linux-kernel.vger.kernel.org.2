Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 683253F3DFD
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 07:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbhHVFPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 01:15:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26698 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229910AbhHVFPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 01:15:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629609307;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0Gs2LheMoMequ9GLp5GAAV9HZnyrxuelNpNsZgJmPrA=;
        b=Z2ZAxPMIo0S4ydLMQ8bWDLNPuAFgdvEEAcB83r3pVOOAF0hGb+7YsnRH1UBXDdjxlLioTa
        57gnl0Mual8RghkY5WjGiit/V205XQE4DOAyKUz1aeP0VxgWz2lKtgD2JnOTS8dDK0EOnH
        0zvZcXAPR6xhq7D5gVyADXR7NuBlUbw=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-RC3FxjriNU6GibGeeIZAgw-1; Sun, 22 Aug 2021 01:15:06 -0400
X-MC-Unique: RC3FxjriNU6GibGeeIZAgw-1
Received: by mail-pf1-f198.google.com with SMTP id n27-20020a056a000d5b00b003e147fb595eso6883016pfv.6
        for <linux-kernel@vger.kernel.org>; Sat, 21 Aug 2021 22:15:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=0Gs2LheMoMequ9GLp5GAAV9HZnyrxuelNpNsZgJmPrA=;
        b=N7AL0ESQKvvHMsl+dYP3KVL5ghZtsd9AIJcElmVe0O+cVre6JmcgUAv/RHPURog8CC
         sIYFb66Zkmq3EaTSB2oD0Nb/Pmnt3bIhosJyPRT2aipT+cXMS7Cn6nEOgu2jDMAjGwNt
         IKs41uFc6sHpxLRmrAhMv/+g4qZqQYg3rJsNuzXe0xBdmEwHfyy5GVMSIs+27d8bn5VB
         XJ6eCu807uDJ+za9V0IcQ3APpR38UFAwEEs06AnYKRd0yv91JMTZPj/ZtImdBj5hZO1X
         d4Pu6CuQKT/Bp2HjQVyos6eR6DLtdv0SOUHR4qS3AXtaKhJTWM6gCCELDkbOiVVYQFGl
         zwpQ==
X-Gm-Message-State: AOAM5320OdK6b05MQE1rpv+MyJjSe60r/azkk+8mZuvEySi8lzUP713C
        oVWtYbp1vWbw/40XuyS2iV58Q1sJQEz1oYOdo9VrEAkXxYeXge/PyNemsf5ohHX5f2ryV0zCkmM
        M4Q1eGjENXkzSeARGA05wBA7sDxT4yxScFMVwWSBrb1lKLEeF1loCfDmd5+ouc0tavJrmuWa5
X-Received: by 2002:a17:902:860c:b0:131:771d:b9d9 with SMTP id f12-20020a170902860c00b00131771db9d9mr7809669plo.22.1629609304716;
        Sat, 21 Aug 2021 22:15:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzOz9wDdlGtpcqlesexFUUvipdykWH/lSdqVg7HzUIwlqzBFgdzWv3amRQClAP9AUNLlfTXMg==
X-Received: by 2002:a17:902:860c:b0:131:771d:b9d9 with SMTP id f12-20020a170902860c00b00131771db9d9mr7809642plo.22.1629609304261;
        Sat, 21 Aug 2021 22:15:04 -0700 (PDT)
Received: from llong.remote.csb ([50.238.61.194])
        by smtp.gmail.com with ESMTPSA id u24sm12161647pfm.85.2021.08.21.22.15.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Aug 2021 22:15:03 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH] locking: Remove repeated verbose license text
To:     Cai Huoqing <caihuoqing@baidu.com>, peterz@infradead.org,
        mingo@redhat.com, will@kernel.org, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org
References: <20210822022414.880-1-caihuoqing@baidu.com>
Message-ID: <a08cca69-63f4-8818-f5de-e1fd79ad91e2@redhat.com>
Date:   Sun, 22 Aug 2021 01:15:03 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210822022414.880-1-caihuoqing@baidu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/21/21 10:24 PM, Cai Huoqing wrote:
> remove it because SPDX-License-Identifier is already used
>
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> ---
>   kernel/locking/lock_events.c      | 10 ----------
>   kernel/locking/lock_events.h      | 10 ----------
>   kernel/locking/lock_events_list.h | 10 ----------
>   3 files changed, 30 deletions(-)
>
> diff --git a/kernel/locking/lock_events.c b/kernel/locking/lock_events.c
> index fa2c2f951c6b..8fa68de8e5a0 100644
> --- a/kernel/locking/lock_events.c
> +++ b/kernel/locking/lock_events.c
> @@ -1,15 +1,5 @@
>   /* SPDX-License-Identifier: GPL-2.0 */
>   /*
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
>    * Authors: Waiman Long <waiman.long@hpe.com>
>    */
>   
> diff --git a/kernel/locking/lock_events.h b/kernel/locking/lock_events.h
> index 8c7e7d25f09c..d837a91e53f7 100644
> --- a/kernel/locking/lock_events.h
> +++ b/kernel/locking/lock_events.h
> @@ -1,15 +1,5 @@
>   /* SPDX-License-Identifier: GPL-2.0 */
>   /*
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
>    * Authors: Waiman Long <longman@redhat.com>
>    */
>   
> diff --git a/kernel/locking/lock_events_list.h b/kernel/locking/lock_events_list.h
> index 97fb6f3f840a..2a6ef031093d 100644
> --- a/kernel/locking/lock_events_list.h
> +++ b/kernel/locking/lock_events_list.h
> @@ -1,15 +1,5 @@
>   /* SPDX-License-Identifier: GPL-2.0 */
>   /*
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
>    * Authors: Waiman Long <longman@redhat.com>
>    */
>   

It looks good to me.

Acked-by: Waiman Long <longman@redhat.com>

