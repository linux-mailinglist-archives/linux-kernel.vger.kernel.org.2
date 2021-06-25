Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E83DD3B4A55
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 23:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbhFYV75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 17:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhFYV74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 17:59:56 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F278EC061574
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 14:57:32 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id m9so6852793ybo.5
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 14:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KIJ95ZY3Sb7CSX9xchZZbIZog2D6IH+x9tYNzZe491c=;
        b=GX19SRHNzluXsOAMnJde5ZS1ydej3xFsDZx7/3nH12No787EDKYGH3odC8/YavZgfe
         pDT2fKCblY/jI4M/nqaxqExCfQtiZdFeqwjPwVB21ZVNL65cvEyPUDp52CEQ7Ou8e5PC
         sHadwE8GPmluJt6e7SpFhIgCnq6+kxg5qGFhXMjAgGf9o80V7SJO8nyCbVMSkiSmAE9l
         Vtrl+5tzpMQ3AQa5YXv7UUg9WpljsaEpu9zehnM3B8G6T5gtV6z0dvIF/W0SCQKcx09s
         SVlyoWPP40MqrNnUoKbs8wal+h+6OI5+K+SxoTwjavJJrLcmRwk5T47DgYa1qzLsxp/n
         N+YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KIJ95ZY3Sb7CSX9xchZZbIZog2D6IH+x9tYNzZe491c=;
        b=tQizCZj7IUmuwibvzkPG4eV1IwD2M0aegbepStqIXK7jgxEdl3vdADkzI9RnDA59Ay
         LYMvwmpnELoJooFOevYMkU9bLOKaLexwTUmr56Nupq8ZZhN8Qm7de8bAhgNs5khciqic
         cQeSr+uf+nEhmsmI7aWRX33MKX7jawKmVLnWBIn3Z6+rUWnVtHv5fDKMAfpNfb8fz4g5
         psP1uXU9kYOAZ2OczR24ln/RC2wDTVDSfoS5A6nKkTHrRdGiuygJcLAPGBhgKYFW89N3
         rqtQZ4+P7HACa/Ak5ESdjW4CcyZQA+193oXHuCFr7ui38rG9ljRSWzZ3VNabHI04EmsN
         7avQ==
X-Gm-Message-State: AOAM532xe3rDsxbTUnBlzq7uQEIx0jwgSD4E9jo5rs3EkBBOPECpJeVo
        qlfx+SA9/6CSfECXUJm2pVwrpMvng/OhYw8gW1A=
X-Google-Smtp-Source: ABdhPJwhAGgB+eZU5gIT3OAj9MgnPrQEV4WnvI4bY0Ga3ccmFp746FNDUbryS4IyVd6TD+jNq2usjYQp1/NhlHPAyKo=
X-Received: by 2002:a25:d8c8:: with SMTP id p191mr14928685ybg.247.1624658252219;
 Fri, 25 Jun 2021 14:57:32 -0700 (PDT)
MIME-Version: 1.0
References: <YNYz+hVeqsQmiEqN@localhost.localdomain> <CANiq72=qtAcsyReu85AVT-cSf3dcvbnTpQYEF1JhxCRP0WgHUw@mail.gmail.com>
 <YNZGNvGn/pkMhsx+@localhost.localdomain>
In-Reply-To: <YNZGNvGn/pkMhsx+@localhost.localdomain>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 25 Jun 2021 23:57:21 +0200
Message-ID: <CANiq72=HCKAyuLD3anAuSug4s0MKMHwRXdMPt0pNs-mTxD1CXg@mail.gmail.com>
Subject: Re: [PATCH] ELF: add and use SUPRESS_WARN_UNUSED_RESULT
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 25, 2021 at 11:10 PM Alexey Dobriyan <adobriyan@gmail.com> wrote:
>
> This is natural place. If you're supressing WUR, then the WUR macro
> itself is defined implying that the header has been included.

I am not sure I understand -- I guess you are saying that your macro
is only ever needed if `__must_check` is defined, which is what I
meant by "related".

But this header was intentionally created to untangle others by
keeping only attributes here.

Cheers,
Miguel
