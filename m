Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 145CA3B0B8B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 19:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbhFVRj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 13:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbhFVRj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 13:39:57 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1469DC061574
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 10:37:40 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id d25so3197482lji.7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 10:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=9d2LZ9iaWzrwN5lQzvoZWRCYsnPkH1VeDq07zPhlLjU=;
        b=AivYEutHF7H6vNhI5DlcJIGt20nf4bbv9nA5BSZGG9Oh90hZb1P05OWmuuCaY5Q/bi
         KbFtIvEQQcC8o0HrDWYSIxAhX2akxIdjLkuWAEI0etMUNqp497U9A2EvMpS/qTMJvPwg
         mo19I8DkPDz6oXoIqGmTcZ7fIs28MtVpviTP0Exr2btOMadn3iArctfXvNMM7dXcJSe+
         1ecZfHR51IS34lqVk/v+6Lcgmj7JXY9uJUyWUG+f9CIDowfWo56ivPaDBe0OEuaQOwWr
         p1g/9VXnHe+A0O5gYDRhlRTN3wFZOESegbe5/ve04tdm9zscc4p+kkOTTKKxwhmCHe3K
         5H9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=9d2LZ9iaWzrwN5lQzvoZWRCYsnPkH1VeDq07zPhlLjU=;
        b=NE4ek+JJw7ELJ/oZR/pvyaMQV13BzAc2HWRfkUASnu+52kb0TF7YHaqGQqgehv5Cy2
         sTkTfjW5JwMuGAN+xqWqNLYeVds80QbZrNkvixwDrMAoGT/5snRwYEKo3JAf68pDEytV
         YkIwfEyNtmyr4zk0EzjiyPKV9BJY68fwF1ifisFWtG844DLvfTgAVGsKx0oXHMeoMGrV
         3KKOwQda7OshBQgysB8C/bPufe3ReYF1xxQlF3rn8clY9zb8+C2PvV70F6NBWhsCfUnE
         tGh+CDBreQUtn7H/HdpMzuodQdgWdLXayVI/5CmxedJyzi5aITnsqrumkXTJHv2IuUje
         lukA==
X-Gm-Message-State: AOAM532BxzNoJHHkaGHWteNOzV+Y2VTDvWYCK1MD2QpV0OgEnAwTrNJC
        yIbfsOGn3gEbQIc4nLtdOMHLEt4cT/4flvasrBI8XWSPzEVjJg==
X-Google-Smtp-Source: ABdhPJwgEak4m2430LhmoQfRd9sv4h6O8b9wQfHoCeotYBMX1RrycxlQ3E1T45Jzt+xkfm8oim4Y1ZDyK3Mk86ATbF0=
X-Received: by 2002:a2e:a722:: with SMTP id s34mr4188416lje.104.1624383458169;
 Tue, 22 Jun 2021 10:37:38 -0700 (PDT)
MIME-Version: 1.0
From:   samarth saxena <samarth.1986@gmail.com>
Date:   Tue, 22 Jun 2021 23:07:27 +0530
Message-ID: <CAN7gi4AWhVDFZJ-xzD608bt9ifgo5dFR+OFOdm7=Ci_kpU8Afw@mail.gmail.com>
Subject: Question for CXL Drivers and ACPI required for a CXL mem device?
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I am trying to bring up a system with a CXL Type 3 device using Qemu.
I see that the device is visible in the operating system at the location:
             /dev/cxl/mem0
And a persistent memory attached to the device at
              /sys/bus/cxl/devices/mem0/pmem

But I am unable to understand how to use this memory (pmem).
How can the Linux map this Pmem instance to user space.
Also, CXL device can be a non persistent memory too. How will that be visible?

Which all drivers are necessary to use a CXL Type3 device as a memory
expander? Is there any ongoing development in the kernel?

Regards,
Samarth
