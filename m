Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89055346433
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 16:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233072AbhCWP7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 11:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232987AbhCWP64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 11:58:56 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D65C0C061763
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 08:58:55 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id z3so18223574ioc.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 08:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NO3WLs2vlBKiTCA7DRRz2cdPr87od0vVxyebRQ/JakY=;
        b=f3vd+CopGTvevG8pEPkv8DeH4ALqoBzv+RVf1kXcnba6/+sTCctXQaaEajrj65fhwt
         YXE+hqZsMzbd7Yxmx5VTJjZTE06KKiIvUiQHe+w6iWx6OMzp5AvvHRYthPBm9WZ9HaQ3
         eysHTBCuabELRxnBPUwc/voVKA+FVDO5TF2zBD8Vj8x+JdV8Aso8ZoAoRsA07BE2uxYh
         zvqKXXFOa5DiqI8/G1tdpKKmpAVGz/8RHhBbnJ2sQW+05MzkqADVLsR3qGRmP2yBZzPz
         DLHy4U+rDB/Ou+AD70UYuLc/4YAWm2UpYr2c59+dQ+8q7LRjYC5BwEMIjs6r/UWzZCM5
         fL5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NO3WLs2vlBKiTCA7DRRz2cdPr87od0vVxyebRQ/JakY=;
        b=YUJltuGXNG27hLFltLRMmKuRdoonx1SxJSserwFEPr7Y8IimS9hf5bqY6rEj9Cuzn8
         2HsojwRJYCN9BZ4Sy3M+xa2DC1pMuS95qIiwHGYsyQkyaL6v5I0Tj+6qNaoXRrGVVNCC
         dessdvWK3FU1pBd7eAZzEAP8ZtTBggBzvRlKe6d4DdZdgIlQbQKyqcZ/FX1FBOiEa7Pm
         aCGggeebP6Vn7yvnssr83mBu8L4NJX69rgl2x8I1a+5dcdnoNyQVde8dRiRtQoS2tWoj
         +Rj5wnVn0oI416QJVk05OlzabIZM4vkuDvm4LyxhQC4w+DztWpUlTUvHMtV7ggRVW5Jn
         2ZWA==
X-Gm-Message-State: AOAM530jnnoQ+lmJ4uMSZgNBPx66ZpEZHmIgf1IckLqDyhdUvkyIcVQJ
        HPKd8ZA3PmfLxC84FwZ79zQEtAenShKm9A==
X-Google-Smtp-Source: ABdhPJwfcaCYU4OYAne4TbFTL8+80cuww4d05IMpb+sAobc+HNYDfnEuWSXybld8Ezbi8ZjwEU4QvA==
X-Received: by 2002:a05:6638:f11:: with SMTP id h17mr5233398jas.67.1616515135123;
        Tue, 23 Mar 2021 08:58:55 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id n7sm9895823ile.12.2021.03.23.08.58.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Mar 2021 08:58:54 -0700 (PDT)
Subject: Re: [PATCH] block: clear GD_NEED_PART_SCAN later in bdev_disk_changed
To:     chris.chiu@canonical.com, viro@zeniv.linux.org.uk, hch@lst.de
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210323085219.24428-1-chris.chiu@canonical.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0ec65a30-741d-9f22-e90b-1f72f68b4346@kernel.dk>
Date:   Tue, 23 Mar 2021 09:58:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210323085219.24428-1-chris.chiu@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/23/21 2:52 AM, chris.chiu@canonical.com wrote:
> From: Chris Chiu <chris.chiu@canonical.com>
> 
> The GD_NEED_PART_SCAN is set by bdev_check_media_change to initiate
> a partition scan while removing a block device. It should be cleared
> after blk_drop_paritions because blk_drop_paritions could return
> -EBUSY and then the consequence __blkdev_get has no chance to do
> delete_partition if GD_NEED_PART_SCAN already cleared.
> 
> It causes some problems on some card readers. Ex. Realtek card
> reader 0bda:0328 and 0bda:0158. The device node of the partition
> will not disappear after the memory card removed. Thus the user
> applications can not update the device mapping correctly.

Applied, thanks.

-- 
Jens Axboe

