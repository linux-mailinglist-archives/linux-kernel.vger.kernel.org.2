Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D91F1430882
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 13:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242053AbhJQLxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 07:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234082AbhJQLxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 07:53:07 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C729C061765
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 04:50:57 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id e12so35678496wra.4
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 04:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=AgJY+3LmnHhiBRJB7wkS46xzFah8QYrk5hhJpw/OHRY=;
        b=k9nNBL2pxviVm04SLtM++62czmZb83RsYv/D9oYls/sSrJEA/iQTWbuSPhrwUS0HiU
         od3o5eAh8L4IL7MBVn6+uSSrnbPdFRgAWNmLRALjqC7x+0UMK/Ru4a1e5GXUyBcX194D
         NnJIyG+seP9hkGYVbpg6Up7Lkj3Sv5wHVQUiwqHiwBysQwRYnoNX6asUsT//bAduqKPl
         PvWx3YWr5Uu7oSMALJa7esTjIoQJynrL/qopFLHnGr+mahPJh/X9/slKvAnjoyrxsA8y
         ri3Kx73dAo+Te+kJXCAodeOPB2nbeoNtdPX7VYmOkRSQ/Ty2X/TGA/2+6ypWatR6LgPm
         aTRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AgJY+3LmnHhiBRJB7wkS46xzFah8QYrk5hhJpw/OHRY=;
        b=i4WkT8vl6hqrQuVmBR+UyolcBqyS/RV+QJ1Nc/+WSdOglCcDgJ0hwasVSQz/bsbnv1
         W6tdoQZW5XrS9yU7zv1vxjRewGBE/vJSc1s7q8pqXHsXAP90ZrKgUw/7nvr++UvxZS58
         fgDHZHKSIkNcTZS+stItui2gupSQcavbVrc4RfCzveO+W7VnTEexmFDwQ3Wf2yCynam7
         kjkMpcdW4QXVJ4d515e4rN56bY/6jbfBFrV7xySO7zkzk9K4Ktc6h7n+TWtxWIlNeBwv
         J0olGAXxTj+2yEvSjfdwgRpmC3P1iXJ6RZyiBLk+FuF1IUmkC0JUo6Flin7oIkJ8Qems
         gDFQ==
X-Gm-Message-State: AOAM531p0feTTjaTFpdjdMpi/J6yXsdkpUzaQlSnsuOR9TnbFgYhRP+6
        KN19L0lzwjq3c+xrcobA+0o=
X-Google-Smtp-Source: ABdhPJy5G2kOcMglkVyl3ZrZbMyy77zZAL2pZ3cT2guiGkxiJQ+WCgEjzurMyvi/FFbFddc98ZLdCQ==
X-Received: by 2002:adf:ab46:: with SMTP id r6mr27887392wrc.71.1634471456130;
        Sun, 17 Oct 2021 04:50:56 -0700 (PDT)
Received: from ?IPV6:2a02:8108:96c0:3b88::d7f0? ([2a02:8108:96c0:3b88::d7f0])
        by smtp.gmail.com with ESMTPSA id c17sm11386053wmk.23.2021.10.17.04.50.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Oct 2021 04:50:55 -0700 (PDT)
Message-ID: <69502994-bbe0-42f3-4c0f-9a1e68798a4b@gmail.com>
Date:   Sun, 17 Oct 2021 13:50:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 4/8] staging: r8188eu: remove unused function prototypes
Content-Language: en-US
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20211016113008.27549-1-martin@kaiser.cx>
 <20211016113008.27549-5-martin@kaiser.cx>
From:   Michael Straube <straube.linux@gmail.com>
In-Reply-To: <20211016113008.27549-5-martin@kaiser.cx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/16/21 13:30, Martin Kaiser wrote:
> Remove prototypes of functions that aren't present in this driver.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>   drivers/staging/r8188eu/include/Hal8188EPhyCfg.h | 8 --------
>   1 file changed, 8 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h b/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h
> index ee4b26ecd19d..084bccc5dcb9 100644
> --- a/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h
> +++ b/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h
> @@ -194,18 +194,10 @@ void PHY_SetBWMode8188E(struct adapter *adapter,
>   
>   /*  channel switch related funciton */
>   void PHY_SwChnl8188E(struct adapter *adapter, u8 channel);
> -/*  Call after initialization */
> -void ChkFwCmdIoDone(struct adapter *adapter);
>   
>   /*  BB/MAC/RF other monitor API */
>   void PHY_SetRFPathSwitch_8188E(struct adapter *adapter,	bool main);
>   
> -void PHY_SwitchEphyParameter(struct adapter *adapter);
> -
> -void PHY_EnableHostClkReq(struct adapter *adapter);
> -
> -bool SetAntennaConfig92C(struct adapter *adapter, u8 defaultant);
> -
>   void storePwrIndexDiffRateOffset(struct adapter *adapter, u32 regaddr,
>   				 u32 mask, u32 data);
>   /*--------------------------Exported Function prototype---------------------*/
> 


Acked-by: Michael Straube <straube.linux@gmail.com>
