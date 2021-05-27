Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 147BE3925A7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 05:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234877AbhE0Dzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 23:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234400AbhE0Dzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 23:55:51 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55219C061574;
        Wed, 26 May 2021 20:54:19 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id r5so5870550lfr.5;
        Wed, 26 May 2021 20:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=L4eVoi7/s33wCXEPgSBGhpwxgCCTmTyv4LkXtwgXAw4=;
        b=IclRlrJlvSK50ZWzvbNFbBmVivcpBeZ09SibluliY1fznAFEVAeq7D59KcSqZrhmqO
         +zLONf9ajOx+zqpCsT3ACUsxsdFnYrcm96Br7iWosmmuTHCEaTAJR+G7hqGtQsTIPgL+
         IRiAqlwW5j3i8kfCXAXKP9fKmvJ1WJ7bzlny2iLeCjZmLgCr9YLsHxnxk2KYgwwPst5K
         OjTOZMRP54UvTC5fHADKzvhi91e9AfEN/D0/fNQpFQVVC5/p1GeBB+levw0fVnK/9KtF
         sVOj2k+GdWxthEdSf9iDVDctEQl5ySrrONKjM4sHONZ1JywbGfBAQfgiDwDyCzveN2bE
         pOdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=L4eVoi7/s33wCXEPgSBGhpwxgCCTmTyv4LkXtwgXAw4=;
        b=KntmTgR1bLkrMMWcDUQ1VCyECncIRMrLtq4Xc2ELmwss303CABtGA3AKOLZrS4hNnx
         +eOnkw9HTgzi77caOunmGjHjatAL/xA/lMij58/TZuKjzMM8ZJ5yveOwieHuSTCNqKFq
         GprYm4XrDeW8ubxxMLJaAcfRCkEAmXe/Z5Pay2RKQ4dj2Y6TYxTIO3AbN6zWLtQE/iww
         kwa9hHXG76tcHjwuIGB/8FJ8+co59l1AOA5fLIytWC6XvNisISkxDkd8Fs9w74zbCVkt
         9xsRtHA2eqEVrPxMIY1nZIaSOGcH9nwtm5rE2Os8K7txRIOCRZcz/qmlqwuUsz4P3Nid
         5oKA==
X-Gm-Message-State: AOAM530ah4FHdD+eboxRgFi7RQTW32VmFpRI5qTLHVh6Ci4590vgNIOO
        I13KtPLO3Ml3XzRatjBD3ot8BVn+wIGVexeIDuQ=
X-Google-Smtp-Source: ABdhPJx6ibXv8fhcYnql06th8CLIhWoIJFGMF4SGItogNPa+1e2GgdhfZUCdzDzjerP12kUr4eolFKV+3xGw8P0qPds=
X-Received: by 2002:ac2:5d29:: with SMTP id i9mr938408lfb.638.1622087657684;
 Wed, 26 May 2021 20:54:17 -0700 (PDT)
MIME-Version: 1.0
References: <1622009578-15577-1-git-send-email-u0084500@gmail.com>
 <1622009578-15577-2-git-send-email-u0084500@gmail.com> <YK6RvBD3c38BhJZa@sirena.org.uk>
In-Reply-To: <YK6RvBD3c38BhJZa@sirena.org.uk>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Thu, 27 May 2021 11:54:06 +0800
Message-ID: <CADiBU3-KMVYOO_HXWQ7TRHAohBUrUmnyXhZDYfTNjbrk3UgpAQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] regulator: rt6245: Add support for Richtek RT6245
To:     Mark Brown <broonie@kernel.org>
Cc:     lgirdwood@gmail.com, Rob Herring <robh+dt@kernel.org>,
        cy_huang <cy_huang@richtek.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI,

Mark Brown <broonie@kernel.org> =E6=96=BC 2021=E5=B9=B45=E6=9C=8827=E6=97=
=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=882:21=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Wed, May 26, 2021 at 02:12:58PM +0800, cy_huang wrote:
>
> > +     /* xor checksum for bit 6 to 0 */
> > +     bit_count =3D __sw_hweight8(code & RT6245_CODE_MASK);
>
> This doesn't compile with an x86 allmodconfig:
>
> ERROR: modpost: "__sw_hweight8" [drivers/regulator/rt6245-regulator.ko] u=
ndefined!

I think I found the problem, x86 only defined __sw_hweight32 and __sw_hweig=
ht64.
If user touch hweight8 or 16, it will auto convert to use thest two functio=
ns.
And the x86 arch didn't define __sw_hweight8 or __sw_hweight16.
The best way is to use hweight8 macro and let the macro convert it to
arch_hweight8
Ack in next, Thanks for reminding me.
