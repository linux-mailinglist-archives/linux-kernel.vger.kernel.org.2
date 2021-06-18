Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17E163AC14F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 05:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbhFRDbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 23:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbhFRDbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 23:31:03 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0940C061574;
        Thu, 17 Jun 2021 20:28:54 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id r16so12001070ljk.9;
        Thu, 17 Jun 2021 20:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KU0XIwJ0XXrc92jT9YLWiEwSpSoGcMOVK76Rj0AjqYE=;
        b=p50ZkJy8Px6CQI47WEA9P7w5S12ZlUR4qZMAJ1jBHmahMP0ijF98QnO18pKdc/w/3Y
         9A+gh/mOFAG0E1z0oq/zuCPwDZwpjjjBknFg4qWs0b6rXGDpj99bnPIrxTs/gBANuxoT
         DsiC7qpOOqZbESsfjuIuCeWRWOb4Wt50ODKbJHQzmoMHbHF1qdzLsiN73zRHh0vpTh0S
         qklC/oQbKwBfuV4VobOIB4PanGDU4dh1tG/sMo+jQpKaaQwjCXTGGSqNl8fqSEGDeICa
         KqJn2Xz2P3wmkcOwlUSkwXVzJZ/0Xnjz4TNXM4V+heS+gvT6nzJcZCo1v3MQ+GWhj13F
         pp7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KU0XIwJ0XXrc92jT9YLWiEwSpSoGcMOVK76Rj0AjqYE=;
        b=uKIaE2+H2oN7ZHBujdy5c1QCkcv/Y7GPW+Gt/FfdFnWzt7fPfv7ycITDEkbgYZiq8b
         0XADp0e8OB+n+wMRRNpgTtnaSGxu39MFxHoiNeNSHaCErFCB6Mv8ibNVqCn4yV+7SUnj
         sX0CrdVvYBu5IjiZpdQZySm7mJ3L5YoDjWfsHGpXdzYfKVwIQarFWD46nykOykMMvqVt
         ILiloKmDjUK4oK03+M+mfGBO1UCfLgB2Zrg4OJtA90eASNjUDt/VBM3dxce3k78bl3S0
         kA6n9WUEhZQY5MgmRVojOopcsIK1i2YYY23s5ig9vOaPO5+VJ4cTYwxI7gdWZTbdQv/z
         T+Ig==
X-Gm-Message-State: AOAM531T6PpS6OK/lQ8hJ1Wl6G/BVw97CnMCKaPm7s6rJPWXXB+TF8tx
        LbViVHjAklNAG058yd/hqnUUqSeJxW8Kw4aWyhXADbOX
X-Google-Smtp-Source: ABdhPJw9OuwMCESWUrDgrF6XLH+4Rsb+54yvZX5ftkDs5+pzB/f5YhbOu4aeL+7uEtI5hxmTOeAQPVQBsov8IFIUCCc=
X-Received: by 2002:a2e:8542:: with SMTP id u2mr7580839ljj.141.1623986932876;
 Thu, 17 Jun 2021 20:28:52 -0700 (PDT)
MIME-Version: 1.0
References: <1622616875-22740-1-git-send-email-u0084500@gmail.com>
 <20210611201643.GA1583875@robh.at.kernel.org> <CADiBU39Prz99ZLtkYdcM9XDQsd0nKKeiEGjW3wq=u75JGjwX=g@mail.gmail.com>
 <20210617162919.GH5067@sirena.org.uk>
In-Reply-To: <20210617162919.GH5067@sirena.org.uk>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Fri, 18 Jun 2021 11:28:41 +0800
Message-ID: <CADiBU39-HA518TP=7_i8bYQWfhAUK_pj+Gn0O6rTKEZxq6GR1A@mail.gmail.com>
Subject: Re: [PATCH 1/2] regulator: mt6360: Add optional mediatek.power-off-sequence
 in bindings document
To:     Mark Brown <broonie@kernel.org>
Cc:     Rob Herring <robh@kernel.org>, lgirdwood@gmail.com,
        matthias.bgg@gmail.com, gene_chen@richtek.com,
        lkml <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, cy_huang <cy_huang@richtek.com>,
        gene.chen.richtek@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Brown <broonie@kernel.org> =E6=96=BC 2021=E5=B9=B46=E6=9C=8818=E6=97=
=A5 =E9=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=8812:29=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Mon, Jun 14, 2021 at 11:04:01PM +0800, ChiYuan Huang wrote:
> > Rob Herring <robh@kernel.org> =E6=96=BC 2021=E5=B9=B46=E6=9C=8812=E6=97=
=A5 =E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=884:16=E5=AF=AB=E9=81=93=EF=BC=9A
>
> > > > Originally, we think it must write in platform dependent code like =
as bootloader.
> > > > But after the evaluation, it must write only when system normal HAL=
T or POWER_OFF.
> > > > For the other cases, just follow HW immediate off by default.
>
> > > Wouldn't this be handled by PSCI implementation?
>
> > No, the current application default on powers buck1/buck2/ldo7/ldo6
> > are for Dram power.
> > It's not the soc core power. It seems not appropriate  to implement
> > like as PSCI.
> > MT6360 play the role for the subpmic in the SOC application reference d=
esign.
>
> If this is part of the overall system power off that seems like it fits
> well enough into what PSCI is doing - it's got operations like
> SYSTEM_OFF which talk about the system as a whole.

Thanks, I'll check and survey the PSCI about the SYSTEM_OFF.
I think it may work.
