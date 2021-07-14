Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4183C91C6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 22:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237489AbhGNUHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 16:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240374AbhGNT5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 15:57:47 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9BDDC061793
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 12:47:14 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id n14so5595619lfu.8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 12:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wpYUDPD+jJFa/2N/K1bMkRrbiJB4ktLKot6CPD1nD6M=;
        b=d9X1AkkxxLd0ZqF7ENPdAZ7RzHjtfCRUal3ATbCVy9C01lTgr+XYPz97dBCPC0u17d
         Oee4489N1rN4EIQbTaADiwZ9iONnBd3u4ih1EiEIDsJZnPdEbKggqhrlqyGo3YmeNQmn
         Lv7q8lebn0Id8Mk+iQhS8bu0n5IlJRb+Bexe9JqeIqnh2tDKIjNSI2zqLMcKz/T9z0LZ
         VMMxKsX7PomW2xTwCtLLtf4LEURUWpSYQlfLUydIqpuKbqnfo8Bk8gfldzzwnioMrTnM
         SHHXoyzP3E9dzBllvwanZGYcfEILh8cwh1CcjtLU3E83KJTxS+kzt8Bx/Z5s9jAw9sNI
         vpJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wpYUDPD+jJFa/2N/K1bMkRrbiJB4ktLKot6CPD1nD6M=;
        b=FtsmGjIPLAQ4WqTSrJbN0t27vg4+YBo1shr0pIGdxJQvblpbQMnxWhXRUawmgrRlMu
         lwRBCfObUwvGUUcZH3XlhHYe9rrMS4dMumNKmU6xy3VM4vsYUafSW/yNq4rI9bmFSXw/
         h+YEqAth72pUqefz+7D2Nubl71OoLomY1xLWHjGkoFKF2bseccbflqBGilaHm/8231/h
         HqtMVW8JECgNS2awKsngnvzt9lGyOl/cgXtmapQIbqkw8X2NmDDn3h6+z/yqO/zWrnrR
         YRYT9SPuPa4RhI3GIz7MIfSW7o3lnQApVuIB6+2IALS87Y4azwZ6/ENp7WVZwqielZwr
         bM6w==
X-Gm-Message-State: AOAM532WktAzzxFoErWXKhLOp5IQeBNqcl3GUosCERxiKLL6fKomcJa1
        G9gTfm3dXEoJwZRyveaJer+n4WmXZjWyuftAewRQDA==
X-Google-Smtp-Source: ABdhPJze67kG1uwUYVbJ6P9gS9Y103rENKreLrQvMcdWxBszP0piK2uRfZDFh75DLLud35kwXezLSncaGc+Ac8ILc4w=
X-Received: by 2002:ac2:4ac6:: with SMTP id m6mr9577331lfp.73.1626292032772;
 Wed, 14 Jul 2021 12:47:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210702044950.10411-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20210702044950.10411-1-lukas.bulwahn@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 14 Jul 2021 12:47:01 -0700
Message-ID: <CAKwvOdn0DPA2sk8MtmVa9shWDH7GL4t2X5K0V4T=+RnpUKJGOw@mail.gmail.com>
Subject: Re: [PATCH] gcov: clang: rectify gcov_info_add's kernel-doc
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Peter Oberparleiter <oberpar@linux.ibm.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        clang-built-linux@googlegroups.com,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 1, 2021 at 9:50 PM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
> For gcov_info_add, ./scripts/kernel-doc -none kernel/gcov/clang.c warns:
>
>   warning: Function parameter or member 'dst' not described in 'gcov_info_add'
>   warning: Function parameter or member 'src' not described in 'gcov_info_add'
>   warning: Excess function parameter 'dest' description in 'gcov_info_add'
>   warning: Excess function parameter 'source' description in 'gcov_info_add'
>
> Obviously, the kernel-doc's and function's parameter names slightly mismatch.
>
> Adjust the kernel-doc description to make kernel-doc happy.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Thanks Lukas!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  kernel/gcov/clang.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/gcov/clang.c b/kernel/gcov/clang.c
> index cbb0bed958ab..214696e28ec1 100644
> --- a/kernel/gcov/clang.c
> +++ b/kernel/gcov/clang.c
> @@ -264,10 +264,10 @@ int gcov_info_is_compatible(struct gcov_info *info1, struct gcov_info *info2)
>
>  /**
>   * gcov_info_add - add up profiling data
> - * @dest: profiling data set to which data is added
> - * @source: profiling data set which is added
> + * @dst: profiling data set to which data is added
> + * @src: profiling data set which is added
>   *
> - * Adds profiling counts of @source to @dest.
> + * Adds profiling counts of @src to @dst.
>   */
>  void gcov_info_add(struct gcov_info *dst, struct gcov_info *src)
>  {
> --
> 2.17.1
>


-- 
Thanks,
~Nick Desaulniers
