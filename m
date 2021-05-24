Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3972538F3CC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 21:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233593AbhEXTmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 15:42:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59753 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233009AbhEXTmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 15:42:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621885268;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QcfSAHV/HbBYuaNWDdQvTZ83TZMYeFvwpY5VZffsoCQ=;
        b=grIN13C7EQn4IgpAWyeyS7JixRWDGWmvo8n3IaU8LXL8MRb4zIu7RD+8NbK/Jzt5A2vO3R
        GqqaVWOkYYRe5TMO2zVTSgvw+bHHj4oin/am6ysAWCP808gBR/ec7R4wbPAqMHqWQ5I/qB
        Bk0uThhlppaB/aKf4SJvpwd2bnarxgY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-558-FPtmFBYlPR-2Nh72jc6Wpw-1; Mon, 24 May 2021 15:41:06 -0400
X-MC-Unique: FPtmFBYlPR-2Nh72jc6Wpw-1
Received: by mail-ed1-f69.google.com with SMTP id w1-20020aa7da410000b029038d323eeee3so14127287eds.8
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 12:41:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QcfSAHV/HbBYuaNWDdQvTZ83TZMYeFvwpY5VZffsoCQ=;
        b=jDqTfmgNA1UX/FNJ4k9pZwo/Jp5MyofvYtRv9q/+fbahSarOZK6fRXAgdd5BZQH4XO
         ep8Ky/xe3agWwpf7W3izsxjkTXX01/eYqtKUL+D0k6d5w6/hhRnkP2waWOjBhnMHzS4h
         WxNMviTvtulSLEUckJ1P4aUlJW+M5QXpruPWXbZ29ZKvUBRUJ1c+7k+IKVXDCeTtXwHe
         AYVTtF9nqxOnHcwEccZ1siYJHH6n/2gBlESmsdZADa84FgPHkuVl1ZY4uT8Rt21AYzdW
         KdJ9v+wUa1ThInNEeJ743H0EdRN0peOWllRF0TsNW7P3LRNL6zhCEs/pC1Yr4ov6HMT2
         yGuQ==
X-Gm-Message-State: AOAM530ZTU/q2cqif5HzNSrdGusDWBx+JUcm8aaKGhR5koljE03+2vSW
        E8aFLjDFM6rrADlAVB+tMt0Qk1YVI+JVZFYahgu/G7ky2ykdNUJFwBHQhYba4vYJDqTJyrO4Dxq
        QqVkzPEsiyP9DPInd+3GFJUJu
X-Received: by 2002:a17:906:9bd6:: with SMTP id de22mr24479784ejc.382.1621885264646;
        Mon, 24 May 2021 12:41:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxb4isv8pBsruVvEy4nUeVgEq0+hKwTOOLp/Fu8OxjdxDfKOhmSPBcjZq+SxEFJohnfubgZfQ==
X-Received: by 2002:a17:906:9bd6:: with SMTP id de22mr24479772ejc.382.1621885264427;
        Mon, 24 May 2021 12:41:04 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id t9sm10273326edf.70.2021.05.24.12.41.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 May 2021 12:41:03 -0700 (PDT)
Subject: Re: [PATCH 1/1] virtio: disable partitions scanning for no partitions
 block
To:     =?UTF-8?B?0K7RgNC40Lkg0JrQsNC80LXQvdC10LI=?= 
        <damtev@yandex-team.ru>, Stefan Hajnoczi <stefanha@redhat.com>
Cc:     "mst@redhat.com" <mst@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
References: <20210520133908.98891-1-damtev@yandex-team.ru>
 <20210520133908.98891-2-damtev@yandex-team.ru>
 <YKu4Qovv1KMplifY@stefanha-x1.localdomain>
 <90021621883891@mail.yandex-team.ru>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <21b08ea7-71c6-1b4b-3833-1c51d0e1d310@redhat.com>
Date:   Mon, 24 May 2021 21:41:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <90021621883891@mail.yandex-team.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/05/21 21:34, Юрий Каменев wrote:
> Hi
> 
>     Is your goal to avoid accidentally detecting partitions because it's
>     confusing when that happens?
> 
> The main goal is reducing the kernel start time. It might be use useful 
> in tiny systems that use, for example, squashfs images with certainly no 
> partitions. Disabling partitions scanning for these images can save a 
> few tens of milliseconds which can be a significant acceleration for 
> starting such systems.

Perhaps that could be configured in the image, for example in the kernel 
command line?

Paolo

