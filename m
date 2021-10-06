Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E06942462D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 20:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238725AbhJFSlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 14:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbhJFSlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 14:41:50 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D21EBC061746
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 11:39:57 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id e12so11630954wra.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 11:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=C5j6gIA1b8ePCYuZs/fRrcTl474BqZvsLpDMgivFPTc=;
        b=eMc7erGqAsArHnHro5uxw6FkWtPXMGgdhckYWOORIUjwHhEpLdH4GzAOI+0daofj5S
         4vTBASYwXNWj7vcfWYCHOBmi8SolWNSu6d2osH6Yt4yDo9BcS5vidGe0EZwaPMgQNmOY
         nenSaKRCdofVL9JQ6Bm6Xb5OWhUaGatBajCD1JVZ89NW1QOGZ19fueqA4TfoLdRwvlSE
         Mcr7nD+aAdbJnJczWM516n974DYVdNv/N8C63MO4Gw0tw+JHWbFICQo84zjMM01N32Ii
         S90TiCLxizpKiRyDNk9Y2I24aUu7EhC0WOLuCrbRGjOw0LL2Tvb4TPTilRNx+zB3QrLC
         SE3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=C5j6gIA1b8ePCYuZs/fRrcTl474BqZvsLpDMgivFPTc=;
        b=lLhtQuFU8ydtnIZwU8R4kMrATtMQsuB+DjI0sMDC08cRg/YaFiWOWi4bMtC5qND2wj
         kCrQ5/5hzUP6xIejBAitKUm3IV1SauGhI6wzWtQgFuYLoNs/qsyAUpopQ2VbtArNzsiN
         bC5ckon3rov4973ON3gBm7aEnjjlr0lOOVlPeonQ4YDOo+DvqR2FuYx//fup8cGCbhaA
         2ahzkVwQwOkev71Qa6M/JmMamIyfsLfaLOLOdIG0vWHz01xyu+8Z6yv86x9APwnUT/wq
         sopaTVG+Lcg4T1/ljOzPcSfwW+xoZvCXkJIobiH+jwxYx1BvDaDuw0wPeweCJO4MYb8X
         WXuQ==
X-Gm-Message-State: AOAM531SlxQ+L5e0j6gwaxqsVTQhTWZop9x69VAMLDaDxuZxloEjzKmA
        6u5GUZbyGpMhvl7u3xudTQI=
X-Google-Smtp-Source: ABdhPJyYHMBq4cKuzyRFnzbxPFTlNfHvjRoE2xRmQvpYKa0jfahIqhRGhMO4fafmYkDBv3/RKOk6Rw==
X-Received: by 2002:adf:9bce:: with SMTP id e14mr23811694wrc.353.1633545596502;
        Wed, 06 Oct 2021 11:39:56 -0700 (PDT)
Received: from ?IPV6:2a02:8108:96c0:3b88::f816? ([2a02:8108:96c0:3b88::f816])
        by smtp.gmail.com with ESMTPSA id t126sm5773113wma.4.2021.10.06.11.39.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Oct 2021 11:39:55 -0700 (PDT)
Message-ID: <15f5374a-c52c-434e-1d6c-78f1d6d3552b@gmail.com>
Date:   Wed, 6 Oct 2021 20:39:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH 0/3] staging: r8188eu: clean up PatchID / customer id
Content-Language: en-US
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20211006090949.1694-1-martin@kaiser.cx>
From:   Michael Straube <straube.linux@gmail.com>
In-Reply-To: <20211006090949.1694-1-martin@kaiser.cx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/6/21 11:09, Martin Kaiser wrote:
> This series should be applied on top of the series I sent yesterday
> (starting with Message-Id: <20211005200821.19783-1-martin@kaiser.cx>)
> 
> Thanks,
> Martin
> 
> Martin Kaiser (3):
>    staging: r8188eu: hal data's customer id is always 0
>    staging: r8188eu: Odm PatchID is always 0
>    staging: r8188eu: merge two signal scale mapping functions
> 
>   drivers/staging/r8188eu/hal/odm.c             |  7 --
>   drivers/staging/r8188eu/hal/odm_HWConfig.c    | 65 +++++--------------
>   drivers/staging/r8188eu/hal/rtl8188e_dm.c     |  1 -
>   drivers/staging/r8188eu/hal/usb_halinit.c     |  2 +-
>   drivers/staging/r8188eu/include/odm.h         |  2 -
>   .../staging/r8188eu/include/rtl8188e_hal.h    |  2 -
>   drivers/staging/r8188eu/include/rtw_eeprom.h  | 55 ----------------
>   7 files changed, 19 insertions(+), 115 deletions(-)
> 

Builds and looks good to me.
For all 3 patches:

Acked-by: Michael Straube <straube.linux@gmail.com>

Thanks,
Michael
