Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1C444669F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 17:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233771AbhKEQC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 12:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233753AbhKEQCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 12:02:55 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302D3C061714
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 09:00:16 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id t21so11350304plr.6
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 09:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0q0PbXxyGkpQf/H/RJhsu5iylKKlnhe5mKg7WkVvJy4=;
        b=o8eYMhHyMXOnUZYR0jwoCSnpbLURTgwXxB3rv9b8bREEUZJYXWDNMk9Bre+wtobT4N
         CdVJa6I0XhKPhrWfCaBk9oq9IZ1ClU2ztH4B19hUwR3i4tGB8BLfLGe5qhATNbzP+Z+l
         h7rbCsrCem7VmT2dNJ4k+7TUetDUSRtQxZa7svb9MirdDtKKxRArim0NRPY4DS/QR2BS
         NRLDyIaHJrZDbLi/pbQ/VJc4jypfjor+FwWAaUwqI/4XThMioUW0AT+iUaNbyPqrg67x
         hIqIly2v3WuZcWtvs5LkUgtpmavliZB8aUxCjadmHRB2quNcpSzKVoDLJIPDvXhf/gXG
         fsNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0q0PbXxyGkpQf/H/RJhsu5iylKKlnhe5mKg7WkVvJy4=;
        b=qZpnb/JykZIQFG3AxJvprqg5+OWJ5g9UJKzcjWpqiglmkD2tB+Z1RUuqTuqs3qnTIJ
         kVv/fmEABK/Pf6EoEmUWW6/my+zr6o9QJX5A6CQvBJuD4WHezUVOiHnnchZo9P8pOcan
         +oDfyxV1TMD94nZOaZvoIfKeXN7r4QfIqiiQZ6ewMO1H2vZuhEfRyQ/o59SOYHKuZnGJ
         xNbJy2Ql2m2Gauxp6R+f2FPRiFJahX9Y00VccPPN6cRx3fFgqE4/xgHwvGRLl81/xYBh
         YjGqdTKyuAbUQXaRQ1wgCVhZFXv/MmNA+tljvoYrqvIl0O63nMkVJpr2yfCTteHhHftO
         3fkg==
X-Gm-Message-State: AOAM530c4pdlOMbZeh7ndffPd0a0Tg9dqJw5fliO7nZ+lk24XoYWYo1Y
        FgcZ3tA9XMI9F3DMYz8o0PJ9Aij3xr5FeOQM/jZjTw==
X-Google-Smtp-Source: ABdhPJyVclGSPb40QIO1EB6ouONHYkOT6RnFDfjRKow9PAxjGmlGyIQZu71kdQrtQD6uU0RjmH7xH6oDOSoyo2Y0A3o=
X-Received: by 2002:a17:90b:17cc:: with SMTP id me12mr11318480pjb.179.1636128015108;
 Fri, 05 Nov 2021 09:00:15 -0700 (PDT)
MIME-Version: 1.0
References: <20211023203457.1217821-1-aford173@gmail.com> <20211023203457.1217821-6-aford173@gmail.com>
 <YXn9aibI1C/+eP5L@pendragon.ideasonboard.com>
In-Reply-To: <YXn9aibI1C/+eP5L@pendragon.ideasonboard.com>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Fri, 5 Nov 2021 09:00:03 -0700
Message-ID: <CAJ+vNU3-81Jr_uWcpyCzMECD4ZS7TbDP6ugi02mEf3JMNvRp5Q@mail.gmail.com>
Subject: Re: [RFC V2 5/5] arm64: dts: imx8mm-evk: Enable OV5640 Camera
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Adam Ford <aford173@gmail.com>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-media <linux-media@vger.kernel.org>,
        cstevens@beaconembedded.com,
        Adam Ford-BE <aford@beaconembedded.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2021 at 6:34 PM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Adam,
>
> Thank you for the patch.
>
> On Sat, Oct 23, 2021 at 03:34:56PM -0500, Adam Ford wrote:
> > The schematic shows support for a camera interface, and the NXP
> > kernel shows it is an OV5640.
>
> The camera is an external module though. Should this be a DT overlay ?
>

Laurent,

I wanted to ask you about your comment here. I would agree that for
something like the OV5640 on the imx8mm-evk which is an add-in board
via a connector should be a dt overlay. I'm investigating using
overlays for features like this on my boards vs creating hierarchical
dts files and I see that the kernel allows building fragments with
'/plugin/' but I don't see any such overlays in the kernel tree
currently. Would overlay/fragments be accepted? Are there any examples
in the kernel tree already that I'm missing?

Best regards,

Tim
