Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE61C371ED3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 19:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbhECRnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 13:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbhECRnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 13:43:02 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D5ADC061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 May 2021 10:42:08 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id e14so4255424ils.12
        for <linux-kernel@vger.kernel.org>; Mon, 03 May 2021 10:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=B8c8UcKOabNygb4slUhxb1MpWvtXEu3qUQwNJzJoOaQ=;
        b=0isSJrE2PQT8gl8Anglx6z1zpID0Zx4kRe2z/kwTKAnI+UPEEGGn7eLeehS4tVYjUP
         njsQwPayHOSBCRBrKHE3PM8AuJod93XUGteWeDiDvzVVb2E9JxMWP5mAydQVDwXnh/lq
         v0JcHY8QX1REhbMwR/y01Au8DVKcerGQjXs/ISLbjGBLkE4/nhCnRx3DJhNRHOESrT90
         S76tD99zgcwZiMznshS4/GgOnGIYFDg+tk9cuypjZ/hdb54cW2w/M+fXyM3J6aROGx8F
         ZAx9q6gSNYHmV7Ri3wpmYAQxdY+HArqawNd//tfnbIaYpRHdlNKHG//Q3HmNY6Q2sdSy
         jrlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=B8c8UcKOabNygb4slUhxb1MpWvtXEu3qUQwNJzJoOaQ=;
        b=UQC+CIylEFo0bOHIaZzRFb4DbLYe7yP9y5cPA2FfsAIGFP/3KEFKsgk5XMOOr1g/li
         zOj0D2cWxnyCAvYhj55VMtiZSwxV3xDmRuW6sQ8R4y4W8geH87RATnmc8E1qgaWncW26
         SVQojNIIF0WSaMY5w2t4Thenie4DAnOL9yS+H4CA+2VkkVl6xrxd/t3E6VQ1pKVN8mPB
         TMr+Yye/1pOO4UDQ6dRnbS8WdXxP5SG52NG0vZiSaamYWnc/0ixGPKZPGUs9PY7+CY/u
         xojXYOBNfbiWIBaa9jIm4pzWEdsitcHTKTenhRCFHSyYE9uhNGbD7lnyxwEESoZsrcfM
         hX0w==
X-Gm-Message-State: AOAM530PkZNsMXhbTkp9awmYn8iOrcAuDB9dJM2xEBheGjf3naQpyPi4
        CkreGW8NVfJrpmoHWnkdKm1x1A==
X-Google-Smtp-Source: ABdhPJzNT5cwZpkJtm0q8ZvU8NX5NQwW4/WZfbEKBrzi+F7XlegU0PUEb28qIZxXi163Kc8lYpEvhw==
X-Received: by 2002:a05:6e02:1a21:: with SMTP id g1mr17471600ile.108.1620063727706;
        Mon, 03 May 2021 10:42:07 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id w6sm5824312ilq.64.2021.05.03.10.42.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 May 2021 10:42:07 -0700 (PDT)
Subject: Re: [PATCH v9] bio: limit bio max size
To:     Changheun Lee <nanich.lee@samsung.com>, bvanassche@acm.org,
        yi.zhang@redhat.com, ming.lei@redhat.com, bgoncalv@redhat.com,
        hch@lst.de, jaegeuk@kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, patchwork-bot@kernel.org
References: <CGME20210503101008epcas1p25d6b727dafcf9ff24db6aa41a3f611fa@epcas1p2.samsung.com>
 <20210503095203.29076-1-nanich.lee@samsung.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c2951dc5-18bc-6c99-7cdc-21e6a8a12f9c@kernel.dk>
Date:   Mon, 3 May 2021 11:42:06 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210503095203.29076-1-nanich.lee@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/3/21 3:52 AM, Changheun Lee wrote:
> bio size can grow up to 4GB when muli-page bvec is enabled.
> but sometimes it would lead to inefficient behaviors.
> in case of large chunk direct I/O, - 32MB chunk read in user space -
> all pages for 32MB would be merged to a bio structure if the pages
> physical addresses are contiguous. it makes some delay to submit
> until merge complete. bio max size should be limited to a proper size.
> 
> When 32MB chunk read with direct I/O option is coming from userspace,
> kernel behavior is below now in do_direct_IO() loop. it's timeline.
> 
>  | bio merge for 32MB. total 8,192 pages are merged.
>  | total elapsed time is over 2ms.
>  |------------------ ... ----------------------->|
>                                                  | 8,192 pages merged a bio.
>                                                  | at this time, first bio submit is done.
>                                                  | 1 bio is split to 32 read request and issue.
>                                                  |--------------->
>                                                   |--------------->
>                                                    |--------------->
>                                                               ......
>                                                                    |--------------->
>                                                                     |--------------->|
>                           total 19ms elapsed to complete 32MB read done from device. |
> 
> If bio max size is limited with 1MB, behavior is changed below.
> 
>  | bio merge for 1MB. 256 pages are merged for each bio.
>  | total 32 bio will be made.
>  | total elapsed time is over 2ms. it's same.
>  | but, first bio submit timing is fast. about 100us.
>  |--->|--->|--->|---> ... -->|--->|--->|--->|--->|
>       | 256 pages merged a bio.
>       | at this time, first bio submit is done.
>       | and 1 read request is issued for 1 bio.
>       |--------------->
>            |--------------->
>                 |--------------->
>                                       ......
>                                                  |--------------->
>                                                   |--------------->|
>         total 17ms elapsed to complete 32MB read done from device. |
> 
> As a result, read request issue timing is faster if bio max size is limited.
> Current kernel behavior with multipage bvec, super large bio can be created.
> And it lead to delay first I/O request issue.

Applied, thanks.

-- 
Jens Axboe

