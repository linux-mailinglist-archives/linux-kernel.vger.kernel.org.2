Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28B263A9B55
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 14:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232942AbhFPNBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 09:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232223AbhFPNBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 09:01:42 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA43C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 05:59:36 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id w23-20020a9d5a970000b02903d0ef989477so2340645oth.9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 05:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2jLSVmuLw4Nb055fI6F5c4n6Y22HkMR7OQfqkvuCNLI=;
        b=fUjGVI1wI44GueP/8qBEGqyVV7NLUmOaIAeyp6CWQXjf7vZ7tnDvIJgVm6qIzUZk3t
         8JWqWR2V4MG5tM4WpAU1MejqCWif82xUXXy/0FMAcKRMCHYnTZNLbIaLrqv5kOQIOkjp
         sApMoUC+CA2QoEQfSDKsfQF1oai8iMC663Uo9AYqcUx5pGrRG3YsfWa+ERQrJLvTG1tq
         xLV2Lohb2GjBvNa5VIzi2beGU3UuVLkRnSSTN5wdWeWTkgS7dmp0z+DuKbDoTX7UGksI
         aW7tvP8LiEZIgEwq7PEGyHJRy82VqVLeQL2h/X4HrhjIha4cZxaMLq+NOfIJFaqey22V
         SwqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2jLSVmuLw4Nb055fI6F5c4n6Y22HkMR7OQfqkvuCNLI=;
        b=kM65YMRorif1381onttxVyizRYywGI5XlGznZQ6JSyKlsGGntxYGq8dh8pHm2hvjRw
         DZxGWelebnpXxzr4DSg98NzgBUzWc3NIVFHk2t9NfSAEsQ6KyxIZyC0zpfMQTLCsLBxG
         I9LLk7DYssqObqyhlHKxiKBbJyoE11bcRY6FLtcLYiE4MIbJU2pPfIuGl4IOqr6VKaQA
         r5iUvpPcK4SXZp29CxFrTxXPA3muZUwO2xz8CVr4L8t5aGowfayig9K9YMFreeRP2xJY
         vZwkatvmHhK9FUM5MB1NKeAgKJHJfQebbOfSPnlqYjUJ6MH//ffYoKN0J1XUqlYcD46g
         RoqQ==
X-Gm-Message-State: AOAM533o3n+9XCk++qjDMs+7u7Nzq+wHwQDQvY+z2MDKGdtiFthdoklN
        V07eTe/ncmXBOpbgn3L/BFJjbQ==
X-Google-Smtp-Source: ABdhPJzozClctq3P3F+vS6zEvZVzcUDa+vFBQHDKbeDCU+xqxPVCz54/ZsosyzWg+6MY9eTPiiqwrA==
X-Received: by 2002:a9d:4d8d:: with SMTP id u13mr3755526otk.367.1623848375674;
        Wed, 16 Jun 2021 05:59:35 -0700 (PDT)
Received: from [192.168.1.134] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id 26sm460938ooy.46.2021.06.16.05.59.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jun 2021 05:59:35 -0700 (PDT)
Subject: Re: [PATCH] nbd: provide a way for userspace processes to identify
 device backends
To:     Prasanna Kumar Kalever <prasanna.kalever@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        josef@toxicpanda.com, idryomov@redhat.com, xiubli@redhat.com
References: <20210429102828.31248-1-prasanna.kalever@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f3035a3f-4494-929f-5c21-ba921a77ea6c@kernel.dk>
Date:   Wed, 16 Jun 2021 06:59:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210429102828.31248-1-prasanna.kalever@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/29/21 4:28 AM, Prasanna Kumar Kalever wrote:
> Problem:
> On reconfigure of device, there is no way to defend if the backend
> storage is matching with the initial backend storage.
> 
> Say, if an initial connect request for backend "pool1/image1" got
> mapped to /dev/nbd0 and the userspace process is terminated. A next
> reconfigure request within NBD_ATTR_DEAD_CONN_TIMEOUT is allowed to
> use /dev/nbd0 for a different backend "pool1/image2"
> 
> For example, an operation like below could be dangerous:
> 
> $ sudo rbd-nbd map --try-netlink rbd-pool/ext4-image
> /dev/nbd0
> $ sudo blkid /dev/nbd0
> /dev/nbd0: UUID="bfc444b4-64b1-418f-8b36-6e0d170cfc04" TYPE="ext4"
> $ sudo pkill -9 rbd-nbd
> $ sudo rbd-nbd attach --try-netlink --device /dev/nbd0 rbd-pool/xfs-image
> /dev/nbd0
> $ sudo blkid /dev/nbd0
> /dev/nbd0: UUID="d29bf343-6570-4069-a9ea-2fa156ced908" TYPE="xfs"
> 
> Solution:
> Provide a way for userspace processes to keep some metadata to identify
> between the device and the backend, so that when a reconfigure request is
> made, we can compare and avoid such dangerous operations.
> 
> With this solution, as part of the initial connect request, backend
> path can be stored in the sysfs per device config, so that on a reconfigure
> request it's easy to check if the backend path matches with the initial
> connect backend path.
> 
> Please note, ioctl interface to nbd will not have these changes, as there
> won't be any reconfigure.

Applied, thanks.

-- 
Jens Axboe

