Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 704133F4348
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 04:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234829AbhHWCF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 22:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234692AbhHWCFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 22:05:52 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4DDDC061575;
        Sun, 22 Aug 2021 19:05:10 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id z5so31180507ybj.2;
        Sun, 22 Aug 2021 19:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=a+lvHaFeJkkkAOQLbRXTzBc/XIrK+hutoY3j14PFZrI=;
        b=MfNfBTZ2vcGCOpo/Q3VnL1nXtWkssmtLA67FYLhXkbprxOmIcdaa36AnwIWnjLW8D1
         HLM7wFzyNanE6G8JALSOZVZwO8ZFHnC09STF42HCeoYDAM4zpFJSSDdCg3zCUfMMacFr
         Db8KAmWZ4jjC3mg4yztVvenudvzmZTy4BlFHUdEt75kQz0bcYJm2FdhLzVcR+UGlxQy2
         QP5aSBZX6VOC4bDPCoq4+D1Vaz4ZeeFGnlckBf+QM3O5R5cj/dsf0HLTWnLfKmQeC6Vp
         duEdP6c/qB4BGDGN1APcKqtckive9N3vW1ESJSRQB/jdS00w5p1RHegoBup37/Xcz1+3
         75sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=a+lvHaFeJkkkAOQLbRXTzBc/XIrK+hutoY3j14PFZrI=;
        b=Ojc+FIZVdE9n6Q6f8/EBdA9Y9m530m8X77oJO/Mga9OwBlDhwcahVSO/H74G11GTdE
         ru8Jdc0V4W/dwacpDv5YL/FffdCjQkfE32TpHNn0+GGpbI0kd7U0DUewbtel03AKNcPa
         +UOvnDlOt39udZELPob1Gb2ZudSIpXp+wMPLSWEBYtOGL1EFascwBaRUIA4rENPlXW9v
         TvDgw70PCrU71RRt11i+q0ythWKeeTYf9Tc+lqiYehvcSytI7CUnxz3Cf/0AZcUZv6fK
         bCm1S4KF/LjNMy5T3bEQHQgzDJthbPWNaiMj1ezQl2+glRCM+Sc258LnJ1p/AXGtLC5x
         ve8g==
X-Gm-Message-State: AOAM531sLMHRvTdbh0IbtwJ136UdiwUDlO7Xon1xyG5lUxPNycciUvUi
        mSqVzK7FDTLdjCq5oVisIIJBTzo7uQRy8FSkPuk=
X-Google-Smtp-Source: ABdhPJyTFctQxEFbGQTEAfjJ9SfrzImsMKkPY0StuBM9e+G/q6jRwHnf/sBE+LKSoOeNbdsilCTJjhL7/Czd0I9Fd5g=
X-Received: by 2002:a25:b845:: with SMTP id b5mr40137971ybm.343.1629684309946;
 Sun, 22 Aug 2021 19:05:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210820030536.25737-1-yaozhenguo1@gmail.com> <20210822151952.23ca9547316dc34c9f3bd482@linux-foundation.org>
In-Reply-To: <20210822151952.23ca9547316dc34c9f3bd482@linux-foundation.org>
From:   zhenguo yao <yaozhenguo1@gmail.com>
Date:   Mon, 23 Aug 2021 10:04:59 +0800
Message-ID: <CA+WzARkRYP=n1T+G3ciUYmM+nK3H-FpRMG5Nq8kpujTwpYmnMA@mail.gmail.com>
Subject: Re: [PATCH] hugetlbfs: add hugepages_node kernel parameter
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     mike.kravetz@oracle.com, corbet@lwn.net,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, yaozhenguo@jd.com,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OK,  It's better to use a concise way to add this function.  I will
use a better way in the next version.

Andrew Morton <akpm@linux-foundation.org> =E4=BA=8E2021=E5=B9=B48=E6=9C=882=
3=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8A=E5=8D=886:19=E5=86=99=E9=81=93=EF=BC=
=9A
>
> On Fri, 20 Aug 2021 11:05:36 +0800 yaozhenguo <yaozhenguo1@gmail.com> wro=
te:
>
> > We can specify the number of hugepages to allocate at boot. But the
> > hugepages is balanced in all nodes at present. In some scenarios,
> > we only need hugepags in one node. For example: DPDK needs hugepages
> > which is in the same node as NIC. if DPDK needs four hugepags of 1G
> > size in node1 and system has 16 numa nodes. We must reserve 64 hugepags
> > in kernel cmdline. But, only four hugepages is used. The others should
> > be free after boot.If the system memory is low(for example: 64G), it wi=
ll
> > be an impossible task. So, add hugepages_node kernel parameter to speci=
fy
> > node number of hugepages to allocate at boot.
> > For example add following parameter:
> >
> > hugepagesz=3D1G hugepages_node=3D1 hugepages=3D4
> >
> > It will allocate 4 hugepags in node1 at boot.
>
> If were going to do this, shouldn't we permit more than one node?
>
>         hugepages_nodes=3D1,2,5
