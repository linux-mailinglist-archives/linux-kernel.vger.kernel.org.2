Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83F703FD82D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 12:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235853AbhIAKvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 06:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238520AbhIAKvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 06:51:41 -0400
Received: from vulcan.natalenko.name (vulcan.natalenko.name [IPv6:2001:19f0:6c00:8846:5400:ff:fe0c:dfa0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9290C061575
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 03:50:44 -0700 (PDT)
Received: from spock.localnet (unknown [151.237.229.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 5184CBC775E;
        Wed,  1 Sep 2021 12:50:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1630493442;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zW+p1tJu2N9Wjpk2M7abVhvtcvMOJ1OzLqdRmccxpbk=;
        b=bHKixlgHso8h1k0nJUYPuLqMnU0iXL+FpzIsKt+e0pn9cx8G2b78yuZjp0Q0W7WWbqYY5E
        jpAmQ9pk0EMzP65egoUoEIQUsN/csZzqR5rp9N0KvDZsOpMlniLR6AGE46n7ZNJ/mTfffg
        vrPqKDsVHCs95HkSwmRFa9vilR0flT8=
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     Michal Hocko <mhocko@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [RFC PATCH 1/1] mm: provide one common K(x) macro
Date:   Wed, 01 Sep 2021 12:50:40 +0200
Message-ID: <5529272.KFOknHQvy8@natalenko.name>
In-Reply-To: <YS9WiF6enhSo8sYc@dhcp22.suse.cz>
References: <20210901092149.994791-1-oleksandr@natalenko.name> <20210901092149.994791-2-oleksandr@natalenko.name> <YS9WiF6enhSo8sYc@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

On st=C5=99eda 1. z=C3=A1=C5=99=C3=AD 2021 12:31:36 CEST Michal Hocko wrote:
> On Wed 01-09-21 11:21:49, Oleksandr Natalenko wrote:
> > There are various places where the K(x) macro is defined. This commit
> > gets rid of multiple definitions and provides a common one.
> >=20
> > This doesn't solve open-coding this macro in various other places. This
> > should be addressed by another subsequent commit.
>=20
> Why is this an improvement? You are adding a header file for a single
> macro which sounds like an overkill.

I agree a separate header file is an overkill for just one #define, hence
still looking for a suggestion on a better place for it.

> The overall net outcome is added
> lines of code.

Not always. There are some long statements like:

```
seq_printf(seq, ",size=3D%luk",
        sbinfo->max_blocks << (PAGE_SHIFT - 10));
```

that are split into two lines. With the macro those take one line only:

```
seq_printf(seq, ",size=3D%luk", K(sbinfo->max_blocks));
```

As of now (counting unposted open-coding replacements) the grand total is:

```
31 files changed, 104 insertions(+), 90 deletions(-)
```

which is not that horrible.

> It is not like K() or any of its variant is adding a
> maintenance burden due to code duplication. So why do we want to change
> the existing state?

=46or me it's about readability. Compare, for instance:

```
seq_put_decimal_ull_width(m, str, (val) << (PAGE_SHIFT-10), 8)
```

and

```
seq_put_decimal_ull_width(m, str, K(val), 8)
```

It's a small yet visible difference.

Thanks.

=2D-=20
Oleksandr Natalenko (post-factum)


