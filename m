Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37C9235B5E0
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 17:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235503AbhDKPVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 11:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236021AbhDKPVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 11:21:52 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E32C06138B
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 08:21:35 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id x76so2157031ybe.5
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 08:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gZdYxGjM5vS4dJgv0fgZ/TigJ4XDAhlJO5G9vI9SLR4=;
        b=KRh4TWatW1ReO35QFMWUqn4uWKKPMdqnAIEXI3QzH1AIRs9aGAFZuUpoOjd315Yf//
         Sfk1ZSmQV4gNzmmECso56PaWuJWAUhP0u9cxrLR3XUHiuLXCsthZvUcFBAkBPjcQk/3m
         rC1jBtnga/MCJVqAJtOWenSpoWW5VwdIbTHqVWl1tRcN9vvJj2bU8kpHD1T940txPZNZ
         liMxNA/Drd+H7s/t6cyKWfuE2B2jKjfa7bnyiSDg/I1ZHmA43ue1RUQNVWrOZOGQyFNa
         9fqzU3oPBe3l4acfG/HXixDuzcAHjFnJrWU2jkcqixydbhm7UnoSzCKlGY2PZdjEqMT5
         YolA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gZdYxGjM5vS4dJgv0fgZ/TigJ4XDAhlJO5G9vI9SLR4=;
        b=JIeHNnjECQeIHIVxeoblmT0nMAwGSKWGW3UUciaIADNxXHW8DoVFM0Q2x1166RrsaB
         S85vKmHK+p7G1wyJfdTiKGUTL/Cc4ZSKSLF/yQQ4JwjFa+3ZbBQqfaHRsfdBP4HUMQb+
         jDgaJRcBqsKt9JJWiPWbVvtLgemgyR/qx7lV8LmFRYY86MA2Yd6H+PxpWgDAGkyJDi5u
         34W4C/yYYqHXDHkYnYkHLpZXMmKDWKjNrs8VnglaQJSstfChMXrUt+w+cftAQyXlr6+Z
         L6qBoi9mffZOVTMxg97ZPVE8Yp6ojTLBIAAm+WzxhyiGojwF7InzpwNufQRD4YZF+6/C
         1NQg==
X-Gm-Message-State: AOAM531g0QTD7kXArs1K8ZziCBleiQMn7eNy/+2VidNbA8dK+TkRMZnD
        DAiosyl26WUafYo0duBp2PivXd7/eadptL5VbMlfbw==
X-Google-Smtp-Source: ABdhPJz8YH5NXe088h2/Zx8aB0WnSxN0iV//khlFG5X5+aDsg1oeDdChzJKeRT18LUlRAggNwvOmhH6NM/X/j53OkLs=
X-Received: by 2002:a25:e89:: with SMTP id 131mr9205440ybo.132.1618154494670;
 Sun, 11 Apr 2021 08:21:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210411112824.1149-1-phil@philpotter.co.uk>
In-Reply-To: <20210411112824.1149-1-phil@philpotter.co.uk>
From:   Eric Dumazet <edumazet@google.com>
Date:   Sun, 11 Apr 2021 17:21:23 +0200
Message-ID: <CANn89iL43xRD6CYrJbUDoaXYhDQ+FAh5fAMn3d3LaDgi1uz9iQ@mail.gmail.com>
Subject: Re: [PATCH] net: geneve: check skb is large enough for IPv4/IPv6 header
To:     Phillip Potter <phil@philpotter.co.uk>
Cc:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 11, 2021 at 1:28 PM Phillip Potter <phil@philpotter.co.uk> wrote:
>
> Check within geneve_xmit_skb/geneve6_xmit_skb that sk_buff structure
> is large enough to include IPv4 or IPv6 header, and reject if not. The
> geneve_xmit_skb portion and overall idea was contributed by Eric Dumazet.
> Fixes a KMSAN-found uninit-value bug reported by syzbot at:
> https://syzkaller.appspot.com/bug?id=abe95dc3e3e9667fc23b8d81f29ecad95c6f106f
>
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Reported-by: syzbot+2e406a9ac75bb71d4b7a@syzkaller.appspotmail.com
> Signed-off-by: Phillip Potter <phil@philpotter.co.uk>

Signed-off-by: Eric Dumazet <edumazet@google.com>

Thanks !
