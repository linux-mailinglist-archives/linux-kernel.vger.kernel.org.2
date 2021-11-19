Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C37F04570AF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 15:29:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235905AbhKSOc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 09:32:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235843AbhKSOc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 09:32:28 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6252AC061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 06:29:26 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id r8so18445804wra.7
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 06:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vjL1/Xkc83e5IAqi+RjDCyFqKkgWPay3pQnrjkRMpwo=;
        b=Mr3r3jWk2vEPIoopPJp69gGnBvcK6ttovuh5lUtYF7suXJ5/UPRdwSvckxEDRa5SC1
         dqhqNAI+yT6D5mg1MYgBD/lF6GssYMcK9xMNuEdE+YuOOmxUtr3GfmkTjnf5b91kO8fX
         nJbWFsJtYu6p5NMhKNNeDlWAwBWwKuBtj3kP8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vjL1/Xkc83e5IAqi+RjDCyFqKkgWPay3pQnrjkRMpwo=;
        b=dhqqy6b205+l38kOlq5JLHj3rjN1QEh0Raik0ii1s2JXg8eJly68JeHMKz51C55lax
         JR6B/exEAa2ifKxkS+bB/EgNdN8hJaZrAE4cr/hT9kg5mDNncVpjk4n1schwWIVIM4rM
         Dj0TilD7b6qwhV5UT/aznePj6kApZWpSC2EovuNGNw72brDurXchvBmRHY3fli74w3tT
         qECMU2OFqvo1U+pNcfrqED3whhc86zHK8HWPvrE8FPPnUQm+awLL+GhgTtjDdkGna3xY
         So3EB2muBC6AAHOFABTTWz6Uo97KXABhOA7V7iFyxEQWMXvJy+1JtSwuaa/YsB6DQISb
         qs6w==
X-Gm-Message-State: AOAM5302bDbXEriFHQeW5aKOj3Z7ixpGNj3Dpbkx6K1nNNu/k21Yd9lW
        0bRevqW6rvons2BNaw2ng7oIeHB+7mlaru7RhOnW2g==
X-Google-Smtp-Source: ABdhPJy/H5G7vVMJyuPD+BHyXDGW4M+NAvU2Q5A5tjFxZ8CfbkWjSiSqfvMjhUGbUmRZnkyEcLnAWlv407yA084LdnM=
X-Received: by 2002:adf:f990:: with SMTP id f16mr7874055wrr.128.1637332164949;
 Fri, 19 Nov 2021 06:29:24 -0800 (PST)
MIME-Version: 1.0
References: <202111190545.G3a209mT-lkp@intel.com> <20211119061103.GC15001@lst.de>
In-Reply-To: <20211119061103.GC15001@lst.de>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Date:   Fri, 19 Nov 2021 09:29:13 -0500
Message-ID: <CA+-6iNx8VCyr9nO5xKN4tx1GrCAFD4vndGtr+cKT8-sPRU+=4Q@mail.gmail.com>
Subject: Re: drivers/of/unittest.c:910:1: warning: the frame size of 1424
 bytes is larger than 1024 bytes
To:     Christoph Hellwig <hch@lst.de>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        open list <linux-kernel@vger.kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2021 at 1:11 AM Christoph Hellwig <hch@lst.de> wrote:
>
> I think we'll need to dynamically allocate the fake struct device here.
> Jim, can you look into that?

Hi Cristoph,

I don't remember seeing this warning before --- I will take care  of it.

BTW, IIRC you asked me to clean up the Broadcom MIPs PCIe DMA usage
code a while ago; we did,  but we observed some regressions when
testing old devices and put it on the backburner.  I think I will have
time in the near future to complete this once and for all.

Regards,
Jim Quinlan
Broadcom STB
