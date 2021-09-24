Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2300F417C23
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 22:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348342AbhIXUHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 16:07:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:45494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347111AbhIXUHN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 16:07:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4847A6124B;
        Fri, 24 Sep 2021 20:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632513940;
        bh=T2wKnG3TpEXIDXaTPfuwPXG73tITA+Kyxu8MivpVLVw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DKrujCS4TdscrIqA5xMxoax/3QkfRV/ty3/kARAbH8SE/iLxscTS03KsPMYhS5emo
         UpqAFawteIFZ/Mye5AnM1yTgfo51mAjY+vrBPdC9gqN4JEvPAFyOuTKCdVMv6VTDnh
         B0yEfQD5GJCDqYD5A3AtjC9KZa2lhlOZHH0gTqSol77rIDhRa4dmyEUN+KVYVBVGmb
         Xo0prznBCmatzmrqBazBwWeF5Gy2iaPTqqE8ZzaIUG1WY1OYROHWDL9AVQXHLwYhuM
         +7lcEogdl3YLetknFG7wpdQWqlXtothcOpa+wwI+okPZaOMfJbLpFMfsVkQp7LIPtW
         PpNY0WHL/Qbww==
Received: by mail-ed1-f43.google.com with SMTP id eg28so40608910edb.1;
        Fri, 24 Sep 2021 13:05:40 -0700 (PDT)
X-Gm-Message-State: AOAM532GAkcn94FiDbCgrBOISMuzA5Ai4WWczjPNFDycOyQMB8dkDkpa
        mvw0TvDhtFhZmpBpftyHuEKOhIe7p38yKANCnw==
X-Google-Smtp-Source: ABdhPJxyz6S94MKunRcaqMWXqhAMBUh5fcIuH4qz77H9oK3cKW3ViwNpZ6fkPgOTcr5XWZK6PQyWqZ7GOL/Mi58LWG0=
X-Received: by 2002:a50:da06:: with SMTP id z6mr7156532edj.355.1632513938876;
 Fri, 24 Sep 2021 13:05:38 -0700 (PDT)
MIME-Version: 1.0
References: <614ad319.1c69fb81.2a0c1.4782@mx.google.com> <8d6223d2-8ca7-0373-bb49-b62894e5fad7@collabora.com>
In-Reply-To: <8d6223d2-8ca7-0373-bb49-b62894e5fad7@collabora.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 24 Sep 2021 15:05:27 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJ9fDXkVgcXTiO+NM9T7OKO+p43NGmJPRvvLi3-_Bd4dQ@mail.gmail.com>
Message-ID: <CAL_JsqJ9fDXkVgcXTiO+NM9T7OKO+p43NGmJPRvvLi3-_Bd4dQ@mail.gmail.com>
Subject: Re: next/master bisection: baseline.login on qemu_arm-vexpress-a9
To:     Guillaume Tucker <guillaume.tucker@collabora.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "kernelci-results@groups.io" <kernelci-results@groups.io>,
        devicetree@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2021 at 12:28 PM Guillaume Tucker
<guillaume.tucker@collabora.com> wrote:
>
> Hi Rob,
>
> Please see the bisection report below about a boot failure on ARM
> Versatile Express.
>
> Reports aren't automatically sent to the public while we're
> trialing new bisection features on kernelci.org but this one
> looks valid.

Have you considered given you have the commit, if there's a Link tag,
sending this as a reply to the original patch? That would be a bit
easier to find IMO.

> Some more details can be found here, for Cortex A9:
>
>   https://linux.kernelci.org/test/case/id/614c36cf0c427f123799a2db/

I should have remembered there's a qemu model... Anyways, sending out
a fix in a moment.

The log here was empty. Any reason 'earlycon' is not set here? I also
noticed stdout-path is not set on many of the Arm Ltd boards. I'll
send a patch for that, too. You really shouldn't have to set the
console on the cmdline nowadays unless you want the non-default.

Rob
