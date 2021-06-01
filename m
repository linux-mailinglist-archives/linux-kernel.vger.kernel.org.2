Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A71213970D9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 12:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbhFAKFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 06:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbhFAKFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 06:05:53 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F28C061574
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 03:04:10 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id z17so13640743wrq.7
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 03:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Oylw+Cwde46yrkq9NbXmlDzaZbfHtwoW7NFHCFszY60=;
        b=o+Ja0NgNlHYuajilaIbSEtRR7d/nAvRXGfyG4FMvl5j8sxaPg/qZbfhF/SAZyH2J/v
         oGzwLPEAtrUkj6nRGMHwn4uBlYxzmGZGK9Kvx+tOM2TjK/3kgjRiWHMFvziXpAFPICCe
         LJGljw02N3SJgP2BwOaRdoK7lbDahiRvHO9zPTfKSg++qZvwbc9qAUQtibMGAmFi2ur7
         B4SNbRpkMSAAq12uBecd1BPN0cJBZw/fDQbRPW5Fc4F2ONZ04a9eLK9jmYXwA4heiM3k
         fLUcnV0LSIPlNPcMPYcyMskOFD9z2cSyGq5rziCG2XmW1o8EA1RLeQ2BVgWnGAqmUGsr
         gq9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Oylw+Cwde46yrkq9NbXmlDzaZbfHtwoW7NFHCFszY60=;
        b=Mhz/jW0NsIBUsjsX1A+U8Xja6SI0xYPQJPbKfz2JNoMKH63oKgoFDigGmuBuyhsbxt
         5RDPvJOtf+dXeYS26iKl4I4G1fcCWt+FoH30K51V3p1x2wXLnZCR/drLVAtWxf7tRmVc
         S0n6XX4HzKsb3gnuwp1BMzTmqYK0nQMG02PLx3E7ZJOeIzD8hQN4EVOxVSUePjhkQP2D
         s4chbIAnRJ+wBamHH7NHuhqiyUqfkUpZU7WMAw23WxYtTdkp959qNMLKFE8ZiJO0OYs/
         dx7qIZV7SIcoylkQ4ybpKJG7bejZz1BPWHTOzLgFgxeyRMaqRTlbgi0g3+DlSOTMFRix
         vT7A==
X-Gm-Message-State: AOAM533EbY51Zq7n6+oG797HbJ4DUMIs5J2eDBUfHvhdaqVAfezwgYNW
        jDXJlGWliEoizcEtyXxeXUPceSuHqllFN4Z2F0Y=
X-Google-Smtp-Source: ABdhPJyYvzLvMWBYADhPC/L0sXKCXJvS8ohDR7Nup1uzs/b/Drk5b6HBrF9cjFYdo3UFMg01jNr5r88J/cOJEYDuDVQ=
X-Received: by 2002:a5d:4744:: with SMTP id o4mr26280927wrs.86.1622541849435;
 Tue, 01 Jun 2021 03:04:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200914150958.2200-1-oli.swede@arm.com> <20200914150958.2200-9-oli.swede@arm.com>
In-Reply-To: <20200914150958.2200-9-oli.swede@arm.com>
From:   Sunil Kovvuri <sunil.kovvuri@gmail.com>
Date:   Tue, 1 Jun 2021 15:33:58 +0530
Message-ID: <CA+sq2CfGu+JPJ9h3Q-nCdmM2erqWbe=p-v_eip-J-R6F2EoXbw@mail.gmail.com>
Subject: Re: [PATCH v5 08/14] arm64: Import latest optimization of memcpy
To:     Oliver Swede <oli.swede@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>, will@kernel.org,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.indradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Sunil Goutham <sgoutham@marvell.com>,
        George Cherian <gcherian@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 8:44 PM Oliver Swede <oli.swede@arm.com> wrote:
>
> From: Sam Tebbs <sam.tebbs@arm.com>
>
> Import the latest memcpy implementation into memcpy,
> copy_{from, to and in}_user.
> The implementation of the user routines is separated into two forms:
> one for when UAO is enabled and one for when UAO is disabled, with
> the two being chosen between with a runtime patch.
> This avoids executing the many NOPs emitted when UAO is disabled.
>
> The project containing optimized implementations for various library
> functions has now been renamed from 'cortex-strings' to
> 'optimized-routines', and the new upstream source is
> string/aarch64/memcpy.S as of commit 4c175c8be12 in
> https://github.com/ARM-software/optimized-routines.
>
> Signed-off-by: Sam Tebbs <sam.tebbs@arm.com>
> [ rm: add UAO fixups, streamline copy_exit paths, expand commit message ]
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> [ os: import newer memcpy algorithm, update commit message ]
> Signed-off-by: Oliver Swede <oli.swede@arm.com>
> ---
>  arch/arm64/include/asm/alternative.h |  36 ---
>  arch/arm64/lib/copy_from_user.S      | 113 ++++++--
>  arch/arm64/lib/copy_in_user.S        | 129 +++++++--
>  arch/arm64/lib/copy_template.S       | 375 +++++++++++++++------------
>  arch/arm64/lib/copy_template_user.S  |  24 ++
>  arch/arm64/lib/copy_to_user.S        | 112 ++++++--
>  arch/arm64/lib/copy_user_fixup.S     |  14 +
>  arch/arm64/lib/memcpy.S              |  47 ++--
>  8 files changed, 557 insertions(+), 293 deletions(-)
>  create mode 100644 arch/arm64/lib/copy_template_user.S
>  create mode 100644 arch/arm64/lib/copy_user_fixup.S

Do you have any performance data with this patch ?
I see these patches are still not pushed to mainline, any reasons ?

Also curious to know why 128bit registers are not considered, similar to
https://android.googlesource.com/platform/bionic.git/+/a71b4c3f144a516826e8ac5b262099b920c49ce0/libc/arch-arm64/generic-neon/bionic/memcpy.S

Thanks,
Sunil.
