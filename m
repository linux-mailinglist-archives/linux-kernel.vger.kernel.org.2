Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0BC83483EE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 22:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234413AbhCXVoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 17:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233601AbhCXVnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 17:43:55 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D447C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 14:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=lwyeLRE3g3UreYgtCiDtmRzgTwzVFmBBdTsaNOT78AQ=; b=Xx37BQ+1LBnwwVZV/cAHESdIRh
        ytbDiMY4AFk3iDSVRE/aKxpFszVLjwSHYMswYFiqqlz6KYqRwc+3Je+8EKzIphjcyGH8iPWq7tuDc
        L7KSeyk38GjlkEYiVDI475ZIZZ5o5MZHtXPbgml801Xj0qb5YrKTbzfYdwAvEmdcP3h3DNbiqss65
        4Jmr53XUfcvxyCWU68MXCvOTYeyxr4eS2xSYRFFiBwpxTnJAPDTx0WL6UUMitWs9p+gdTf/q43zjp
        jTNUNfMHcrFlYbyIc4I4nJqMPLkMM5jqRUahV08jfEtIMLfj/B1uJL+QVrAvOBwwsIzT0kvbczIyk
        feWDpGMg==;
Received: from [2601:1c0:6280:3f0::3ba4]
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lPBI7-000FgH-OW; Wed, 24 Mar 2021 21:43:52 +0000
Subject: Re: [PATCH] drm/nouveau/bios/init: A typo fix
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, bskeggs@redhat.com,
        airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20210324063440.14969-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <e5d43d9f-c1b5-e5e8-cdd6-6ec4ff709ca7@infradead.org>
Date:   Wed, 24 Mar 2021 14:43:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210324063440.14969-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/23/21 11:34 PM, Bhaskar Chowdhury wrote:
> 
> s/conditon/condition/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c
> index 9de74f41dcd2..142079403864 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c
> @@ -401,7 +401,7 @@ init_table_(struct nvbios_init *init, u16 offset, const char *name)
>  #define init_macro_table(b) init_table_((b), 0x04, "macro table")
>  #define init_condition_table(b) init_table_((b), 0x06, "condition table")
>  #define init_io_condition_table(b) init_table_((b), 0x08, "io condition table")
> -#define init_io_flag_condition_table(b) init_table_((b), 0x0a, "io flag conditon table")
> +#define init_io_flag_condition_table(b) init_table_((b), 0x0a, "io flag condition table")
>  #define init_function_table(b) init_table_((b), 0x0c, "function table")
>  #define init_xlat_table(b) init_table_((b), 0x10, "xlat table");
> 
> --


-- 
~Randy

