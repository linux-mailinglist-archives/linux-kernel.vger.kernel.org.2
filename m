Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE973AE435
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 09:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbhFUHbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 03:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbhFUHbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 03:31:43 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20911C061574
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 00:29:30 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id q18so14370345ile.10
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 00:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8lMY5Y1M2Fkto6rrQzCjVGHSHgMySdc375BKQ8gO1ac=;
        b=V2WdVS5Ik1QaDSWLMORBqoDtVqHxcUGRL1nOROg1kP71TeQc6n1ID2nUmApty4r01p
         PAOtiCrotD9VVo9l2hPazyd/VMhhU8qjvVfxLBWZZRb2PC512K5Ev6bSsJP++0cWq2e2
         aHo0X9CZsyjbas9LZgPvfLdB1s4h+esAAkRorBeX3gHF4jgPFMZe3KvN8uuincXrkQ/k
         PxwSzFs7kyevTd4sI4PZ+gyjUZ3LVGVqOZqeIGhnBqQV4J5emBRSGvgTOlXPmae2rYqx
         n2BnonaiQEAHSViuCPsZxGEZQ4TiIVY0aOKpYGSK5PLQ+s2FataTeTnhJVd/jT7Io1Wj
         qUSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8lMY5Y1M2Fkto6rrQzCjVGHSHgMySdc375BKQ8gO1ac=;
        b=EtbROr5xRsoFE787U4ME2US996/kVbc3KN50tH+weqmEbdGd3KZujbjFt/xNsWRaZr
         VtNYP4kw/al7HDouh3XgEjqz5+gknLAMltniBGvy1atwDopSOk7cwAFtTCcLPxrcOfZq
         HfD089M889W/OIjoLR2S7Yk8GQlkihO5ykky9gsTetwV7sLjpnRYd4ZGETqO2WNTgVTT
         9qdlXNy1uHeuuKKxD+HzFCJdhQuw5apaUjAAAYUswNh2rVOu4IXGj7md8vyP/yDl4csV
         3OA0tMjkUkUTgcRUPmCtvKmVOY4kys1C4BIlJEa38eyZq0revRas6Fp6ecGuQ/5DLXfB
         6LRg==
X-Gm-Message-State: AOAM530F+8ZNLO8wJsUZ2khgm5A6K3G/K31BFcFw+VqJBs/A5Zl8AUYR
        A/jGRjts4oytyClhkEWjy/utJ7jWZHY=
X-Google-Smtp-Source: ABdhPJzoWd/zv4a73Hm+6UMDFbDuTtY/aW3uBGeGtEkenIY4u+PBWjnMDhS0OKgWb4CgBE+ldgp/5g==
X-Received: by 2002:a92:dcc6:: with SMTP id b6mr17562405ilr.146.1624260569530;
        Mon, 21 Jun 2021 00:29:29 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id n12sm5667918ile.0.2021.06.21.00.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 00:29:29 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 9725227C005A;
        Mon, 21 Jun 2021 03:29:28 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 21 Jun 2021 03:29:28 -0400
X-ME-Sender: <xms:2D_QYDlNxyZfzBpfoV-3ZiPujRkEzw-P2jl6PiCTVUo26HA9tTUNHw>
    <xme:2D_QYG0zv3ikIIB5_X5cx8QYqHrIuh_ZOinUusmcpCxe4mVbMJ1_Dr0lL3TVvJvbd
    vgngj6kMsmXaSB9wA>
X-ME-Received: <xmr:2D_QYJoreRdLpN54Z0nsDMCRaQCi-dp6vmDc5GpJjnfZjsYSjDTKOlnGlDk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeefkedguddujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeevieejtdfhieejfeduheehvdevgedugeethefggfdtvdeutdevgeetvddv
    feegtdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhh
    phgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunh
    drfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:2D_QYLlYn97_5J3QtgSONEaJUP0vJl98HqZiFU-OJwnJqe0Tu9ZdPA>
    <xmx:2D_QYB3BXmgU_XnjYQZ0JLQrLArahPstOBlz2_5tsPCyFNz3tC6SdA>
    <xmx:2D_QYKvjej-Dlq81IZG_EuaIJhqKFx9kuA6AMSMpbyFM5f3MhUDDZw>
    <xmx:2D_QYJ-8pe4LgmMJ35YubzTKham6TuNPkLl6qWE0InIHDhO8Iu75uw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Jun 2021 03:29:27 -0400 (EDT)
Date:   Mon, 21 Jun 2021 15:28:53 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] Fix issues in check_irq_usage()
Message-ID: <YNA/tdi4Dh4FLC16@boqun-archlinux>
References: <20210618170110.3699115-1-boqun.feng@gmail.com>
 <2760706369e7401dd794339e3f22859c243272ea.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2760706369e7401dd794339e3f22859c243272ea.camel@sipsolutions.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2021 at 07:36:26PM +0200, Johannes Berg wrote:
> Hi Boqun,
> 

Hello,

> Great, thanks! I'll ask the folks who could reproduce this issue to do
> so as soon as possible.
> 
> Not sure if you saw my previous posting:
> https://lore.kernel.org/lkml/8a61ecda99843307018e3e71a5540682436443fc.camel@sipsolutions.net/T/#u
> 

I just replied that thread on the particular deadlock scenario there.

> That was with patch 3 of this set already applied.
> 
> 
> If I understand correctly, then you're basically saying that if we apply
> all the 3 (or 4) patches here, it'll just change the report (that you
> can see at the link above) to actually say something that I can
> understand to see where the issue is?
> 

Sort of, these patches will provide you a correct lock dependency path
on the deadlock possibility along with the correct call stacks. However,
currently I don't think it's easy for lockdep to print the 4-CPU
scenario that I post in the other email, so it will still take some
effort to decode the lockdep, so you will still need some lockdep
knowledge to understand the real issue ;-(

Regards,
Boqun

> Thanks,
> johannes
> 
> 
