Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F55832A97A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 19:33:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443531AbhCBSaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 13:30:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1575905AbhCBPfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 10:35:11 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73BE0C0611C2
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 07:31:11 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id m22so31930437lfg.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 07:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fL0AumZD+ZV7RDH5XqYhmB5OulPM6pG2ol2pOztokaY=;
        b=yG3i7iz/rEBxhg/9yaFCE017PRiu8UQYzvqpTXVz7+qqlbWT8yIxJ+4AsNwt4++VTj
         H8BwQsDP0JkYDinVG4+5nmWp4lyFKLEyBJ0L4z5YNMvCFDxlqhrAkleFkoFzuhldfqPe
         vq/ngnv+tGJKyYuqxSV8uzVfPKIrTrjuW6LbAFeAZ5qqcM41wv9fdYR4yELa/aAwUS31
         2leRshpu4SxH91IwatuegYY+ZQZJosi/oTJiqJS3XkdWjXUMbw49xGKB/vSgJt6sfXzc
         vlYF2ATOgXIIj+z0WWnRNJDrBYLoM3hcEhRfM90c208VKTsMz2OFeVpDVG2/3DnLpFWN
         bU3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fL0AumZD+ZV7RDH5XqYhmB5OulPM6pG2ol2pOztokaY=;
        b=i0+7QHfit8wbevaMyBnzX0Fl7jQICbKOouIYSg2Yq9ZMODLcmtltxjg3qvhq4vyzMC
         F3iCw3I+DgUn4pixBAh7sRW5/5YnD394B+Qeal38bM56NsMJo+DwwPYg6Bn8N5/vrSkP
         vdSPsLhE8az0a4Vv37edH8kpG827ZrKJ0DrU6k+JVbATo3gbpibMWVzu+CTVzzELAEs7
         gnPrrhrZNTzGWuX+1BE66WOXDLOdvhUoF/lVG4HkFO8fAK4AStWjtrXibLZgPMMkYLnr
         2diPx9H/m/AvRyBNkMIFn1LXqeRLw0o1tpWmerduqqR79YecZRtZbYoIKYfzFAcRWqUp
         0LiA==
X-Gm-Message-State: AOAM533fPA7bXrZ1Fre0iS/OvTLJAiMm6yRQRdyLVZGFXBkscvJkOWxM
        zgXd8MPNpCjMmP3035lV7O6fRNCV3ZE8wliHkoxPuA==
X-Google-Smtp-Source: ABdhPJyF/0gX8VnffeJrG1RyJd6Yz/yaX9phga01OuwC40B8O7VAx0FsD7hVckpnvKypLK4OM9edN/3JLx6x9C20ZLU=
X-Received: by 2002:a05:6512:74a:: with SMTP id c10mr12816686lfs.586.1614699070004;
 Tue, 02 Mar 2021 07:31:10 -0800 (PST)
MIME-Version: 1.0
References: <20210225164216.21124-1-noltari@gmail.com> <20210225164216.21124-7-noltari@gmail.com>
In-Reply-To: <20210225164216.21124-7-noltari@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 2 Mar 2021 16:30:59 +0100
Message-ID: <CACRpkdYvkr_8mJMjUsLWq09HYaOey7cmWivOxscnX9jrhA-E=Q@mail.gmail.com>
Subject: Re: [PATCH 06/12] pinctrl: add a pincontrol driver for BCM6362
To:     =?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6IFJvamFz?= <noltari@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jonas Gorski <jonas.gorski@gmail.com>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 5:42 PM =C3=81lvaro Fern=C3=A1ndez Rojas
<noltari@gmail.com> wrote:

> Add a pincotrol driver for BCM6362. BCM6362 allows muxing individual
> GPIO pins to the LED controller, to be available by the integrated
> wifi, or other functions. It also supports overlay groups, of which
> only NAND is documented.
>
> Signed-off-by: =C3=81lvaro Fern=C3=A1ndez Rojas <noltari@gmail.com>
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>

Same comments as the other drivers!

Yours,
Linus Walleij
