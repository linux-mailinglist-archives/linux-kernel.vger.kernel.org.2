Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8ED03F9422
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 07:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244175AbhH0FuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 01:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbhH0Ft6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 01:49:58 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C86EC061757;
        Thu, 26 Aug 2021 22:49:10 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id t9so4513569qtp.2;
        Thu, 26 Aug 2021 22:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MSsI/7qJw1DvArF1vTWLSwP6sgJus0lYgVXPHZzbWNw=;
        b=NlNKNb+4bv2FUlOgawKpK9Syn6Uunn5dhrsmVyo9BrxycCda079nn2w9aRBTasSyZz
         BedTU3R22l6Jv10f+tSvk6aATiBtFM9PR4H5ir6SE8e8SWVfMLhhsg26/Hfx5PH4fef+
         Lpl8XUy0u49lRz4H884vkokOXXNiWTxMQrx28=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MSsI/7qJw1DvArF1vTWLSwP6sgJus0lYgVXPHZzbWNw=;
        b=AsjgAmK1sM1q4fMkWyUfeT47ACXfBvW1zUT/nESOyCre3If1ONQD2uneZ3LdOG16Tm
         iOYuovQwz1248qbO30sf4xov01JHxA/xdvPRSh/+5e4TGL3EgH+hzM5PxcURzRvcSptw
         MrhCJYIQ0YVbnwfpFpyXd2sKRWW4V7dHq9aWTJX64VA0NzHn9dFYTXri9dSTNEXFH7CZ
         aAYUOj6J9RfxHrnwelxSH20t7ZWjZao3uMkFrIyKfcUzdeYJ8oPcYR0CmsDvRSHk6t9k
         EJ4bgZ7qoySA/ajma223jg2uEvDny/XRZZ5YdsHf/vIssotMEnfOQASCugTuieO4ZPYE
         BoLw==
X-Gm-Message-State: AOAM532AIPJhiXe6ekZQx5wseQsDf4BvoysWE0BbEyqWgmRHSdQ/3K41
        GDUQjMSosXTebVFrtLdshs3y++R237c97OrJcffJkFmw
X-Google-Smtp-Source: ABdhPJwx0VRG+mEdKimqU3fnKkuUHiC7yML4WfO0SFrgcfCEd2XorGNmSgGMqMdj87H5pAQvxCgvZCfzwVWhrfJffuw=
X-Received: by 2002:ac8:4b64:: with SMTP id g4mr6983536qts.263.1630043343101;
 Thu, 26 Aug 2021 22:49:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210826061623.6352-4-chiawei_wang@aspeedtech.com>
 <202108270732.OvBQ4K3D-lkp@intel.com> <HK0PR06MB377927BDCA9CC79B598251B291C89@HK0PR06MB3779.apcprd06.prod.outlook.com>
In-Reply-To: <HK0PR06MB377927BDCA9CC79B598251B291C89@HK0PR06MB3779.apcprd06.prod.outlook.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Fri, 27 Aug 2021 05:48:50 +0000
Message-ID: <CACPK8Xf1g2fp5X3ELBUyjzP6Fmvt1XWLU_UgCKdZaDVjdyKryQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] soc: aspeed: Add eSPI driver
To:     ChiaWei Wang <chiawei_wang@aspeedtech.com>
Cc:     kernel test robot <lkp@intel.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Aug 2021 at 03:52, ChiaWei Wang <chiawei_wang@aspeedtech.com> wrote:
>
> Aspeed 5th and 6th generation SoCs are based on the ARM 32-bits architecture.
> Should we follow the report to make the driver 64-bits compatible?
> Or revise the driver to use more specific data types?

Yes, in general it's expected your driver will compile cleanly for
64-bit architectures. This helps with testing and static analysis,
where CI builds all the drivers for x86.

Cheers,

Joel
