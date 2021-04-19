Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7BFA364222
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 14:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239225AbhDSNAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 09:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233225AbhDSNAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 09:00:20 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5FF3C061760
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 05:59:50 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id d25so10887042vsp.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 05:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SfOA2fJqrmUH0V6oeInMKkmh/Za44ba9W6xTvurj+Fg=;
        b=ZPCOd5rTk9IhUMyu4sOkEi9OUk4b17rIFqbKSWh1MU7CDJmpdr43mu007PIONyCmM5
         lVfRVHV8kjnLm8QToRcYwXtnuOYul94cPley36foigct7s2u7UKa1iHR/VGFuG0e2DKx
         VFUii2IRIwH/frKzMD1RtlATkgJUlgbUv7G4PO+oGTftEBSHsFc4NJ22varpbKHBs9+Q
         UoFClrHwKttWssaO04p6c9hnGmKNxrQF2u6sLFUhtQWzMxh4HNwHvg6BqJ3/UASCwE2r
         SQKAwtcDqdXwJsNeMdShk01vMJYAbsLj6ehrBVU57TneX3u2hFuRCjzd4WyJKcGLJblj
         54Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SfOA2fJqrmUH0V6oeInMKkmh/Za44ba9W6xTvurj+Fg=;
        b=kTXvOX4AeUPVS0SS6eLbcS1MCa0K0FJnLQkeE0yipHARIQlCBzcDhzhiiNOgywwCAK
         kH1uQK7m1zymheDEX8K6dhuqHCOkucXhM4rD69txXHqO0FKDfmqrDTTxxdVc68KPkC1H
         4OlMBtpomGyhAzI35m0AJP8i+frfw+smi4QzYFA88otNg1b9dPm/dtmuixMq9kIrVyTb
         jy0Hl3iyHW3JeAKVO10StP6KAHhYmn07i+1cg0VpzqxygNrUwJakByISjuaLHXwB9cdk
         d1emNfvWlb1XPcS5nvPXWYe7vvAi7PwE26Pa/NVgpDVXzKRiI0vEMws1np10rbhgtLdP
         RcDA==
X-Gm-Message-State: AOAM532h2mqACeqYzq43dOkzFtPRQO08rphsQZgzIvtvZ6ZnOh907EMy
        ADtoam/n1NaYqxKC5x09WjkbZwsbrU3TCA61no5V1Q==
X-Google-Smtp-Source: ABdhPJwt1y1ZpSzLC3eFat/GmkHji1q5G6LFnEcx8ONWvqUG56tiSZD8J1yXKo7UpSxwEbzmrOyArcpO7WAfHaxceHo=
X-Received: by 2002:a67:e902:: with SMTP id c2mr1456865vso.42.1618837189916;
 Mon, 19 Apr 2021 05:59:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210419122943.68234-1-ulf.hansson@linaro.org> <DM6PR04MB65755248E394D37512288DACFC499@DM6PR04MB6575.namprd04.prod.outlook.com>
In-Reply-To: <DM6PR04MB65755248E394D37512288DACFC499@DM6PR04MB6575.namprd04.prod.outlook.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 19 Apr 2021 14:59:13 +0200
Message-ID: <CAPDyKFqqrqhwk6XPgmnfyj7Hh_8aRN3kHSHR7b4E+RVGVYDKhw@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Move eMMC cache flushing to a new bus_ops callback
To:     Avri Altman <Avri.Altman@wdc.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Apr 2021 at 14:46, Avri Altman <Avri.Altman@wdc.com> wrote:
>
>
> > To prepare to add internal cache management for SD cards, let's start by
> > moving the eMMC specific code into a new ->flush_cache() bus_ops callback.
> >
> > In this way, it becomes more straight-forward to add the SD specific parts,
> > as subsequent changes are about to show.
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Reviewed-by: Avri Altman <avri.altman@wdc.com>

Thanks! Patch applied for next.

Kind regards
Uffe
