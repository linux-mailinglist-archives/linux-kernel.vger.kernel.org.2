Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3293547D9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 22:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236693AbhDEUyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 16:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232553AbhDEUyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 16:54:22 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2341CC061756;
        Mon,  5 Apr 2021 13:54:16 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id e7so13919000edu.10;
        Mon, 05 Apr 2021 13:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6LxZVp7twuk1JHL5Xp5YNmNLmYb9qEFDrvk0yyYE9tM=;
        b=izPft1Q8DNWOqGOzh0EVVXbGudTKc/QkFQrq1vaPGy5hlQl1Rg832THF64ekd0mvTW
         34MdJluVwdeY0nK9mBQgLsk3zXZaB99wZJZ8q8jfAwCttRTElIFj00xZOL5Flk/6d77y
         +6lFSY1YrJnsZDgJhyDjwHaRneP1ZAUNpVaGiQodMjnUEWJE0UK9nhfDy/ipxUdJ3Mmb
         ER5YZaLFrwdcRvxTHbB/esi0RqLhtVTKPNyu+GydJWBEBwoP70dEdXyC559whVj5tJ4t
         wIp5ed1FCjSHHbjgppU6kODjFedGbHdB6mwUztVqZb+irWYqKDBwlem5T4tcW3Apb0/5
         8EAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6LxZVp7twuk1JHL5Xp5YNmNLmYb9qEFDrvk0yyYE9tM=;
        b=tOwTp7F2aJzpU5MKqG/Iel8biUBjGtwCegiMR7r3jAHe8Vp2q8tF9fcWCp/9jgPq6P
         k5OxPMCJ5X48GotuWsCyRcThjqZ8VMaIkY1qiiDDOwBIZxRsl3m9RlgYw2/k/fN0aWg9
         okkHw8Y55SGfUPtHwmXGB14/on6WQKQSBsBjbCLFoq+16dOnrnmk5TZf17Ea9b5XiWpy
         4qqp+7p4whT809rlTo2Bp70E3QsZAoV5ad0x5QL2MfDxJUtzpZXU/1FhZq3WY8JQOZ6o
         6NMjp3e5833n/woPFnPmdP7J2kJdflv3lvlTaZ/cLsoMiVrSNpsa6V7pfv9NVHeAvRVI
         LK4Q==
X-Gm-Message-State: AOAM531Tbi5t78kCgYWv257/VGmMTjl8ME5P/lfdntvS3vy9hh5NkaHW
        87bgRgXZf4HVGPj9g92bKdRfJCdYjz+hAUTlXMs=
X-Google-Smtp-Source: ABdhPJyN+vM2VPpcIcc/xtuCy7HPRYS7fw/LYDVq5myxQKYyLgsXAxiosFhNwD+Pjccyed4xUIMudTIf2EZntQWJgWo=
X-Received: by 2002:a05:6402:1713:: with SMTP id y19mr33524220edu.52.1617656054852;
 Mon, 05 Apr 2021 13:54:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210329161256.31171-1-christianshewitt@gmail.com> <20210329161256.31171-2-christianshewitt@gmail.com>
In-Reply-To: <20210329161256.31171-2-christianshewitt@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 5 Apr 2021 22:54:04 +0200
Message-ID: <CAFBinCCpUC4eYa=HdcmxLxfBU=4JRpSzr+qGUZoHQRq+u0Ok5g@mail.gmail.com>
Subject: Re: [PATCH 1/3] arm64: dts: meson: remove extra tab from ODROID
 N2/N2+ ext_mdio node
To:     Christian Hewitt <christianshewitt@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2021 at 1:17 AM Christian Hewitt
<christianshewitt@gmail.com> wrote:
>
> Remove an extra tab from the ext_mdio node in the ODROID N2/N2+ common
> dtsi file.
>
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
