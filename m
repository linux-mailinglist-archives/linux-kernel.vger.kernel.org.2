Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7953144C1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 01:17:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbhBIAQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 19:16:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbhBIAQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 19:16:51 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 874C6C06178A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 16:16:09 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id l11so7903805qvt.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 16:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wvDdMI1NXVAkjUHOPoqH3HqzglyvtUTKJ0dm2oqjRbo=;
        b=AsvV4nrdtLLnfAqVB/AkdcYiMZwA0PSjiz1ls5J6SoylwyZXIsFs37H7sgfhAQlUN6
         oOTm207M4k0vHYeQR2v39XebQWfd4lmq++D1D2wmNZPv75U3KnKjtC+yBHikP+9bXWC3
         7hesZoOeKw1dRhLzx/gRqgbjL9dlR6t1k0NljUTLJBuZD4Rjfo/32d0ROUoO6X930pWB
         zeYFT9gnUdGZvAlxyTuAlc3ZXxhjEgn4Mg2zeYwzpH/BFErWGmiWk91x/15d4LJk8xDu
         iGRysCWRlwO2M+gKJT9qKL94zQv+aHONFiqsEmmx6FJmuOZ1dZZzYIXTirLJYLEr95EQ
         PxLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wvDdMI1NXVAkjUHOPoqH3HqzglyvtUTKJ0dm2oqjRbo=;
        b=QBtuiBoAyiAWUp37fWgmo7uLDlOQNURcAUwKHk4YVL8R8VOqfyRVml9CzAFr98+seu
         U7k//X8PBA95DpIrl6sawybEfMTtEIqWVX9t5dEqG0od3kkWgS9lsI7RS15V3aJfqNEF
         7PbQxkwkjSpY2dIP4oNvcnSelmPG0/4yLDu27JWY/fvb/cfNDn89A/wSWKbesNQ7Exg5
         F8HFpm+Z8MI2wf8K2w0dJSJFAT5lnhRFdTPiv38a138e4OrpYAV3mGrYIILoX6WO2yi8
         99famPbXj/HNUKFf8n4YPWpLncleWcOzGIsMZsmym56tqOu0dqgxMCRI5ifHokSvUZHW
         HA9w==
X-Gm-Message-State: AOAM531dLBc63boJHDl7tpPHxhCIJvRbXlR1OtQtrCpcuW+6qCNsL4mn
        GksOkzn9aCIeqSU3Ds+WB/OONP/vKYQ2JYKxhqqjXQ==
X-Google-Smtp-Source: ABdhPJztx/GKm0UC6Jwh32Q5gk1P+99+vOhEgfM2BEppuF8fmG98UzBhYQ4A5HCMeQIxEzPlFdkJLp8aNtmlMSfQLYI=
X-Received: by 2002:a0c:f7d2:: with SMTP id f18mr18475799qvo.39.1612829768625;
 Mon, 08 Feb 2021 16:16:08 -0800 (PST)
MIME-Version: 1.0
References: <20210205141728.18117-1-john.ogness@linutronix.de>
 <YCDdwY8mMb9JZkXn@jagdpanzerIV.localdomain> <87ft26oqya.fsf@jogness.linutronix.de>
In-Reply-To: <87ft26oqya.fsf@jogness.linutronix.de>
From:   "J. Avila" <elavila@google.com>
Date:   Mon, 8 Feb 2021 16:15:57 -0800
Message-ID: <CAGFReePzfSUADTwpoEUHGV2pLs-KgsfEPWzOY26T-rUwAM9qxQ@mail.gmail.com>
Subject: Re: [PATCH] printk: avoid prb_first_valid_seq() where possible
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello John,

Thank you for looking into this! Yes, I can confirm that your patch seems
to have resolved the issue I'd reported.

Thanks,

Avila

On Mon, Feb 8, 2021 at 1:21 AM John Ogness <john.ogness@linutronix.de> wrote:
>
> On 2021-02-08, Sergey Senozhatsky <sergey.senozhatsky@gmail.com> wrote:
> > Can we please also ask the kernel test robot to test this patch?
>
> LKP is an automated service. The problem was reported for an older
> commit. The new patch will not apply.
>
> I will try to contact the LKP team and see how we can get some sort of
> verification.
>
> @Avila: Can you also verify that this patch fixes your issue [0]?
>
> John Ogness
>
> [0] https://lkml.kernel.org/r/20210122235238.655049-1-elavila@google.com
