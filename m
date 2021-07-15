Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 975543C9DAC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 13:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241902AbhGOLZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 07:25:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57435 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240366AbhGOLZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 07:25:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626348146;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n3XMjsLqmL6fZAAA+JBtyt58Zb9isCAphRrAoufbmyY=;
        b=gGqXWSAqUdtKoN5RqiXiSDJUUylntgAneUf/dCPJRUcfVFBGKTyeYzC+KF+S5ICn2Uxv71
        wW6MXE/U+n4CJ/OJyy6NLmGm0TtR5TyvIWkBCXTS7j5zbIEj70iSxQQkRFH0pdRTmFgWnb
        HdIjhrOEZoNnoHrcpO8QW9cFSpP4kmM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-g15W2eraOPmTred8Oe4y2w-1; Thu, 15 Jul 2021 07:22:25 -0400
X-MC-Unique: g15W2eraOPmTred8Oe4y2w-1
Received: by mail-wr1-f71.google.com with SMTP id k3-20020a5d52430000b0290138092aea94so3161781wrc.20
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 04:22:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=n3XMjsLqmL6fZAAA+JBtyt58Zb9isCAphRrAoufbmyY=;
        b=XkAKaSedWsapG4N+GKFREfNG4bdvYNNw/CvGanotZWoY/e/Z069qRJkdqcPwGyOWHX
         4THqEs1IiqVhXdcBHezXcsPz1QFlNfL9msIfefewvI1U8QEu0bltLoknKdL6RsKovD3B
         ACGdBwtIZMvdhyGKM0w2CV8/5ITpSBa0RtXfifZwFbVDDTQNikH4YfvOPMSC2frtpc0s
         mMKgwImYzCGrd2IIOtcrvg5GBDeI/SA+k0e5Sea+EWRt+Er0caEx7ybtlVwukjVvmXw7
         Prs0OenjnhilsXppRdjy08yIn3VImaYnzHTx/Rd96vfUE9SYEHnNTKqVp+p5m6iublM+
         3x9Q==
X-Gm-Message-State: AOAM5320weunSwJsNjze0DTqgalTlcV5lMMoM+lPZMW+HvvTZXqyeCL6
        5Po9NWvI1Dlz9yfBbDnwYS7tjsq7v791o/8YiNqjRUof+2GG8Dj2icyxuUXiz3kHSLrQoMbTn2d
        NS4XJ4CtzLA5oraV1ELmH5CqV13OdJeG4fi+TXOK/9onRXP1H1VhLJkZHxrQCf3XE/+hitQLiqI
        0A
X-Received: by 2002:a5d:52d0:: with SMTP id r16mr4822770wrv.323.1626348143956;
        Thu, 15 Jul 2021 04:22:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxxUBHhfe+A3WtzBYo5eZtyU+fS1EBqnOvDIUROVv21BrPU/0Ixxe0AbzLRTePqxWt25P3MgA==
X-Received: by 2002:a5d:52d0:: with SMTP id r16mr4822740wrv.323.1626348143761;
        Thu, 15 Jul 2021 04:22:23 -0700 (PDT)
Received: from ?IPv6:2001:b07:add:ec09:c399:bc87:7b6c:fb2a? ([2001:b07:add:ec09:c399:bc87:7b6c:fb2a])
        by smtp.gmail.com with ESMTPSA id w15sm8708936wmi.3.2021.07.15.04.22.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jul 2021 04:22:22 -0700 (PDT)
Subject: Re: [PATCH 1/1] virtio: disable partitions scanning for no partitions
 block
To:     Yury Kamenev <damtev@yandex-team.ru>, mst@redhat.com,
        jasowang@redhat.com, stefanha@redhat.com, axboe@kernel.dk,
        hch@lst.de, cand@gmx.com,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210715094707.19997-1-damtev@yandex-team.ru>
 <20210715094707.19997-2-damtev@yandex-team.ru>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9bd3c75a-63b3-427c-c54c-cd12587ba58b@redhat.com>
Date:   Thu, 15 Jul 2021 13:22:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210715094707.19997-2-damtev@yandex-team.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/07/21 11:47, Yury Kamenev wrote:
> +#ifdef CONFIG_VIRTIO_BLK_NO_PART_SCAN
> +	if (unlikely(partitions_scanning_disable))
> +		/* disable partitions scanning if it was stated in virtio features*/
> +		if (virtio_has_feature(vdev, VIRTIO_BLK_F_NO_PART_SCAN))
> +			vblk->disk->flags |= GENHD_FL_NO_PART_SCAN;
> +#endif
> +

Has this been added to the spec?  It doesn't seem like a good idea, as 
pointed out by Stefan[1], Christoph[2] and myself[3].

Paolo

[1] 
https://lore.kernel.org/linux-block/20210524145654.GA2632@lst.de/T/#m2697cb41578490aad49ed1d8fa6604bf0924b54d
[2] 
https://lore.kernel.org/linux-block/20210524145654.GA2632@lst.de/T/#mc59329fd824102f94ac2f6b29fe94a652849aca0
[3] 
https://lore.kernel.org/linux-block/20210524145654.GA2632@lst.de/T/#mee6787c4fd87790b64feccc9e77fd5f618c2c336

