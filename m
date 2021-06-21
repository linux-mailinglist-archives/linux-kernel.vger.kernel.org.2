Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8533AE211
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 06:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbhFUELy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 00:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbhFUELp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 00:11:45 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43262C06175F;
        Sun, 20 Jun 2021 21:09:32 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id k16so14150769ios.10;
        Sun, 20 Jun 2021 21:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ozt30WketsZIkHP1jtdAEYhPe+Ssf0hjpZm6XlaKud8=;
        b=tzLE4iLVhZYCj4MFwb3r1WzDTou0m061KBJ1I1fvxlRmEIFotfoPB3HU6YNnL3ERtf
         se5WuAHiSg8LI7iMdrtkPu1DL8iRI9rhCf+KqivYoyNq7IdXYq1l7HW1Z1GeE3AxS4qn
         ZQhjAyNaZNEj3177Y9GDyEV8+lAKbXhqAvzammyWTi+wYkessodEv8MXyEP2fm/5fhb/
         alpbQiem3fbSRtzP3LDIB+3b0VDYxvAYDpuxdbZ6c5Y28G22BfNu54heFPj6h0Yz1P/D
         2uzU5/1OmSxJ7YVjEtf9KG5fYIBO++4FFnit/VO7Bj2Yrr7Kis0znEAbU8yKmH5GRSp6
         B5Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ozt30WketsZIkHP1jtdAEYhPe+Ssf0hjpZm6XlaKud8=;
        b=Aq31xUHpJlwVLgSGovSQiel7zQjwEW4qOwMH7ji0NV50+Kh5D/xvVZfj4W5UTqp0Fe
         7ENccoZBWo1mPIFH/kA/sPDF0FUTq/wN2izEZSWZYNtoSZyuQ7RHMuqWzpFnzX8uyA4o
         YKM+u4goIL2svPLRkQwzwcDo6rQD85inZNIsslV4OMu2EYRz0xUvL/N6O/yHiRI4am4Q
         eSuoPMc4XBIZX8iIHLq+SBovW0NKoSPm4EQ9uJh2YfK4yPpsv8VpYfjVZj+PZ60OM2fe
         A/4TudAePxrUYYU1zrvlzXR5atVqVfgDsp/F2CHG+UlO1TCkOAjoVOjxDtw/6X/ubbaI
         UT4g==
X-Gm-Message-State: AOAM532mE8lvwEzy9x9qKEyMfGVxRiRZFx+B/zghTQLtFftoNbt5+BEN
        PsJb1f5NTsEHwXLctT/9MxrDyzb3ZUYqGDKY7iE=
X-Google-Smtp-Source: ABdhPJyap+JPlL9yD6xpqncp05ZUS1SbeSEAxrf8IMnG/1ONbbPboxsuX1YhRkxGG+cmBcSkWnfNymLwdFiT+JapdgM=
X-Received: by 2002:a05:6638:33a2:: with SMTP id h34mr15307716jav.60.1624248571750;
 Sun, 20 Jun 2021 21:09:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210511002040.802226-1-peter.hilber@opensynergy.com> <20210511002040.802226-2-peter.hilber@opensynergy.com>
In-Reply-To: <20210511002040.802226-2-peter.hilber@opensynergy.com>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Sun, 20 Jun 2021 23:09:21 -0500
Message-ID: <CABb+yY2q8Vw90=qEiNSOUZ39ZmX0ECShTvSidLoYCuZ-xGy-Mg@mail.gmail.com>
Subject: Re: [RFC PATCH v3 01/12] firmware: arm_scmi, smccc, mailbox: Make
 shmem based transports optional
To:     Peter Hilber <peter.hilber@opensynergy.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Igor Skalkin <igor.skalkin@opensynergy.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        souvik.chakravarty@arm.com, alex.bennee@linaro.org,
        jean-philippe@linaro.org, mikhail.golubev@opensynergy.com,
        anton.yakovlev@opensynergy.com,
        Vasyl Vavrychuk <Vasyl.Vavrychuk@opensynergy.com>,
        Andriy Tryshnivskyy <Andriy.Tryshnivskyy@opensynergy.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021 at 7:22 PM Peter Hilber
<peter.hilber@opensynergy.com> wrote:

.....

> --- a/drivers/mailbox/Kconfig
> +++ b/drivers/mailbox/Kconfig
> @@ -1,6 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  menuconfig MAILBOX
>         bool "Mailbox Hardware Support"
> +       select ARM_SCMI_HAVE_SHMEM
>         help
>           Mailbox is a framework to control hardware communication between
>           on-chip processors through queued messages and interrupt driven
>
Isn't this too generic?
Not all platforms, with a mailbox controller, use SCMI as the protocol.

thnx.
