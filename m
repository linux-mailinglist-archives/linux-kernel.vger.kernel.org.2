Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11F3740FAB3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 16:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232100AbhIQOs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 10:48:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32345 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230494AbhIQOsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 10:48:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631890051;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2rkt90TAydOsFexCe7JVTwkkB2M9YRQUiexnhQR/3k8=;
        b=JJiw/MFiKIaKL3+0LPJDdpjL9j8UXXF0rUTo61W652PZPdeqAbKQc0QHLYPPg+66HsGSN/
        ud2Ts3X46Y56XIFGR4QnmwDJd9KFLX3sYVBR+qr8Dk8dF6rdvnvdu6oPYawrFo50kfkUUZ
        CXk4UOQGVPFQxnoCQhfii7RHiYjpeC8=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-576-tLnxSi7FMwmoX5ksD5LK-A-1; Fri, 17 Sep 2021 10:47:30 -0400
X-MC-Unique: tLnxSi7FMwmoX5ksD5LK-A-1
Received: by mail-ed1-f69.google.com with SMTP id b8-20020a056402350800b003c5e3d4e2a7so9273388edd.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 07:47:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2rkt90TAydOsFexCe7JVTwkkB2M9YRQUiexnhQR/3k8=;
        b=2y/4RvodONDxFUR1vps3eiyf4Ialf8QgNVahpSqNT0kC9IwVu4y9/izs/izJYPf9uF
         bLDxdwQPdRXzejht06MzjaNuCfAdUnFGNnlcHZs8PRLIo7pvnmQifuFSVdeXAcHg2Sev
         mAn87zBUftdZKbLHwGnWTVF9DLzNi/xQ8V73hixfLlrFfeFaC3DY5b99TSiqiucCNC3E
         3zs4Vl2jzNFsD9cJ+EaQp82RoyoEx60sXH8xHBkBW4mC/5+8grDv8IBFCjPrlrFRDehw
         ybZ6oIVgoyz9+8v/+Lyge8dVSo13KIDvoGJstTRtd07QzXiXiPcMkFMJtQ2T9w86CzIi
         P6Hg==
X-Gm-Message-State: AOAM532q0uEhrCbQSMtJTwUWs/QPp/ktTmZ68kIVeBUHlT+n854gv5Sn
        uPu1oxQ6DyJ0t6/HXfKx9SrDCiXZXer/AdD92toxpPZi9oqc+eS9XQw8hUZl0gF8UYpfuYd0uF8
        FgACW/8eiqnD01aBDj4NsEcTS2WaYHSgNyrC8gy+hHtGZRF6y2x/+dblxVW4Lqm8R9ePPrRUldp
        Yp
X-Received: by 2002:a17:906:1484:: with SMTP id x4mr12480783ejc.72.1631890049250;
        Fri, 17 Sep 2021 07:47:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw4o8+2RbXPY8KxUEewXmnpdKigR8Ox/d2GQyrWqeXxZqNeTarJKA4tZZWAIj8C+Y+iXHw+sg==
X-Received: by 2002:a17:906:1484:: with SMTP id x4mr12480752ejc.72.1631890049011;
        Fri, 17 Sep 2021 07:47:29 -0700 (PDT)
Received: from x1.localdomain ([2a0e:5700:4:11:334c:7e36:8d57:40cb])
        by smtp.gmail.com with ESMTPSA id lv10sm2362640ejb.66.2021.09.17.07.47.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Sep 2021 07:47:28 -0700 (PDT)
Subject: Re: [PATCH 0/5] lib: devres: Add managed helpers for write-combine
 setup
To:     Thomas Zimmermann <tzimmermann@suse.de>, airlied@redhat.com,
        airlied@linux.ie, daniel@ffwll.ch, marcan@marcan.st,
        maz@kernel.org, akpm@linux-foundation.org, npiggin@gmail.com,
        thunder.leizhen@huawei.com, gregkh@linuxfoundation.org
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20210916181601.9146-1-tzimmermann@suse.de>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <9e5e73d1-bb7b-055f-8c48-a877a2e9c0fd@redhat.com>
Date:   Fri, 17 Sep 2021 16:47:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210916181601.9146-1-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/16/21 8:15 PM, Thomas Zimmermann wrote:
> Add devm_arch_phys_wc_add() and devm_arch_io_reserve_memtype_wc() for
> automatic cleanup of writecombine setup.
> 
> Several DRM drivers use the non-managed functions for setting their
> framebuffer memory to write-combine access. Convert ast, mgag200 and
> vboxvideo. Remove rsp clean-up code form drivers.
> 
> Tested on mgag200 hardware.
> 
> Thomas Zimmermann (5):
>   lib: devres: Add managed arch_phys_wc_add()
>   lib: devres: Add managed arch_io_reserve_memtype_wc()
>   drm/ast: Use managed interfaces for framebuffer write combining
>   drm/mgag200: Use managed interfaces for framebuffer write combining
>   drm/vboxvideo: Use managed interfaces for framebuffer write combining

Thanks, the entire series looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

For the series.

Regards,

Hans

