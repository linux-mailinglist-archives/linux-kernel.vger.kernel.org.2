Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 635FF3F3BB1
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 19:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbhHUR1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 13:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbhHUR1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 13:27:54 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7925CC061575
        for <linux-kernel@vger.kernel.org>; Sat, 21 Aug 2021 10:27:14 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id om1-20020a17090b3a8100b0017941c44ce4so15910489pjb.3
        for <linux-kernel@vger.kernel.org>; Sat, 21 Aug 2021 10:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HLWCn02MgCPOMWc3SzwkfWYw42/4p4VBHBuNhVkmEPk=;
        b=Vk3YbIKE0MG4qacLCkB6pkFHgrD1C1Lid8H5AchZ12QaAu3YGhYnvrnMYeupTk6V0Q
         LfO7CEAdRHYtDWfel5YHGFmTwaGoBoP24sTvy6q/qRplgTjIU8R/mbIeZuDDgCV0PhQy
         wPgRrDcqhrC7BUeuGzectdbvY9p+EvBneFbxi4muvSPY6SwlT2RWZfvB979FXC5JyZ9L
         9Y8VTQuh+56wWWpfSTu/1juiJJgc1CE1Au9adDE/XAYO6x4e6NBZ4+Apqi2vmbHzJu6S
         OIGbW2Sh1OlpW2KsvWua8WuwVysVFcq9nkSwU1IuJ2W97SD27KvZ0FdWMOSY6A7IqZtL
         ibSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HLWCn02MgCPOMWc3SzwkfWYw42/4p4VBHBuNhVkmEPk=;
        b=af22RVNkkSQKsu7vNeCNCCZs6NtBimxp0AgyJTSCHGFDakE4ZorHkA69S4d7FA3f/7
         g4HkPedQbkC4rauzXg2NKdVU/iWbhxosaL4q4/oK4psYiKujQ4FYu792NFl7UEt1F+cz
         eBRcyGEPWPpzm5oAmcg/dVXnBds8t3hfRDUITA2CQEl1IGGGD1syAMED5jJB5iJmcjB2
         5veqGdTbeSNyI0AHh2kWrj7RzT7vL6R8IIb8OKx9y6Fau7Qy+hJMdDsnwKO86pB4fn7e
         Y4MLeX0Dl3gvUh437Jh9E3hkyEvjTHYwajg4x/9p4zFgZNUo6u6RcVcSXPUpetcwe3v7
         iWxA==
X-Gm-Message-State: AOAM531YsnmXb3WGTLhi+wskW5ItEAgoKzrm5K2cJSeCqV8LP3mvVnJq
        kB8ZG9ntZt4HA9iOdZG+kXJhgYieY44Ie4KRGMSaxg==
X-Google-Smtp-Source: ABdhPJyTTIoTWdj9P9z98L4sZipGb1Y2PcrZtOZxfVNO3x4w4cC9prKMVZlGLvNS8E9xh8EwcIqUIt3KLwCfrRIccOM=
X-Received: by 2002:a17:90a:1b2e:: with SMTP id q43mr10902605pjq.217.1629566833962;
 Sat, 21 Aug 2021 10:27:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210821164859.4351-1-martin@kaiser.cx>
In-Reply-To: <20210821164859.4351-1-martin@kaiser.cx>
From:   Phillip Potter <phil@philpotter.co.uk>
Date:   Sat, 21 Aug 2021 18:27:03 +0100
Message-ID: <CAA=Fs0mU0bkXPY35fkuudoWfAps2jp1qc3ga53LXgg6d+0bVSg@mail.gmail.com>
Subject: Re: [PATCH 01/10] staging: r8188eu: remove unnecessary cast
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Aug 2021 at 17:49, Martin Kaiser <martin@kaiser.cx> wrote:
>
> name is a const char * by default. This type should be ok for r8188eu.
>
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>  drivers/staging/r8188eu/os_dep/usb_intf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/staging/r8188eu/os_dep/usb_intf.c b/drivers/staging/r8188eu/os_dep/usb_intf.c
> index e002070f7fba..72556ac10d7d 100644
> --- a/drivers/staging/r8188eu/os_dep/usb_intf.c
> +++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
> @@ -61,7 +61,7 @@ struct rtw_usb_drv {
>  };
>
>  static struct rtw_usb_drv rtl8188e_usb_drv = {
> -       .usbdrv.name = (char *)"r8188eu",
> +       .usbdrv.name = "r8188eu",
>         .usbdrv.probe = rtw_drv_init,
>         .usbdrv.disconnect = rtw_dev_remove,
>         .usbdrv.id_table = rtw_usb_id_tbl,
> --
> 2.20.1
>

Looks ok to me, thanks. I would consider using a cover letter style
[PATCH 00/10] style approach as an addition in future though, just my
personal opinion.

Acked-by: Phillip Potter <phil@philpotter.co.uk>

Regards,
Phil
