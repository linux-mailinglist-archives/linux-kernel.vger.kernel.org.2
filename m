Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60CB045E1BF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 21:40:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356907AbhKYUno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 15:43:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357108AbhKYUlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 15:41:42 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E019C0613B4;
        Thu, 25 Nov 2021 12:33:44 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id c3so8931721iob.6;
        Thu, 25 Nov 2021 12:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZGJMV8L0xIfo6824D1QFIO2JOAipCJYM3y5yS0h3fUw=;
        b=ThAHbxP6zW3y2z5iWgNAj8GUtM2px8RHMpP0eU+3SfdUzBcEm58Mj1AiplBKG0Pwbx
         jZ+YuBovqHLw7EJbw+8oHvNKEZ2XS7Ok81l2/QqMDXQ69tR+V/+PNJZdET1fmhfCH/SI
         Uk0LE+2z0m4lU14FQ6YrcjMzQDt4TDtTCLbNGRXh9Ia4EW1qUjJbqwmwk0u0pS58nbAt
         IwFXmXkUnr23kyWQP0gc+Iyc6pU6aeO/Khs2Bg9f/4DqNKTEw+cn8MGblI437Nq3dpwR
         TmGuIhg41Nw3MUsWQNNgR0maG1hTN6+x0eS0tpCxBtAUvhZFRkFl9pJ1XDgRKLa0KjPQ
         0AXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZGJMV8L0xIfo6824D1QFIO2JOAipCJYM3y5yS0h3fUw=;
        b=4EFw+V7+AWZe7/qGEnYlD+1V7e97IOpWIxqVxxMuc1HxBcefEb1oAVwpxF0SPLOhm7
         QfE2fUKH4XyTMbdBudzVldo7Xo2weg6Rad5k0meQGeFDhViXHEgPJALoqgcegF5kMALC
         ebV47XlaOIXxia1CmICEK+LEYf9EYN2NUE9eKC1wEOXMbx33sB3FTSw7HL9A657blDdQ
         NRi4uz0mE9B4wKRCbnf0ejeiQfTrqn3nwMzt6z8et6+wUHHEv8zzvnN6xyuQhu443rwC
         oR0PG4QBFBlftOvszyOcBdewE1v9aDg8KpjOpBeg+SPvX575VOpIuCGJL4Ps24gg49Wq
         5sYQ==
X-Gm-Message-State: AOAM532nY2a9I7QasPc8A/OQJzW1wV90aa34U1vzdAe5aKEvDVFg90t/
        h09/Xhxaditvuimj4H5NHXKtAWCEyarzRh1Zgy8=
X-Google-Smtp-Source: ABdhPJz+5TI7RWReAyBkCMHBGn8t1G46iHUI93uTDkMsKVAJtKaaXzt1JO0YtsIAh7Hm9+/r9qG8zeBdycruB4TIwrc=
X-Received: by 2002:a05:6602:2d04:: with SMTP id c4mr27125834iow.146.1637872423489;
 Thu, 25 Nov 2021 12:33:43 -0800 (PST)
MIME-Version: 1.0
References: <20211122212850.321542-1-pauk.denis@gmail.com> <20211122212850.321542-3-pauk.denis@gmail.com>
 <CAHp75Vfg7LKX-21+b6f5c34G4Y=ZUqrWRbfDt_quCiJe+By-Ww@mail.gmail.com>
 <CAB95QASDiwM+-AwPgGfc7dP=Ctm0s2WP4xrapJzNHJ22B9foAw@mail.gmail.com>
 <CAHp75VeO2mz7wJpuKdrErnYcw-dUOBs9W4FzA6MkgCQLr0eQUg@mail.gmail.com>
 <CAB95QAT_b8Wef+4wN-H8dKZXxgnznqOk5J0fMuL2XJLhob7d9Q@mail.gmail.com>
 <b7616187-87d8-c87f-8f66-d5936a33395f@roeck-us.net> <CAB95QAQ2vpXFxZC0G6ogbpk+rDzGMN7N8-RaUX9w_U5bQ1WGMg@mail.gmail.com>
 <CAHp75Vdi8ujoC5LTYqNmiWe1dTxrYRQKS+YtZE921d-6CZTs=A@mail.gmail.com> <20211125222526.405ce775@netbook-debian>
In-Reply-To: <20211125222526.405ce775@netbook-debian>
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
Date:   Thu, 25 Nov 2021 21:33:32 +0100
Message-ID: <CAB95QAQnU8t4uY17mO9edEd9jktariU_RcZk_1Jdevfr-o0Gnw@mail.gmail.com>
Subject: Re: [PATCH 2/3] hwmon: (nct6775) Implement custom lock by ACPI mutex.
To:     Denis Pauk <pauk.denis@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        thomas@weissschuh.net, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Nov 2021 at 21:25, Denis Pauk <pauk.denis@gmail.com> wrote:

> I would like to propose to leave the current name of the driver and add
> the same logic as in the current patch. So when we know the exact name
> of acpi mutex - code will use such mutex for lock and directly read EC
> memory region. In case if we don't know the exact mutex name/path or for
> some reason ASUS decides to change UEFI code - code will use WMI
> methods. In such a case, adding or checking a new motherboard will
> require only adding a minimal list of well known registers without
> disassembling UEFI code.
>
> What do you think?

Sounds reasonable to me, but nevertheless I think dropping the "wmi"
part from the driver name would make the name clearer with the
proposed functional change.

Best regards,
Eugene
