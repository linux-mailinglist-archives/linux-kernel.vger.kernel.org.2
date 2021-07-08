Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3976B3BFACD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 14:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbhGHNBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 09:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbhGHNBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 09:01:33 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E19EC061574;
        Thu,  8 Jul 2021 05:58:52 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id t3so8386038edc.7;
        Thu, 08 Jul 2021 05:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F7/IfADTgL9yOioxWQhJ9S28lRDKiNWk3KD0yBlKwCc=;
        b=TVDT44os/tMgjVjvo9RbDXQC2OG0po0QN8RuKbGmR6lSsyGZkhfPmFFFQWJ1J6Cv6a
         qwcBn4C2BtVAAJehF1M8KyljHri4p1r0L9nL544ITb5DxJILtZ9lHI2qa35IdkMss6Ge
         2JH/NzBbB2Oc47ZRRkKablIVKytugjXCHUCr7nSLKnCuOY97+FDO52+cNq386reO76oR
         /vA12fxSIgzNpLeXKPXSw9tuNt3CBAXZEhMGKttBDUtHs/WTpCAhxNXJNOofJjlPr1m2
         NEyo4iyZILSsFEWir1mNxStXvNFbd1MxgGkUURjdWPMRw/Y4G85baBw5h6PvKLBXqxIo
         vymg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F7/IfADTgL9yOioxWQhJ9S28lRDKiNWk3KD0yBlKwCc=;
        b=AUVp5y7bbuFmOcpGjZAsqJFLeIMogQeBSM+xBnZL7CA/ZB+E1j3UOlpRwbUE2h0Hlm
         iuvvOTtTI83EdXHZyWHGHReIk29ltgsFtaHaD42P6crpOzqOJrvYCRt4XwmMG5x6ZqSW
         UR9/nlMFSs0DUusocXhgQYiIagr80BQFJhZGrrIFl6MaySXp3vA2I8+8yNbwiU+QqWda
         ukTysI7vcDLNkElBxm5vWWn2mETupuYMHo/MfJubvx6seGkWIcHuGbWlCadpdfm2Ot75
         Pnkd2fgNZLgz6g9oWl1RMwFKSnM+68skxBO/aDhr/k1mdKHKVoH1C/DelynF8yPzfq9m
         nugg==
X-Gm-Message-State: AOAM531RtliSMt8c0DTuipiMR0vBJAaSGYLQhV49MjiEwgiaMZujSxKH
        BOX8fbLREnaHJyDNEzBqy85LQTw/vXo+NOW6gqI=
X-Google-Smtp-Source: ABdhPJxh5e6Dih0tKgLooQiJgxsMnUHsrh4ajZkKoXviZRRgTEijVM+wNachv7JUoRtRkhpprj5tihI+WBFAnmw3tyA=
X-Received: by 2002:a05:6402:190c:: with SMTP id e12mr4828457edz.176.1625749130631;
 Thu, 08 Jul 2021 05:58:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210705112358.3554-1-linux.amoon@gmail.com> <20210705112358.3554-4-linux.amoon@gmail.com>
In-Reply-To: <20210705112358.3554-4-linux.amoon@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 8 Jul 2021 14:58:39 +0200
Message-ID: <CAFBinCAkAz7Vhd6Rkk3RYC7x7i-yZiNykObTxv-R2wYCTxHSRQ@mail.gmail.com>
Subject: Re: [PATCHv2 3/3] ARM: dts: meson8b: ec100: Fix the pwm regulator
 supply properties
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 5, 2021 at 1:25 PM Anand Moon <linux.amoon@gmail.com> wrote:
>
> After enabling CONFIG_REGULATOR_DEBUG=y we observer below debug logs.
> Changes help link VCCK and VDDEE pwm regulator to 5V regulator supply
> instead of dummy regulator.
>
> [    7.117140] pwm-regulator regulator-vcck: Looking up pwm-supply from device tree
> [    7.117153] pwm-regulator regulator-vcck: Looking up pwm-supply property in node /regulator-vcck failed
> [    7.117184] VCCK: supplied by regulator-dummy
> [    7.117194] regulator-dummy: could not add device link regulator.8: -ENOENT
> [    7.117266] VCCK: 860 <--> 1140 mV at 986 mV, enabled
> [    7.118498] VDDEE: will resolve supply early: pwm
> [    7.118515] pwm-regulator regulator-vddee: Looking up pwm-supply from device tree
> [    7.118526] pwm-regulator regulator-vddee: Looking up pwm-supply property in node /regulator-vddee failed
> [    7.118553] VDDEE: supplied by regulator-dummy
> [    7.118563] regulator-dummy: could not add device link regulator.9: -ENOENT
>
> Fixes: 087a1d8b4e4c ("ARM: dts: meson8b: ec100: add the VDDEE regulator")
> Fixes: 3e7db1c1b7a3 ("ARM: dts: meson8b: ec100: improve the description of the regulators")
>
> Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
