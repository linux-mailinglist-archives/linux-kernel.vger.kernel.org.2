Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDB71407624
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 12:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235648AbhIKKvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 06:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbhIKKvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 06:51:31 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73FA0C061574
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 03:50:18 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id ho42so9630632ejc.9
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 03:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s2Y3phh03w3iRLb0/7Vq/tzxOC9memZK2T90WvxR2nQ=;
        b=fify17R/MnNeLrBfrQO6PIZos/02vGN4spF3jkC5+crxApQr3LYKMN+0mNpfJ9tktx
         40rhDy8wrctIr9+OyHMABWAgCs2wFHxEiIP0KEyISNGGBJuqQsbfin5R0AdoWY17tRUQ
         ssyCwr643v+MejXpIkI/pQacKs3f2F0get0EFOUL9jzSVv4Sf/1Ql2lu6jHAtnJZtXKd
         /732usDH6/GqpMBT6Jn8XVsiGhoGH4LDeTNb6KuFDW1G3WTTge2xZJwv/ju+TzTsXzr5
         Nsv6LxHsnnunmK03O317Ja6YCAqeNK2b58Zii6wKzHAVyGt5T81+BBbMvIQml7hqtHx2
         bxsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s2Y3phh03w3iRLb0/7Vq/tzxOC9memZK2T90WvxR2nQ=;
        b=O/RfrjDeuiOfZGSm5nu/vLRfjAHT5Wt5dXK5jnwHsCoE4Rm/uKL2ajwPKRHN5yruMB
         W8HEgjj8UbHWmRKYZ3kHvUP1PJI1riTTDIpYQuBIQeQtA1JMPrtzpj+2GxU+aiaumw8V
         fx7lrEVyJiKWuCglvhoxM/WoPignIcz4cryBmN+jQjlf+X7Qx2u83JeAFisAxDw/obbV
         9rluEmWt7KQj96WcdPHJun724NsnsDhh7A6BtUJZSL/5NXlMznvTR4xZQTT2yOEEJFDx
         XZmGqI41qYNHUKTMDwf682bRGv7P/xRkzgLyGQrp7QvSpmfIHTIszkkSpPgoK9JoIGms
         8dBA==
X-Gm-Message-State: AOAM530cm01Qob9UQ6/9F+lnfd5cf6W+o5iRVUSfj59Un6UcGh7+f+2K
        CSwrEszMzCzGrw3sMcQccUw=
X-Google-Smtp-Source: ABdhPJwb7nclu2LG1b6eNFK/XRQdhssBAA5X7h+PK+Q54yEPVYRbElGOfFcEJXDBGnlm2zOzh5O2Mw==
X-Received: by 2002:a17:906:95d7:: with SMTP id n23mr2187912ejy.479.1631357416896;
        Sat, 11 Sep 2021 03:50:16 -0700 (PDT)
Received: from localhost.localdomain (host-79-43-5-131.retail.telecomitalia.it. [79.43.5.131])
        by smtp.gmail.com with ESMTPSA id s7sm753717edu.23.2021.09.11.03.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Sep 2021 03:50:16 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     gregkh@linuxfoundation.org,
        Michael Straube <straube.linux@gmail.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] remove pointers from struct hal_ops
Date:   Sat, 11 Sep 2021 12:50:15 +0200
Message-ID: <23645260.HGxgaUW6W8@localhost.localdomain>
In-Reply-To: <296aa357-1bba-4136-c651-a18d04c8d32a@gmail.com>
References: <20210910205033.3778-1-straube.linux@gmail.com> <1858319.rr7sHpn3up@localhost.localdomain> <296aa357-1bba-4136-c651-a18d04c8d32a@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, September 11, 2021 12:24:09 PM CEST Michael Straube wrote:
> On 9/11/21 11:38, Fabio M. De Francesco wrote:
> > [...]
> > Hi Michael,
> > 
> > This series is good.
> > 
> > Furthermore, I compiled the whole series with gcc version 11.2.1 2020816
> > [revision 056e324ce46a7924b5cf10f61010cf9dd2ca10e9] (SUSE Linux) one
> > patch at a time. There are no errors or warnings at any time in any of 
the
> > seven builds.
> > 
> > But, unfortunately, I have no time to test. So the whole series is...
> > 
> > Acked-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > 
> > Thanks,
> > 
> > Fabio
> 
> Hi Fabio,
> 
> thank you for the review. I have tested it on x86_64 with
> Inter-Tech DMG-02 connected to a CCMP network without any
> issues.
> 
> Perhaps I should have mentioned that in the cover letter. ;)
> 

I see Greg sometimes asks "how did you test it?" when he notices that the 
developers don't say so explicitly. I guess he wants to know this whenever 
changes have the potential to interrupt or alter the proper functioning of 
drivers in ways that aren't clearly identifiable by just reading the code.

I think not all changes require testing. However, I guess it's best to play 
it safe and say if and how you did the tests.

Thanks,

Fabio

> Thanks,
> 
> Michael
> 



