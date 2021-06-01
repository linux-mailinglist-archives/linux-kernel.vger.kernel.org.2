Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1883974E4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 16:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234071AbhFAOGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 10:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233797AbhFAOGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 10:06:16 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13BCDC061574
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 07:04:35 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id e11so19349488ljn.13
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 07:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+XU4vzQB0ErM5xzFAql1V2srdsu5siUWOeZiFIJbDSA=;
        b=JcB0QHJIBgCBzrXdQPP0+QjfzfghPxqbxPHwiwO+hCfZfPsBImvk6i0AXxZrOWdjuq
         jdbvqPr1Eedlno91fEFLOwJViYUgwYveq2xzvYt1M4FFvpYy9uIXQbjP22n2AxsuGEJR
         whj7GrSsWLA8ehBOC0raOvp2VJ3drEIzYIerGCJ2lheLIi6jMryv1j/N2YNvauji/4jS
         83MzvvjWzF4jX0scThsjgcgHl13Wr6sk+6k5vraUTIqgqy3npMz6aWX92hHJ1vV7HL5/
         /oTrfPvU6OYc4zOHi+hQPd4GxDUVBHrpoHqFzpzJPzkwmmrjl42uLfCl9V8aErOk4Ubt
         5RKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+XU4vzQB0ErM5xzFAql1V2srdsu5siUWOeZiFIJbDSA=;
        b=haItE9Q0ZCRCM8f72H0mnnxSyeo2cdaviMpUahM5mzCrPrjNId83UoHcyk4Zdnpplf
         NWbaGWhV1IXNPPO1zn5xaMYwZgTiUiLfmhI6aTeeHeanpUFv/qk1nXxq3bMvTlKgRZdJ
         pybBM5V7IQmsDrenuyTKs2z3FalhqNgatOfxe4URUM1jfzHvXFal6bnqlm4R6MWtioiz
         fBtwtB/zY0wtyhw1+MZUG0ITa4RV2sLXZgRhStFk/vsLXoU6+rjD88DrcEf1P8yyq3Hb
         dtKFnE3oRGP0mGtfXqoJa8ZK5IYP5tp9/t++eJHTI6tVzP6eWz0au1evdJBJfYc026vk
         7x+Q==
X-Gm-Message-State: AOAM530yOxOuEQYeK8fLBWUkUpBlTMyWtGhfRTrFN5+6cE5F2bPbhn7N
        b2tAB+VkF9nD/C7Chs1AKklsLXU7Y6nsv2HfK5t3TiBnY7w=
X-Google-Smtp-Source: ABdhPJxZCACE4lw5r0ugg9a6xINh5KYdHUgF5y5rascxASPQEfOUBFqflDZO3XuvwiAaKFfsMBNZNyYM2h9544/tVvM=
X-Received: by 2002:a2e:824c:: with SMTP id j12mr21271911ljh.490.1622556273122;
 Tue, 01 Jun 2021 07:04:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210601100256.70030-1-tongtiangen@huawei.com> <DBBPR04MB7930A304416458880D69E1C7873E9@DBBPR04MB7930.eurprd04.prod.outlook.com>
In-Reply-To: <DBBPR04MB7930A304416458880D69E1C7873E9@DBBPR04MB7930.eurprd04.prod.outlook.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 1 Jun 2021 11:04:21 -0300
Message-ID: <CAOMZO5CKW5n4P9X5tTHGcS-MkN=gmCkyS1+bkwn98kaK2vL3-w@mail.gmail.com>
Subject: Re: [PATCH -next] soc: imx: gpc: add check for of_match_device in imx_gpc_old_dt_init
To:     Jacky Bai <ping.bai@nxp.com>
Cc:     Tong Tiangen <tongtiangen@huawei.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 1, 2021 at 7:11 AM Jacky Bai <ping.bai@nxp.com> wrote:

> I think there is no chance to pass 'invalid of_id' and 'of_id_data' to the probe function.
> Such check seems not really necessary.

I agree. The only way this driver can probe is via device tree.
