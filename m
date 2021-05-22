Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4060938D391
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 06:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbhEVElm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 00:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbhEVEll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 00:41:41 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50924C061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 21:40:17 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id o10so19089617ilm.13
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 21:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t8iBox4ol81m5fHmyTvnyunYxePU1d0FPyjIJmpeVDU=;
        b=D2O5JIp259Np3IXd/jqDz9tZIDBmVNYRWA+krZxb6VUpNiLtDi0w2P+ElcCOtdlvQa
         UBeko+Uw4FkP56RW8rJxdrUPMtIs6EOFnaK5GZQxzYBht/NVWbt1TB4WsSJVuMFvk8+S
         bnjCRAnpnYT8n6mEQJC2BX44AOf71cjec3zR/w4zV8rL05aWjbd2l56GG/Zkjn623KSD
         xOwWHZ0iJvdEBjGGyrAKdwFTJOy5Qhybpcw6/6c8n5ejdX/fJOhMKRQB9P09QbIfcQ7w
         YBPkZAXObMcQOBmmEmTbea28AmOlCe5bazFMEaqRSIc5tFdast9zY9Swq8K+Jq1gBJe0
         56PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t8iBox4ol81m5fHmyTvnyunYxePU1d0FPyjIJmpeVDU=;
        b=JPnBnJr1y0bdLH+3CLEy4vxJHb9QUrSEElA2h4nFffIu/NIgl1oiI3jOZUqr0JmMEE
         3VJ7LLIMXjIQXX2PCfXnT133ZHq9Ud0HPeGFD2zSRnMZpgRfceFLHN9/Mq1icRaqNjEv
         uicHC8o1CoHOz/bg25vDeVpXk02ndejflYCIep1rpf5N7GnikTZrYKKTlLIenp6OZ8+a
         Uxu5/FLGDiBEdViA4pEpyf57T6S5jJTQEon66SI8sK054k0rhaH4c405vM49xhCF+be1
         xgLr/3yLGvPyDIeAEQvsRXP49hNAeL79yD3ae3Stp7ofbPB1RN/SIvK4I7dSLXSelTfl
         vZew==
X-Gm-Message-State: AOAM530Vb6VBWs4duugxWHGk2NKFOsOqcTw6S5bXHy0V5rCGk9pcbfX2
        EQBR7uGXprrT/Q/CZJokbkLIBietHUSIYuft/Z4=
X-Google-Smtp-Source: ABdhPJyJIDtkV9VCtJIqEEbeFNSULpg+hg2p5mRIK1bnN+tEV05XsOjEcdLXw0wLHurQ/NEe3kqtAhIBboS7PCCiBcA=
X-Received: by 2002:a92:c243:: with SMTP id k3mr3447391ilo.81.1621658415190;
 Fri, 21 May 2021 21:40:15 -0700 (PDT)
MIME-Version: 1.0
References: <cb099c69-0d59-7a12-b0bc-2ce71264363e@canonical.com>
 <20210518192820.181500-1-ztong0001@gmail.com> <YKerHVMuqnRQmhMz@kroah.com>
In-Reply-To: <YKerHVMuqnRQmhMz@kroah.com>
From:   Tong Zhang <ztong0001@gmail.com>
Date:   Fri, 21 May 2021 21:40:04 -0700
Message-ID: <CAA5qM4Akv5UYFPN3V7QCz15M_zEKUXfR1jfohNsRM1sFVywrNA@mail.gmail.com>
Subject: Re: [PATCH v4] misc: alcor_pci: fix null-ptr-deref when there is no
 PCI bridge
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        open list <linux-kernel@vger.kernel.org>,
        Colin Ian King <colin.king@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,
I have sent out a fix-up patch as suggested.
Please take a look to see if this one works.
Sorry for the trouble. and have a nice weekend.
- Tong
