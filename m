Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0E0F3CAFBF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 01:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232397AbhGOXt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 19:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbhGOXt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 19:49:57 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A801C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 16:47:02 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id l18so8539375iow.4
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 16:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hagqR0rIEofPLGA0i4if5oDt7BNWphhYllufZmpy6Wg=;
        b=ik6ORfHl60Ja+N/arCXf4ZaNnLb4zb1i/c2izCQ8Ep3z83IRpKfkccNluJcGVWjEfV
         3J3Wj4eObC/gV3rLZEhgqtKysCBIBfNkB4HkRAeNf2cr9xM828RQvTA0xRh6k2hCc5cX
         wmDpHglzTPto0HrmoRqCPqQtYcy/0kqLgaXvfUhfc3l3RpJJfKoTw3z43HddlHXb4ICw
         zNCYtdOU6DNT8jfIuy1ApG5L8rL5GztbBPeqNAcz+lCpf8SaxlCcyi6wp7x49jiGPXe0
         SMY1447gH2pTlsTHTBXPGnwDYy/Vhiyn2Cr3wdCwein2egBBZnpcpVgw3qrS3LU+/xvY
         jlLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hagqR0rIEofPLGA0i4if5oDt7BNWphhYllufZmpy6Wg=;
        b=K8o5v7Lw+sqqMW9jqesytbZQtlnSzGArF0cBmO1Xkq5VR6+GdKnRheIus7rxox5O+W
         DyCEa87YPl5//gfaAn4L4+bnTCfMue6zEQ/MUr1BSNUHj3UXGxAC0rBbgha9lkxXT6CM
         ou1kP9oiZbi2mYFx4hFvhDnIrifw94mWBUTmDzehr/tmrBM2SuGxnXXtDdKN/3Zqf0FV
         4EKr5VR9yHj1808K1QrUx9HizMwJjddOu3InUl54ce6d+56PsE6MIuhOfsr48PH/aOTd
         Ubu9j9/JLkwfGmyHfVQq10xUCd6i3UnubORDutcN3qrt3j0NUUq/FR1jB8/gdZ7CVPbo
         yXHA==
X-Gm-Message-State: AOAM530oepGAEZ8I/RqT/Cmtqsf+5wFcVJJ/XIkcm/YvNmes0n0AhXil
        Ba81S3oxYvuWS3KSAJhySfzYzSj+pFLVLusepNA=
X-Google-Smtp-Source: ABdhPJwQ5JwGnub0fM/nEAdXvOzAL0Z6QL54NBLcvmxp4ASM5kc/RE2E/KPLyylDGZpS2wj8FasqoTUoJUAf0+fETnA=
X-Received: by 2002:a05:6638:240c:: with SMTP id z12mr6177770jat.41.1626392821872;
 Thu, 15 Jul 2021 16:47:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210616141548.39787-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20210616141548.39787-1-andriy.shevchenko@linux.intel.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 16 Jul 2021 01:46:50 +0200
Message-ID: <CANiq72=TTH3EezpHUepjq3dPouV5V=Say_whcaHf5RnP4b7V6w@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] auxdisplay: ks0108: Switch to use module_parport_driver()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021 at 4:15 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Switch to use module_parport_driver() to reduce boilerplate code.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks, queued (without the newline unrelated change at the bottom).

Cheers,
Miguel
