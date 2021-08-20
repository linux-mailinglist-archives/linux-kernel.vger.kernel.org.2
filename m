Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1D893F373F
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 01:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240652AbhHTXSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 19:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbhHTXSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 19:18:42 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D0EC061575
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 16:18:03 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id u16so16334055wrn.5
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 16:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=ndVrv9LlDSJtPxdQ7srGUgMyCM4NsNR8S4LYvnghJTg=;
        b=XF5zPQpKbCu9pv7P7tqvIpvMlZoq3FvUjlwVcpmfs9wHHTkyNu6D5G8TNGFcuu/t42
         vYt6Uc/eP2y+7YKJ6G5oo1X1FZ/ElQ6c6l+jLwV4z6NXXGiw3yNd9FLXAB36zr8uHe5m
         Q6l4+bvMtlqQVlBVHcQu6sG3Hd98k8uxvFqIwaEAfnIAPF64Yc4UqJ9f9gBtAHFCskjL
         isMCRoA5eaLT4S64vbfOpl8mRd6V6Z0oaG7aDxdUzEhByaDOYqK3Y8ARzflLek7u7P8Z
         wC/4UuRWInhvZBsrEXt22QeZpH+Ni7vwizt3iMpw44EYVmzDEW/SHZyfUP5tcBh9tJz1
         LjFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=ndVrv9LlDSJtPxdQ7srGUgMyCM4NsNR8S4LYvnghJTg=;
        b=PfzVLOqm9+iYQMp3/cVFxCEDJIPqPsxUQ6+pnjOkAOzR5noDT1tAZLfGPEtFF4Ahvj
         L8rWOUhds9KISIkh2EJFRWlpDPUepYq4+PmWlVreu3eb3hjf0hqMKbaTbJ5RzzY+9OAj
         0cKyT8h9zRDV/mP4Uz387/Zya72QzHzXPAAiYiKidHa8BztryHnefqTcgwmgRq0DCfYZ
         CPjoG355dcxlp6Z9+93zXZj5Wmy2V1aAXFNg30KnQUs5wmeD54g7ifJp81Lh0BWJqUZm
         /PUdMUMfpbvrMMkT6KPOFSoqFWk9Ui3zrWb13OSaDiGGah8wFv0DS4pr9uM9E2rfRfiF
         1/xg==
X-Gm-Message-State: AOAM532ZBEVqlg24u8glDOVL7UaENPHWZn6f52qz7iinJ6fOcVqM2/cb
        pqQe9jxw7C0OHU4j97qAlYK8ew==
X-Google-Smtp-Source: ABdhPJz2F89Mt5pKkgsy0sbPI9dqRbklsMqgiIt7JIP7QWqkNW3HhlgSKFjuBKw/yP8WdqmrMC6p0w==
X-Received: by 2002:adf:db83:: with SMTP id u3mr1140912wri.363.1629501481925;
        Fri, 20 Aug 2021 16:18:01 -0700 (PDT)
Received: from ?IPv6:2001:8b0:dfde:e1a0::2? (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id j16sm7321552wrr.78.2021.08.20.16.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 16:18:01 -0700 (PDT)
Message-ID: <1590e1abf3991c4b9023173bddee5b9e912d2c47.camel@philpotter.co.uk>
Subject: Re: [PATCH RFC 3/3] staging: r8188eu: add error argument to
 read_macreg
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Larry.Finger@lwfinger.net, gregkh@linuxfoundation.org,
        straube.linux@gmail.com, fmdefrancesco@gmail.com
Date:   Sat, 21 Aug 2021 00:18:00 +0100
In-Reply-To: <44a5a4ab2eae8e0deb969028a5488ea892008c8d.1629479152.git.paskripkin@gmail.com>
References: <cover.1629479152.git.paskripkin@gmail.com>
         <44a5a4ab2eae8e0deb969028a5488ea892008c8d.1629479152.git.paskripkin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.3 (3.40.3-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-08-20 at 20:07 +0300, Pavel Skripkin wrote:
> Since read_macreg() calls rtw_read*() internally we should tell
> callers about an error on the read side.
> 
> Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
> ---
>  drivers/staging/r8188eu/core/rtw_mp.c    | 9 ++++-----
>  drivers/staging/r8188eu/include/rtw_mp.h | 2 +-
>  2 files changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_mp.c
> b/drivers/staging/r8188eu/core/rtw_mp.c
> index 601a1fd5d4e7..6bbea1cc364a 100644
> --- a/drivers/staging/r8188eu/core/rtw_mp.c
> +++ b/drivers/staging/r8188eu/core/rtw_mp.c
> @@ -7,20 +7,19 @@
>  #include "../include/odm_precomp.h"
>  #include "../include/rtl8188e_hal.h"
>  
> -u32 read_macreg(struct adapter *padapter, u32 addr, u32 sz)
> +u32 read_macreg(struct adapter *padapter, u32 addr, u32 sz, int
> *error)

Dear Pavel,

Correct me if I'm wrong, but this read_macreg function seems to be
completely unused by the rest of the driver. Rather than changing the
signature to do error handling, maybe it would be better to just remove
it?

That is just my view though, would be interested to see what others
think - perhaps it could come in handy at some point.

Regards,
Phil

