Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4923B49C7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 22:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbhFYUhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 16:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbhFYUhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 16:37:03 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24EA6C061574
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 13:34:41 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id i4so6555427ybe.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 13:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f7/u1McoJBT3/3b6BeTVTbv4r7hZzqsmMtPeO7kEfA0=;
        b=IujKgBy4SRh8y32WMXXsoJaKLrAM50QYXrZihWnYdP30Kk1o4cwhpvmZqVW5DJ85n3
         SqWrOQLBRNsEPV0peR9qUGd8nM13KtbWeyDYzH8jY6CxLmhrRc1TR7Lj7XM2cn9HraIq
         jx7zmqUY+5BijIE5ZhfQLUY/bKZd8VgZ1KC4FXchRY/wG/LxgVtkReD4Vph35amCXQkU
         5QeOoir6Ihv+wyv7mUzcSYiEE2icwaY9lk73Oxx4JiF3ET8gpslU06Q5QJzMwi7OPnXh
         07nMN5Eah2ePMwQD+3At48Q9R+1mF71GqnjZZHDCeYoAupK1jtvSYOzikYBDiQLike6T
         /ldw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f7/u1McoJBT3/3b6BeTVTbv4r7hZzqsmMtPeO7kEfA0=;
        b=qa3e4mqu6SzC+cKraE+vo/5wc2iR9y51yXiQ2pAWVV+Uj0YhhF6ueWrnYtOnL3TeeG
         F8kLahTHtwuyQy1FcNF1MIPlRBif1AC8SfoT5o7BsFMpE+ajoI4ymwY2PnxKNpLL6Jki
         d0U7/RuWrsZ9H0FrvjpUV1A+6dQTIan5bMC4l9jifo9iHZs45/hqmAoRfWvWMIRPWAwH
         pENBCv0rBe0l71hJLVmP+InKk1a9eT/mtBoX2CH4dvcmfz3ODvIdt5wFs5Bq0vbnIUZR
         +lfhylQPIQpnfuo89dMeSRE6xlA56wUNkHQbUuLvPJv4sOzo1Fh0xdn1lZigZlngqaae
         zXrA==
X-Gm-Message-State: AOAM5316UfwGE9rV2HjTnBot3iZMasFIIkp5P4RfYJ9YzY0ITPqObOGc
        YDz3qx+MYTOBLjGQ1ePCIWjIHGi56pq5b9AucbTtoGsiaiqD7w==
X-Google-Smtp-Source: ABdhPJyQ1Uww6bFqPyT6OxNVC35nNHd/xsudQl0jSRiJFArSRIHmSzTZfQT7LHSJc4Y5Ktzoy1mIn+MCA7e6R1tVx7o=
X-Received: by 2002:a25:6c8a:: with SMTP id h132mr14208913ybc.422.1624653280403;
 Fri, 25 Jun 2021 13:34:40 -0700 (PDT)
MIME-Version: 1.0
References: <YNYz+hVeqsQmiEqN@localhost.localdomain>
In-Reply-To: <YNYz+hVeqsQmiEqN@localhost.localdomain>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 25 Jun 2021 22:34:29 +0200
Message-ID: <CANiq72=qtAcsyReu85AVT-cSf3dcvbnTpQYEF1JhxCRP0WgHUw@mail.gmail.com>
Subject: Re: [PATCH] ELF: add and use SUPRESS_WARN_UNUSED_RESULT
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 25, 2021 at 9:52 PM Alexey Dobriyan <adobriyan@gmail.com> wrote:
>
> +/*
> + * "(void)" is enough for clang but not for gcc.
> + */
> +#define SUPRESS_WARN_UNUSED_RESULT     (void)!

While it is related to the attribute, this macro is not an attribute,
so please add it somewhere else.

By the way, the name has a typo.

Cheers,
Miguel
