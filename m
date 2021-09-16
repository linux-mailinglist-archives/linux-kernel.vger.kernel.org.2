Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 187C540D32E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 08:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234505AbhIPG0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 02:26:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47713 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234417AbhIPG0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 02:26:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631773517;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YDYMLRQB5NY9ENd9cvkxCO0IUruGgbCum6Qchd6u8hw=;
        b=Id5g486MsCnvVU7sJSTazfMzzNfvxZHlLdiVgtdODCKHf0BA+6Pz4oE21eCnDUrErXRIjB
        Z6/FekFNbs8DH+6IuVilVUTBmGdTijmDQalDGWwpzY3UPQvaVuJ24msTo0XiCwmTOFiqQF
        INZCwY2bUzsPUqDkiEsP18HOiY5l6ag=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-E0BrZvqvPSijyRozPLyn7Q-1; Thu, 16 Sep 2021 02:25:16 -0400
X-MC-Unique: E0BrZvqvPSijyRozPLyn7Q-1
Received: by mail-wm1-f71.google.com with SMTP id c187-20020a1c35c4000000b00304b489f2d8so2672370wma.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 23:25:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YDYMLRQB5NY9ENd9cvkxCO0IUruGgbCum6Qchd6u8hw=;
        b=NsXdwnRIT0v7XZtTNLMAOSnEoT+Kj9338WafvozJdvqE3s7bAu5qy+r7+ficxTJj5X
         KvRdM+CIPmQ7e8NNo25WYaxMijomBbe7bGhtXPnTsC99s8o1XJAQXChz8fNUZqwCuS0K
         CreBqgYm1fjxq/F1ZYpz+TjJLbdQJsocL3QkQjtttVJI9HbJM2bsIxuu4vpB8ED7mGFl
         20pBczWqArfW0UNiWvqZEQbEGVqKy14ykZpMDi0BSGuRdyInUMUOJGscyELVpw3zoESC
         Y0S9lzAukAkm49KvHj62xNjXRr8Y0tjZ98nsTPOqVfD2PFMQFCFtyHzcUMUKPw08MX03
         6r+g==
X-Gm-Message-State: AOAM5335jSiGuT6YjrpWvMhVKUleW9B+AnhJbOS3vxevdxdBgSIL98q+
        JbXMVz/ORANC2u9bTNdNSIHHM5Vdz66iRJiTBCZpxEHIGQUckFPwxGNax/hOSKGv2am6un8KadY
        WT6R5NHa16+gRFJaYND7NmKkCzbIz6b0PBjpuUFXr
X-Received: by 2002:a05:6000:11d1:: with SMTP id i17mr4125594wrx.424.1631773515396;
        Wed, 15 Sep 2021 23:25:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwqTzrhsF/h6jSo+GRqZ3bg71kapWMBfrCU4g/DI13eBzKbIvKPTkQ38efTQNFa3EWEajYZ6DIZ1odcXcag90U=
X-Received: by 2002:a05:6000:11d1:: with SMTP id i17mr4125564wrx.424.1631773515148;
 Wed, 15 Sep 2021 23:25:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210806142914.70556-1-pkalever@redhat.com>
In-Reply-To: <20210806142914.70556-1-pkalever@redhat.com>
From:   Prasanna Kalever <pkalever@redhat.com>
Date:   Thu, 16 Sep 2021 11:55:04 +0530
Message-ID: <CANwsLLGYoexzyMkK5_0jpTA+P=_FS_UyudZSeTS=EZPjakYDpQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] nbd: reset the queue/io_timeout to default on disconnect
To:     linux-kernel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        Ilya Dryomov <idryomov@redhat.com>,
        Xiubo Li <xiubli@redhat.com>,
        Prasanna Kumar Kalever <prasanna.kalever@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Just wanted to bring this up again and remind you about the pending review.

Many Thanks,
--
Prasanna

On Fri, Aug 6, 2021 at 7:59 PM <pkalever@redhat.com> wrote:
>
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
>   block: cleanup: define default command timeout and use it
>   nbd: reset the queue/io_timeout to default on disconnect
>
>  block/blk-mq.c         | 2 +-
>  drivers/block/nbd.c    | 9 +++++++--
>  include/linux/blkdev.h | 2 ++
>  3 files changed, 10 insertions(+), 3 deletions(-)
>
> --
> 2.31.1
>

