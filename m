Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7DAF38D64F
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 17:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbhEVPQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 11:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbhEVPQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 11:16:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F3FC061574;
        Sat, 22 May 2021 08:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=M8xEYJUOS1PH8zqwRp4HnULXuuhN/mYcj4cUJQVCOX8=; b=LnPT1shAR3Mz03jGrAq1VIYXDy
        wTIBxj+XN+tZ+tm3MFi0vs28hDbfUOGVK5k+GuCpdmM7nq1tDLRp8uorsCO//5d7VQq9JcgeEFuCV
        jbN9o4lXwLL/Tk0eZV1XjQ9GFxYamuRUQY5oSt1xGLmIkGXMnTlFD8yrRUl7kuxuGayIn1JdMHOO7
        1tp8IASsKV+YP/Itu4JI+2SrmNSW1fU9QTV2hi4ZCiu8c0AQgfFF9bvaYNqczbePgcKwLp8Bm7acK
        45CGZdU6/i3B2+Ur82wgfAFpxmdD+s5unpQCJBEte4O+CUmAOfBKzuNaTFQgPM7oYOKfOA37qwm37
        xXkiZVzw==;
Received: from [2601:1c0:6280:3f0::7376]
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lkTLG-0008dF-Em; Sat, 22 May 2021 15:15:06 +0000
Subject: Re: [PATCH v2] f2fs: fix kernel-doc syntax and remove file name from
 file header
To:     Aditya Srivastava <yashsri421@gmail.com>, jaegeuk@kernel.org
Cc:     lukas.bulwahn@gmail.com, chao@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org
References: <d1e7aaa1-4f59-2480-003d-5a5a37443c75@infradead.org>
 <20210522114351.9538-1-yashsri421@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <d9d527e1-f23e-c8a1-cc80-be8a445457cc@infradead.org>
Date:   Sat, 22 May 2021 08:15:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210522114351.9538-1-yashsri421@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/22/21 4:43 AM, Aditya Srivastava wrote:
> The opening comment mark '/**' is used for highlighting the beginning of
> kernel-doc comments.
> The header for include/linux/f2fs_fs.h follows this syntax, but the
> content inside does not comply with kernel-doc.
> 
> This line was probably not meant for kernel-doc parsing, but is parsed
> due to the presence of kernel-doc like comment syntax(i.e, '/**'), which
> causes unexpected warning from kernel-doc:
> warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>  * include/linux/f2fs_fs.h
> 
> Provide a simple fix by replacing this occurrence with general comment
> format, i.e. '/*', to prevent kernel-doc from parsing it.
> 
> Also remove the redundant file name from the comment headers.
> 
> Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
> Changes in v2:
> - Remove file name information from header comments, as suggested by Randy
> 
>  include/linux/f2fs_fs.h | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
> index 5487a80617a3..b5a081aa86c4 100644
> --- a/include/linux/f2fs_fs.h
> +++ b/include/linux/f2fs_fs.h
> @@ -1,7 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0
> -/**
> - * include/linux/f2fs_fs.h
> - *
> +/*
>   * Copyright (c) 2012 Samsung Electronics Co., Ltd.
>   *             http://www.samsung.com/
>   */
> 


-- 
~Randy

