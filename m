Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB3D239753F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 16:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234209AbhFAOU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 10:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233797AbhFAOU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 10:20:26 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF6B4C061574;
        Tue,  1 Jun 2021 07:18:43 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id q1so22081722lfo.3;
        Tue, 01 Jun 2021 07:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=KXstzcw3/aVMxQaiNWbjfW9WtHIbWTjD9jpZ+zSJg6c=;
        b=rOlMkqigQxAVmYjWCFu8/iS3qGnXYt4aMVZjyXg+y7llORejh6cnUvmNYZ7C1k4e5b
         Twee4bUGr/UraNPez4o433wor8Z5G7vcJclfzPWvDw3nGBa4qr1lXMhPYQ5dV5Ty4DB6
         /f0VNmbq4fwwunXYrF+/pPRSJepUS0waAS0bq5aBtBxFhuAQE28hCz0Kiu6NlJOi/r7z
         krw4cnZt1KntDlzOeQZ8t3XPx9sl2xiqkS+bXN5MWgrXLH1HRGkDBoRDhHONp+m3rNrQ
         35JHRNCUBDoH9lV6vRXxedFOpSC+IJPAMqADrpkbZvBSRv3LOopAqTSrgagB0DcmcAd7
         SxrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=KXstzcw3/aVMxQaiNWbjfW9WtHIbWTjD9jpZ+zSJg6c=;
        b=fqnHKUR9f2Hhwv4OEW4HOrEeuPNHUvFXrme/NrygER3LLx3gDv4JltMomFicWmiUNe
         0vetk2aJj6DUh9vE7ZV//c0idLmV4FWzaoLHwTr+OAdDtNQ87yV1zV6b8Ygr+sA8i1UO
         /+e5ofBMuy087zDI2MQ3OFNyAxZosVg3NqDUalm26wbk7/fY6sJIfflNMSrVz22t9xFQ
         RgN7/ZF+JMmNgaekCGlaQHkCm2KA0ePZcJfT++T/7MaRMAMb/QnoE2byDNYfgwgZ7Kog
         1FzHbcpE0plRv1x0gA5xuPyn3Z+M2FdPRCtWUhoXhp7mpG8D59l88mxRJX/pJvZ9pna+
         4a3Q==
X-Gm-Message-State: AOAM530yS7+Owku8v21r4s8WVDbl8IWVbudSem3zx68a3kM5dSXYGOnT
        p1Eb0cbGgIueR1jO6np1k7xMQVAVNqGiP96BZKNva3LyZCUMIg==
X-Google-Smtp-Source: ABdhPJzwFj3PquNHHm0+6epEPGib/kx5Ytz7IE7V8p8U0EE6+3HRY4KRNvmCV7rM+kveqHaovTbhlVipN0EkM70lxvs=
X-Received: by 2002:a19:7d89:: with SMTP id y131mr4502072lfc.108.1622557122210;
 Tue, 01 Jun 2021 07:18:42 -0700 (PDT)
MIME-Version: 1.0
From:   Menglong Dong <menglong8.dong@gmail.com>
Date:   Tue, 1 Jun 2021 22:18:29 +0800
Message-ID: <CADxym3baupJJ7Q9otxtoQ-DH5e-J2isg-LZj2CsOqRPo70AL4A@mail.gmail.com>
Subject: The value of FB_MTU eats two pages
To:     jmaloy@redhat.com
Cc:     ying.xue@windriver.com, David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, etdev@vger.kernel.org,
        tipc-discussion@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I have a question about the value of FB_MTU in tipc, how does the '3744' form?
I notice that it is used in 'tipc_msg_build()' when memory allocation
fails, and it
tries to fall back to a smaller MTU to avoid unnecessary sending failures.

However, the size of the data allocated will be more than 4096 when FB_MTU
is 3744. I did a rough calculation, the size of data will more than 4200:

(FB_MTU + TIPCHDR + BUF_HEADROOM + sizeof(struct skb_shared_info))

Therefore, 8192 will be allocated from slab, and about 4000 of it will
not be used.

FB_MTU is used for low memory, and I think eating two pages will make it worse.
Do I miss something?

Thanks!
Menglong Dong
