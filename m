Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF3493B7EC1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 10:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233325AbhF3IQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 04:16:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:38044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233048AbhF3IP7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 04:15:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9CA7D61C9F;
        Wed, 30 Jun 2021 08:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1625040811;
        bh=KO4vyaUivIt0ADyQShDhV1aCw7X6viddALTw7vTzn4g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=allzi4pTPxU9HtC2mQ2IL+I/Ef0+0nuO719xRyraDLXt2ZvCbXedwNHZn+qxDl5Vd
         2bKhVaRFNk8LHJ94UbXIBgyUa5jK/5MtIgFp81gWHpYCfxiST6dUr2d1atgQ0IxHPJ
         W6f3X8pCYm8OSzfEYjw+laO/meyF2++Lk4r4NAh8=
Date:   Wed, 30 Jun 2021 10:13:28 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     =?utf-8?B?6raM7Jik7ZuI?= <ohoono.kwon@samsung.com>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
        "ohkwon1043@gmail.com" <ohkwon1043@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: cleancache: fix potential race in cleancache apis
Message-ID: <YNwnqOuFlIG6Jofy@kroah.com>
References: <CGME20210630073310epcms1p2ad6803cfd9dbc8ab501c4c99f799f4da@epcms1p2>
 <20210630073310epcms1p2ad6803cfd9dbc8ab501c4c99f799f4da@epcms1p2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210630073310epcms1p2ad6803cfd9dbc8ab501c4c99f799f4da@epcms1p2>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 30, 2021 at 04:33:10PM +0900, 권오훈 wrote:
> Current cleancache api implementation has potential race as follows,
> which might lead to corruption in filesystems using cleancache.
> 
> thread 0                thread 1                        thread 2
> 
>                         in put_page
>                         get pool_id K for fs1
> invalidate_fs on fs1
> frees pool_id K
>                                                         init_fs for fs2
>                                                         allocates pool_id K
>                         put_page puts page
>                         which belongs to fs1
>                         into cleancache pool for fs2
> 
> At this point, a file cache which originally belongs to fs1 might be
> copied back to cleancache pool of fs2, which might be later used as if
> it were normal cleancache of fs2, and could eventually corrupt fs2 when
> flushed back.
> 
> Add rwlock in order to synchronize invalidate_fs with other cleancache
> operations.
> 
> In normal situations where filesystems are not frequently mounted or
> unmounted, there will be little performance impact since
> read_lock/read_unlock apis are used.
> 
> Signed-off-by: Ohhoon Kwon <ohoono.kwon@samsung.com>

What commit does this fix?  Should it go to stable kernels?

thanks,

greg k-h
