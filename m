Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9304454A6F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 17:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238836AbhKQQDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 11:03:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbhKQQDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 11:03:05 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2884C061570
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 08:00:06 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id d24so5720109wra.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 08:00:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pT4qZN+otEOp9NMbVkyGI+t8qf+gp/bjSr+EEcpc+qY=;
        b=a1HnUlYAMQ53OdlHDqoKq15Xxmd2IMeYI7OblQGavX1XLR7ALsre4TIaNbHpxrmewy
         TrlDwzuka8xIwNbUxjXkTwsRJKLIFZhGoxE1HsfvGXtZHIceOc9o07cadzt9t6xAIpCl
         q9uXp3KXH94nEwtpPeX+VOdNVaMSxedSN/jPMa2wEExsn4NDJZUnVtN6KYL4aAz77KHJ
         YQ1lYG3Ic0feOv/osj5o8rHRP6mbixtE6yWo/i/8YMg07JCsigSGAgEpVjM0jqSseT3Y
         8YIruI6vXfinNpiCc8VhiQpKd33FueGXgDiA5ElggX0k4YhLKcySLrnl/3PXkqba7FJ3
         RHMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pT4qZN+otEOp9NMbVkyGI+t8qf+gp/bjSr+EEcpc+qY=;
        b=SHS3+2Ar2fD02WW3HAFTxAiGVEuLrY/o7aGZ1Bzb5Y2EkKHV9I1XhgV4lFvoTCk7KD
         CHRqjUl59yH/oi1qJBMLFQY4uQCeHXboczALrwCsQ5SVEOvpzXc7md9eO0CRRxnlnJjC
         wuo6mlJARLYVL7pm3kAO2K6pUnkX7ylk/MgDQzbzmwtra43440hB3rSCkQLF6zgdkgiy
         v9HmBleplkN8zttoqozavzgiMtAOqojlYbN0WSWN6PTu2C5mwqgTTDMU5m6MnM6+X4KX
         0cjItbOCGzpdCR1eS7szh1HnDbu5M22gL34vOCA/cRT+5OSAac3hbyqhxnbjUWiZ9HUq
         smYw==
X-Gm-Message-State: AOAM533TXB7ayjg1JlKTSdPNgwNWiCPycROVliQj+6t7bE5O7g6Fy44g
        4P943mC1o7JidCCbK/rc4+2Nr8pZs9YrQHV3BWzJNA==
X-Google-Smtp-Source: ABdhPJzPHMvLDdvlzwIuUsfIgZhSFqd3lWj6Bl2uefwiTnm3ZI4o66LnjNX5/C/BKLJHusY8qtE6WUMu7AigEgQYIEk=
X-Received: by 2002:adf:e387:: with SMTP id e7mr21743098wrm.412.1637164805103;
 Wed, 17 Nov 2021 08:00:05 -0800 (PST)
MIME-Version: 1.0
References: <20211117152917.3739-1-alexandr.lobakin@intel.com>
In-Reply-To: <20211117152917.3739-1-alexandr.lobakin@intel.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 17 Nov 2021 07:59:53 -0800
Message-ID: <CANn89iJFjAOw=5fvC1jrgDrV=0c6bCt16NqgySgd4DxR6Yz+PA@mail.gmail.com>
Subject: Re: [PATCH net-next] stmmac: fix build due to brainos in trans_start changes
To:     Alexander Lobakin <alexandr.lobakin@intel.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2021 at 7:29 AM Alexander Lobakin
<alexandr.lobakin@intel.com> wrote:
>
> txq_trans_cond_update() takes netdev_tx_queue *nq,
> not nq->trans_start.
>
> Fixes: 5337824f4dc4 ("net: annotate accesses to queue->trans_start")
> Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
> ---

Thanks !

Reviewed-by: Eric Dumazet <edumazet@google.com>
