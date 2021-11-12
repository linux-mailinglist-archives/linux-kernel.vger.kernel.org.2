Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D67FE44E2BE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 08:59:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233833AbhKLIB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 03:01:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbhKLIBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 03:01:55 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7A5C061766;
        Thu, 11 Nov 2021 23:59:04 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id t19so16580681oij.1;
        Thu, 11 Nov 2021 23:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=K3BG6NxpY8NKeo+Tqcp86/JjXR0k4/0cRXbuFf9kpkw=;
        b=T8eM0Ca8W3WasdquLqo3rqVZw/SxwkpBLztTbqHOvf3hoJth31paV+af8gJ2CROOf2
         G4d1Y5dfk1NwdYVrpUCykO7Wk7sImX8qcjpPqQ3H5bOKsXFl9C35KzvZda6oqOmvyrq8
         BADl/I9/XMh5ZhMRi2GTDg72LRhCquxzOYMjizmXNsDmrA46sc/UDFePylwvWG7U/KrP
         CS2lJwzfgRyEGJ6yUVqW0L0BD/g2nTqSHIG3YcbBUTc6iY5gYwnvIljpfnbJ8HoVRbzv
         SnL2Tg7G03W6Jyax/Txq9qLA+ui3hkkE1k5H5ccXJxSI+TI+YBqXUpLdEi1ScX/9d+p5
         hjNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=K3BG6NxpY8NKeo+Tqcp86/JjXR0k4/0cRXbuFf9kpkw=;
        b=oh9U6WB/etddYhwz2GJYh4szTj12t8AbuP/j/aUz2D+AzLJ6+TZLzjXcHmT9SAxwJO
         9U5yd4BkRbmIvjhakKE8V87yJXeE+AIqS81l1vG66WiagC3WBsWsOTKnrQenIoCnjSfK
         1ZH12Z3BqE1USOhGh32qWpYvi3mY2P9gCeAj4UfY529k+xk+0Z2kKfUyzr61rVZHIsoS
         OCEGrb9mWw/ESW2avZEd/1dfnpkKl2wj2UomA+c7/oKRUw1TtPQUvJLdL8HxK+VfZKof
         /vWibCe72sOhYSvj90qW7tY3hpE56V//sKOC1lVB4io3o0oZl9VB0knL5i80ApTaeibZ
         K1TA==
X-Gm-Message-State: AOAM5319IfgXXTF4HzrAbWhg5Mm4Tv9Rt11zsHEBArtNIIjiw4HCiuln
        n1I6zbT1WxidAimWfBbbn0HhTefh6TamO8gEB+Kdn2TeJYw=
X-Google-Smtp-Source: ABdhPJxgVzahm0dCklWl/h2IrGV7uB13NBpq1wp2AzbqiNNf1okVgAIr1d5sPfiSeXthsKDiIr+zNhlNoIy/kMmYnyE=
X-Received: by 2002:a05:6808:2cc:: with SMTP id a12mr11640076oid.126.1636703944304;
 Thu, 11 Nov 2021 23:59:04 -0800 (PST)
MIME-Version: 1.0
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Fri, 12 Nov 2021 08:58:51 +0100
Message-ID: <CAKXUXMxBW0qM06i7TvFG+8HrwbR1eYR+9Ed648aZ95mtXiA7Tg@mail.gmail.com>
Subject: Removal of config MACH_FSG and dead reference in LEDS_FSG
To:     Linus Walleij <linusw@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linus,

Your commit b71377b3e1e0 ("ARM: ixp4xx: Delete the Freecom FSG-3
boardfiles") removes the config MACH_FSG. Hence, the config LEDS_FSG
and its corresponding driver leds-fsg.c is effectively not selectable.
I do not know much about how with device trees we ensure that specific
drivers are selected, or how Kconfig build dependencies are combined
with device trees properly here. So, I do not know what the right
patch is here.

Was it intended that this code is now made obsolete? Can this driver
really be deleted?

Or does it require just some further adjustment to make the leds-fsg
driver productive again?

This issue was identified with ./scripts/checkkconfigsymbols.py, which
reports the following reference to an undefined config:

  MACH_FSG
  Referencing files: drivers/leds/Kconfig

I am happy to support creating a patch, once I understand what needs
to be done in this case.


Best regards,

Lukas
