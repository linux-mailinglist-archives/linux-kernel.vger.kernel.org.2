Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 335643590D9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 02:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233072AbhDIAUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 20:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbhDIAUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 20:20:41 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD4D5C061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 17:20:28 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id n8so6945076lfh.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 17:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kcYroiRC9yMubNZI5GRBrJxPUSJ6ME/aidZpzxmOBVY=;
        b=ShiEwGTowQ5E4ABewWxRYzqflRv1TBXapdNidkbXgngl5KQwDCrge+cM4X6Mga4Gi2
         VW26FIxsXxm4NSxUgucY+ElaWlbqkxk6QOUzqdQ8KSshFbcfaSpRL5LApYwcbFqhelPz
         QiUfJNM56NDSQfbJE12h2SnnZlhoKGPw4Vrzxt3DxqqJqtXvj4RUZBPzL/s0Kcv/bzzk
         BacbyVTngTTQF7XzaGrJo4CLJeQ5WWCbKUP2b1124M5nhM/s8TlGRIUDOir0ewzQJXtm
         ZROx8y1RRm2avyt0DfYLOP0ZiqpH6NlgDuecrlAlbuhDq5vy6ynsevymZ+9HBTlWwxR+
         bsSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kcYroiRC9yMubNZI5GRBrJxPUSJ6ME/aidZpzxmOBVY=;
        b=e395+zoEyxQ7EtlHJ6z9jJcpthpIhidCp9rAQx0+guDZ095Q5JO4XmFwYzzQrxHX5w
         H9jUjH40RT4PolQqxcBRatzJggmU1MdTfHwuRw1ccwaJo5yXKvf0vAuNrdtryaIAfTSP
         ldvjyDfhilcnRC/ifLPNNQU4rfCwEnFVX63idwCVXJasRWdnchaHkbYieCVPocTjLQH+
         tVHrT78ja1h4QzUjMEIZFA/2WvM9qm1JY1alnvbJnvFUxuqBvzThl/p83Aq+mpVW4yUo
         0uAJDZ5rGfgjmb940IVizRHEWojUvskCPBnlD/yyt5zfXAuN3H/mDAZwSRugJW0dw5Vk
         NboA==
X-Gm-Message-State: AOAM532zVgYCRGPWDA2mBT4LafCQO3UKNL5HsrVaQVXA0sac/fJeQfMM
        udnJr9zlfm6dVJyGLepmQFn7qvvyhj4PPDOi5YmR5w==
X-Google-Smtp-Source: ABdhPJxFOEWl77857t3e4LL6FuJ04RG1YL1faLdAIBlMPJD9Mz0gSlXYRJcY3na27GM7eCcDN0SSHX2EloCY94FEWzs=
X-Received: by 2002:a05:6512:985:: with SMTP id w5mr8308276lft.122.1617927626865;
 Thu, 08 Apr 2021 17:20:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210408125429.199592-1-zhaoxuehui1@huawei.com>
In-Reply-To: <20210408125429.199592-1-zhaoxuehui1@huawei.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 8 Apr 2021 17:20:15 -0700
Message-ID: <CAKwvOd=4ebTNPMOD5K_tUDOY6jx-VT29kUNv=d8ZLxG+1bv6=w@mail.gmail.com>
Subject: Re: [PATCH -next] lib: zstd: Make symbol 'HUF_compressWeights_wksp' static
To:     Zhao Xuehui <zhaoxuehui1@huawei.com>,
        Nick Terrell <terrelln@fb.com>
Cc:     "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, yangjihong1@huawei.com,
        zhangjinhao2@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 8, 2021 at 5:55 AM Zhao Xuehui <zhaoxuehui1@huawei.com> wrote:
>
> The symbol 'HUF_compressWeights_wksp' is not used outside of
> huf_compress.c, so this commit marks it static.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

Quite a few other functions are declared in a header, but I don't see
any existing callers in tree.  I wonder if the maintainer could
consider cleaning these up so that we don't retain them in binaries
without dead code elimination enabled, or if there's a need to keep
this code in line with an external upstream codebase?

>
> Signed-off-by: Zhao Xuehui <zhaoxuehui1@huawei.com>
> ---
>  lib/zstd/huf_compress.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/lib/zstd/huf_compress.c b/lib/zstd/huf_compress.c
> index fd32838c185f..1e5e001c3d41 100644
> --- a/lib/zstd/huf_compress.c
> +++ b/lib/zstd/huf_compress.c
> @@ -79,7 +79,8 @@ unsigned HUF_optimalTableLog(unsigned maxTableLog, size_t srcSize, unsigned maxS
>   * Note : all elements within weightTable are supposed to be <= HUF_TABLELOG_MAX.
>   */
>  #define MAX_FSE_TABLELOG_FOR_HUFF_HEADER 6
> -size_t HUF_compressWeights_wksp(void *dst, size_t dstSize, const void *weightTable, size_t wtSize, void *workspace, size_t workspaceSize)
> +static size_t HUF_compressWeights_wksp(void *dst, size_t dstSize, const void *weightTable,
> +                                      size_t wtSize, void *workspace, size_t workspaceSize)
>  {
>         BYTE *const ostart = (BYTE *)dst;
>         BYTE *op = ostart;
>


-- 
Thanks,
~Nick Desaulniers
