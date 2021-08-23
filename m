Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6B853F4342
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 03:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234802AbhHWB6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 21:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233258AbhHWB6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 21:58:46 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BAF0C061575;
        Sun, 22 Aug 2021 18:58:05 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id n126so17810237ybf.6;
        Sun, 22 Aug 2021 18:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wLsr+R0Fve9ivW+7qc/jUuotRZ00tnDPLOXaKuMzzD4=;
        b=RkT7Ab1TdRuLb9JbE9JxGn14hi9GH2rFmC4TG7zt/+6Ai+lnjwwfRqKVWumQIP1NHz
         TSwE5cSAXmTimpu03Q5vD3ve+pA3rlI0ZWUKLOq7Mh1//0bcuJ3PP6ZZEC5/jnZIjImj
         ZXKKvbwiPLSwLLv4pQneuFAMoiDrgjDFCzvM6XPhBAddFaszBV/NNQzXsCgVEWGlMQt4
         53/NFAqgHiNJiVdCcDYIugaFG0paytp0T3hs6jBMsSzH64WkXPL88QKUK32ycBqo70xp
         dKtKHYYFqUXTwqOPO9emQvjbxRor4yx4e4pl/EScwhZE0tNjYn5bLTgmGhyG0Pf7FjWQ
         0PFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wLsr+R0Fve9ivW+7qc/jUuotRZ00tnDPLOXaKuMzzD4=;
        b=l/uJULeYcIuWQt1blH82AruYe1lVAd52sW9lSbMI1LqzK3+eWyZXeBkpLfCF/GfoJH
         1pKFr7LsmkuvRZtux2wR+CP99F2LGvCngeJnUJvCuRHPKpcVuYZEqWDlfIR2Fk8jGNV+
         rUnyaXbC29Ctw7z8CTrNAC4/3Vt6OCoXvET5Wk/FmbtFHZAMpdCeCM3QoCUaKc+VVGn+
         9vqL7OjwfCXI9qDLGSkjzpJlcCLH2fSw7JYscFqAT06L/ShTF7473hclx6oPz13q4pMv
         rLZddrroAsjY0RxeoxfadTmAnvsqpTVTAtATjJq/xUQhjZLZRMBCN5MTxPgPJujRf68o
         balA==
X-Gm-Message-State: AOAM5323sJdh0PpDEfH9/+GiLqDqVJQyfx1vuWWKYGYYZZzRiFYviUUQ
        WKFRCYDBFqszTJlzom3TbfotV6hF8YqqCq+tPgE86CNyBQ1DKQJ/+Rk=
X-Google-Smtp-Source: ABdhPJxRvdQG0Ud1bze67w4fbPLedynZ27gerJNJTzB4xfNCcMWZBJ9gwk33CZztFXNBYImwJ9ALQOhaC6ZoSpzAyJk=
X-Received: by 2002:a25:b7c8:: with SMTP id u8mr39872181ybj.268.1629683884334;
 Sun, 22 Aug 2021 18:58:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210820030536.25737-1-yaozhenguo1@gmail.com> <20210822151952.23ca9547316dc34c9f3bd482@linux-foundation.org>
 <YSLPWybBCyE/6x7s@casper.infradead.org>
In-Reply-To: <YSLPWybBCyE/6x7s@casper.infradead.org>
From:   zhenguo yao <yaozhenguo1@gmail.com>
Date:   Mon, 23 Aug 2021 09:57:53 +0800
Message-ID: <CA+WzARmb+KVLo=isfU7T2bi=9O=UFFG57CBk6w-+haKp_OqbMg@mail.gmail.com>
Subject: Re: [PATCH] hugetlbfs: add hugepages_node kernel parameter
To:     Matthew Wilcox <willy@infradead.org>
Cc:     mike.kravetz@oracle.com, corbet@lwn.net, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, the expanding of hugepages is more elegant. I  will change it in
the next version.

Matthew Wilcox <willy@infradead.org> =E4=BA=8E2021=E5=B9=B48=E6=9C=8823=E6=
=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8A=E5=8D=886:28=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sun, Aug 22, 2021 at 03:19:52PM -0700, Andrew Morton wrote:
> > On Fri, 20 Aug 2021 11:05:36 +0800 yaozhenguo <yaozhenguo1@gmail.com> w=
rote:
> >
> > > We can specify the number of hugepages to allocate at boot. But the
> > > hugepages is balanced in all nodes at present. In some scenarios,
> > > we only need hugepags in one node. For example: DPDK needs hugepages
> > > which is in the same node as NIC. if DPDK needs four hugepags of 1G
> > > size in node1 and system has 16 numa nodes. We must reserve 64 hugepa=
gs
> > > in kernel cmdline. But, only four hugepages is used. The others shoul=
d
> > > be free after boot.If the system memory is low(for example: 64G), it =
will
> > > be an impossible task. So, add hugepages_node kernel parameter to spe=
cify
> > > node number of hugepages to allocate at boot.
> > > For example add following parameter:
> > >
> > > hugepagesz=3D1G hugepages_node=3D1 hugepages=3D4
> > >
> > > It will allocate 4 hugepags in node1 at boot.
> >
> > If were going to do this, shouldn't we permit more than one node?
> >
> >       hugepages_nodes=3D1,2,5
>
> I'd think we'd be better off expanding the definition of hugepages.
> eg:
>
> hugepagesz=3D1G hugepages=3D1:4,3:8,5:2
>
> would say to allocate 4 pages from node 1, 8 pages from node 3 and 2
> pages from node 5.
