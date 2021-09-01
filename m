Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF583FDEAB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 17:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343708AbhIAPat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 11:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbhIAPas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 11:30:48 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F80FC061575
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 08:29:51 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id f4so5878276ybr.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 08:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yEydQnCiiB9iy6pnOk/cAGg/1/rtBHcq3DPIzAFNphY=;
        b=hSUaQDMK4O8Ut68DmSUoyerIq/HjsCLsDayNQWB1FJynMeNZXln0F3/aUTnbm8y39I
         rkLW3LfODYhP3/b7uR5g4aNi1am0qJJ1VSfnjaVnJqN2Z7AWTZCmE+WqVDqdwAx903hl
         Ed5BM1FRToqbl4PX3nY9E1zbR+/f/d5vrspqeSiHkFJFsSTBQPBLtblBZPTevVPdfOdU
         1etEgYH91SZv7rIC++eZ4aDUo3AprLZt+EStIhc37YenTf4Az7k9ji2PO9JwU5UhOpeg
         LlnVsEp7rlHJEzbFA8Q+uEBR1GW9ZS02cYBAhhkOrBT8I15H8lGRljTeyIMt6pwSm1EW
         3gLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yEydQnCiiB9iy6pnOk/cAGg/1/rtBHcq3DPIzAFNphY=;
        b=Tp3X3rvBk8K35zpsL/Rtftm8pkXxyk7/vA3P8gik690GDC0n9Hd6AiPKGSifs3Ir6M
         thScOKOijjXfVnUbcsfuZ46lC8I77mmfaw9fp/D2tLxBG8rJjvovBwgc9zICVhFYBIBs
         bj4tuUf1rQWXruOtRM0YXKfMQ3t1VTILkjm/hWyMNi1frDmViY3nnOM+XOyseQexCvuK
         Dcy6sEkEZCSNvfAGwKt7xGvwK+d1p8pswM2RzkceBgzpIK8lLBC2KPNYniBqIMMJb03k
         NLWW/5W3jFpj4NyuWrWkN+eu57Nf7Ww1hxBpUBQgc44Fa780kVd+xsLXeCKpPNmrrXui
         czMA==
X-Gm-Message-State: AOAM530hqbx/5Hv+ptpbjKUpr6IU5Do9mOp6MvYPWbj/3qgU5tyORBPL
        7K5Mq/6oktLlGRHgx5XuTldJ3mMAByfK5vt22jK4UA==
X-Google-Smtp-Source: ABdhPJz5awbgOKC0zlUDSKhgM3uohHZwxW/JsQQkEsstbjQi6yQpMmzZsV8j+DIAJEvOUGFfzNlU80svca6oG4UqIsI=
X-Received: by 2002:a25:6994:: with SMTP id e142mr88133ybc.364.1630510190355;
 Wed, 01 Sep 2021 08:29:50 -0700 (PDT)
MIME-Version: 1.0
References: <1630492744-60396-1-git-send-email-linyunsheng@huawei.com>
 <9c9ef2228dfcb950b5c75382bd421c6169e547a0.camel@redhat.com>
 <CANn89iJFeM=DgcQpDbaE38uhxTEL6REMWPnVFt7Am7Nuf4wpMw@mail.gmail.com>
 <CANn89iKbgtb84Lb4UOxUCb_WGrfB6ZoD=bVH2O06-Mm6FBmwpg@mail.gmail.com> <c40a178110ee705b2be32272b9b3e512a40a4cae.camel@redhat.com>
In-Reply-To: <c40a178110ee705b2be32272b9b3e512a40a4cae.camel@redhat.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 1 Sep 2021 08:29:39 -0700
Message-ID: <CANn89iKxeD0sMe-Qp5dnQ_vX28SGeyW3M857ww4chVsPE-50uw@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: add tcp_tx_skb_cache_key checking in sk_stream_alloc_skb()
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     Yunsheng Lin <linyunsheng@huawei.com>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        MPTCP Upstream <mptcp@lists.linux.dev>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linuxarm@openeuler.org,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 1, 2021 at 8:25 AM Paolo Abeni <pabeni@redhat.com> wrote:
>

> You are way too fast, I was still replying to your previous email,
> asking if I could help :)

All I did was to resurrect this patch (rebase got no conflict) and send it :)

>
> I'll a look ASAP. Please, allow for some latency: I'm way slower!

Thanks Paolo !
