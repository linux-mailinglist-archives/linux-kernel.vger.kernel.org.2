Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5763D43C01E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 04:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238184AbhJ0Cob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 22:44:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44014 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232103AbhJ0Coa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 22:44:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635302525;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zG4wOwNju0vbwzgcCbmJ62s9mn3CKYEpgz+8LI3TwWk=;
        b=eGaeZVxkpWWVYgrq2530lM5ATBda5UyBiiuO4wQw+IFu4tBRGt0DxfuEtYq5zn+3ZpwxUj
        lnlhd3ijsaZWPESJ1grCYHUbzXJ4VwqDsoKLWyB6KMYuz9P1r3n0vqWG5bh3mDuO4g711J
        GoFv1eAVZ2KUXJD8rLauX+M5gdZ0Z94=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-xVGXbrmuPbOhdju_sx6wEQ-1; Tue, 26 Oct 2021 22:42:03 -0400
X-MC-Unique: xVGXbrmuPbOhdju_sx6wEQ-1
Received: by mail-pl1-f199.google.com with SMTP id u17-20020a170902e5d100b0014169fd3334so197914plf.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 19:42:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=zG4wOwNju0vbwzgcCbmJ62s9mn3CKYEpgz+8LI3TwWk=;
        b=zhFNa//Q53Bj9hEgajhaN906m+tKvZW/2qzBJycY4PTQHo635OSdu2KvVKiyINE8C7
         DGFEgHSHfKHQz/RUGAQm+LWNCOE7wPPogr6S9HXh7fCQhfd63IFZX+LRKnBHWk+gnljg
         h+XCMhUqCLGb822tOkmtsrR+nFLclF5uxn0auQRRfxTnKhLK0GfLLEFHpmKUClyBClFn
         wQoqiEQzGm3KUEDoinvsl77cUm6Yg0ZStZ1/sjYblNVwVqYKDVbB8ZVw4SyV5YiM4rTB
         PO3hijHad+Sw0B7vM0KIBAmCkz4v+P94g6ahloBfymTtcl34b9X1VHY2G0DFSDvKKtnZ
         6nGw==
X-Gm-Message-State: AOAM530IxS2iatxXdK+zdC8BD/1BtpPMMzhZ/9A0I3afmnaVgjT40BFK
        /WvJzsevi4ssblIr1fIk7s+APrQX4aoWquGQWr8Bej9xa5w7ZQ0OSB1VFXmmZBmZPXsBoJNZGeq
        m157yv+75qANrnC+NvZ782JLw
X-Received: by 2002:a17:90b:3841:: with SMTP id nl1mr2843360pjb.24.1635302522765;
        Tue, 26 Oct 2021 19:42:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz7/5OU3lvyXYztvEXb/ExmtHdCQzdKN/vMBrgbJMaHdW2excTPY8LP3gMdhwF+AdVbp7nbAA==
X-Received: by 2002:a17:90b:3841:: with SMTP id nl1mr2843329pjb.24.1635302522512;
        Tue, 26 Oct 2021 19:42:02 -0700 (PDT)
Received: from [10.72.12.93] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id mi11sm2170281pjb.5.2021.10.26.19.41.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Oct 2021 19:42:01 -0700 (PDT)
Subject: Re: [PATCH v1 0/2] nbd: reset the queue/io_timeout to default on
 disconnect
To:     pkalever@redhat.com, linux-kernel@vger.kernel.org
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        josef@toxicpanda.com, axboe@kernel.dk, idryomov@redhat.com,
        Prasanna Kumar Kalever <prasanna.kalever@redhat.com>
References: <20210806142914.70556-1-pkalever@redhat.com>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <c46ab94d-4e09-f74d-3d05-789cb47c1057@redhat.com>
Date:   Wed, 27 Oct 2021 10:41:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210806142914.70556-1-pkalever@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/6/21 10:29 PM, pkalever@redhat.com wrote:
> From: Prasanna Kumar Kalever <prasanna.kalever@redhat.com>
>
> Hi,
>
> This series has changes to reset the queue/io_timeout for nbd devices and
> a cleanup patch.
>
> Thank you!
>
> Prasanna Kumar Kalever (2):
>    block: cleanup: define default command timeout and use it
>    nbd: reset the queue/io_timeout to default on disconnect
>
>   block/blk-mq.c         | 2 +-
>   drivers/block/nbd.c    | 9 +++++++--
>   include/linux/blkdev.h | 2 ++
>   3 files changed, 10 insertions(+), 3 deletions(-)
>
This series LGTM.

Reviewed-by: Xiubo Li <xiubli@redhat.com>

