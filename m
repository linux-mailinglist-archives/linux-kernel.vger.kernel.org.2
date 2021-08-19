Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 709CC3F17A7
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 13:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238318AbhHSLFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 07:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236149AbhHSLFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 07:05:53 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A908DC061575
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 04:05:17 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id x27so12056923lfu.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 04:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dwNmdQpLJD7B+msYQhGKkmB2rXBh0sZ7boDUuFMKREc=;
        b=VHrkkTsg+SZWiv/iXZ6ryn/LWRC9qlLL3CrXx2Zduz1l8d+IulS6BzZVT6lZbKLWRc
         kI/dVT59/Ll9tg/KZiN6tKXWMcZuIkFTPQF22qlVQ0AfBhV573YmTcKhSMleWfJpxq3H
         WnAotFYdjULuaIAE2kTy81wHqn713ztZNo0esKNNmn9uy5pO8KLZeUKkUvpR/IvA08H7
         kByRggkdEdOSgXmN+m6CpDLXNRTCyh+3xYIby8tLAMYM8fhzhDa3P3uLk1qKJpFY2tc9
         4cEtWzJZp313bw+e6o2ld95QS3nZNGncEwlAV4OcbZnoLNO2rDUf74qdMfsEi/s8aWUP
         ygrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dwNmdQpLJD7B+msYQhGKkmB2rXBh0sZ7boDUuFMKREc=;
        b=Nq8hAcb9ikGYXybV2atk14FPQAtjTRGF7Hh/9UsjVuiIj5ppqobyqd1VPlfK040xff
         PNTq5dNMKVAuBIfw6/0lNnBkNwrLGyaBK4qw9pZvgmV90XSQZvQr0Vubpu/Q9KP80wkn
         TRZEbuZyal+jCmsz0q4+u5G/C4M+x/TnDZD1EaLE9jqrSXIbrAWjzhbviI6rkDDwE9BE
         ln6B0Y6WOmOHsCxhmHJdO4S/rzFiJRpgBKdYzbJKbH9c221t9GOCkknIiQz1ytBonxID
         DfgzQ+eCP8pWxJ+C00OkgdmI6K47Q5FVr3RmPjETWpP9bN/1NpP6dcTeAh3E9YDN0vOW
         KJnA==
X-Gm-Message-State: AOAM532UC0Nx7lFJtXhwwMw9cF9n2lfexjogubps/ytN44BeD0FXKce5
        WX+G1BNZmhVkeIA6DIeBrFzgIJlHRRQgiiKF
X-Google-Smtp-Source: ABdhPJzstQPsh+acMze1ytayn7jedZsnrRa37ObK3H8IBRO1hHIC6fDDqltqS1wBql6oRiSEcmodOQ==
X-Received: by 2002:ac2:58d4:: with SMTP id u20mr9822418lfo.157.1629371116056;
        Thu, 19 Aug 2021 04:05:16 -0700 (PDT)
Received: from kari-VirtualBox (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id d4sm270087lfg.261.2021.08.19.04.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 04:05:15 -0700 (PDT)
Date:   Thu, 19 Aug 2021 14:05:13 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     almaz.alexandrovich@paragon-software.com, nathan@kernel.org,
        ndesaulniers@google.com, ntfs3@lists.linux.dev,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] fs/ntfs3: Remove unused including <linux/version.h>
Message-ID: <20210819110513.wdyry5rp7orw3s36@kari-VirtualBox>
References: <1629361417-94657-1-git-send-email-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1629361417-94657-1-git-send-email-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2021 at 04:23:37PM +0800, Jiapeng Chong wrote:
> Eliminate the follow versioncheck warning:
> 
> ./fs/ntfs3/inode.c: 16 linux/version.h not needed.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Fixes: 82cae269cfa9 ("fs/ntfs3: Add initialization of super block")
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Reviewed-by: Kari Argillander <kari.argillander@gmail.com>

> ---
>  fs/ntfs3/inode.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
> index bf51e29..bb01f1b 100644
> --- a/fs/ntfs3/inode.c
> +++ b/fs/ntfs3/inode.c
> @@ -13,7 +13,6 @@
>  #include <linux/namei.h>
>  #include <linux/nls.h>
>  #include <linux/uio.h>
> -#include <linux/version.h>
>  #include <linux/writeback.h>
>  
>  #include "debug.h"
> -- 
> 1.8.3.1
> 
