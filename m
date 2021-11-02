Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29E334428AC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 08:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbhKBHiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 03:38:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:51136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230484AbhKBHip (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 03:38:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C4C4A60EB8;
        Tue,  2 Nov 2021 07:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635838570;
        bh=E0ffIejdumv1RC0pKbIxm0RZVYMo3MKph+prxcwMGlU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=MBqM7NOGsv5CRd9fXjWUpiLJyBboJX6EhA5ls6iSoQFlruMVWgONtIO52dMnDunlD
         5f70COA/MArLTyI1XBEScaKSYzHIjyv6gcyO3bB1lrVbfvI9LwqoaWw1Fvi+/DKw3E
         XAUh90H//Wl9REfS/aKRH2OQiwHn/IhSYyQTuZ8k7mlS366fiTq3Lidrbmu4qro9nS
         2Q94oHzTXQpVuYCsdWQsdf3N/Lcit73nGOpbsG11GDXVy9SXGnPsHUERWNxd4Je8Nw
         U5D8ECrCc4testNtX0Z9rlbNLmJS00wRlBCe1uyzS2WtReNGTIQt8f0oIa6UM5NL0E
         OLYsf31jectiw==
Message-ID: <037676b3-4f66-c749-5c8b-ac0c1ef7facf@kernel.org>
Date:   Tue, 2 Nov 2021 15:36:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH v4] F2FS: invalidate META_MAPPING before IPU/DIO write
Content-Language: en-US
To:     Hyeong-Jun Kim <hj514.kim@samsung.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <CGME20211102071004epcas1p4d6422cb2ccaa6af495cee4f041f63048@epcas1p4.samsung.com>
 <20211102071002.71823-1-hj514.kim@samsung.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20211102071002.71823-1-hj514.kim@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/11/2 15:10, Hyeong-Jun Kim wrote:
> Encrypted pages during GC are read and cached in META_MAPPING.
> However, due to cached pages in META_MAPPING, there is an issue where
> newly written pages are lost by IPU or DIO writes.
> 
> Thread A - f2fs_gc()            Thread B
> /* phase 3 */
> down_write(i_gc_rwsem)
> ra_data_block()       ---- (a)
> up_write(i_gc_rwsem)
>                                  f2fs_direct_IO() :
>                                   - down_read(i_gc_rwsem)
>                                   - __blockdev_direct_io()
>                                   - get_data_block_dio_write()
>                                   - f2fs_dio_submit_bio()  ---- (b)
>                                   - up_read(i_gc_rwsem)
> /* phase 4 */
> down_write(i_gc_rwsem)
> move_data_block()     ---- (c)
> up_write(i_gc_rwsem)
> 
> (a) In phase 3 of f2fs_gc(), up-to-date page is read from storage and
>      cached in META_MAPPING.
> (b) In thread B, writing new data by IPU or DIO write on same blkaddr as
>      read in (a). cached page in META_MAPPING become out-dated.
> (c) In phase 4 of f2fs_gc(), out-dated page in META_MAPPING is copied to
>      new blkaddr. In conclusion, the newly written data in (b) is lost.
> 
> To address this issue, invalidating pages in META_MAPPING before IPU or
> DIO write.
> 
> Fixes: 6aa58d8ad20a ("f2fs: readahead encrypted block during GC")
> Signed-off-by: Hyeong-Jun Kim <hj514.kim@samsung.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
