Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E675344AC5B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 12:15:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245619AbhKILSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 06:18:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245616AbhKILSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 06:18:06 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8138FC061766
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 03:15:20 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id o4so33068982oia.10
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 03:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4hVT10Becr18q5c+7WtU6LwFlNBSvo80lS6A2/bda08=;
        b=ZhXfE8fkb4kM7D/n3iQS5fnoQZmaFTutNdUzpKyGPv436hMukJ9vK1uP8tSpO+PXRc
         M0gVdu0NzRyblMeiuI5wcMuznoCarl71nL8IqX393wppVulXPC/2CW2lP35vMZ5CE+lH
         2B+KjwBr8x+ccQ0A6uNiH86Qp6Yg47a32b0fNz682Z0o0fZEGTXFvbECg4WDTQHhzSgH
         7HcoeYeS+AulErQ4lYSbEqPEhJ/etfjjZDt9rXYyNi1awNAcRgfc0UwYDt+Da7NdwPz4
         5My5tOefwW3IZn2ct0ets51BOzleP69gT4Wz0swbJIRpPG6eQoA30u3F1oDWrDBuEZP/
         NyYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4hVT10Becr18q5c+7WtU6LwFlNBSvo80lS6A2/bda08=;
        b=xqToBjuJvBgYLy1aauNW1LjW0M7wbeTCdvza3kUSWDU5C1FkGX9S8hFbOA5f1epNMq
         MPQf8qT33wY/4ruqYg6levZ9AnapbSA8c7KkVRH2LhX+kxdcPw/vgfzkms6eeJ3bQZtl
         K3WNFeEoTKxef5V22heUyZmmCF0Arzw5xWBlBhLuASLrvZTN4vq+wgca+tSjzq30gRBj
         XWzhhEVkjWKYbHv1Y6x0NTG4MezHZSOw5uhuP5lRs63JCuSWuclgmk0lMxtX9LP5ZkiC
         G4bazfVREUQm90gsgFbtdJSNn128x0oSZZqjL9B0sOGNC69V+qhKIFpm4gfp6ihgnUB3
         wHYw==
X-Gm-Message-State: AOAM5308Lb3Z2JSK4GC3MThPeCyyoU4XLxV7+FV8/teCEgv1b7Co/uwT
        mEpkDlYSwK+U9g+VXEpnIOO6ZIxX0pdQZCORPzbuAw==
X-Google-Smtp-Source: ABdhPJwk/P0SmvmDLHXhXAK1zJywnnYAVMs+ay9ZSTJjMZGRMEHispXDZQ/dpNO4SGj4/9plBxGXloJ/zEgEPWm0dyA=
X-Received: by 2002:a05:6808:60e:: with SMTP id y14mr5037966oih.162.1636456519895;
 Tue, 09 Nov 2021 03:15:19 -0800 (PST)
MIME-Version: 1.0
References: <cover.1635944413.git.hns@goldelico.com> <10f243eccdca10ee34b09fb626500f4a56da914a.1635944413.git.hns@goldelico.com>
In-Reply-To: <10f243eccdca10ee34b09fb626500f4a56da914a.1635944413.git.hns@goldelico.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 9 Nov 2021 12:15:08 +0100
Message-ID: <CACRpkdZgrjfJ5mbstnwPELs_AWqZSBUZ6LXAR031Mm45Aivg_Q@mail.gmail.com>
Subject: Re: [RFC v3 1/6] mmc: core: rewrite mmc_fixup_device()
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        =?UTF-8?B?SsOpcsO0bWUgUG91aWxsZXI=?= <jerome.pouiller@silabs.com>,
        Avri Altman <Avri.Altman@wdc.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Tony Lindgren <tony@atomide.com>,
        Bean Huo <beanhuo@micron.com>, notasas@gmail.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        letux-kernel@openphoenux.org, kernel@pyra-handheld.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 3, 2021 at 2:01 PM H. Nikolaus Schaller <hns@goldelico.com> wro=
te:

> From: J=C3=A9r=C3=B4me Pouiller <jerome.pouiller@silabs.com>
>
> Currently, mmc_fixup_device() is a bit difficult to read because of
> particularly long condition.
>
> Signed-off-by: J=C3=A9r=C3=B4me Pouiller <jerome.pouiller@silabs.com>

That's more readable!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
