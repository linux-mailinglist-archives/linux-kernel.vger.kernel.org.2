Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8EF643C550
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 10:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239305AbhJ0IjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 04:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232025AbhJ0IjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 04:39:16 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E109C061570;
        Wed, 27 Oct 2021 01:36:51 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id v3so3393689uam.10;
        Wed, 27 Oct 2021 01:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FZ/r4xCuzoVfg1rTb4wXv0tkWAM+D0xue0Hb3YHjI8g=;
        b=hx/mmb90US3JK4Rv1aPCSq2iakKYlaa8JL8gi3Aa5gqa7SIEGjT/dzasJEUcWOhXd6
         TqrCfrJZ+U41p8/rIOHGv2+Gv9NegbCuoRAu8lrccJb/Z+6bgZOGihSfJFHcCxj0mezO
         vLwAkl0EBcKM9FzY52mSHildEzuBAWrUPXmwK+sNamGXOmr8iV/Jpi52g8evpodhsTD7
         MypJBq7HDr3b6wxSpGyisjSlRufItV4lCSxABdTqk057pO5TixZrUuS/Pt6MWoG0qtw5
         CYvbhGjjLMtDya9sRE89EFypbbHYCx8Ja+Xgch1Rw95sSDJVOcibKC1uShRngNk+rR3q
         6EYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FZ/r4xCuzoVfg1rTb4wXv0tkWAM+D0xue0Hb3YHjI8g=;
        b=wZxU3T456r1BmiOgKZSGMaNwqF5kH3egllOcsyMguni+cvSWXwlsvsAHYV5KY33NW+
         /nN3u6lKyujO/e1d3wZP9iGV6+DJg10/9lE81X+POt92cd3M+w6qBICuhaOvMCNfq3Fd
         6Do0oJNsztelAR+9hOWMtcSt9ib8mX2xrI+oq725YSolWW0nfH85THVl3aXhch9lsUJo
         5fQ99tvC+k/UxSyIT1xYkvNk2j75XEjTA2PDf1CO+th+ie7eVvmzEKxFQz4s1b43vSbE
         YVAV+ily2q1YB6wBHmNchtTtCuniwVEaMi2TV8g4Hqn874/RCwqebT90/n+lMQhfx6kL
         gi2A==
X-Gm-Message-State: AOAM530DCP3+iMmdPQ9wDI/80IMPJwlPc7dJmpNOPrlsYAniwCo6g5pg
        gHcm9DGO4f+hjlbpj0gqaagFMsXhaz/5GzVKvj0pb1V6
X-Google-Smtp-Source: ABdhPJxF2/sXtDaGXuJCrBIF338MMnb8yU9ZyBUJkt/xtC+CxXBtdSsdH5cSBjpOJYEIiCgbXe6ZSiHuxrXnDW+i/Sk=
X-Received: by 2002:a67:33ce:: with SMTP id z197mr20051208vsz.13.1635323810559;
 Wed, 27 Oct 2021 01:36:50 -0700 (PDT)
MIME-Version: 1.0
References: <20211019041659.15761-1-sergio.paracuellos@gmail.com> <YXi5Tm5QYirZeFw8@robh.at.kernel.org>
In-Reply-To: <YXi5Tm5QYirZeFw8@robh.at.kernel.org>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Wed, 27 Oct 2021 10:36:39 +0200
Message-ID: <CAMhs-H-Ohts75+ivL4SfriJ5MixtxTDGotcRZoR-Z5nhR=JKjw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mips: convert Ralink SoCs and boards to schema
To:     Rob Herring <robh@kernel.org>
Cc:     John Crispin <john@phrozen.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        NeilBrown <neil@brown.name>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2021 at 4:28 AM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, 19 Oct 2021 06:16:59 +0200, Sergio Paracuellos wrote:
> > Convert Ralink SoCs and boards bindings to YAML schema.
> >
> > Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> > ---
> >  .../devicetree/bindings/mips/ralink.txt       | 32 -------
> >  .../devicetree/bindings/mips/ralink.yaml      | 87 +++++++++++++++++++
> >  2 files changed, 87 insertions(+), 32 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/mips/ralink.txt
> >  create mode 100644 Documentation/devicetree/bindings/mips/ralink.yaml
> >
>
> Applied, thanks!

Thanks, Rob. I cannot see the commit in your 'for-next' branch but I
guess it is just because you have not pushed it yet from your local
tree :)

Best regards,
    Sergio Paracuellos
