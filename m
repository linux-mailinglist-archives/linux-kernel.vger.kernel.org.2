Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F15D5315F77
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 07:28:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbhBJG1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 01:27:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231633AbhBJG0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 01:26:20 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E76C0613D6
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 22:25:39 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id s15so635155plr.9
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 22:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EYC/DUp6zgu6VxQFUQoYksxgB771ELLZNhkq5r+2y4I=;
        b=mi1iHHsoMz1TfVP0LLl4zU+I9JjHoHKp7Ryvew9pVpjCEn7azxp5ddNElx6NTu6w1z
         n/DRGRSbdpY+WbhYTMMXO0fkNIbYXXbo76/HmZjhf+9IaVzE1LSoru4rM+BD6Za+2RIU
         s4psr2bKwppAAgzm6/uzDJooH1sAskRy5sygIf2f8baHDqpZtTXIrXxCgHB29h8AP8aw
         9SJ9uNDXcuFXIuwq2Io5VNSyuMUiz1Mb7wJu6NHUmz+U42DAGEE9g1K8LFXWsYtgljGa
         OGH0B8HXXTrWbGVVxf5R0cVsuKDAyDDHpyzlcQua60OcaQVe/sDAsZSPhqMvpOhIvYQo
         S7eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EYC/DUp6zgu6VxQFUQoYksxgB771ELLZNhkq5r+2y4I=;
        b=LnvW2RdyVqNycnsGTmq/LhpeYoJiWWZwKS+1rYWFeUTOL4pskerPhxIvsz+IjcJ/4W
         U7vszvhnfK3Bm35TumHkPspGNepN/9BATi+1qzCSmkaPSejL6RM2RMkmJT7bhS3Af8ue
         GgY4JL3mA7WcwpLBsdEQti/52ueIvfNwcLjuW5lnC4FxNLGteIkGt+Kos56ARyUpsby8
         Hb35Bz9fhahsxeyYy7mDPKc2Qh7SDtkomN/zOA+VVc2NKm7lcjpiWOBdKyMsiI/VgjPJ
         bDMIb0zMoYCB4eCzV2mF6ThLEHqUGU73O17PZiJd0OBeZbIU19L2PiheFycZnhMNv2PS
         05gg==
X-Gm-Message-State: AOAM5304RMeIbtk/HZ2xXJioQAS2zwzeLwvR4Us6WRIVbbTDOc+fGQTH
        hUAt9e+Gw2L4orwZ9QHtKnGd05oy2uvk4QmuiIY=
X-Google-Smtp-Source: ABdhPJw4ajHcLy/c1Iwcd06kK8laeCtXZp6IUhx7KZ2ijW/sjXLi80uLRj9MCM6KOjVJ/C4anUiFiynFm5LUvd2ybJs=
X-Received: by 2002:a17:903:114:b029:e2:f8fb:b6a1 with SMTP id
 y20-20020a1709030114b02900e2f8fbb6a1mr1594205plc.77.1612938339482; Tue, 09
 Feb 2021 22:25:39 -0800 (PST)
MIME-Version: 1.0
References: <db5dd593cfd8b428ce44c1cce7484d887fa5e67c.1612869229.git.viresh.kumar@linaro.org>
In-Reply-To: <db5dd593cfd8b428ce44c1cce7484d887fa5e67c.1612869229.git.viresh.kumar@linaro.org>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Wed, 10 Feb 2021 00:25:28 -0600
Message-ID: <CABb+yY3QkiZqWLJ8LmXXVy0n-UN1YxxbBOMcnTmHTe6WLeKmpA@mail.gmail.com>
Subject: Re: [PATCH Resend] mailbox: arm_mhuv2: Fix sparse warnings
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Tushar Khandelwal <Tushar.Khandelwal@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel test robot <lkp@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 9, 2021 at 5:18 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> This patch fixes a bunch of sparse warnings in the newly added arm_mhuv2
> driver.
>
> drivers/mailbox/arm_mhuv2.c:506:24: warning: incorrect type in argument 1 (different address spaces)
> drivers/mailbox/arm_mhuv2.c:506:24:    expected void const volatile [noderef] __iomem *addr
> drivers/mailbox/arm_mhuv2.c:506:24:    got unsigned int [usertype] *
> drivers/mailbox/arm_mhuv2.c:547:42: warning: incorrect type in argument 2 (different address spaces)
> drivers/mailbox/arm_mhuv2.c:547:42:    expected unsigned int [usertype] *reg
> drivers/mailbox/arm_mhuv2.c:547:42:    got unsigned int [noderef] __iomem *
> drivers/mailbox/arm_mhuv2.c:625:42: warning: incorrect type in argument 2 (different address spaces)
> drivers/mailbox/arm_mhuv2.c:625:42:    expected unsigned int [usertype] *reg
> drivers/mailbox/arm_mhuv2.c:625:42:    got unsigned int [noderef] __iomem *
> drivers/mailbox/arm_mhuv2.c:972:24: warning: dereference of noderef expression
> drivers/mailbox/arm_mhuv2.c:973:22: warning: dereference of noderef expression
> drivers/mailbox/arm_mhuv2.c:993:25: warning: dereference of noderef expression
> drivers/mailbox/arm_mhuv2.c:1026:24: warning: dereference of noderef expression
> drivers/mailbox/arm_mhuv2.c:1027:22: warning: dereference of noderef expression
> drivers/mailbox/arm_mhuv2.c:1048:17: warning: dereference of noderef expression
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> Hi,
>
> This should have been merged to 5.11-rc since the driver got introduced
> in 5.11-rc1 itself. I don't see it queued for linux-next as well. It was
> posted over 6 weeks back and no response is received yet:
>
Yup any bug fix should be sent in rc. But this, imo, lies on the
boundary of code and cosmetic issues, so I practiced discretion to
keep it for the next pull request lest I won't have much to send ;)

> https://lore.kernel.org/lkml/db5dd593cfd8b428ce44c1cce7484d887fa5e67c.1609303304.git.viresh.kumar@linaro.org/
>
> Would be good if this can still go in 5.11.
>
Of course it will.

thanks.
