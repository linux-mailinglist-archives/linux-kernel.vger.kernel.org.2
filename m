Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C47203496DE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 17:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbhCYQcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 12:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbhCYQbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 12:31:38 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE6E4C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 09:31:37 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id l1so2334566pgb.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 09:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1rk0lMdfic6T8FzgQX46kyAy/H7cmQtjKeViSHPt/tc=;
        b=Oymlkos7+dYkFe689RLE6JqTySCe5lGo30nijzNu/xlA67II/D0MTcuokaPt0Ec7An
         22NENOJwiiU6SBiMqJ6jr0ykPSNnm0HSU4TzBMtNqUOwaMzRNvyULYgtNyw52HD3oPq+
         /Sbj7D+lqzfGxHDdq9I+yQaBhdIo4/IGyRHoQZxhTfbJm51OFCKz91kFe46Oq4Kh5Z7M
         qO23FtQz7six/ftkTZcf/QA4MWzAgWDtJlJP+nNRQkhz39sd0E4uhUaq6cQgDNmkwSiF
         vf5rbhwaGBYbcjD6kuW2y63/lBLm1jQURAOW9INo5W90QZb/am8HkPhzaC2CgSYQeLxy
         xLDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1rk0lMdfic6T8FzgQX46kyAy/H7cmQtjKeViSHPt/tc=;
        b=RvvJXYE9V94wnwQujdb8EnqeIcnWux/nEfmo0BNGQY5YUI1X2CaiUtlt9Rg9q5EroX
         Wio2cDDXz9czLLgyo+It/8Wslrr/QcqYcDO1DmmokaBwZAb8x4d+Mn4K3VtiK3C9QlGG
         D6mzBuea2cCsajFxfA09MR1lHnsfIax/t7YQ1F+JaSUt4+QkxY3VEbjvOd0W690aSoWV
         UDwo6gzamJFaLTo1QpG6m9II+oNWANlrk14S1IGkuM8ZSW8bRElImBn6s1mg0FbPA3MC
         dAL93Pgyee5e5flUWmlyQP26K0hMlsf3UPub/chgdPPPZ+ksD+BLxS7lBptGV8fU+1tH
         Xh9A==
X-Gm-Message-State: AOAM533H9mj63hAdjNkebTaamqtMPXCGmqNBO7FwwnqoWDkt77sfNRYd
        aQiZ4PyQBdB+ZD/t5EXB5+KZ+X7hTd5lz4Zb5bIlPw==
X-Google-Smtp-Source: ABdhPJwEMYCDOMvtNtf62LxlQetuFPcjrxC72s4cpA+AUgsRz7y/xZBYsBvAVTWJ8AOGwiqKr5YWUH+koOSXOkvwlLM=
X-Received: by 2002:a05:6a00:b54:b029:207:2a04:7b05 with SMTP id
 p20-20020a056a000b54b02902072a047b05mr8916394pfo.12.1616689897368; Thu, 25
 Mar 2021 09:31:37 -0700 (PDT)
MIME-Version: 1.0
References: <1612689000-64577-1-git-send-email-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <1612689000-64577-1-git-send-email-jiapeng.chong@linux.alibaba.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Thu, 25 Mar 2021 17:31:26 +0100
Message-ID: <CAG3jFyshwH3szLESkYXjFokVbBqELHswpwkLDAArJg+dWJ3nbw@mail.gmail.com>
Subject: Re: [PATCH] drm: bridge: convert sysfs sprintf/snprintf family to sysfs_emit
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pushed to drm-misc-next

https://cgit.freedesktop.org/drm/drm-misc/commit/?id=fffa69aa6b1c89853cd00dea969e4754633596d7

On Sun, 7 Feb 2021 at 10:12, Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> Fix the following coccicheck warning:
>
> drivers/gpu/drm/bridge/lontium-lt9611uxc.c:858:8-16: WARNING: use
> scnprintf or sprintf.
>
> Reported-by: Abaci Robot<abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/gpu/drm/bridge/lontium-lt9611uxc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
> index fee2795..3cac16d 100644
> --- a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
> +++ b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
> @@ -855,7 +855,7 @@ static ssize_t lt9611uxc_firmware_show(struct device *dev, struct device_attribu
>  {
>         struct lt9611uxc *lt9611uxc = dev_get_drvdata(dev);
>
> -       return snprintf(buf, PAGE_SIZE, "%02x\n", lt9611uxc->fw_version);
> +       return sysfs_emit(buf, "%02x\n", lt9611uxc->fw_version);
>  }
>
>  static DEVICE_ATTR_RW(lt9611uxc_firmware);
> --
> 1.8.3.1
>
