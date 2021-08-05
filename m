Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 946903E1609
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 15:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241765AbhHENtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 09:49:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:39132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238790AbhHENtp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 09:49:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 85C136113C;
        Thu,  5 Aug 2021 13:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628171370;
        bh=5fYdOE+SvhIaViGDce04NeXByPmfDOo0xZmV7y6rHGc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=d0Bj0XqaaUisl1Ast872dXyKMs88fEj9Wp098dOBxbyjn0B/0dVuBe/twXdLpodq5
         5Le1eX22Gk48J+dzJX5QcxPD3fcEoAyH9T1j0iA+C97q5vl011tbWL6E6oCuGpmRhE
         biiu6/S6nb81mFwHgcEvbnDAKxn0+JpJgZu8feFuQ1IbWbFDmHirjO7NhGt5ajOSZs
         XNNMEl661b7NPgCXVWWmX1Xx1ilBA95+Nl9te+P1v8GZBAV953d+6H9zZDLrLIqQJR
         eAvmkpus7Jg1kb0hpWWcn6oTNgxz0DqasZvOz+zs5PRJqM/dhQz7oZMvsWWd4InrKE
         ddriESDVSCr3w==
Subject: Re: [PATCH] f2fs: Kconfig: clean up config options about compression
To:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <1628170224-13239-1-git-send-email-yangtiezhu@loongson.cn>
From:   Chao Yu <chao@kernel.org>
Message-ID: <23f17a0a-7d0a-97c1-246f-994b8ffecc8d@kernel.org>
Date:   Thu, 5 Aug 2021 21:49:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <1628170224-13239-1-git-send-email-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/8/5 21:30, Tiezhu Yang wrote:
> In fs/f2fs/Kconfig, F2FS_FS_LZ4HC depends on F2FS_FS_LZ4 and F2FS_FS_LZ4
> depends on F2FS_FS_COMPRESSION, so no need to make F2FS_FS_LZ4HC depends
> on F2FS_FS_COMPRESSION explicitly, remove the redudant "depends on", do
> the similar thing for F2FS_FS_LZORLE.
> 
> At the same time, it is better to move F2FS_FS_LZORLE next to F2FS_FS_LZO,
> it looks like a little more clear when make menuconfig, the location of
> "LZO-RLE compression support" is under "LZO compression support" instead
> of "F2FS compression feature".
> 
> Without this patch:
> 
> F2FS compression feature
>    LZO compression support
>    LZ4 compression support
>      LZ4HC compression support
>    ZSTD compression support
>    LZO-RLE compression support
> 
> With this patch:
> 
> F2FS compression feature
>    LZO compression support
>      LZO-RLE compression support
>    LZ4 compression support
>      LZ4HC compression support
>    ZSTD compression support
> 
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
