Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77DCE36EC49
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 16:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240247AbhD2OW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 10:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235277AbhD2OW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 10:22:58 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD5CC06138C
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 07:22:12 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id l22so69252436ljc.9
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 07:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+8pq1Kqgoz6ZHvHL1zhX2LjB8GHuu5vWdNBGM6IWtfM=;
        b=mc/mJJ0M5BjWs+AjcEuzQcK+z3rfCbbAjE+T3jWnBcpqDFrDa8zY1c2Qpfo3Ty2Agt
         lUsvYrGyB0mYE3+D+skpru7sgUnAF9hNnodvw+M3+CHBrEN9LdA1pDtjXCNhcrU9T70V
         LdPqecJEy55gdmVPNaCM1SFW6rwT4DGmkCaSN/nrWDXiIyEi1jnydnLTnf/jI3W7qr1M
         ptbrsV8UGkuYacdZhx6szz1DJBINrGOTp5rcmDH9bjND3duVEgoGey5gIj+7OpychOK4
         XeKR5SnCCKLL3T84Rh+4tnCrZsUaEOH4Yp7N5xECrNLp5ZdYJBe8tjCp/96ixUp9K0wd
         8okg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+8pq1Kqgoz6ZHvHL1zhX2LjB8GHuu5vWdNBGM6IWtfM=;
        b=GoIUoEwUz9XaaYe5UH9rLNvDClpDvCCCdQ8eHsTvCyzOlMneNYDm89u8giUj8w5xYS
         TL9HoFvB251+kh6be6IVLpZWcmAIkR8KB9UQeP7XJ5SR2FRlj1wFMIz16QSlY8E+UjYE
         SJx/3ata18ji1xN8cqKbxlGLLg7+Zgphf88PotB0bMPw3mOKuRk9H2p753RrqAdppzvQ
         rCsFD1ak4D9gVh8cykL9nn8foTTG2cpRjXHiDGi/kUIcQi2TLiDcs5U0uxXOEMTLNEjT
         EpSc8sv90wSP2MI76AYOp4+lzjUhStZ76VCER82Tu6yowrnzJ6LYI+sW7WynChlij7MU
         5k1g==
X-Gm-Message-State: AOAM531yTF1fsLKXlr3cGrHIaPsrsDPoFWZ2Chd9BnK61QHUVvKVmZVM
        NFL80eWH0jysHUrobDAuscpXhGzEOFHBl+8JI90iJg==
X-Google-Smtp-Source: ABdhPJzO35dKKTFRnT/r8hEfK4HSyi7SS5FjyS1L0dYZ1L4/ErLt2jFnCudZRuNqvaW0hAT3ICWgwi1ERk6Jn5gjP4M=
X-Received: by 2002:a05:651c:c1:: with SMTP id 1mr23822611ljr.467.1619706130628;
 Thu, 29 Apr 2021 07:22:10 -0700 (PDT)
MIME-Version: 1.0
References: <1619080202-31924-1-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
 <CACRpkdaDP+JnCP+go9hZAObnNgmJyJRDFypX2CZGp-UJBh5wNA@mail.gmail.com> <CAHp75VfpvPdAAW2JpvdiDtzS3LUF_=Ej7c2LEML_+pOwi6CtWg@mail.gmail.com>
In-Reply-To: <CAHp75VfpvPdAAW2JpvdiDtzS3LUF_=Ej7c2LEML_+pOwi6CtWg@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 29 Apr 2021 16:21:59 +0200
Message-ID: <CACRpkdaxTxCz=LJuGL_wCNTZESK0opixBzLass0w0n8A6P7mfA@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] Add ZynqMP pinctrl driver
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        git <git@xilinx.com>, saikrishna12468@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 23, 2021 at 5:55 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Thu, Apr 22, 2021 at 12:14 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> > On Thu, Apr 22, 2021 at 10:30 AM Sai Krishna Potthuri
> > <lakshmi.sai.krishna.potthuri@xilinx.com> wrote:
> >
> > > changes in v6:
> > > - Rebased the patche series on 'devel' branch in pinctrl tree and no
> > > functional changes.
> >
> > Remaining patches applied! Thanks for working so hard on this!
>
> Hmm... I have had a bunch of comments. Okay, they may be addressed by
> follow up(s).

Sai: can you please address Andy's comments with replies and/or
follow-up patches?

Yours,
Linus Walleij