> 24.05.2021, 17:29, "Stefan Hajnoczi" <stefanha@redhat.com>:
> 
>     On Thu, May 20, 2021 at 04:39:08PM +0300, Yury Kamenev wrote:
> 
>     Hi,
>     Is there a VIRTIO spec change for the new VIRTIO_BLK_F_NO_PS feature
>     bit? Please send one:
>     https://www.oasis-open.org/committees/tc_home.php?wg_abbrev=virtio#feedback
>     <https://www.oasis-open.org/committees/tc_home.php?wg_abbrev=virtio#feedback>
> 
>     GENHD_FL_NO_PART_SCAN is not used much in other drivers. This makes me
>     wonder if the same use case is addressed through other means with SCSI,
>     NVMe, etc devices. Maybe Christoph or Jens can weigh in on whether
>     adding a bit to disable partition scanning for a virtio-blk fits into
>     the big picture?
> 
>     Is your goal to avoid accidentally detecting partitions because it's
>     confusing when that happens?
> 
>     VIRTIO is currently undergoing auditing and changes to support untrusted
>     devices. From that perspective adding a device feature bit to disable
>     partition scanning does not help protect the guest from an untrusted
>     disk. The guest cannot trust the device, instead the guest itself would
>     need to be configured to avoid partition scanning of untrusted devices.
> 
>     Stefan
> 
>           Signed-off-by: Yury Kamenev <damtev@yandex-team.ru
>         <mailto:damtev@yandex-team.ru>>
>           ---
>            drivers/block/virtio_blk.c | 6 ++++++
>            include/uapi/linux/virtio_blk.h | 1 +
>            2 files changed, 7 insertions(+)
> 
>           diff --git a/drivers/block/virtio_blk.c
>         b/drivers/block/virtio_blk.c
>           index b9fa3ef5b57c..17edcfee2208 100644
>           --- a/drivers/block/virtio_blk.c
>           +++ b/drivers/block/virtio_blk.c
>           @@ -799,6 +799,10 @@ static int virtblk_probe(struct
>         virtio_device *vdev)
>                    vblk->disk->flags |= GENHD_FL_EXT_DEVT;
>                    vblk->index = index;
> 
>           + /*Disable partitions scanning for no-partitions block*/
> 
> 
>     Formatting cleanup and rephrasing:
> 
>        /* Disable partition scanning for devices with no partitions */
> 
>           + if (virtio_has_feature(vdev, VIRTIO_BLK_F_NO_PS))
> 
> 
>     I suggest user a more obvious name:
> 
>        VIRTIO_BLK_F_NO_PART_SCAN
> 
>           + vblk->disk->flags |= GENHD_FL_NO_PART_SCAN;
>           +
>                    /* configure queue flush support */
>                    virtblk_update_cache_mode(vdev);
> 
>           @@ -977,6 +981,7 @@ static unsigned int features_legacy[] = {
>                    VIRTIO_BLK_F_RO, VIRTIO_BLK_F_BLK_SIZE,
>                    VIRTIO_BLK_F_FLUSH, VIRTIO_BLK_F_TOPOLOGY,
>         VIRTIO_BLK_F_CONFIG_WCE,
>                    VIRTIO_BLK_F_MQ, VIRTIO_BLK_F_DISCARD,
>         VIRTIO_BLK_F_WRITE_ZEROES,
>           + VIRTIO_BLK_F_NO_PS,
>            }
>            ;
>            static unsigned int features[] = {
>           @@ -984,6 +989,7 @@ static unsigned int features[] = {
>                    VIRTIO_BLK_F_RO, VIRTIO_BLK_F_BLK_SIZE,
>                    VIRTIO_BLK_F_FLUSH, VIRTIO_BLK_F_TOPOLOGY,
>         VIRTIO_BLK_F_CONFIG_WCE,
>                    VIRTIO_BLK_F_MQ, VIRTIO_BLK_F_DISCARD,
>         VIRTIO_BLK_F_WRITE_ZEROES,
>           + VIRTIO_BLK_F_NO_PS,
>            };
> 
>            static struct virtio_driver virtio_blk = {
>           diff --git a/include/uapi/linux/virtio_blk.h
>         b/include/uapi/linux/virtio_blk.h
>           index d888f013d9ff..f197d07afb05 100644
>           --- a/include/uapi/linux/virtio_blk.h
>           +++ b/include/uapi/linux/virtio_blk.h
>           @@ -40,6 +40,7 @@
>            #define VIRTIO_BLK_F_MQ 12 /* support more than one vq */
>            #define VIRTIO_BLK_F_DISCARD 13 /* DISCARD is supported */
>            #define VIRTIO_BLK_F_WRITE_ZEROES 14 /* WRITE ZEROES is
>         supported */
>           +#define VIRTIO_BLK_F_NO_PS 16 /* No partitions */
> 
>            /* Legacy feature bits */
>            #ifndef VIRTIO_BLK_NO_LEGACY
>           --
>           2.24.3 (Apple Git-128)
> 

