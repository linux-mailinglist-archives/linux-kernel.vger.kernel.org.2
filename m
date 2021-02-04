Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9727230EC5E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 07:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbhBDGOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 01:14:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbhBDGOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 01:14:50 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51189C061786
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 22:14:10 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id a1so2074784wrq.6
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 22:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xgHzQqM7Lq62ORquHPkb4VNOYCwVoPGIPjGQe4hn+cQ=;
        b=RrUyEy/qircZcidYS/z9FTtqPHZhNCPKypUymmx5N5+20Osxp1ysGMBpji502uXsST
         4TkZYunVG0bli1+cUBFMsfYszw8dH4Zu2ED869pWa8ijBqnX1U2bpUDYt99pii/5z3Uz
         yirtdioTIviZ5Gowx104V6fcEp6zmcBkfKZde4+GJjY6b+PoXbPm9KMYd0d62LfbZsGQ
         IW89t2WaBb7Tn9NcK/bSEQI4Omx538VBJzSNoLkM6LBfZqNe2tK4jISXrdYFqHmaektP
         by2pxKrKL0cJM9XZIkp5RWYCeT2okfocFGhhnt/JiPc76eyzK457jyqJatFKClPoVoOf
         dAOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xgHzQqM7Lq62ORquHPkb4VNOYCwVoPGIPjGQe4hn+cQ=;
        b=ad4KsGhi9RTb6+sswwIwhsjZc0ZskES0/UVUso5X4bu9VHj8OMqkovioIMDCdcOO+j
         sMboYApOMVE6lP8gIrgKVoerTf/d83So5Q9PW42dfx1LovHvKPxdfCG4bU1urUgDOTmg
         54n5wrTxrGgCnzjp3LlBTFTfSSr8FghgBXGmxU3LXX1Nrxs3r4vaK0xaMS33UWZH8AOq
         0tTjIn9z/PnvSCYcJ6q3VsCVVgVhEW+9cHdpk3CmDIvZMe1zgbwYkQMvXwTfCUTlOWfL
         EDPYYbCRbPxU2M8axYcUz61cmjhGTqfGXUBvWNVoIytpYriaBO3773Oq8b8zdsnz0pbi
         kz2A==
X-Gm-Message-State: AOAM530Nne2nbJZ9rg9t/nX7MGYDGzJf2xv+CPVsRzHkxs65ykpn0/G+
        AMQ9pA+icedREV3AfIUYaSBy+NqEdF2PX578qVNrRQ==
X-Google-Smtp-Source: ABdhPJyC1vkWHqe63BdHOP8poxSwuVrurAeaA1vkzS6TO0q0xtyQ/Ji4LIxcuRG8jCJowNS2WTd51Pf+SJ7KDklg1ls=
X-Received: by 2002:a5d:6092:: with SMTP id w18mr7298340wrt.75.1612419248851;
 Wed, 03 Feb 2021 22:14:08 -0800 (PST)
MIME-Version: 1.0
References: <20210204132043.1.I2392cf11fb353d10459958100b69d93346fa167c@changeid>
 <ec6caa23-28d6-9695-2b0f-b3ba9ef28b60@infradead.org>
In-Reply-To: <ec6caa23-28d6-9695-2b0f-b3ba9ef28b60@infradead.org>
From:   "Anand K. Mistry" <amistry@google.com>
Date:   Thu, 4 Feb 2021 17:13:56 +1100
Message-ID: <CAATStaMRHai=jWr4x1cZVs2MrME+1QSqoXD75xAOQfxb723hQQ@mail.gmail.com>
Subject: Re: [PATCH] x86: Add a prompt for HPET_EMULATE_RTC
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi,
>
> When you run "make olddefconfig", should this "depends on"
> line evaluate to true or false?

True. RTC_DRV_CMOS=y by default on x86 systems and HPET_TIMER also
appears to default yes (on x86-64 if I'm reading this right).

Oddly, the RTC config option doesn't appear to exist. Probably a separate issue.

> I.e., what are the settings of these symbols in the old .config file?
>
>
>         depends on HPET_TIMER && (RTC=y || RTC=m || RTC_DRV_CMOS=m || RTC_DRV_CMOS=y)

Actually, none of these options are set in the old config.
RTC_DRV_CMOS and HPET_TIMER appear to default to yes.

 % grep HPET .config
CONFIG_HPET=y
# CONFIG_HPET_EMULATE_RTC is not set
# CONFIG_HPET_MMAP is not set
 % grep RTC .config
CONFIG_RTC_CLASS=y
# CONFIG_HPET_EMULATE_RTC is not set
CONFIG_PM_TRACE_RTC=y
# CONFIG_RTC_HCTOSYS is not set

>
> If not, is there some out-of-tree driver involved?

No out of tree drivers involved. I tried this on a vanilla 5.11-rc6.

> I'm having a little trouble seeing why this is needed.

So am I. But this is the magic that lets me keep
CONFIG_HPET_EMULATE_RTC from the old config. I did manage to trace
where the option is being overridden in the conf tool, but the
reasoning why is beyond my knowledge.

-- 
Anand K. Mistry
Software Engineer
Google Australia
