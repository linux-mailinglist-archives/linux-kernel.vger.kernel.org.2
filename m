Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8593D442525
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 02:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbhKBBbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 21:31:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:54576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229479AbhKBBbc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 21:31:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8100E610CC;
        Tue,  2 Nov 2021 01:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635816538;
        bh=U4ZfHBCoy7l0t3Jy95ZI7OxQi81CBShvutclXQmAFT0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=h3e/wPN49mFL+g6AWga1fecsxgMNYCRZpqscSnDcjjDs+1bnHGvZNIDMocr78L448
         XJeP3J6z4+6AhonbxwIiX3Q3hJXdlQwKivUvTvDgMX7VxPVHjDtzHCHRT2UFWSb8Hh
         dEnyUc42UULcpm/Ta19CFsa5Kxz/Y82qR5hWODdnJybgS8fpUFBslyoc438CZMpOCI
         KG/QAUqYWU+mxLCt+SFA4RrGrdrnPMpqkNwlPSpyJGdyPDlGM8rCgXC7Y8HOCStydp
         LLkgxU1TvVVHc4l3Qi6G8O3RuvUfMYd8oOoZPrhk5BJehbuuWSNNxAAqWdSHu9O6HM
         eWFfYFvG0qrZA==
Message-ID: <56b09503-e545-919b-b86b-d90d9b84fbae@kernel.org>
Date:   Tue, 2 Nov 2021 09:28:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH v2] F2FS: invalidate META_MAPPING before IPU/DIO write
Content-Language: en-US
To:     Hyeong-Jun Kim <hj514.kim@samsung.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <CGME20211101084637epcas1p3a17850a8a437488649be9b41ffa889e2@epcas1p3.samsung.com>
 <20211101084634.38727-1-hj514.kim@samsung.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20211101084634.38727-1-hj514.kim@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/11/1 16:46, Hyeong-Jun Kim wrote:
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
