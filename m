Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8A4A41C4F6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 14:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343921AbhI2M4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 08:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343889AbhI2M4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 08:56:15 -0400
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF713C061760
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 05:54:34 -0700 (PDT)
Received: by mail-vk1-xa35.google.com with SMTP id f126so424125vke.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 05:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zfQ5dM+Ri1P9r/ui3gb3SorhujmtF4JU4NTdcKikmrY=;
        b=Bsb7ycsZA74HsDPL09ZQAQzDgROsLRCu95Hc6OF0nBRCNlpFqOEl7hBm5n1R5n+GxS
         DY57YA9QCGz0DcHNnzyH8eenAa47pYdR9FLLRm9K7+sO4Y14fI7RCyHBToxJaDIhz0cc
         ozkSrY4d/0ZoSX99+wPd+DDkFDbf68V2vK3iI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zfQ5dM+Ri1P9r/ui3gb3SorhujmtF4JU4NTdcKikmrY=;
        b=Bvz1OmZWjK8fCfBw+yerLlmyR4REX/ZZNgKBJXRbeVetmXNmOpbOP/Sx94KRjQx9F9
         /pxiamBvXU2rluAYwuX+d9kYImCOoiIzuubRyd30YI8iJDL9QEnEkccXBCW9nipvP3j3
         9qB9307KDxhbM/NRNhWqKQqyS2e/agJYEJl78SgpCorI73jewEjWyuwi9r9c6TUF3a21
         6f9We5D1fYs6ei855kIQvpOlaGcf+ADMi7qug1f6FORNmOL4UngWDpCyy854YhOpbBie
         B6AluJBjwJ4t4ziqeKtP7T8NLz+s5JEaQLYg2Zd6s3GEYYtNbulkbz5bGjuOaul+/IPf
         /O+Q==
X-Gm-Message-State: AOAM530EnATmDDy5CnT0gH0JvVylRwBAf3tqAz3bHZiXdFnnJtYTn9B9
        ccNr4toRH0OKLH4mGrsnnEk6iX0BVW10KaZxidIiUfeSO5Y=
X-Google-Smtp-Source: ABdhPJzASCAh1IQGYf0Z3+LmFUl4XjYjTnybbVYyzQweEYSBjlUQemy10vtzR3hPvQY3k1Ypz3X3t1Ghxi70+l2QGFs=
X-Received: by 2002:a1f:f203:: with SMTP id q3mr8867332vkh.1.1632920073828;
 Wed, 29 Sep 2021 05:54:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210928123906.988813-1-colin.king@canonical.com>
 <CAFr9PXnMXPmuaUnfr-VwaZDX1hY8ZDtp1+UxOau6DKpUP9FdzQ@mail.gmail.com> <CABgxDoLPTcRbZZgAdJ9+=9OG+a=F59x9SQ9HvQkVvGmkDjO6-A@mail.gmail.com>
In-Reply-To: <CABgxDoLPTcRbZZgAdJ9+=9OG+a=F59x9SQ9HvQkVvGmkDjO6-A@mail.gmail.com>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Wed, 29 Sep 2021 21:56:36 +0900
Message-ID: <CAFr9PXna7YsYnfdtu1jvJhkVSX0SiyixYr_bTsx3tDepeHqcMg@mail.gmail.com>
Subject: Re: [PATCH][next] rtc: msc313: Fix unintentional sign extension issue
 on left shift of a u16
To:     Romain Perier <romain.perier@gmail.com>
Cc:     Colin King <colin.king@canonical.com>,
        Daniel Palmer <daniel@thingy.jp>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-rtc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Romain,

On Tue, 28 Sept 2021 at 22:55, Romain Perier <romain.perier@gmail.com> wrot=
e:
>
> Hi,
>
> Le mar. 28 sept. 2021 =C3=A0 15:31, Daniel Palmer <daniel@0x0f.com> a =C3=
=A9crit :
> The crazy stuff being, I ran rtctest from selftests and rtc-range (1)
> that tests a variety
> of dates including 2038 and 2106 for example. Both tests passed :) (proba=
bly
> because *this case* specifically did not happen while running the test)

I suspect it works because for reading the time because seconds is a
u32 not unsigned long like the other functions.
So if the high word of the register is read, is promoted to a wider
type and sign extended it doesn't actually matter because it gets
truncated to 32 bits so the sign extended part is gone.

Cheers,

Daniel
