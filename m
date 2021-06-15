Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 431AE3A79B5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 11:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbhFOJCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 05:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbhFOJCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 05:02:52 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D293C061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 02:00:47 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id g6so12754347pfq.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 02:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to;
        bh=zGk/ZhZWEg56YKF9pnwKft4+fj3bPtgDY5IUehTT0YA=;
        b=Jkea5xajdNNa/DoSamLSHW7sW/9w77HVE+u8mXp8kW/Kj8gzSfv6RlzMIGPQo8BP7R
         Q6Z5FYbyc/v/ihYMwO81l0t6QyFiFlAs3mEBs2ERbtXwMXzTYoW5ZRKUUCvd3Y7Yq+oG
         kQ/R4V+pZK3sRiVNBVbs7LpIGe7gzG63BPZEcJP7XfQefQPgeXgcmx64qDvC+M1SkAdr
         tqtGJpk45BMUq4+M9dizyfjBjQ48yja4jCiqxWGuKnQmjmDHzB3hK36MVFap5dg96QX0
         BYZKPL4mPa3ThhhlVVeXOwUE3irUE5O8Dv0Wqeu6196/YjO7vGT9bhxeMEZehSFAsmFe
         wCTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to;
        bh=zGk/ZhZWEg56YKF9pnwKft4+fj3bPtgDY5IUehTT0YA=;
        b=ai1N7NUu0bobW5mKvZwu2eh4ZEj4pxJIgNtQ1SG0Tz2WRpObROtPJ34tSOUfBWU3RW
         5gpSFsnwLgiNm+QJDL+eIyC8HnAGF2Zu2hnpZDUXP4nFCh+46t1pNhv1PDSMjs6YnCmG
         1Rv8o62vYnk4vo7JqRl/UyfB0ZUYR5wTPjyL7H4GGv9fxIAtrdZLIuPIUahk9HE9IaH2
         JqtIgrlENmcYMqVIVmPMJQjUCJj7o761Di3T1GbIWVRVfVXzviQOrxxBKweZeHlqqPtN
         4Ds9yBzIMx3NjeMhtiWOwC6yo+ld0Xfs/D0ebb9RqtDAd6hlonVDulowKS4TjusjWNPg
         9iIw==
X-Gm-Message-State: AOAM532RjFb9iRm2TObKhFCmog1tp8uSuvzyJIbiie1vqgHvkHwXRwTl
        0wLQPnbo3N/pVewqq8oGpZFHfwUAhe5qDwW7KoU=
X-Google-Smtp-Source: ABdhPJyArQjLVQfaFsEkyhlWrPUANbiGPwfXla5QoPPraYkUH51+vWY9PRS6PkrC+hlnbwB+sQ62iEellTgKqbWBl4w=
X-Received: by 2002:aa7:8551:0:b029:2e9:f46e:c560 with SMTP id
 y17-20020aa785510000b02902e9f46ec560mr1603883pfn.14.1623747646728; Tue, 15
 Jun 2021 02:00:46 -0700 (PDT)
MIME-Version: 1.0
Reply-To: mrscarolinemanon9@gmail.com
Sender: mrsalifousawa@gmail.com
Received: by 2002:a05:6a10:674f:0:0:0:0 with HTTP; Tue, 15 Jun 2021 02:00:46
 -0700 (PDT)
From:   "Mrs. Caroline Manon" <mrscarolinemanonn@gmail.com>
Date:   Tue, 15 Jun 2021 10:00:46 +0100
X-Google-Sender-Auth: qRTBLTZ-okqwqwg2c85ZOjv5WIw
Message-ID: <CAFadjVGu=8SKJuh=iHV7WDqELjDyA1p7DV3KJRiUwDofV-X2gg@mail.gmail.com>
Subject: Greetings from Mrs. Caroline Manon.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Friend,

I know that this mail will come to you as a surprise as we have never
met before, but need not to worry as I am contacting you independently
of my investigation and no one is informed of this communication. I
need your urgent assistance in transferring the sum of U$10.5 million
immediately to your private account, The money has been here in our
Bank lying dormant for years now without anybody coming for the claim
of it.

I want the money to be release to you as the relative to our deceased
customer (the account owner) who died a long with his supposed Next Of
Kin since 16th October 2005. The Banking laws here does not allow such
money to stay more than 16 years, because the money will be recalled
to the Bank treasury account as unclaimed fund.

By indicating your interest I will send you the full details on how
the business will be executed.

Please respond urgently and delete if you are not interested.

Best Regards,
Mrs. Caroline Manon.
