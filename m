Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1DD642514C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 12:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241005AbhJGKn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 06:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240987AbhJGKnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 06:43:12 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FEC9C061746
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 03:41:18 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id e12so17651015wra.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 03:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=21L/ntXDB6O/WZavBXYDV8nwPWCxwlOT56pjE95r/Ew=;
        b=Z7JGYSlpSaN58lUY8OlrR5Zqr6QcD/wNCS7BzNZe2YxfhcVeogEhQo9SjnxzqCI18C
         XBbvzSmOpRmA9UgLsJj7ZMcm4ksLyFBwOeyjUh45pkUotS3sJQRgCWfKHc7pHscVRLyf
         HdP0GvRBdwR1ybmK65hjcEO0ecg3ZycAJRvtknyJwdGVyrrE86HoNMkY74Y00yQhYgzH
         leGOpsg/i/+z0FRJSmpQp8rXFeugFuT9zLeUxBtaaMJKN28TnMEjVN751amObREpc/ur
         PXJQ7hD3JVRqt/MnOj6tzz/Yw4Q727YXxk7lyf71/EcbK0O4cQ2CQgJQqdFSyfbbwBYf
         lkiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=21L/ntXDB6O/WZavBXYDV8nwPWCxwlOT56pjE95r/Ew=;
        b=xL+niO+wTXVKzLb2uY6RXyiuJ2OQVX6ik277SYu6qNEy8tLfrEGUG/bCE9fyX/ocwf
         9HYlwQCdRIr/LejzoZL+YPFQSuYB8gT2J42gQdlAN8DzrPRWrTtgJuSF3U7g3K4CObMA
         CplSt2MiosJo7zpIP0tqa2MD9JsTo9rkY4+2pbO0k+vq+WkexZJCuhmHfRYjj/Cs7HQr
         aqmP+l/UFmItnUsC3kDkrRi6XUTpupDUZoecn/uFUuTtLq5is/HFM7xSfRYp89Nhqt7z
         BqmZjs8kVgB2fRNEDPWvRE/y+Z7RyQ60Vb4vTab3/y9bJtsH3C+K6XSDZEmiwvUxGdK1
         GuiQ==
X-Gm-Message-State: AOAM532jx/WttR6XKdNrAPLyd8k/0AG5/rentuWEQ1p0HW2VVuhtwsq/
        wnyKlZCxWAIz32JLZvZX+kU=
X-Google-Smtp-Source: ABdhPJx10zvbHlwoDfIqbyaGT7g8BgydfaX6FWXITOunxGSmNO0T7KN7oNQg5GPWS0FX1jQ0Hkf14Q==
X-Received: by 2002:adf:f48d:: with SMTP id l13mr4316740wro.94.1633603277250;
        Thu, 07 Oct 2021 03:41:17 -0700 (PDT)
Received: from ?IPV6:2a02:8108:96c0:3b88::5d0b? ([2a02:8108:96c0:3b88::5d0b])
        by smtp.gmail.com with ESMTPSA id y6sm13085981wro.63.2021.10.07.03.41.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Oct 2021 03:41:16 -0700 (PDT)
Message-ID: <620e62d8-6662-004d-38b8-369ad53ce738@gmail.com>
Date:   Thu, 7 Oct 2021 12:41:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH 2/2] staging: r8188eu: remove GetHwRegHandler from hal_ops
Content-Language: en-US
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20211006203510.9083-1-straube.linux@gmail.com>
 <20211006203510.9083-2-straube.linux@gmail.com>
From:   Michael Straube <straube.linux@gmail.com>
In-Reply-To: <20211006203510.9083-2-straube.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/6/21 22:35, Michael Straube wrote:
> Remove GetHwRegHandler from struct hal_ops and remove the wrapper
> rtw_hal_get_hwreg(). Call GetHwReg8188EU() directly instead.
> 
> Signed-off-by: Michael Straube <straube.linux@gmail.com>
> ---
>   drivers/staging/r8188eu/core/rtw_ap.c           | 2 +-
>   drivers/staging/r8188eu/core/rtw_cmd.c          | 4 ++--
>   drivers/staging/r8188eu/core/rtw_ioctl_set.c    | 2 +-
>   drivers/staging/r8188eu/core/rtw_mlme.c         | 2 +-
>   drivers/staging/r8188eu/core/rtw_mlme_ext.c     | 4 ++--
>   drivers/staging/r8188eu/core/rtw_pwrctrl.c      | 2 +-
>   drivers/staging/r8188eu/core/rtw_wlan_util.c    | 2 +-
>   drivers/staging/r8188eu/hal/hal_intf.c          | 6 ------
>   drivers/staging/r8188eu/hal/rtl8188e_cmd.c      | 2 +-
>   drivers/staging/r8188eu/hal/rtl8188e_dm.c       | 2 +-
>   drivers/staging/r8188eu/hal/rtl8188e_hal_init.c | 4 ++--
>   drivers/staging/r8188eu/hal/usb_halinit.c       | 4 +---
>   drivers/staging/r8188eu/include/hal_intf.h      | 5 +----
>   drivers/staging/r8188eu/os_dep/ioctl_linux.c    | 4 ++--
>   14 files changed, 17 insertions(+), 28 deletions(-)
> 

This patch is outdated and can be dropped.

Thanks,
Michael
