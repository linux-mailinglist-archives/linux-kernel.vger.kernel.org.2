Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2457F30EF78
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 10:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234937AbhBDJSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 04:18:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235221AbhBDJR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 04:17:27 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A906FC0613D6
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 01:16:46 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id e15so1854309qte.9
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 01:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AmBt+QBUa6Rk8Esa6z3e1upLAfuFMaxUM0Vmij8Uhxc=;
        b=M+WH+ecDqHze/MNXKkDmtT5nkjcD8fZGebwEVipByySFmMSiXJ1pMZQn4rL2Rds1FM
         7oo+GHfTPF4d5F/Dk3dZinp0Rtym8aRQ9AUtVjnow+1gNqhYvYBflm7RbGJwb1VKgABE
         enTvlQJTJnCPsY+ZLlwURSO/YU0FTRVNXINSg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AmBt+QBUa6Rk8Esa6z3e1upLAfuFMaxUM0Vmij8Uhxc=;
        b=Lyelp/U0+BWGn14D8cn2/12QBbD9iK3IZD0ADFY5/oWAtjlhtYVlX/EUpwuJyY12Gh
         BADij9u+mPX8ImzsMynkUBmOJ3Nsrx+CHaJaWDytM0mt9cNdlrFLIUD3wI5Cyfj6vZYM
         IxGHnW0aw2B2E7NrlPrrbLqMnGV6cxxH4Syb9EWHH6k+S3YLeO4Eg+xAk+uo50Sd/Ake
         ha4RlUw2BPqoPgudDKyR4/FPIgYSZLa7kjGemr67x8tq3E5aUm0SLO4UPezCRwvBcTDU
         117QgSANG580DEeVNlzYsY+2tDJbS3CXA6ghdCADb0vX1RXXUVAAFJLvTE8sZdvpbdIO
         AK8w==
X-Gm-Message-State: AOAM530rOx81eqnaB4KbM4i0krArtsW10qf8Z7IprhL7Vp5QBT4rYEwx
        5bW2EYg4YuhIfQ+GByjssjoniWYvBWCLtV8zs90v+M/FxnG5wA==
X-Google-Smtp-Source: ABdhPJwxRYDC5+7x/VZ8/QtUKjMZ5v/NvWdXnQsK1Tls9r7rCTig7B32re1NJS7G+V/Zgmg+vedWvgfVV9kYd4aNJ4E=
X-Received: by 2002:ac8:1c61:: with SMTP id j30mr6242823qtk.297.1612430205031;
 Thu, 04 Feb 2021 01:16:45 -0800 (PST)
MIME-Version: 1.0
References: <20210203021539.745239-1-pmalani@chromium.org> <161242303435.1051580.1469403981857153644.b4-ty@chromium.org>
In-Reply-To: <161242303435.1051580.1469403981857153644.b4-ty@chromium.org>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Thu, 4 Feb 2021 01:16:33 -0800
Message-ID: <CACeCKaekU7o57ucFM7RSNM0_0N8GLMc54Dp4VQYAxMnVaEnmNw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] platform/chrome: cros_ec: Import Type C control command
To:     Benson Leung <bleung@google.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Utkarsh Patel <utkarsh.h.patel@intel.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Benson Leung <bleung@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Benson,

On Wed, Feb 3, 2021 at 11:18 PM Benson Leung <bleung@google.com> wrote:
>
> Hi Prashant,
>
> On Tue, 2 Feb 2021 18:15:37 -0800, Prashant Malani wrote:
> > This command is used to communicate with the Chrome Embedded Controller
> > (EC) regarding USB Type C events and state.
> >
> > These header updates are included in the latest Chrome OS EC headers [1]
> >
> > [1]
> > https://chromium.googlesource.com/chromiumos/platform/ec/+/refs/heads/main/include/ec_commands.h
>
> Applied, thanks!
>
> [1/2] platform/chrome: cros_ec: Import Type C control command
>       commit: 3ec28d3673362076444e290bdb0d94ec6432dc09
> [2/2] platform/chrome: cros_ec_typec: Clear Type C disc events
>       commit: d521119c8b0d70b91971d632430ec1143e5d2e26

This (patch 2/2) now looks like it will lead to a conflict with the
following patch which went into Greg's usb tree:
cefc011f8daf ("platform/chrome: cros_ec_typec: Set Partner PD revision
from status")

If we want to submit stuff to for-next, perhaps the immutable branch
should be merged into for-next?
