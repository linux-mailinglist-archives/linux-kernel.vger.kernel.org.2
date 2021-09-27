Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69ED141A35D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 00:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238081AbhI0Wys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 18:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238079AbhI0Wyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 18:54:46 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA37C061740
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 15:53:08 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id ba1so17528483edb.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 15:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BQp8JYGJ+f5XdBPD0bizM23yOI7k4/ajn1w0TesKPeY=;
        b=kbJTghR3dU/D5TrYekFiEAtlWDbtsvyItG4oEXFY940XeNw3L4JlMh2Xnrv1cxwRdv
         zo1NZsM+54/HCOy2Cx4f0zUTT/2cNSUV3BZ9GqAHWp40cqChCcrC/VZxCfBLo+QdmcSv
         uxrKB3lpgbPa70heNUkpLcfFRf7KFIGYYm+CkyWbgzb1f635KYnh59pN/eEttndG6boR
         eu6944rpVRAsLvdQuBUAQHCdf3IVtZnFoYuQQD6s5JeIUDxTzQzRou44yM0r1YGuSitB
         TQr+Rdzrjdn4LRmR1074zCkVF+GAVpkRlDb2ya3fb5U1yUK1UM+J03F9dKb08DCwPDSw
         3M6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BQp8JYGJ+f5XdBPD0bizM23yOI7k4/ajn1w0TesKPeY=;
        b=j/6Ir+MTC4LcvchyG0brTbNl60aT0MsI0jlROaJSJD3yX4W1VALzRDUEEuh1M37HNw
         ybF9yTMKJOZwJfxy2jgPxEC2fGKQVJDw71aGi9HeIy/BRrgrgtE83oBkMJv2A4txkMNi
         ND/UFi7Uiu0Ty/OlQ4I2sukAW0NciMdUbP3nqVvu/0Qcvuw45hW8W+fSqQAChMERIwLf
         TUbEZRiGnmDrXrqz8URL4NPVMWo8NOe5nUSXewCRpUNQ8cQ2iS0bG/wNlAwtDbJBi5UC
         tCiF6MFr4QDvIlHReJvLDb60Lhi0IfJ7DRyU1pj6jK+jUDNTfYlSlbqR6EvgWsD415M/
         h0rA==
X-Gm-Message-State: AOAM533VxXFakkjvUsS2meg2AEcYt/2+KHael/1mDxZenzOK393D8aHX
        Xn0GXp9Nl7m29On/B790dC6QWYr3eY7FvS6JaBqNIQ==
X-Google-Smtp-Source: ABdhPJzWVsTL2K+FA4w/s5AUANxN3+EHPicSZHVZhSjG1fRcamTeuXdH1nsX/AlbqTw2gYKuZALxKiAtXPabE5PMYPI=
X-Received: by 2002:a50:da4e:: with SMTP id a14mr3480074edk.154.1632783187091;
 Mon, 27 Sep 2021 15:53:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210927210946.3746116-1-bjorn.andersson@linaro.org>
In-Reply-To: <20210927210946.3746116-1-bjorn.andersson@linaro.org>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Mon, 27 Sep 2021 16:52:55 -0600
Message-ID: <CANLsYkzkqYDZCzkVCtFODBui_THjEWrWRAgfxhZuebtUybTPrg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Update remoteproc repo url
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        linux-remoteproc <linux-remoteproc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Sept 2021 at 15:09, Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> The remoteproc and rpmsg repos are moving from my personal namespace to
> allow Mathieu to push to the projects as well.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  MAINTAINERS | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0f28fb4b4e5c..dfc93b8e4f28 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15987,7 +15987,7 @@ M:      Bjorn Andersson <bjorn.andersson@linaro.org>
>  M:     Mathieu Poirier <mathieu.poirier@linaro.org>
>  L:     linux-remoteproc@vger.kernel.org
>  S:     Maintained
> -T:     git git://git.kernel.org/pub/scm/linux/kernel/git/andersson/remoteproc.git rproc-next
> +T:     git https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git rproc-next
>  F:     Documentation/ABI/testing/sysfs-class-remoteproc
>  F:     Documentation/devicetree/bindings/remoteproc/
>  F:     Documentation/staging/remoteproc.rst
> @@ -16001,7 +16001,7 @@ M:      Bjorn Andersson <bjorn.andersson@linaro.org>
>  M:     Mathieu Poirier <mathieu.poirier@linaro.org>
>  L:     linux-remoteproc@vger.kernel.org
>  S:     Maintained
> -T:     git git://git.kernel.org/pub/scm/linux/kernel/git/andersson/remoteproc.git rpmsg-next
> +T:     git https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git rpmsg-next
>  F:     Documentation/ABI/testing/sysfs-bus-rpmsg
>  F:     Documentation/staging/rpmsg.rst
>  F:     drivers/rpmsg/
> --

Applied and pushed.

Thanks,
Mathieu

> 2.29.2
>
