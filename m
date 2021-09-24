Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED90417CF8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 23:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347366AbhIXVX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 17:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233640AbhIXVXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 17:23:25 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F28C061571
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 14:21:51 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id e15so45726543lfr.10
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 14:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=Ay8MGxYjkDUP6vbre30sU18YDDt8pPWIWuNxlPafmIs=;
        b=NyuCTbtEj8BN/xqGVQ5MYldyggUJUrqXrh8iLd+fGxtTfeNztBwPZsl0ppACWCvOBF
         u0OaEgAh0dm0YNjLaZN56MviHESKDCYKluoVPXaRNEbsa5zmjmwOg8tl6GMCxZJO9map
         pS1Hp45xGrjgu59LdObZwW7LkHOGzIGpBuL6iGJ7JeQODliLVuGx6gL5X2SqymcCIKV7
         wwx7dKRPleHyOpEp+elrPuhu11cqMQWUclaGchOnQV1ZX+my9dDDFzB6/eWMMqAZyM55
         1AlizQm7ST2TpgtaLnaDnnDcdHMIApw3Qqs5ajz23oL3VHtFt8isJna7i7IcrErP7p4n
         DtiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Ay8MGxYjkDUP6vbre30sU18YDDt8pPWIWuNxlPafmIs=;
        b=3mMuuLquHue8oTOdxqps5YG5WpSmai5gVVfXfNnmQNIqRrI84uPOy0tpXewZsUGyf4
         CT8zrYdwwKGGd/b2dYf2krq3XVkw+++aSdLUWXtmYmYcg+4JrRT0bi8pRtaP3QHUb8jJ
         TNGT60mHSDu1uQER1WRV7OslWJVVereknnq8UHr1evzupBxRCPL9I62XUI3jCpcKJ1+l
         14Mrjo6dOcUpTFhJnOAiKt3rAs+MqjWgkThNN1Xkt+b8W2HDGd61tm+CoxD8xA2ghzfw
         o5rkEDH4U58WmaMKsB8ItJvbNBHKZhd6fHntTcw6Wlw/BbgoWkMtS/5zZVJODEaoN7XL
         6czg==
X-Gm-Message-State: AOAM531axQBgjT0jfsY2J8KYK7Jtvm4c7oT7vNOSy3OMDyxa30PhIgXH
        Whsabv6t9UfZqyXep5dCgYr4QycZa29HketPPG491Ud9NVE=
X-Google-Smtp-Source: ABdhPJzgapiRIc5l9Vd0iL2ve8WqBiDl7wm3bQDrNgQk2Z+cOMJxtYpFnIc8VWLG6OylvypCbtm/Ep53QgXpc70sP/E=
X-Received: by 2002:a2e:8150:: with SMTP id t16mr13083136ljg.357.1632518509862;
 Fri, 24 Sep 2021 14:21:49 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?B?SmVwcGUgw5hsYW5k?= <joland@gmail.com>
Date:   Fri, 24 Sep 2021 14:22:17 -0700
Message-ID: <CA+osTZWkMh-HOQkLoHNyQLsUusU4N2vY-dr2Z+u7oY63+9o0-Q@mail.gmail.com>
Subject: Problem with VirtIO TRIM/DISCARD?
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm experimenting with running VMs on a 4Kn sector array, but I'm
having some issues.
Specifically it seems VirtIO TRIM/DISCARD support may be broken for
non 512B sector sizes.

I started digging, and landed on this commit:
https://github.com/torvalds/linux/commit/af822aa68fbdf0a480a17462ed70232998127453

On line 143 the TRIM/DISCARD size is converted to a sector count - but
it's using a hardcoded sector size of 512.
Shouldn't that be using the actual block size gotten earlier?

Did that code just wipe out a ton of data following the TRIM/DISCARD area?

Regards,
-Jeppe
