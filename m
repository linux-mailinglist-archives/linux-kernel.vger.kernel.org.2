Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE0EC34D555
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 18:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbhC2QoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 12:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbhC2Qn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 12:43:58 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E2D2C061574;
        Mon, 29 Mar 2021 09:43:58 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id o16so2642469ljp.3;
        Mon, 29 Mar 2021 09:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EJA04ZTI6BF3T7RTrxt/PRfIkpOFj2/PcmhPczxlcIE=;
        b=THtoF59AVOFrR2jstQBNOoDcCB3dQWh93fHaqXEcvO6bOXhPRvN/8TTsypthmcU/UM
         7owCSX8NkHl8e8J+iFGtj+lVPrVQnLR8m9FfUaHm2usLQF3/Ihx9eug/2HcW6JcqmMWl
         e1dSxyzypN/4jCg4LVG1Mi4NjAQCkdAeAMupYwoMRAmdRzvfbSutokQwCvgD71J9KIRc
         ioKEB6E5pMQ9ODdDJg49OAZPraUF1oMBiKUKb6VxvUQtncu5rNH1r/20pJLezAxSuChl
         wnwTupu+GYlnlJB90p5n1z7OfAxBC4ffWz0Fe7ambJ9mbYDgBBWCP3J2ve8YMcp+/Ahx
         TziA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EJA04ZTI6BF3T7RTrxt/PRfIkpOFj2/PcmhPczxlcIE=;
        b=CEuCs57A8k8rsiXT3e55r+NC0U+dGGTs69buvpaco1A2IrhxTqHa+qbVfZFvf1m3mq
         yRdyDHdGKwXHiXNJHbdwkxxwGMSFa8MPjdJLHCZcfETabb7RTf3nSi1g1/n3/p/gIxio
         NaMOBsDnpzQHfQjJrS9g7CS1avWXdCmfEOmmTixxQuyMmHVfMO3khXjwrwMUP9sNiinu
         ARW4j0+2jBzsK3AsPndPkYHWudwwmRjRz4tC5U4N5IDMIFZuLsiDu3lT5AzQB1Z6QrX2
         65+PWiLE9avFXDjpkFf4SYJPa0Q78FbxIqNL2V4Fj2SHoaLaMVt33cjbPDPOValgIV23
         L/OQ==
X-Gm-Message-State: AOAM530i+QE0ORin1l5Alli5AYaZZqNeqA9YmZl0elPUdn7BVEvUeeXp
        UZHCL2aHGMrpd975UASF1fBiPknYBWV/D2SribI=
X-Google-Smtp-Source: ABdhPJzS8PQfFWyMazbBa7Hc/f4knOhxnZndQbdzqKAFN6z6q+U1344mkldKZH8fX2YKnlVG0Nr19E2tf6O0Uy6Gu1s=
X-Received: by 2002:a2e:9a4e:: with SMTP id k14mr18376958ljj.116.1617036236649;
 Mon, 29 Mar 2021 09:43:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210329142604.28737-1-yashsri421@gmail.com>
In-Reply-To: <20210329142604.28737-1-yashsri421@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 29 Mar 2021 13:43:44 -0300
Message-ID: <CAOMZO5DLaw7uCBX03YgpY7ZvcjNW6gdsbOx9et+pgEGjRMm=dw@mail.gmail.com>
Subject: Re: [PATCH] usb: dwc3: imx8mp: fix incorrect kernel-doc comment syntax
To:     Aditya Srivastava <yashsri421@gmail.com>
Cc:     Felipe Balbi <balbi@kernel.org>, lukas.bulwahn@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org, USB list <linux-usb@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aditya,

On Mon, Mar 29, 2021 at 11:26 AM Aditya Srivastava <yashsri421@gmail.com> wrote:
>
> The opening comment mark '/**' is used for highlighting the beginning of
> kernel-doc comments.
> The header for drivers/usb/dwc3/dwc3-imx8mp.c follows this syntax, but the
> content inside does not comply with kernel-doc.
>
> This line was probably not meant for kernel-doc parsing, but is parsed
> due to the presence of kernel-doc like comment syntax(i.e, '/**'), which
> causes unexpected warning from kernel-doc:
> "warning: expecting prototype for dwc3(). Prototype was for USB_WAKEUP_CTRL() instead"
>
> Provide a simple fix by replacing this occurrence with general comment
> format, i.e. '/*', to prevent kernel-doc from parsing it.
>
> Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>

It looks good, thanks:

Reviewed-by: Fabio Estevam <festevam@gmail.com>
