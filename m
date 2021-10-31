Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 927F6440F7A
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Oct 2021 17:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbhJaQln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Oct 2021 12:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbhJaQlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Oct 2021 12:41:40 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0405CC061570
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 09:39:08 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id e144so18848197iof.3
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 09:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HuyhslhAk1Pp7puf3EU8lOlEEWbwv/ka8qF3oPU6dZs=;
        b=Vou91/NsTERRgFjIEMMJYijC6WjqDEzuxRVCM/RmxzkfXLyFccHPYzx7vAw0QVKVLQ
         /OZVAw+IfFehYNdZeie5/EcuNUlQXfAEBI6sAOZ17LJoQwWvOSHInZ0aZEni4vTM8ezd
         /SwCT0yckmvmqHUUUoENOlOmDJF/W3x4VqPzWF1kl7OGfnWq2KOXG+Vs7cBPQE86U36W
         6+kQ22eDtvhf6YKq2Fpl5mjVudYwSgTI9wRch1W6U+LXvLGNpCczXL1pgu+q/Q76mS2u
         KbYSQK9wHJsRIv9PKQf57zLVgTka1U3SNgbuKp/k7BL8tFrVesAXalEyyKs6/obNaYe7
         NHSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HuyhslhAk1Pp7puf3EU8lOlEEWbwv/ka8qF3oPU6dZs=;
        b=4xXyczH9AjrCmyvnWjZBsSZoQnHRN1lmcyEA8dE0wbbm0wmjqeWnU3WDNJZcFe4QGQ
         OMa9mhg3yP9oN5ge/LvWJACfodmWMySWGLXLYtsADOETb0ymOE9hY2eHZBNCl2ueO00G
         HkX5jAZsmkyrNLna/hv25/FHQoeMhpuVIPZnvTnVG/DjSKtv1QNrcYXsv42cRIzCyZ6t
         +AXdRmWp93ptGIz1fEnKH3jqUVPGUAI2XNcezhMPLU3rTFbO27hJ1P2xWsOkCMquFm5M
         OaIjFYz3F/7YgWyb7TCIHwrBSt5GQ4vFdj+CfszXEjDmD+NrXYaxWCG+nBKCF2LX4ClI
         MGTg==
X-Gm-Message-State: AOAM531ykls6io0ydNh2r3PNjWSPwKpebnrq9h60arkjmCkmN+PYrbqf
        sy4ok95gDLIGdHAkGloVQpN11PdP1iUwkrywbQ/5mAJMOlo=
X-Google-Smtp-Source: ABdhPJwqGv6gqpPoGZe1MtPv8GGrap1s8oktElCK9G83ZG64N9XZXjHENjNBryOeiWr3/Tqj1TI/GrskG013jO9+obk=
X-Received: by 2002:a5d:8903:: with SMTP id b3mr17683659ion.44.1635698347506;
 Sun, 31 Oct 2021 09:39:07 -0700 (PDT)
MIME-Version: 1.0
References: <20211029215516.801593-1-cmirabil@redhat.com>
In-Reply-To: <20211029215516.801593-1-cmirabil@redhat.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sun, 31 Oct 2021 17:38:56 +0100
Message-ID: <CANiq72=cp+LTQhGMMmtWHLAk+AE81HOVB+2f06kQ9DXtBz+NyA@mail.gmail.com>
Subject: Re: [PATCH 0/5] Raspberry Pi Sense HAT driver
To:     Charles Mirabile <cmirabil@redhat.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Serge Schneider <serge@raspberrypi.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        linux-rpi-kernel@lists.infradead.org, fedora-rpi@googlegroups.com,
        Mwesigwa Guma <mguma@redhat.com>,
        Joel Savitz <jsavitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2021 at 11:58 PM Charles Mirabile <cmirabil@redhat.com> wrote:
>
> Signed-off-by: Charles Mirabile <cmirabil@redhat.com>
> Signed-off-by: Mwesigwa Guma <mguma@redhat.com>
> Signed-off-by: Joel Savitz <jsavitz@redhat.com>

Please note that you need to write `Co-developed-by: ...` (see
`Documentation/process/submitting-patches.rst`); otherwise, it looks
as if this was sent through several layers.

Cheers,
Miguel
