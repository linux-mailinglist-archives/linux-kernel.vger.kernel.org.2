Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4450332DE05
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 00:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233340AbhCDXuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 18:50:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232543AbhCDXub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 18:50:31 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E7DCC061574
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 15:50:31 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d11so337949plo.8
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 15:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fBM3x2Jvh9yrxQ8ou6SaTNUrWPPxI8MhXrn4+8d/y8c=;
        b=Hmor8MyonFhRh2pbmVfovEH002W6qy4lse5CAJQ+/Zm17vWvpD3lWwFdzOICcX+QIu
         3DYCK7YULgmVXv0tlY2ijCUyzXAMvvKpjroy9rkuXavrpG98/mg7Vx24VTJf4VNpvZmb
         NfdaAdu7K432oYrEjhmMEANSWaJU2yeh3J/TI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fBM3x2Jvh9yrxQ8ou6SaTNUrWPPxI8MhXrn4+8d/y8c=;
        b=QoRS4CN04DSlXR/P3Um8z4R9mJNaH6z1+PdWbVJlQjrHgBgFe+eQqTJPCuBh0TjCgw
         AfVD8fKgtTTXXMWD0zvbqCCawlhPfWEBLERqnW5Lpwsfuyf27x/Oz7r4d8D+m4vb9m4R
         /EVFkm37IJxiUsDmrp1Eg0ArkOmfsAFSW5z75tfcDUzl2pbd9EJvRgpIJuaLol96xL4R
         Bz+znOBkLWb6ih/I8SZuduTUsfiKyMEE8cCP9SRAQCBSWoHbI97EzENx8EItXU4Wkvpb
         cuEXoI5pTk8YHO7QhkMgTcn8judkegD3IcjzvHIKSDqZRwzE/xkvX7VGh4NmMug9GgNs
         +Zqg==
X-Gm-Message-State: AOAM53323vSKUlB0tT3tTR/DahpDycf3TRD4ks6b9ghjY9OfyOjqC2tx
        y0QwWX4tm24wtdDjqGBftsP34A==
X-Google-Smtp-Source: ABdhPJyaoW1Ju/pSLOkgKfHs1exljGevVAWLF0woDDaC82pKsBL/28eSt8LgZmiOkVSWk05IonrI5w==
X-Received: by 2002:a17:90a:16d6:: with SMTP id y22mr7360453pje.55.1614901830516;
        Thu, 04 Mar 2021 15:50:30 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k128sm426613pfd.137.2021.03.04.15.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 15:50:29 -0800 (PST)
Date:   Thu, 4 Mar 2021 15:50:29 -0800
From:   Kees Cook <keescook@chromium.org>
To:     zhaojiele <unclexiaole@gmail.com>
Cc:     jmorris@namei.org, serge@hallyn.com,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] security/loadpin: Replace "kernel_read_file_str[j]" with
 function                   "kernel_read_file_id_str(j)".
Message-ID: <202103041547.2D77671E92@keescook>
References: <20210304083638.174767-1-unclexiaole@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210304083638.174767-1-unclexiaole@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 04, 2021 at 08:36:38AM +0000, zhaojiele wrote:
> Actually Linux kernel already provide function "kernel_read_file_id_str()"
> for secure access in "kernel_read_file.h".And, in "parse_exclude()"
> function, there is no need for
> "BUILD_BUG_ON(ARRAY_SIZE(kernel_read_file_str) <
> ARRAY_SIZE(ignore_read_file_id))"
> when access array by functon "kernel_read_file_id_str(j)".
> 
> Signed-off-by: zhaojiele <unclexiaole@gmail.com>
> ---
>  security/loadpin/loadpin.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
> index b12f7d986b1e..3e8bdcd06600 100644
> --- a/security/loadpin/loadpin.c
> +++ b/security/loadpin/loadpin.c
> @@ -210,8 +210,6 @@ static void __init parse_exclude(void)
>  	 */
>  	BUILD_BUG_ON(ARRAY_SIZE(exclude_read_files) !=
>  		     ARRAY_SIZE(ignore_read_file_id));
> -	BUILD_BUG_ON(ARRAY_SIZE(kernel_read_file_str) <
> -		     ARRAY_SIZE(ignore_read_file_id));

This should stay to make sure kernel_read_file_str doesn't diverge from
the other two. However, maybe it should be tightened to:

	BUILD_BUG_ON(ARRAY_SIZE(kernel_read_file_str) - 1 ==
		     ARRAY_SIZE(ignore_read_file_id));

>  
>  	for (i = 0; i < ARRAY_SIZE(exclude_read_files); i++) {
>  		cur = exclude_read_files[i];
> @@ -221,9 +219,9 @@ static void __init parse_exclude(void)
>  			continue;
>  
>  		for (j = 0; j < ARRAY_SIZE(ignore_read_file_id); j++) {
> -			if (strcmp(cur, kernel_read_file_str[j]) == 0) {
> +			if (strcmp(cur, kernel_read_file_id_str(j)) == 0) {
>  				pr_info("excluding: %s\n",
> -					kernel_read_file_str[j]);
> +					kernel_read_file_id_str(j));
>  				ignore_read_file_id[j] = 1;
>  				/*
>  				 * Can not break, because one read_file_str

I feel funny about making these into function calls when we've already
validated the index, but yeah, that would be fine. Can you send a v2
with the earlier suggestion addressed?

Thanks!

-Kees

-- 
Kees Cook
