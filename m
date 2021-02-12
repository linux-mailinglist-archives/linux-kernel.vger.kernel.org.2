Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5746D31A671
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 22:03:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbhBLVBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 16:01:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbhBLVAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 16:00:44 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD739C061756
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 13:00:03 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id x14so979296qkm.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 13:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7dfJau1Z2/Z0C+aryaDQsBuNGqh/xpuz6IGzQTXpFDE=;
        b=ho4MgAkccq9A6xs2pboGPRayWLr3i1qFp20B9cvS0cs2FcJ2pX12SHB6BFfaJ7Mcnr
         3bs50en/QfINHzxw+JBaURVEmpKQJzWWBlTnLwfSKcYhheuGaM9wQbUHI66qhMwoeT/W
         Rc4fMnk4XtdMHQNZZSgUDy6mFMkKyjmcMGR5WYJvBO0044F0iXkJc1wnREySood9aLLy
         aUZc6bhqES6O/zN+iCS5zXfSIfg1xAI1wNXbgHQ2D6dyBMV8X3d9D4kTujrzNa5SAS0l
         CbNnvd7LnTc3hrSyS6nqLdkn+p/5EbKzoXr8AkKudTP1CTVbJez7nx5xyrlfxQJDoMfJ
         1naA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7dfJau1Z2/Z0C+aryaDQsBuNGqh/xpuz6IGzQTXpFDE=;
        b=N65uLPrwgi/lsXqQAZYN/pp9UQUg6N7T0TVqbF+CLlYssjQZ/fP7X6pWrjz+1UOHOa
         oXxZOE+vB/qG2GbAf0qB2sayjWF2YhwVy/lSMjrCC0ov70n5wKT8Nt/Zf7B5EVYYGXc1
         1XiG2Mp6XDgOXRRKqf4Y2ihxoodq0GxDzNBx97wIWPIIEUcJCAqjrXAbHDqTCreFoAab
         hEYptkVGssfZs6+T7KNKpEC1UiIjr5VvOaIhdniFduM3jCqSblI/RoXbZpDMl167O/91
         oC3VEqDlCHhjzeaDMJt/xtsqQCZgpicGif3Qe42wMketQ8gWLkHETjeLGs9+xOoZKlsv
         hbjQ==
X-Gm-Message-State: AOAM533sIe6VJoo7X8lmAkBik673HH8n/ZsEbZCGVun9e5DTt448bLMB
        kg94QCk2h7RaSHvTnGUj4EfI1oB4R82ourlXLwecEW5grhQ=
X-Google-Smtp-Source: ABdhPJy6Z0W4TyuKig4+Ca8RyGe2t1thus2KTVLAwJ8xpq6uicWcz6au/b4OKzrdNujYwPgFz/7vK2/TPBawsLn+Ass=
X-Received: by 2002:a37:83c3:: with SMTP id f186mr3910863qkd.185.1613163603085;
 Fri, 12 Feb 2021 13:00:03 -0800 (PST)
MIME-Version: 1.0
References: <20210202124838.30805-1-jbe@pengutronix.de>
In-Reply-To: <20210202124838.30805-1-jbe@pengutronix.de>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Fri, 12 Feb 2021 21:59:52 +0100
Message-ID: <CAFLxGvw=5uK0AHmMq5vqOWiBzS68TBd-vU3G9mpWeTXeO5B47A@mail.gmail.com>
Subject: Re: [PATCH] fs: ubifs: set s_uuid in super block to support ima/evm
 uuid options
To:     Juergen Borleis <jbe@pengutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        linux-mtd@lists.infradead.org, kernel@pengutronix.de,
        Oleksij Rempel <o.rempel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 2, 2021 at 1:55 PM Juergen Borleis <jbe@pengutronix.de> wrote:
>
> From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
>
> This is required to provide uuid based integrity functionality for:
> ima_policy (fsuuid option) and the 'evmctl' command ('--uuid' option).
>
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Acked-by: Juergen Borleis <jbe@pengutronix.de>

I took this patch, thanks a lot for this but I have changed the sob-chain to:

    Co-developed-by: Oleksij Rempel <o.rempel@pengutronix.de>
    Co-developed-by: Juergen Borleis <jbe@pengutronix.de>
    Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>

Namely, "patch was created by Steffen Trumtrar, Oleksij Rempel and
Juergen Borleis.
Steffen Trumtrar committed it and Juergen Borleis later sent it to the
mailing list".

Is this right?

-- 
Thanks,
//richard
