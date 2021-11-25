Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75DFC45E2CA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 22:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243454AbhKYWC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 17:02:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234283AbhKYWA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 17:00:27 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79ABFC06179B;
        Thu, 25 Nov 2021 13:52:46 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id e3so30729209edu.4;
        Thu, 25 Nov 2021 13:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=flIOUkZOz3tjaA5fa6HkaZ5dnqqF8aPvmbEfodvpXWs=;
        b=f7t+tFpaj6sDYa3XUdzfz//6WEEpGGk/AHcqd8UcUzKHOgWqop/H3XFMFYxlbaeUzX
         xRDQqDxFucv5BAvcfIu9P2JMzKu/XDKgZ/fNLUzmsasJ7LR4RYjkDTaASWzmx0ld2dUn
         +20eLMM8eN3wXehxczAwnmm5SYfI+VidvnKVvMhlSZyOFDgn4TOGdlVM/M4gHzSN9N/d
         8Jsljzd9sCXf1rlACbXxXKZ7W4swFl2VebMTbskZA4ev/F2t0rvd3cnIyYyKtYrdj9H4
         l5BLsm+qsWGtUjBzDBqgmBrbM3d3Fi6Y0jXL9efSB7wQtH0EKFYWd++fd9CvewfzAEWM
         6qZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=flIOUkZOz3tjaA5fa6HkaZ5dnqqF8aPvmbEfodvpXWs=;
        b=jXI6kDn5dK66yehECspt3kInN1sfd+8/VXFRCRoMwuU6ZTHfDWbO3b6KulMRc26oWa
         At4KqCwYhG4Qzecep/BjrhfswG3//48GZMCQbKpYlpK/G2ifeNV9FpiZr170dBiH8Fvl
         mx1rQ+fVyeNEiBzqhcqB9kJG6tkD5/U3VZOZhOqImOiglP+cMS9Z6G30yw6OaxGRz4xu
         yHvtmu/OaGPvbOuFH49kdIcEuSpGZJB6UUb0BgUQXBhbptM6E0uCkdR8OaQPmaNrs415
         O9KJ0PBs+BgEEkFVxARp4oWltU+zJEPffUrYpKiX+xH20xxMMKHlBI8ikO1iCP3oMRRV
         E1ZQ==
X-Gm-Message-State: AOAM530RgJDqzLLgEc5L4Q9GOWjq/Fsd+g0RIOz6ylVW5mLVTy53nu+9
        FfeksWPUzV+Q07qYFjRHyBqw79I8gWFuAZdxINTP7I+GRFs=
X-Google-Smtp-Source: ABdhPJx2TnoFqSWP6hCNWJUIOF8fSr6ej5pUns6bO/sTCK8oMpLD8a7uxKZieAl42XFbn8s1TjpyecjHejMt792BQo4=
X-Received: by 2002:aa7:d0d1:: with SMTP id u17mr43386732edo.135.1637877164721;
 Thu, 25 Nov 2021 13:52:44 -0800 (PST)
MIME-Version: 1.0
References: <20211122212850.321542-1-pauk.denis@gmail.com> <20211122212850.321542-3-pauk.denis@gmail.com>
 <CAHp75Vfg7LKX-21+b6f5c34G4Y=ZUqrWRbfDt_quCiJe+By-Ww@mail.gmail.com>
 <CAB95QASDiwM+-AwPgGfc7dP=Ctm0s2WP4xrapJzNHJ22B9foAw@mail.gmail.com>
 <CAHp75VeO2mz7wJpuKdrErnYcw-dUOBs9W4FzA6MkgCQLr0eQUg@mail.gmail.com>
 <CAB95QAT_b8Wef+4wN-H8dKZXxgnznqOk5J0fMuL2XJLhob7d9Q@mail.gmail.com>
 <b7616187-87d8-c87f-8f66-d5936a33395f@roeck-us.net> <CAB95QAQ2vpXFxZC0G6ogbpk+rDzGMN7N8-RaUX9w_U5bQ1WGMg@mail.gmail.com>
 <CAHp75Vdi8ujoC5LTYqNmiWe1dTxrYRQKS+YtZE921d-6CZTs=A@mail.gmail.com>
 <20211125222526.405ce775@netbook-debian> <CAB95QAQnU8t4uY17mO9edEd9jktariU_RcZk_1Jdevfr-o0Gnw@mail.gmail.com>
In-Reply-To: <CAB95QAQnU8t4uY17mO9edEd9jktariU_RcZk_1Jdevfr-o0Gnw@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 25 Nov 2021 23:52:09 +0200
Message-ID: <CAHp75VfWnLV29FpJ_FdJg+j3tu9QQzbPAs6OOjZ-3Fdqw8SDOA@mail.gmail.com>
Subject: Re: [PATCH 2/3] hwmon: (nct6775) Implement custom lock by ACPI mutex.
To:     Eugene Shalygin <eugene.shalygin@gmail.com>
Cc:     Denis Pauk <pauk.denis@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        thomas@weissschuh.net, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 25, 2021 at 10:33 PM Eugene Shalygin
<eugene.shalygin@gmail.com> wrote:
> On Thu, 25 Nov 2021 at 21:25, Denis Pauk <pauk.denis@gmail.com> wrote:
>
> > I would like to propose to leave the current name of the driver and add
> > the same logic as in the current patch. So when we know the exact name
> > of acpi mutex - code will use such mutex for lock and directly read EC
> > memory region. In case if we don't know the exact mutex name/path or for
> > some reason ASUS decides to change UEFI code - code will use WMI
> > methods. In such a case, adding or checking a new motherboard will
> > require only adding a minimal list of well known registers without
> > disassembling UEFI code.
> >
> > What do you think?
>
> Sounds reasonable to me, but nevertheless I think dropping the "wmi"
> part from the driver name would make the name clearer with the
> proposed functional change.

We don't do changes for something which is not yet in the kernel or
about to be there. My proposal stays the same, sorry.

-- 
With Best Regards,
Andy Shevchenko
