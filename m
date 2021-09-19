Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1F0410D45
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Sep 2021 22:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232112AbhISU24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 16:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231730AbhISU2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 16:28:55 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE0F4C061574
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 13:27:29 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id j134-20020a1c238c000000b0030b32367649so7669353wmj.3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 13:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PcjFfxcrjteANGpGF7D5h5Ro2oR8eemHGlF4IkMGOLA=;
        b=xGzFp8r1r0uOS42WicW6cab3um5XLbPkFQJQm8JIU0K3l+0J6Z42tRvbq09SJlOnax
         fuaeLB43yebhaS/4O+SpR1uEhJxIiXYskAXKUt5+G9oTJnzYPJVBDQ58VGFrAYBbWtGC
         CPqw0pxp0BJncoFFI2h+8MV61GmQle4NOuEgcsCO/BC5rIp0wwd+1uH/uRe89qe+TdPo
         /PqY1YCIrC3+XzG1EbYnd8vUZ95a/IwiuSHneUVdAo7XKG3iyYppgsBNjLD6oVrsyuRU
         Mymko/6EBQdLpJN1/d0vpVk05JtLaqDr1mYb1JBbTmPjJNGPwDfqFDxkF3TlWkSmjMOs
         PrEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PcjFfxcrjteANGpGF7D5h5Ro2oR8eemHGlF4IkMGOLA=;
        b=zoUe6rdSphoC3wMqrsKdhxpH83w77J5y+NPomrj1Q8ba/zpAmd5K+khuYlCg75F3kI
         4jfA8xdW6uLk3Fjelr4QV4Q1tv/+tVRmgwKEcFjltzNiLBSp5I2Q9zfH8wBsxqSqlypb
         xKHv09kQFclgL8ZDlF7n1/iMemauNXtFIp3DSWcHNZUEuJp8eoff508TmFED3iQVFscS
         DzMcAaT4FaAxoZ8HqwyeAxEl8AtVIy4zFG4tcf8dNjKYXHN5rJkiYaT/2axy8QxpUHYZ
         /jFKw/4JXhnV0G8OlVnsdiCN3IeG1Rqxffqc2C7aDFTpBFU/OyESWwq31cF0nAoqwGat
         gnVw==
X-Gm-Message-State: AOAM532Bh2ES/DcdejRzPXgFXVfH3aCmPVxkAPtCkYK4RG9pSiCkXUVz
        zFv95rZFypmXLHn9MPtxFdHTX+gRoARFZA==
X-Google-Smtp-Source: ABdhPJy4enHG97or0jjruzghXKph7A17B5yf1KXMX+/obgR+oI9hpHXdapukTthLw77i5Vt3cksTJg==
X-Received: by 2002:a1c:7f11:: with SMTP id a17mr3130088wmd.166.1632083247680;
        Sun, 19 Sep 2021 13:27:27 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id y8sm13407878wrh.44.2021.09.19.13.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Sep 2021 13:27:27 -0700 (PDT)
Date:   Sun, 19 Sep 2021 21:27:25 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Michael Straube <straube.linux@gmail.com>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        martin@kaiser.cx, fmdefrancesco@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] staging: r8188eu: remove unused functions from
 rtw_ap.c
Message-ID: <YUedLaAAp1jZiUvL@equinox>
References: <20210919153659.20826-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210919153659.20826-1-straube.linux@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 19, 2021 at 05:36:53PM +0200, Michael Straube wrote:
> This series removes all unused functions from rtw_ap.c.
> 
> Michael Straube (6):
>   staging: r8188eu: remove ap_sta_info_defer_update()
>   staging: r8188eu: remove rtw_acl_add_sta()
>   staging: r8188eu: remove rtw_acl_remove_sta()
>   staging: r8188eu: remove rtw_ap_inform_ch_switch()
>   staging: r8188eu: remove rtw_check_beacon_data()
>   staging: r8188eu: remove rtw_set_macaddr_acl()
> 
>  drivers/staging/r8188eu/core/rtw_ap.c    | 584 -----------------------
>  drivers/staging/r8188eu/include/rtw_ap.h |   6 -
>  2 files changed, 590 deletions(-)
> 
> -- 
> 2.33.0
> 

Dear Michael,

Looks good to me, built and tested here with no warnings and driver
working fine still. Many thanks.

For all six patches:
Acked-by: Phillip Potter

Regards,
Phil
