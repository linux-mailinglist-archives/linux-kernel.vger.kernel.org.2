Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7BD530FB50
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 19:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239027AbhBDSXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 13:23:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238990AbhBDSXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 13:23:23 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D2BC0613D6
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 10:22:42 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id a8so5967822lfi.8
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 10:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dl1jkO0fwdt4pUp2PZMa/AtL4iCw0WB6gtyM8w8mF88=;
        b=dbsHHieWHrkFxo0Xsex1dXCpAjaZ2InxVFPEp2VXSoU9G0Bl8DUCqCegA00Mtxr08N
         2LgEAkoO5XV7eaXMzAr4+ghm7PTh/+zfFocr4mnL44nAakoh15m8E1Za0UttJGG0t0jW
         U+7O4Sq78Np1dnIS8mkSHL0iMgEEriNz40X6YBokwucZqKY6H1ICPDPbfPxWsPyo27NQ
         cpXeEiiwkzh9qJwwXMcIbJAZkNHS+eBmpP+Kr2ZYQnRJTcggSP6qzQPgRJYW6LPykLc8
         EnEsIKA6+Hlrf3tn7zek3YiDOFrPnmWZ+nSKZKEOGwAed29gmFGh/bU+rf7QrohOoi44
         5LQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dl1jkO0fwdt4pUp2PZMa/AtL4iCw0WB6gtyM8w8mF88=;
        b=F2LHgQQrk7mQrhQ4+qrulm6lM0hIcVTBopkbNm1WJ6snWJTBzHnQaZN14b7b3ZqkCi
         omSSXGzf9A8+x2d1Sngmt6pfA4CT0LJ84Vdso/jQvjCZV4K2Dw8PBgRCTpm9A+SztAs/
         Qb8+hN55PsVsk1g6JeKYIN6bIxJC96A7DAXnav3exkIvJlVSMrKxNOZUil4M792oimbv
         8U+U1iRANv5Ivt6MNpeQGiN6bo/VthWSUFjA6muYrXu2FzOXPTU7kNZHiIMTHC6oPr2g
         knZyTLzapvLHYWLRqugn7Dr/wAaO6wiXaNnaLcNlQLF0p0UTUuJGMTgJog8iknif4EZZ
         Wu+w==
X-Gm-Message-State: AOAM533/sdeY5NrEZZi98kgg99EHmGu/Qk/fMo+GbDNCf+gVDc0lasrX
        +0cf7KtZQLP0karUos3kRFpktoxJXcZJ46HpTzOpOfUD27lZAw==
X-Google-Smtp-Source: ABdhPJwTSKES/HRpi0u7z/hDixxZ6i0UmvJ5AuQQVLwNDoKVcLfRbLbRWwtIcyOeCOlyCd2CjvDEdEllM257X3YYD7k=
X-Received: by 2002:a19:ad0d:: with SMTP id t13mr344921lfc.539.1612462960932;
 Thu, 04 Feb 2021 10:22:40 -0800 (PST)
MIME-Version: 1.0
References: <1612287314-5384-1-git-send-email-oliver.graute@gmail.com>
In-Reply-To: <1612287314-5384-1-git-send-email-oliver.graute@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 4 Feb 2021 15:22:29 -0300
Message-ID: <CAOMZO5CDhUprEn8umeBa0Y3kvU1qSawqJ2Y0-F-EMakmLOu4BQ@mail.gmail.com>
Subject: Re: [PATCH v3] drm/panel: simple: add SGD GKTW70SDAD1SD
To:     Oliver Graute <oliver.graute@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oliver,

On Tue, Feb 2, 2021 at 2:35 PM Oliver Graute <oliver.graute@gmail.com> wrote:

> +static const struct panel_desc sgd_gktw70sdad1sd = {
> +       .timings = &sgd_gktw70sdad1sd_timing,
> +       .num_timings = 1,
> +       .bpc = 6,
> +       .size = {
> +               .width = 153,
> +               .height = 86,
> +       },
> +       .delay = {
> +               .prepare = 20 + 20 + 10 + 10,

Adding the datasheet label like Marco suggested make it clearer where
these numbers come from : /* T0 + T2 + T3 + T4 */

Glad you got it working on your imx6ul board:

Reviewed-by: Fabio Estevam <festevam@gmail.com>
