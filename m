Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 570853151CF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 15:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbhBIOiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 09:38:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232198AbhBIOhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 09:37:37 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A686C06178A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 06:36:57 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id n201so18916968iod.12
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 06:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sssg8KmxqU8VRCtUYxA1o0jiJ/Ogsm8bVP7G94M7KA0=;
        b=UIHkK2HX+tLzNxL/ptPBHZMx3SYQKMFY8aCJoIddkhUF+01JXmbyRIAm9Cj7z7EFOt
         zVlxYCfeJoKJsGHbu5qgASUHnp8OucPDl6pmn0biWRmIxvKS+eVcs2Afd3XNE1HQ8baH
         aXINBYnNDwMK7ecaeErOQI6tqLZ4ZLPfsjr6gI8xt+Ox+xI//batqG8ntnmYqOLYbNrQ
         +wYh/8+CTsMaEpiNLRAxJEbW2suGZZnfQ81XAWh95eGe7QTHXSKuEF9PkxFI+ml3Vm3l
         r4SDOkyFqJ6cvyGPKm5j1akkXa74YxMLgLxv9DEk3OgWe6NlGN+O5LXFEyFj78njoPFW
         N3JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sssg8KmxqU8VRCtUYxA1o0jiJ/Ogsm8bVP7G94M7KA0=;
        b=MLrfvjbiCq3m8eYt+obAth/e+139ZiciqKyWnDc+NTI5t7cSmlRsI4k/mi8pSQDkfZ
         vAVQ8TNwhL1D3veTnvUlp9i8j1lKMtf+r1IirSpfz1HgOuLUIGmdV1OTI+Y4cZ6Ny4+y
         T/KGZtLG5pyNXsvExarpF/IK2+LEZpd5EDS7wuInF5uxjESoqkdNi7oR9HLKKttevupc
         gn35/7xQvEAX0b8g2B6Gv9QZOmW5up7uLR6O1oE3dQxQIuGENu//SUT1M4kRUd4NCFSN
         UMBu+MaG2tNxyMpSbLNQzu2cedv5oKROQ02+GbXm73Im+RlfaxbpEZrVJWdD5lWHU7XO
         ONRg==
X-Gm-Message-State: AOAM532f4JKYMSvp7folMtXwmDHZWC4DLrvd//5C1vvAKR2p8O47U8ch
        GgFRlnorEQuOOKjfDBcAuV2ZvKd3yYhVgwY9
X-Google-Smtp-Source: ABdhPJxxTqGhtJcMSiPJCMIu1CELREH8sJLFd1lS8Ok90jVMZpbOZMwdhLOq+c8W6+hvFo+i4hylZw==
X-Received: by 2002:a05:6638:12d3:: with SMTP id v19mr23275574jas.42.1612881416549;
        Tue, 09 Feb 2021 06:36:56 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id 14sm10659330ioe.3.2021.02.09.06.36.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Feb 2021 06:36:56 -0800 (PST)
Subject: Re: [PATCH] fs/io_uring.c: fix typo in comment
To:     zangchunxin@bytedance.com, viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210209024224.84122-1-zangchunxin@bytedance.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <04e4ac54-c38a-2160-d152-000c0147a274@kernel.dk>
Date:   Tue, 9 Feb 2021 07:36:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210209024224.84122-1-zangchunxin@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/8/21 7:42 PM, zangchunxin@bytedance.com wrote:
> From: Chunxin Zang <zangchunxin@bytedance.com>
> 
> Change "sane" to "same" in a comment in io_uring.c

It's supposed to say 'sane'.

-- 
Jens Axboe

