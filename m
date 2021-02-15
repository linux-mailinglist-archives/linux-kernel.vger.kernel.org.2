Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8F931C100
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 18:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbhBORua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 12:50:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231660AbhBORr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 12:47:57 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB19DC061574
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 09:47:16 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id f1so11761656lfu.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 09:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=ri8r0QWyV+GpeiVDFOhcmhq8RvvDVRYHrS/HSMA0tvw=;
        b=IKAJUgCftQoBmFHgXAAxZRVH0+3pG2XISwgVJUMcwg5HKQVX2qWDCNI3428uv7bc3P
         H2O5vlMh/KmI8dBYAgADseRk8CxU7HcFb6+ZpXGAOMt6FqGy83tT5r4Rf5RpNV7sGPsq
         deZt//zjPn6tGJl1djc349TkpvLFTPw7CSCeoPGxoem+9r2n1HPNBpogJrYlRj12iN/6
         KEQ8+K0PYbQt72AqOSdoV/NHgW5loY3piVea+MQvhaoRY5jlHFVP1QpExi/5jLglZcMu
         AvsV5CzU5TQTuoAwz5l/nTeItEvIkuV9TxYhKmT0rDU2DeEFg7IFI3VdLxMhBzbwpKdC
         qavw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=ri8r0QWyV+GpeiVDFOhcmhq8RvvDVRYHrS/HSMA0tvw=;
        b=GQWiJLPb6ENycLA+UQsEiyDfezzmcMUgYIMSQqRhddF2cXWKgHIaPEuX8ukC+HLSQq
         SMpLf88429iaZSdgmKo5KhaCyECwH/SEhic8gSnHDfwROpguWO8nmLCIuVhsXHapRqDf
         ANbBaIozc0UYDd+82T+DuvfvoeVjLA3nTaDObXhbY15ReGKbhOiYEoIetZLn5lF7rOj1
         134lWc0JoqBrZXovgAugRL3LiLkYu940smLnY0HeZ5hWD74oAYwt8LmxXhXw176Ix5po
         qdRZJHLrKUvtYMwwdMo1/2ek2nEPm/K5UJl1DalJprV/edJpZh0RLiu36JtwU1K8cWIl
         1mQw==
X-Gm-Message-State: AOAM532gbDqDmJIRr61hq4yzXXY4erM6JoO+eMfyRu5W9KxbuPWACW2a
        yy0+WrEfd9+DrOHCPCk05LYy67tWpASxkllzY15sxI8k1Ac=
X-Google-Smtp-Source: ABdhPJwagaw9pxS+fy3PxhZBhYc4IJW/hNgnGK5Zpxd6f34j0BVuu42dI514PJ98yGNo0x4CGhi5Q+C4mqlW7ZwqIx4=
X-Received: by 2002:a19:c70e:: with SMTP id x14mr6893382lff.62.1613411235132;
 Mon, 15 Feb 2021 09:47:15 -0800 (PST)
MIME-Version: 1.0
From:   James Spader <jamesspader.linux@gmail.com>
Date:   Mon, 15 Feb 2021 23:17:03 +0530
Message-ID: <CAKpeocV5osRZL2W+rXJVOQS0vcTCBXNp4aWMsVs9TqjhpBuEBA@mail.gmail.com>
Subject: mlx5 HW crypto offload support
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     saeedm@mellanox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Does HW crypto offload support for mlx5 work under virtualized environment?
For e.g with PF (Physical Function) driver and VF(Virtual Function) driver.

If yes, then how does the information that is required to create
security association get passed to the PF driver?

For example in rx full offload the FDB table needs to match the spi.
As the spi is created by the VF driver, how does its value get
communicated to PF driver...

Thanks
Best Regards
James S
