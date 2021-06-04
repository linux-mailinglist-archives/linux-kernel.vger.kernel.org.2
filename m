Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49C8239BE6E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 19:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbhFDRUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 13:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbhFDRUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 13:20:46 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CBF9C061766;
        Fri,  4 Jun 2021 10:18:52 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id ho18so4636177ejc.8;
        Fri, 04 Jun 2021 10:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aV8VFwDqQyLM7O/HC0yXgAxy4pRZKgMLngJbx9RyuLw=;
        b=r0PFQO3W+KWBaNQd9bdmLdmneEcX0chXaML3BDsrowJ2hvRJ0KdPRAuw7blwxP/6lM
         nwme2xV9y2H/tmYu33xcBcmrDVvaFkt6hCFm90AlnTOvEScyVVz1+Q5HMB2g25p0zKbi
         l7mzBvLH/5tz6TBtsgvLHcdXtU8ADcWXoK6ekTlcc4XhfFuRiVq/XbN53NwVD6pjJLB6
         xmLF2He5kAEwqrS4Zpq4NSEl8dXj2ppmntpg9mD5h32AWrxc+h2aLTqrm2CcaaYdsA3m
         N3TgjGIbybuaRxsIM7giWe2zn/59EHbaW/wk9G8I6JR05zEH5n7gtmXqiGl48SWPYF2R
         4sdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aV8VFwDqQyLM7O/HC0yXgAxy4pRZKgMLngJbx9RyuLw=;
        b=ONP6Ywn7S1xILS+N5xk5pBAoaSn5xIp+sMpjMUereJNmiVYTKgZmgviSStffoq9w6o
         CoMosijw9RUwEpMiTPhv3aG9JN5zZOaEcCEshKUlOayxGVrX7G0t86fstlNdNBO9evsC
         /KnRG7DoEjn0mr6Y7Wm+5UR+oXzu2SyUW1Qb4WjpH7wguBf0tAtlT++6D3pruqVtj9pE
         AJ6Ltrfp2RwG3ZkAN/2gUR+ieOszreKBQe3Ob1AwasCDkeT/vhHU55p6P4+Usj1GxpF9
         wwlYQ2jorhmA3Iwdso5LGJMtH281TFbyO3vkbBrsAt9nLf6ixL4M9XMI7zP8rBzAEuiD
         jFQA==
X-Gm-Message-State: AOAM531e5G7F/GLPZKwnXTOaipE1LR13rtfKk96yQho2vCKjoWgp3VPj
        5lLJ6thXaFUGhCiDznT1XO7OowFnMPHjq/JdMyY=
X-Google-Smtp-Source: ABdhPJzmfa3gSEAJuAKzn67r0Jj59tYYouwbp4UpcgEO7HHUdbgQpZjEUqVT3vW5n6TSpxJr7orxiv4DyldBSQSjhKg=
X-Received: by 2002:a17:907:2d8d:: with SMTP id gt13mr5324328ejc.162.1622827130788;
 Fri, 04 Jun 2021 10:18:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210524103733.554878-1-martin.blumenstingl@googlemail.com>
In-Reply-To: <20210524103733.554878-1-martin.blumenstingl@googlemail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 4 Jun 2021 19:18:40 +0200
Message-ID: <CAFBinCDn_0TeyLG9b9uB+4-4PdeNXgja11wf2CGcQ99tUNjkyQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] clk: meson: rounding for fast clocks on 32-bit SoCs
To:     sboyd@kernel.org, jbrunet@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>, mturquette@baylibre.com,
        khilman@baylibre.com, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome, Hi Stephen,

On Mon, May 24, 2021 at 12:37 PM Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> On the 32-bit Amlogic Meson8/8b/8m2 SoCs we run into a problem with the
> fast HDMI PLL and it's OD (post-dividers). This clock tree can run at
> up to approx. 3GHz.
> This however causes a problem, because these rates require BIT(31) to
> be usable. Unfortunately this is not the case with clk_ops.round_rate
> on 32-bit systems. BIT(31) is reserved for the sign (+ or -).
>
> clk_ops.determine_rate does not suffer from this limitation. It uses
> an int to signal any errors and can then take all availble 32 bits for
> the clock rate.
>
> Changes since v1 from [0]:
> - reworked the first patch so the the existing
>   divider_{ro_}round_rate_parent implementations are using the new
>   divider_{ro_}determine_rate implementations to avoid code duplication
>   (thanks Jerome for the suggestion)
> - added a patch to switch the default clk_divider_{ro_}ops to use
>   .determine_rate instead of .round_rate as suggested by Jerome
>   (thanks)
> - dropped a patch for the Meson PLL ops as these are independent from
>   the divider patches and Jerome has applied that one directly (thanks)
> - added Jerome's Reviewed-by to the meson clk-regmap patch (thanks!)
> - dropped the RFC prefix
please let me know what you think about this v2
I am asking because clk-divider is widely used, so I'd appreciate if
this gets some time in linux-next (so for example Kernel CI can test
this and report issues if there are any).


Best regards,
Martin
