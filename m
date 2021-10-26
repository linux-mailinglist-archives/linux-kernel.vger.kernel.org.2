Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 828AA43AF9B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 11:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234563AbhJZKAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 06:00:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49775 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234197AbhJZKAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 06:00:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635242262;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1zy+x1pDQRw0Wm0gptmGRgNn/axz9jWocmq6wNEwfts=;
        b=Ww8LCd21VZ1qu7KiKPv/2pSSMqL9/fF5wvLScORqVhXVOLITU4hlEw+ZToEAwctHWwWeNu
        TtFKy/4svP1U4VWotHAcewSqBxhX39jwL7frrI/rE60eA5ubhm5o0/pkkJ5zpe01F8gIOe
        OI0tbjm87kXkt1pyzIH3WDRPTrZGYwE=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-445-DJdyNpKONxWtT3NtcLfqgg-1; Tue, 26 Oct 2021 05:57:41 -0400
X-MC-Unique: DJdyNpKONxWtT3NtcLfqgg-1
Received: by mail-ed1-f69.google.com with SMTP id q6-20020a056402518600b003dd81fc405eso1678609edd.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 02:57:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1zy+x1pDQRw0Wm0gptmGRgNn/axz9jWocmq6wNEwfts=;
        b=i5NIYJOOnB2civABHcp91j3ec6XzxDDnL/Q6T4yvF9SQbbSEMZk9zzthgLfOiE0sAp
         OFkSdsU9SpJcX0v99H2ltJOiN91IMVKwVoN7NtUIgVu25OU+aT3i7hOblwCzfl/xBwgB
         JzZTM20w0HAVEzLKmwasnTO1U5wTkp11yfolPL39/AyXH8amlx9osBGgaZ4snDm+s3s/
         9hW5D9DyZd08NKPaZPGxyi5oInltgvuboU+RSg+J2DWOvwSYKjx6mzK/9luY7y0yAJqq
         HcIQVk+1++Op800IvwGRY/s55iYrOrxSGnNOvbY5Rp8Au3F4fAgfhIQINTYngu3iGQvN
         NZRg==
X-Gm-Message-State: AOAM533Aw2rEU6H6PSH2fIdIirjNEWx384Swk9yvL4/mYIlL4nxwKPcD
        F8uNckPb6UI/0BZvKsaFmKNaHCf6AX3TyyQlaYdFe/IEq9ai8t6wLessYrUs6LLy11TUTzQyL0Z
        IVkKfx8r9H9rF23S7Esn5bOC5
X-Received: by 2002:a17:907:7f87:: with SMTP id qk7mr1426858ejc.105.1635242259338;
        Tue, 26 Oct 2021 02:57:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzwS/KH58hNErZtIqzUcxf+jKnF612u7uUMoQ6KEk9+PhgjhDtnZ/bUayIb+ys9E04S1L9wMg==
X-Received: by 2002:a17:907:7f87:: with SMTP id qk7mr1426832ejc.105.1635242259097;
        Tue, 26 Oct 2021 02:57:39 -0700 (PDT)
Received: from steredhat (host-79-30-88-77.retail.telecomitalia.it. [79.30.88.77])
        by smtp.gmail.com with ESMTPSA id hp13sm7133502ejc.66.2021.10.26.02.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 02:57:38 -0700 (PDT)
Date:   Tue, 26 Oct 2021 11:57:36 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Wu Zongyong <wuzongyong@linux.alibaba.com>,
        Arnd Bergmann <arnd@arndb.de>, Eli Cohen <elic@nvidia.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] eni_vdpa: alibaba: fix Kconfig typo
Message-ID: <20211026095736.wwbjat4pzt3kpbm7@steredhat>
References: <20211026083214.3375383-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20211026083214.3375383-1-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2021 at 10:31:59AM +0200, Arnd Bergmann wrote:
>From: Arnd Bergmann <arnd@arndb.de>
>
>The Kconfig symbol was misspelled, which leads to randconfig link
>failures:
>
>ld.lld: error: undefined symbol: vp_legacy_probe
>>>> referenced by eni_vdpa.c
>>>>               vdpa/alibaba/eni_vdpa.o:(eni_vdpa_probe) in archive drivers/built-in.a
>
>Fixes: 52e437b2b222 ("eni_vdpa: add vDPA driver for Alibaba ENI")
>Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>---
> drivers/vdpa/Kconfig | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

