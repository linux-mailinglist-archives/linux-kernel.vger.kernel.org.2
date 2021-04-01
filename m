Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D074352185
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 23:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234639AbhDAVUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 17:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234114AbhDAVUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 17:20:01 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106C7C0613E6;
        Thu,  1 Apr 2021 14:20:01 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id jy13so4941484ejc.2;
        Thu, 01 Apr 2021 14:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KC0mTuJ4tgq29clt/DJ1oKRDWafL4y7QMhvb3vAxv64=;
        b=KRAgTi8Xn1rADTywa6/h1bK6vvnZ5Xk8rKdavqQbRCx4KkmZOzawZHnEz+XOffhRwJ
         eoClDVWHY0uaKbFPMa+l0aCMYdBllnbasCEKckPy4eAG0EHHy3qo3H1ryG5lR8K2wO61
         GKxv7tUPa/D4K6+wiw6x4JXHFtXXkTXHbZ7HuiH/1c2Pr1+3Hct4E24RwjKUTkdGvv5L
         sg2brW87LUkN6DlU/270ayFdlgkJDs8+aQCI7D8iT5F1R537ryQmt8UrO+DMxdXyMX44
         6pF4T76GkHtI5DZ7maHEJy+7DgjKWXTZ7F2kyuMwMaDDxY/Ab0TO+GlGaK1ZccT3Kqm0
         Ty8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KC0mTuJ4tgq29clt/DJ1oKRDWafL4y7QMhvb3vAxv64=;
        b=icxDdrGIgGm6O+w5dt/ggcyUQ8VmZ6Wu2OaVPw0/2Wtu/zJLJk6u/tthWJwj+o52sr
         kzthNOhqrTcvOPZL/VyfDNc/9tsisFThEEG7fXF9JoYEdrER77X8Yrm8IrOfJeDq7dQv
         PoQbOt7HWnDbBckNyfoCLlDuiiZSV5/qQwfW4UkAxt/pmZ/soJjhofKAGhMFxQMA6tqG
         wkzNipRINCm46ZreOC78oL+Fzao2KeOxPar1T7y9RMVZ7dMLFKTF+9eE60c1igE/x4Qo
         MUR4UlZ0/SNwIkbnRbQarX9RY677sSIY1TXzG+XBJi/xSbGkdpHq+c9UHrxGYj3CxyO4
         8tSw==
X-Gm-Message-State: AOAM5311tfDZSxTbCvC2fr28VNtjOxEgXN2JRDsNpHm67ov+xl4PqTQP
        qsLPFB3McXqyqzb27AXVFPkABwrxbh0PYzEwtUxqe4ko47U=
X-Google-Smtp-Source: ABdhPJwtHXc+ksomWeIaHGamXKspypkINK+06RXyA5gdVtCimYtqIkYh7FQORxH0Ah8aG7yz4+beL4aCKsUXkLnuycg=
X-Received: by 2002:a17:907:7683:: with SMTP id jv3mr11106994ejc.450.1617311999664;
 Thu, 01 Apr 2021 14:19:59 -0700 (PDT)
MIME-Version: 1.0
References: <20201118230414.121316-1-aford173@gmail.com> <20201130220249.GA3109751@robh.at.kernel.org>
In-Reply-To: <20201130220249.GA3109751@robh.at.kernel.org>
From:   Adam Ford <aford173@gmail.com>
Date:   Thu, 1 Apr 2021 16:19:48 -0500
Message-ID: <CAHCN7x+om4W5jqnuAW4-nMkZLc5nrYu7NUsbM36r0wyFSYa4-g@mail.gmail.com>
Subject: Re: [PATCH V5] dt-bindings: soc: imx: Add binding doc for spba bus
To:     Rob Herring <robh@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Adam Ford-BE <aford@beaconembedded.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 4:02 PM Rob Herring <robh@kernel.org> wrote:
>
> On Wed, 18 Nov 2020 17:04:14 -0600, Adam Ford wrote:
> > Add binding doc for fsl,spba-bus.
> >
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> > ---
> > make dt_binding_check -j8 |grep spba
> >   DTEX    Documentation/devicetree/bindings/bus/fsl,spba-bus.example.dts
> >   DTC     Documentation/devicetree/bindings/bus/fsl,spba-bus.example.dt.yaml
> >   CHECK   Documentation/devicetree/bindings/bus/fsl,spba-bus.example.dt.yaml
> >
> > V5:  Rebase on 5.10-rc2 to be able to check yaml
> >      Add Reg entry
> >
> > V4:  Remove an accidental makefile change
> >      Move type:object under additional properties
> >
> > V3:  Rebase sample from aips-bus example
> >      Split off from series adding i.MX8M Nano functions to reduce noise
> >
> > V2:  Attempted to update yaml from feedback
> >
>
> Applied, thanks!

Rob,

I am not seeing this anywhere.  Can you tell me where this was
applied?  It's not appearing in Linux-next

adam
