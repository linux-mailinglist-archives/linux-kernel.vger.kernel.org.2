Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDEE6334C17
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 23:59:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233530AbhCJW7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 17:59:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232523AbhCJW7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 17:59:02 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F92BC061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 14:59:02 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id q25so36387062lfc.8
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 14:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N68/UEUzlpif7Ax075aqYxprAMrYKWK3Ssev8phjkaM=;
        b=yvUcCC1gSAOlgiDwgi5B7EC/gKPt7Jr6aw1ASICE4SntLDDliq2VAnNy6AZofg4RTM
         PXpOUI79Vn0rE4RckPFB4KU+zR70TGSPDMFmi3zG1a/T4Q8mwBz3yqFN0VGD1eQw+TsT
         QQiGJ1vsoy5qKKEgJpU2AWdd5dnvbOk9Z+l2i2yQ3wClVwI7ltAORb6KzH6a8Qr3Aw7j
         GE9l1kwYZwY1Nleg2tRz6frwvvDY2AZ/r5WToT5yBXB45M40w7qXwAhwPe0n3+/aoMaj
         BzwJdv8gfoLaeWEZ+/mn+4QeGnQgymzlnufGZA4hABAtn0ZS5mOSMHDR0tVeyJn5Maxj
         5Nww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N68/UEUzlpif7Ax075aqYxprAMrYKWK3Ssev8phjkaM=;
        b=YYcRGYR6NZTV/DtmDNvKxqA6DRorKmbQo3VhzkxlVaNHyq7sbuvuxWH+KF6Lwn6vPe
         O2W69/KCedX5vu5FEAlXNPIHj/6xFm9jqORnrhVGPMVFtj5Q6KYScIPLY19nrRwDBexg
         /ARfhzi43BjlCV7jRqDrvbAgkouMXPhDIekyumqOKEH5KMrzeP6OVD80PEmfr7zV/tc8
         4cixNzGw0GT1AOXOdRO+z7jkgWfnu+/kngGIVgPSlt0dKICzksJJVw0ap26ElAtt9OVs
         aKmFrYTP9ZZGmXctDPk+2faeYIX/3wDl04+Z9kiFVw/xPlOlyJtmRMNFFn2QbJTzYje0
         cR3w==
X-Gm-Message-State: AOAM532F40rYF85BfrUsHjhNzKaMuXCjd2/2f3vn5vs0sAmDaujOCZM8
        Tqp+0t35hyVlfuWJlvHfDr78DTUOw/vKwUhh0c7MnQ==
X-Google-Smtp-Source: ABdhPJwgJjRVFNbR7sDlEvybOfyGPw+Qfct55BdTShLcobamBGE6tDfd41XZY1h4VDsdpIw15BRLXHYkHe14mpZBa3E=
X-Received: by 2002:ac2:4d95:: with SMTP id g21mr469271lfe.29.1615417141090;
 Wed, 10 Mar 2021 14:59:01 -0800 (PST)
MIME-Version: 1.0
References: <20210305080658.2422114-1-jay.xu@rock-chips.com>
In-Reply-To: <20210305080658.2422114-1-jay.xu@rock-chips.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 10 Mar 2021 23:58:50 +0100
Message-ID: <CACRpkda-Hbue8Si=1D=qMAyZjOHcybAdSRY1F75ofbdBr8DnNA@mail.gmail.com>
Subject: Re: [PATCH] kernel/irq: export irq_gc_set_wake
To:     Jianqun Xu <jay.xu@rock-chips.com>, Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 5, 2021 at 9:07 AM Jianqun Xu <jay.xu@rock-chips.com> wrote:

> Module driver may use irq_gc_set_wake.
>
> Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>

Aha there it is, perfect!

Marc/Thomas: can I have an ACK to apply this patch to the
pin control tree?

Yours,
Linus Walleij
