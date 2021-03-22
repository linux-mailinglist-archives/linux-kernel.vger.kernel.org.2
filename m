Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F21E344AFF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 17:19:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbhCVQT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 12:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbhCVQTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 12:19:17 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E51F6C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 09:19:16 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id h13so20067597eds.5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 09:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eldFodHTbSBJUE2zcFhJoaj3CYiDURbwU2RZsCSY3vk=;
        b=iR453lW6sLP64qnFJYDmv4LE+4sZNsatktXtJrVGX0ebjNnNdfszZqv/O8c5sz6Lql
         3cF2GGsmMczfu/Y8Z9DpcpoDV2f1l+sOluo8NnCVJvA59cxfjdJ/2Z60y+N3n7lyfJ+F
         Wj+3Gd8uM7NuTZ8/QXuz/TN8mHEDeWdFbDs47VrQnK58TNAnLVP7w9GvSHD1DnTB+P/S
         2qvHT7o9/F75zGzpStGm9i4CdN0XzV81skEHiWn1JR8IBB349l7yE6X6ah2gYH8Dra27
         WrlqSv1hmz5Miwu12AnySMAg2Cu5YrRJ3LJQJDmXUxAsG8qB+ucSWyzp2ae3pQRUJyGU
         5Pzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eldFodHTbSBJUE2zcFhJoaj3CYiDURbwU2RZsCSY3vk=;
        b=JeEnqH79IwjwPw5kMm1VKmidvMdjkxuC6Sc+19d34J+6+7NVsSfpTOhRvmpk98Rbdj
         qQaV+NzhgaxnISewjOyeq/LDQ/xLLMe2Lq+isjxl7spFx9I2yqjBxY+u94LpsvpWh0hB
         b2QHN/Pa0aXoA10RS2tvJdM5Jo3ZWGtOc6wbVUKF+XbrqzTaMfgyQpcuNyujVQyh052l
         RVkwk+23g/r5B/azrgrWVH1z3jRFmdyVOdr/AjsSow+7pDRbX5Y2JqQtVwrkrzQ2YJK0
         XSxkzLvOw6Tll+cddHONV/2WauAC4ukQZnNn9hAI+MqsMikQaNjMOqRBsQ+VPBhm6gi5
         roCg==
X-Gm-Message-State: AOAM533tJXcKd2CogXgnwVgsBILGZd6Jui+KLPDri8dFRmkZXC98z5Vf
        0jlphaSFV0e7Dv7cxE2pv70fDTAU7tmGqqAE
X-Google-Smtp-Source: ABdhPJxzhZ75lilJTGnJ2uSE44+ivj3vV6JfjU0UFJ/NAJPT46u2jR9a2541CVFtYpcFf8t22GkKPg==
X-Received: by 2002:aa7:d841:: with SMTP id f1mr367235eds.286.1616429955708;
        Mon, 22 Mar 2021 09:19:15 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id y17sm9746213ejf.116.2021.03.22.09.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 09:19:15 -0700 (PDT)
Date:   Mon, 22 Mar 2021 16:19:13 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc:     jason.wessel@windriver.com, dianders@chromium.org,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org
Subject: Re: [PATCH V2] kernel: debug: Ordinary typo fixes in the file
 gdbstub.c
Message-ID: <20210322161913.fbvrtnorezojddee@maple.lan>
References: <20210317104658.4053473-1-unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210317104658.4053473-1-unixbhaskar@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2021 at 04:16:58PM +0530, Bhaskar Chowdhury wrote:
> s/overwitten/overwritten/
> s/procesing/processing/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Applied, Thanks!


Daniel.


> ---
> Changes from V1:
>  As Daniel pointed out, I was misdoing a check,so corrected
> 
>  kernel/debug/gdbstub.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/debug/gdbstub.c b/kernel/debug/gdbstub.c
> index e149a0ac9e9e..8372897402f4 100644
> --- a/kernel/debug/gdbstub.c
> +++ b/kernel/debug/gdbstub.c
> @@ -321,7 +321,7 @@ int kgdb_hex2long(char **ptr, unsigned long *long_val)
>  /*
>   * Copy the binary array pointed to by buf into mem.  Fix $, #, and
>   * 0x7d escaped with 0x7d. Return -EFAULT on failure or 0 on success.
> - * The input buf is overwitten with the result to write to mem.
> + * The input buf is overwritten with the result to write to mem.
>   */
>  static int kgdb_ebin2mem(char *buf, char *mem, int count)
>  {
> @@ -952,7 +952,7 @@ static int gdb_cmd_exception_pass(struct kgdb_state *ks)
>  }
> 
>  /*
> - * This function performs all gdbserial command procesing
> + * This function performs all gdbserial command processing
>   */
>  int gdb_serial_stub(struct kgdb_state *ks)
>  {
> --
> 2.30.2
