Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC1C42A037
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 10:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235033AbhJLIsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 04:48:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:35572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230043AbhJLIr7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 04:47:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D07D4604D2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 08:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634028357;
        bh=ULMfajxXFfQnKWwyvWuwZXs1MwYLqkiBLOaPfeLHv2Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=R04ZOORPm2YoynLNPwKWFZcNnNN7ROKnhL4T/0BROgclAuu1rgkcqY2xfFtMorayZ
         7512GBQZbbsRGNsPscNXM2bY+yXNL4M9XRHdfJz3968c/BisaXdvrrkQofK4f9Z8h2
         tCLKMh+/SvhW8PJSfxpUSlXAn743CdSFsEt7EM3ZE792oHXJkRlqcER1jyqg8w4uAC
         CbaW9V3l7M6dPoEiNmZsidyOY26QNmrjSXJz8fuWmIAEQzYQkJsQgW08zqaNAKIXjO
         rdsD8u/85EYJ83k4OP7nYEZE08hTa+86sGlgs/Sl6/ZOi+fBmyy6dLCJ6B/ZOYW9up
         VpYmX4UlT+mfQ==
Received: by mail-yb1-f178.google.com with SMTP id a7so45063259yba.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 01:45:57 -0700 (PDT)
X-Gm-Message-State: AOAM532EKZ2kwQWZdoVJAHpA9e1ptkNW6frXafVVEwqd2EJE7AimXP1s
        XQodalG7OKL2V8VRMFfY9nDB3nKNA8u4C/nGgE4=
X-Google-Smtp-Source: ABdhPJwYlJZ5/sEPPMa9gJh5LP9+DG6O+KdtcXjeXNIfq1iYHwR3JB/2IVkPEECk3sniQto9rWiBBQ0djIRQP747gxo=
X-Received: by 2002:a25:4507:: with SMTP id s7mr27915623yba.445.1634028357090;
 Tue, 12 Oct 2021 01:45:57 -0700 (PDT)
MIME-Version: 1.0
References: <20211011151443.12040-1-vegard.nossum@oracle.com> <CAK8P3a2+dU53PMJZvkDDGUyv=EiHuc03njGf6SXTxw9A4ByeHw@mail.gmail.com>
In-Reply-To: <CAK8P3a2+dU53PMJZvkDDGUyv=EiHuc03njGf6SXTxw9A4ByeHw@mail.gmail.com>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Tue, 12 Oct 2021 11:45:30 +0300
X-Gmail-Original-Message-ID: <CAFCwf10RESQdvb9J6nYQ3q1gvCZ0E3EQ0tA+b7hrUdVF_7ZhWg@mail.gmail.com>
Message-ID: <CAFCwf10RESQdvb9J6nYQ3q1gvCZ0E3EQ0tA+b7hrUdVF_7ZhWg@mail.gmail.com>
Subject: Re: [PATCH] habanalabs: select CRC32
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Vegard Nossum <vegard.nossum@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2021 at 6:33 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Mon, Oct 11, 2021 at 5:14 PM Vegard Nossum <vegard.nossum@oracle.com> wrote:
> >
> > Fix the following build/link error by adding a dependency on the CRC32
> > routines:
> >
> >   ld: drivers/misc/habanalabs/common/firmware_if.o: in function `hl_fw_dynamic_request_descriptor':
> >   firmware_if.c:(.text.unlikely+0xc89): undefined reference to `crc32_le'
> >
> > Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
>
> Patch looks good to me, I wonder how I never caught that with my own randconfig
> build testing. May I ask how you found it?
>
> Fixes: 8a43c83fec12 ("habanalabs: load boot fit to device")
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Thanks!
Applied to my -next tree.
Oded
