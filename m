Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 702D345E9A7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 09:53:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353399AbhKZI42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 03:56:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:23611 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1353737AbhKZIy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 03:54:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637916673;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m0q1FtV/hCmMxBW6bOw7HA8YRfBLsTGYeP2j6B9MS2M=;
        b=PvGi/rzQFxmh164CYooeBN9hznOZfGqdIcbM+lGMZIa1ipCAsoAsKgCIWIm40KaMJpg5Hs
        3bw9S+cETp97ob3TXcMqE7+kaNC/hwKpqp7GwgjHwKE198AH0R9WfRYCfr3nSCU1r5g9XC
        StnewvjxZxc2WpOTIow40TGP8Wu348Q=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-291-Ja9wqEJEM029RlbSu5ynAA-1; Fri, 26 Nov 2021 03:51:12 -0500
X-MC-Unique: Ja9wqEJEM029RlbSu5ynAA-1
Received: by mail-wm1-f71.google.com with SMTP id ay34-20020a05600c1e2200b00337fd217772so4992080wmb.4
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 00:51:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=m0q1FtV/hCmMxBW6bOw7HA8YRfBLsTGYeP2j6B9MS2M=;
        b=tiA+f65E5/zOWejz61egYRqBlm/yH+jZc+QrTPnrkpU552q1XjbGamRMvRpDXZTB79
         s/om5YHCoUxOXLU8C0m58h9H0bG8gYWssA/yWwtHJm07axQW3flKfTfhZOw9gpAchldL
         cr5BU4bm05C1W/sC1fZdr66YRoHqyAYUSj9UjpI/IeuL8+nmBqtPOxGRo97RiTyyXk6S
         Po5ucttBb7P7ol/BZvJFvchOZUGVNRzcXa0/a4fPrJsTg5JtosdLX/JizEae6pwsye+8
         eMiZUJzYTuu/W9Q41bI/yoxY7n9ipXIqv+y6l3x4bz4fkN/UOf5fhaJMGUZd3JzOFyY8
         UnBA==
X-Gm-Message-State: AOAM532A8Lk/e11k6zk/mjk/FPJ4Q/IfAkp9jlYe0Ejm02PlpReq9HeU
        N1WPXDo3g/IgMvKw2aSyzqSyPzezMz1yDIaBe06EByB2Nlgcri9PFbpgiXrvNpDYB03meu/YQbt
        /TSDLMG2USCSOoQvBRhbGPsau
X-Received: by 2002:a5d:5643:: with SMTP id j3mr12864179wrw.138.1637916671003;
        Fri, 26 Nov 2021 00:51:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyJWBwXygeN6NpMAN/QamV/bgObotWaHpViXb90YpSCTC9w/eitvSmw9kmmsoYm62fZ47Za3w==
X-Received: by 2002:a5d:5643:: with SMTP id j3mr12864158wrw.138.1637916670803;
        Fri, 26 Nov 2021 00:51:10 -0800 (PST)
Received: from [192.168.3.132] (p5b0c69e1.dip0.t-ipconnect.de. [91.12.105.225])
        by smtp.gmail.com with ESMTPSA id r62sm5373757wmr.35.2021.11.26.00.51.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Nov 2021 00:51:10 -0800 (PST)
Message-ID: <33f597f0-3237-112e-692f-add18c4ca976@redhat.com>
Date:   Fri, 26 Nov 2021 09:51:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH AUTOSEL 5.10 3/4] virtio-mem: support
 VIRTIO_MEM_F_UNPLUGGED_INACCESSIBLE
Content-Language: en-US
To:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc:     "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Marek Kedzierski <mkedzier@redhat.com>,
        Hui Zhu <teawater@gmail.com>,
        Sebastien Boeuf <sebastien.boeuf@intel.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        virtualization@lists.linux-foundation.org
References: <20211126023034.440961-1-sashal@kernel.org>
 <20211126023034.440961-3-sashal@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20211126023034.440961-3-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.11.21 03:30, Sasha Levin wrote:
> From: David Hildenbrand <david@redhat.com>
> 
> [ Upstream commit 61082ad6a6e1f999eef7e7e90046486c87933b1e ]
> 
> The initial virtio-mem spec states that while unplugged memory should not
> be read, the device still has to allow for reading unplugged memory inside
> the usable region. The primary motivation for this default handling was
> to simplify bringup of virtio-mem, because there were corner cases where
> Linux might have accidentially read unplugged memory inside added Linux
> memory blocks.
> 
> In the meantime, we:
> 1. Removed /dev/kmem in commit bbcd53c96071 ("drivers/char: remove
>    /dev/kmem for good")
> 2. Disallowed access to virtio-mem device memory via /dev/mem in
>    commit 2128f4e21aa2 ("virtio-mem: disallow mapping virtio-mem memory via
>    /dev/mem")
> 3. Sanitized access to virtio-mem device memory via /proc/kcore in
>    commit 0daa322b8ff9 ("fs/proc/kcore: don't read offline sections,
>    logically offline pages and hwpoisoned pages")
> 4. Sanitized access to virtio-mem device memory via /proc/vmcore in
>    commit ce2814622e84 ("virtio-mem: kdump mode to sanitize /proc/vmcore
>    access")

As 2. and 4. are part of v5.16-rc1 but not v5.10-stable

Nacked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

