Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3783B3CB3AF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 09:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236847AbhGPICZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 04:02:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38445 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231454AbhGPICP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 04:02:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626422360;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wCE1R54px7pHO31Ms6CYqYxxvSqJ9OGRkqgRs5U4lAw=;
        b=Y/W56AUtv/HobZ/oOCvuy5vCKWRkMvhTvc/dfq1CR6FzGcr+OKTYGZMbd7vn11/YjTk1Lo
        HU+hmwJFIy1J9jKdN2UtpjFXH0adPY/bGMsXoJ+0Xj2+BlhRq+yHXH8wRS87cKr3MSTjWd
        YBMFA9wQDG4hCdcNu5Y80K5tkko1RoA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-301-xKUr3TRSOQWozbLiW0tatA-1; Fri, 16 Jul 2021 03:59:18 -0400
X-MC-Unique: xKUr3TRSOQWozbLiW0tatA-1
Received: by mail-wm1-f72.google.com with SMTP id v25-20020a1cf7190000b0290197a4be97b7so2847622wmh.9
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 00:59:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wCE1R54px7pHO31Ms6CYqYxxvSqJ9OGRkqgRs5U4lAw=;
        b=fUO8AXv1ZJsJ5zQ1YnCxYWxcVSkVadqFezGRkqkn078imiZeZZgSua4vGg2ajlBgwK
         ONKTYyyDJ9LHhyhp1WlrBsJn8QMIIP/3XlEpASpfkfRvEiCY6qgMbRqcPyEpz34HNBxd
         sbvbC50dK+TQsyRQMfaHWqpnzPJbD+gUa8T4yIRzcwLHQr2/JkhbJzf6JYie+sWk/S2K
         M5BJkZbxgTWGGLri++A501en8nSdLQzaCRJA8kEA3kq8Id/GNtbWos/+ysIL3n+plVmY
         EZ4yUEQUxki2lzQLxv1bE11+BIJ1QGso889TNxRoRxK6nJ+m4K5blyYsoSD8wMVEYCRH
         7aiQ==
X-Gm-Message-State: AOAM532KNBsXKZOVbLNaSmDOTw1cyLZbXqfRD/FM98p0mhOFYSjLdoWR
        sGXs4yKqS71d+VHonNuZL8DRS8/iET9ygpRYqxQ0wD2xzPxvkjvi24gr+0OGxSFWKjoOu2TWAQz
        ixQauSXf41JAN1ajS+A9hQW+v
X-Received: by 2002:adf:db85:: with SMTP id u5mr7309335wri.167.1626422357612;
        Fri, 16 Jul 2021 00:59:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw+RSign22VHGZ9AxdA/IXsttb6RUFVCR5OCRio31NpfiHCPu9//zmQKLt69ZGL0luxr5/GKA==
X-Received: by 2002:adf:db85:: with SMTP id u5mr7309303wri.167.1626422357339;
        Fri, 16 Jul 2021 00:59:17 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.gmail.com with ESMTPSA id r67sm10558378wma.6.2021.07.16.00.59.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jul 2021 00:59:16 -0700 (PDT)
Subject: Re: 5.13-rt1 + KVM = WARNING: at fs/eventfd.c:74 eventfd_signal()
To:     Hillf Danton <hdanton@sina.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Juri Lelli <jlelli@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        He Zhe <zhe.he@windriver.com>
References: <df278db6-1fc0-3d42-9c0e-f5a085c6351e@redhat.com>
 <8dfc0ee9-b97a-8ca8-d057-31c8cad3f5b6@redhat.com>
 <f0254740-944d-201b-9a66-9db1fe480ca6@redhat.com>
 <475f84e2-78ee-1a24-ef57-b16c1f2651ed@redhat.com>
 <20210715102249.2205-1-hdanton@sina.com>
 <20210716020611.2288-1-hdanton@sina.com>
 <20210716075539.2376-1-hdanton@sina.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8759e324-418b-493a-adee-236738cc3a4f@redhat.com>
Date:   Fri, 16 Jul 2021 09:59:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210716075539.2376-1-hdanton@sina.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/07/21 09:55, Hillf Danton wrote:
> On Fri, 16 Jul 2021 08:54:58 +0200 Paolo Bonzini wrote:
>> On 16/07/21 04:06, Hillf Danton wrote:
>>>> With the patch:
>>>> 	- no warn
>>>> 	- continue using the VM normally...
>>> Well with the patch applied, the VM works fine without the stuff protected
>>> by the spin_lock_irqsave(), then without the patch why simply printing a
>>> warning makes the VM dumb, given the warning is there actually also
>>> preventing you from touching the lock.
>>
>> If the warning is triggered, eventfd_signal will not do the wakeup.
> 
> [I am assuming we are not talking about the deadlock in the comment.]
> 
> No preemption occured without the warning printed.
> Why will the wakeup behavior change without peemption?

Sorry, I don't follow.  What I'm saying is that without the patch:

* the warning only occurs if preemption occurs during the 
spin_lock_irqsave critical section (and therefore it can only occur in 
PREEMPT_RT kernels)

* the warning causes an early return 0 that messes up the VM's networking

Paolo

