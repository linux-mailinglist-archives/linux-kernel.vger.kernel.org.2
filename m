Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19909368854
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 22:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239656AbhDVU7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 16:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239430AbhDVU7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 16:59:00 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E42C061756
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 13:58:24 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id s7so46036598wru.6
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 13:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Rcbt/IVdLUggvz4+msojAAS7f+QcRf8lQX/rCzIQBDM=;
        b=G5M9KpmPBgHjMVnw9ZZkTydNcwRMwEDyabT64whiNV1C7h8KDSK9ZZliZnIPiWy1s3
         Ra7UtwLiD9yNnRxPFsN/2pJGVnO6aAxol/XBvoVOAJyAsE4YJyj/1DtuhPDV4dgpI8oR
         kd5SH+gF/BTnxr8sn//6G0ODL//1MvwE4Q0AX0lU/kPu15h1g/j66NtN6xjZRceKlOhx
         I+e/qMOdu/DMufo0X9MBZ4QnLrCrCSfVFgqEossPfG0/sFGfQyf9KU0LevZid+MVHU+j
         3oTrJRGAvmoRDdHVxAZ5dzD9HGWYapNZVQLbQkfQgHUUMQhpJ+pOB+ZBxYdJ5pLI/GmU
         hsYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Rcbt/IVdLUggvz4+msojAAS7f+QcRf8lQX/rCzIQBDM=;
        b=TgtuynIk3najJmMxHEXR68gf29Ydy5ycurhasFVVDusaKnlBbferfYUGeLvEoB15AQ
         xVVICkIdpRdBMB8cYGTQP3RdLmMUReA8QIvS8EjDOw7iO8cJa6r7zTpFbXwG31Q28cYh
         1G/7R29V18byU2T2eZ9IpHBabLyz0fXkk0ffy3bMt+ynFf4r62BcOXyUHZ4KC0dw8Eby
         WrYzZOisiQ7sxoq+TDzXPny03ghyyWGZGNTZdvaHezA9j5JE9XI7hbcBNL93W9tjnjND
         eMl1OA6ShvB+1i3H/hvEkWSmTpABcT629hX3PeSvTl40rUlgl1eSFXBypTCBAuBWrSeo
         /dOw==
X-Gm-Message-State: AOAM531ukPlTPpnyPHLSHUpSxhfDxbRoo58v0tIUp54/+rILNtU0uZTv
        iCAtSz5FfFFKmZNYCrEYYdODMmn+vrq+TT4GqJt3HQ==
X-Google-Smtp-Source: ABdhPJwh8SxwWjJr6hAStLiR71jQrutVAhJUpx93KzzucycJlExKwrC507PR0MX3FHaSpVcOY6NOfA==
X-Received: by 2002:adf:bc49:: with SMTP id a9mr313764wrh.109.1619125102976;
        Thu, 22 Apr 2021 13:58:22 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id t63sm4970352wma.20.2021.04.22.13.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 13:58:22 -0700 (PDT)
Date:   Thu, 22 Apr 2021 21:58:20 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Eric Dumazet <edumazet@google.com>
Cc:     Florian Westphal <fw@strlen.de>,
        Sabrina Dubroca <sd@queasysnail.net>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: geneve: modify IP header check in geneve6_xmit_skb
Message-ID: <YIHjbNfXyu+zD9Wq@equinox>
References: <20210421231100.7467-1-phil@philpotter.co.uk>
 <CANn89iJwipuJ6tTj5XjnvXnAB3N+dF=8oeCMSUyt+A_cUbr-pw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89iJwipuJ6tTj5XjnvXnAB3N+dF=8oeCMSUyt+A_cUbr-pw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 08:43:57AM +0200, Eric Dumazet wrote:
> On Thu, Apr 22, 2021 at 1:11 AM Phillip Potter <phil@philpotter.co.uk> wrote:
> >
> > Modify the check in geneve6_xmit_skb to use the size of a struct iphdr
> > rather than struct ipv6hdr. This fixes two kernel selftest failures
> > introduced by commit 6628ddfec758
> > ("net: geneve: check skb is large enough for IPv4/IPv6 header"), without
> > diminishing the fix provided by that commit.
> >
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
> 
> SGTM, but _please_ add a Fixes: tag, since stable teams now depend on this,
> more than human parsing the changelog.
> 
> Fixes: 6628ddfec758 ("net: geneve: check skb is large enough for
> IPv4/IPv6 header")
> 

Dear Eric,

Thank you for your feedback, I will make sure the new patch has the
Fixes: tag in it.

Regards,
Phil
