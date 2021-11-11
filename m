Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DFCA44DC87
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 21:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233343AbhKKUes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 15:34:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231754AbhKKUep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 15:34:45 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9738C061767
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 12:31:55 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id q124so13753161oig.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 12:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UbyzGu3N0WG7w9a548DYe86BOPNj4uEfZNAhmdT33UU=;
        b=FbLSf0Z6YvJ3bQWiFHND2pElxVlQ9IWrax5XKJ1ehwffexys/MBTQoc7C3URclEpVa
         mpRQAaJMzuppbUY5dAN9eEgA6coQQNJeASZ1gG5aaPTIMkFCsyHxoMGni+IBQZRv+RSg
         A3VregAuKJNZULaIcTTylTN+/kolCtEoZR0OhR+FNradtzUvjthGLj+1urAV6jkVmpGi
         amNR8C5FSVDtJN+HrbeYbms1cLV7uOcT+BNyBTOdql8h3+AIxxJrhj/4sT4Pf5arPltg
         7KqsgKlVR4PyFqd+IMnDcLWnhzHFjxcu5czPN2GrnNE2D3a2YSEMysqYRhb7EKeLpxl3
         tzUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UbyzGu3N0WG7w9a548DYe86BOPNj4uEfZNAhmdT33UU=;
        b=aHN8R+WubOpZe0eb/Qd1620T28YyyBv0BknqDB4qbVDNQKuGJHu+KdCNPf+45p3c5D
         D94zQFYdScJ6EoG1CNsM20CPHD9GNZKQYtrUAMUkghSvRXImEgOTPsRrdGxQUCKnHPuc
         TFRTRcuSu86OhtiEiYLdxpZScHbQHiYBQE+/tp0KU7vYnjUq1utN1lV/d9ZBUYDn/B7j
         ie7IIAgtTNYOReZMrOERFsgih27WIUc6IplP0Nt/Zzuz9f+YoJNw8TOtBcUwKrHSRmUZ
         9iZFgOK/qoDqRgILS5BNV4OrjOBcGoC7iqoNaV8dv0SibIH2mLoUyQw+JiEUcZkb0NF7
         2MfA==
X-Gm-Message-State: AOAM533HCvaniBxtmYXE68umYYYidemFjPlYREgirx7E2zvm5yJ36K2Z
        HxJpNRcAY4fGhSdPKw0kY2lnLtRPhDywRbo3cTpi536np+E=
X-Google-Smtp-Source: ABdhPJxmIHWrFPEygsIUhcXRMfVgLnn0WRIXb3HRTWJDJnpws25W1kOso2NAuizh0Dk5vPUNPOxsEo0j8EYQYsUd5y0=
X-Received: by 2002:a54:4791:: with SMTP id o17mr8692071oic.114.1636662714953;
 Thu, 11 Nov 2021 12:31:54 -0800 (PST)
MIME-Version: 1.0
References: <20211111202506.19459-1-brgl@bgdev.pl> <20211111202506.19459-2-brgl@bgdev.pl>
In-Reply-To: <20211111202506.19459-2-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 11 Nov 2021 21:31:43 +0100
Message-ID: <CACRpkdaLt5Ra2S8h=8N6ek6r6aYXxg1e8WD76eP8JSau721Xew@mail.gmail.com>
Subject: Re: [PATCH RFC 2/2] gpiolib: check the 'ngpios' property in core
 gpiolib code
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 11, 2021 at 9:25 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> Several drivers read the 'ngpios' device property on their own, but
> since it's defined as a standard GPIO property in the device tree bindings
> anyway, it's a good candidate for generalization. If the driver didn't
> set its gc->ngpio, try to read the 'ngpios' property from the GPIO
> device's firmware node before bailing out.
>
> Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Nice!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
