Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91ABE410737
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 16:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239428AbhIRPAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 11:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232897AbhIRPAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 11:00:45 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7867DC061574
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 07:59:21 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id eg28so18660891edb.1
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 07:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=niEaq0kKF0iBjZuQ5Wc+yWHyu7KChWeCovcL9cnN++E=;
        b=N/E/clcVaUzIw1MZ0BMtPR/SsYJsDQgTVU0UloalL7Zpu93go3m/VVNuynwUkYmnKD
         VDmtJl1yEuHfvfiy8+gP6y7HS7D9eZ73qXzixTXLM7Q+M6zdDoaubXKejHqK2xjPnm0Z
         jli4RluD89eVd3ix1GPF/lsPe00z2n6E+bLhK2rcVHKz4NbNv85UAs7qt+3ve588ykFl
         PxMcBZJZgAah8bE4dnBHJBZtL8BHMvTfq0dJkvNq4TZch+9dvpwnhqp9LWPdrff54V8Z
         ZQfbL9meWdiyjj41mP8taNDbvrvhN9dWuaf8EdompyZ98N8xmpadXcs/dsTqRrppMXwB
         lLww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=niEaq0kKF0iBjZuQ5Wc+yWHyu7KChWeCovcL9cnN++E=;
        b=qMnSfSp9k/ykO0wyLAFYoGJmhq2nS0/mSOuVkIWyTMCUeSA1hgMPgtpYRXexgGsUf9
         icnSlmNDjCXDAQNgv9AiVGUq/Tb8a+TNuk26SRuRBUD2yCSJ/aX+YmNox7Yqlh1japhj
         1vyHRi01FXN3xf/nf+tm0JfWCdSUdMo5+pFtcnQPlN8K/lhWOIA5yVxV2bTyjiHS1gpN
         5yw1i6CMBAVJHpfAneMncgSj+qzyVLIyHRaHW2CNJiyx+zOphkmbuRPQ6aWXjLlA95b7
         zjhk2wcC6patAvf3x+bN4vFz91m10aMiacvIHs8dLuyFqcSp6490qsalnCIvBSz2bh/W
         zL9g==
X-Gm-Message-State: AOAM532HxMMcyxFPxI56utafV0UVchCPE0idJmtMxiz4UTq07OnMtlqr
        x9ZL03N1j6ggWFVeZHepxtk=
X-Google-Smtp-Source: ABdhPJyIRbr3ljVCgKs9CgAY+OiUSwsCODmJaBh0YO2QVEQe4grRflUHFfO3/Ww/OwuebG+if21TdA==
X-Received: by 2002:a50:d802:: with SMTP id o2mr18734216edj.95.1631977160139;
        Sat, 18 Sep 2021 07:59:20 -0700 (PDT)
Received: from ?IPV6:2a02:8108:96c0:3b88::cde? ([2a02:8108:96c0:3b88::cde])
        by smtp.gmail.com with ESMTPSA id p11sm3723781ejb.61.2021.09.18.07.59.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Sep 2021 07:59:19 -0700 (PDT)
Message-ID: <deba6fb6-8b6e-6b7e-67b2-53be87d9ac7a@gmail.com>
Date:   Sat, 18 Sep 2021 16:59:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH v3 1/2] staging: r8188eu: brfoffbyhw is always false
Content-Language: en-US
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20210911161019.26881-1-martin@kaiser.cx>
 <20210918135722.23976-1-martin@kaiser.cx>
From:   Michael Straube <straube.linux@gmail.com>
In-Reply-To: <20210918135722.23976-1-martin@kaiser.cx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/18/21 15:57, Martin Kaiser wrote:
> As a consequence of the bHWPwrPindetect removal, brfoffbyhw is never set
> to true any more. Remove the variable and code that depends on
> brfoffbyhw == true.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
> v3:
> - another rebase against today's staging-testing branch
> 
> v2:
> - rebased against today's staging-testing branch
> 
>   drivers/staging/r8188eu/include/rtw_pwrctrl.h | 1 -
>   drivers/staging/r8188eu/os_dep/ioctl_linux.c  | 7 -------
>   drivers/staging/r8188eu/os_dep/usb_intf.c     | 1 -
>   3 files changed, 9 deletions(-)
> 

Looks good to me.

Acked-by: Michael Straube <straube.linux@gmail.com>

Thanks,
Michael

