Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45FA537BE2F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 15:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbhELNZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 09:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbhELNZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 09:25:25 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F734C061760;
        Wed, 12 May 2021 06:24:15 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id i9so27148277lfe.13;
        Wed, 12 May 2021 06:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FNt+NOcWM8X1QJ7llYMoCnrfDlcGrj2tEmZi8pUq7O8=;
        b=qOWvRvG7tzgimbdfyTHQ7s8eJVvPGW7eBJMyIZ2evsp1iXImlG/8vtJfM53xv/cm4W
         UlRZbYkQnMWZHJx0+mxlQR43MIK+DaaJYHnUH0+3sZu1KMjg88ipdKn/maaJAt9e2aZB
         put/LJunWg1p9PS9HCLQYJFPrT6xIojlyc2UV+Bcx3TT0JyhdG07K58MjdkFoEJUE1JL
         m6ewPsZN4Z00WjRyLBrJhBaugQfsgdcoXLLyzyMH57tTWbERketJlQRXtuTIY5QCXqu/
         lgqTpYTXBigYquhBLNt+L/NWXGXlutO3n+dpZ6XvQ1/X3jd4FzQxfgHCv7rNgzmbWcNV
         RmmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FNt+NOcWM8X1QJ7llYMoCnrfDlcGrj2tEmZi8pUq7O8=;
        b=ftOyKMsfSeMCVKxEA+1vJvY9TXdY51ezVbOFA6t5+ttYLmdBEFykFk3o9/OeNyRcdW
         54orqh4nO+OAp0GEGMZgxEts1YOcVD8ZqR8Yq8LSxuf2KzwOUJHDzJnEAEEECbd6REKq
         F8r9oxstZXwKT1vWeNnzWEl8Y+HrQMeneNCVin4TnuydePJfD5BGw5my60jRVTkVPk0I
         83eVZIM+iw4yz0DaSVurDJl7yevtJmg0Zh16byl9kFep3RyasfHQS7muQvKb4u6v7Qx9
         chTN7hKqNkruUDimDAJL7jefAYgHi2J9lTscd2zivFILzvWijnNZi42SonuD6StVZV9Y
         WW6Q==
X-Gm-Message-State: AOAM533YXwmr7eRL2hy/skzS4HI+Xlxwrakl3/k1EE1moQ24MqlNy9KO
        dkU0Oxivai/ZH3gSJ6bKlkZa5PVxTtDPFwS4+Ns=
X-Google-Smtp-Source: ABdhPJzPH/WVZDS5OucEds1xF3JzYycwl3MbagkYpZIqK8/hfDllSm5c2ngzuBI8JvgJM5di53AUtl/mY/I4aDjZq9Q=
X-Received: by 2002:a19:c391:: with SMTP id t139mr26232562lff.295.1620825854210;
 Wed, 12 May 2021 06:24:14 -0700 (PDT)
MIME-Version: 1.0
References: <1620813510-31079-1-git-send-email-michal.vokac@ysoft.com>
In-Reply-To: <1620813510-31079-1-git-send-email-michal.vokac@ysoft.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 12 May 2021 10:24:03 -0300
Message-ID: <CAOMZO5D-UxVbFZRfrHrv83R8Q=O4Rs1YkCzoF152ou=oU+=baQ@mail.gmail.com>
Subject: Re: [PATCH RESEND] ARM: dts: imx6dl-yapp4: Use aliases to set custom
 MMC device indexes
To:     =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 12, 2021 at 6:58 AM Michal Vok=C3=A1=C4=8D <michal.vokac@ysoft.=
com> wrote:
>
> Until commit fa2d0aa96941 ("mmc: core: Allow setting slot index via
> device tree alias") was introduced, our usdhc3 and usdhc4 devices
> were enumerated as mmc0 and mmc1. The mmc1 device is used to boot/update
> the board and its name must be fixed.
>
> With the referenced commit, aliases from imx6qdl.dtsi took effect.
> Override the aliases to get back the original device indexes.
>
> Signed-off-by: Michal Vok=C3=A1=C4=8D <michal.vokac@ysoft.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
