Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1470D42988D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 23:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234980AbhJKVD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 17:03:27 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:54917 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbhJKVD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 17:03:26 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1M4skB-1mZl2Z2v0p-001zC4; Mon, 11 Oct 2021 23:01:24 +0200
Received: by mail-wr1-f50.google.com with SMTP id g25so13608434wrb.2;
        Mon, 11 Oct 2021 14:01:24 -0700 (PDT)
X-Gm-Message-State: AOAM530j6sS0/vQ+Rj01Q2xxQbQB5U5o81ALsKYzexVpZoP1LIJmIwl4
        J0Hu4ZGmJW8D7GKN92ZJ9XcKaj8OLQHwUjh8ojA=
X-Google-Smtp-Source: ABdhPJwJlum4oCdRbc3gkZC+CU0jqqrsb2c79AL+PGtKmiX7j5JjRUVa5I5C2ZIVTw28c/jHjdNNO1NBcNYOXZnCGJY=
X-Received: by 2002:a05:600c:4f4d:: with SMTP id m13mr1388672wmq.82.1633986084389;
 Mon, 11 Oct 2021 14:01:24 -0700 (PDT)
MIME-Version: 1.0
References: <20211008034533.343167-3-zhang.lyra@gmail.com> <202110120420.QA3lbmW1-lkp@intel.com>
In-Reply-To: <202110120420.QA3lbmW1-lkp@intel.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 11 Oct 2021 23:01:08 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0bDn3Eu6sTjrg1=vx-jrrvvrrkA7GVVj3puSF28BZ+Hg@mail.gmail.com>
Message-ID: <CAK8P3a0bDn3Eu6sTjrg1=vx-jrrvvrrkA7GVVj3puSF28BZ+Hg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] arm64: dts: Add support for Unisoc's UMS512
To:     kernel test robot <lkp@intel.com>
Cc:     Chunyan Zhang <zhang.lyra@gmail.com>, SoC Team <soc@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, kbuild-all@lists.01.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:ep6wLfA0Cq3ObMz0ONTD+ygspTTb2tPJid699+a3dW0f//HuWx1
 lNu1KSEd+76RDKs2kZa4ADGRSA3ATgXgl890Lr2HHDdHpZokfFj6mY5jZ/1/cwv5UT10XB3
 I/70YJRO/tn23c0IGCIhcCkYm78YKrO5hdcmWABQN2b3pf9+bU3x8dasLZfysuAn0CwQBxE
 PG5LRvjVT+YQWH7BCusww==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:0so7U7GFGVE=:Z89U3ucftHILPVkTFCeI+S
 Tspt5A4lhvpUESGl1hiaaAjMKhsO+AuqpXIk8nFXlwdDzV/j/puqQpqEviCaem91sj60GFBvx
 /ZyYqdY48NdHLhYZm0Qn1wE3dD1YqVNq3m/gR5d7oBv0T2BP42qARMGyD8G0LtT+/bde8y4Tp
 +eMWfMJD7kOjdcytqm5LUWNmpFvGQRELxG2e0P0jFfOZPqBK6vck2woAZH/roXaVnjDDSTkCn
 NWrvED2K8U0XSTJ+Jbjh4b+JOhSIPgQ5HNcPjo1AQ9b5FJ//m3ZeesY0Mn3Los/tdswJypXQA
 eOhKayulSez9mXLR0282p70HAzeFJZLf1EmaVnmf7Y9QaSikzKaR1bcsLMYujNCw7Z+/f8e+o
 fAxoXL+AzCbl1AngRIJrXPwdhtMCNLXE8uPWSTBZkx1JbodtghIHmNUGSvMUQdE38xOraviTy
 yR0oKipWCjLyJxjnkRsgIgUUa13D8clGXBBIXLJ28bB7pKkQS1eu3xktce9eZmweHuRVebuEw
 wl/46DiRIRrjtAy7QuWvR1h3IMkE8sAMoTj7dHJGYbt3qIMbUHTGwZa2U4Ewut91hXzdg6z9r
 m4zuAv4zENydtgo2bGaCqfb4yxRvnJvh6BPfeMwFvs0lw9XpQKTXudGIATHyImgddmRh6holF
 RCcCLkk7eP50DDZaCWLqxIDDPFxEGrsr0O7UpXuekNVyvKc7BbCz2fAf068R8MpcKed1QY750
 WDpu0xUXMiFg8CuX1BTKS+37Mzho9QVreZ6ZcAXaNTIMV0+vGSwrDvc82Hu+FnSOijoZhLXBa
 e3sGsFlQeQuoaHCXI3NoDnQJj9VvND8kk8VdMjWrOsDlFcxOs4mQGTIOpn78uCmGh6f0kfXjn
 aFl/osKKIq0Pb84wJTCQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2021 at 10:29 PM kernel test robot <lkp@intel.com> wrote:
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    In file included from arch/arm64/boot/dts/sprd/ums512-1h10.dts:11:
> >> arch/arm64/boot/dts/sprd/ums512.dtsi:8:10: fatal error: dt-bindings/clock/sprd,ums512-clk.h: No such file or directory
>        8 | #include <dt-bindings/clock/sprd,ums512-clk.h>
>          |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    compilation terminated.
>
>
> vim +8 arch/arm64/boot/dts/sprd/ums512.dtsi
>
>    > 8  #include <dt-bindings/clock/sprd,ums512-clk.h>
>      9  #include <dt-bindings/interrupt-controller/arm-gic.h>

Thanks for the report.

Unfortunately I just pulled this, and then a bunch of other things on top.

Looking at linux-next, the binding is not merged yet, which means I should
not take this one anyway.

I'll keep the first patch and revert this one.

         Arnd
