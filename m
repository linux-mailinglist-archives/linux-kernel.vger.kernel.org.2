Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C67E03D26F8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 17:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232588AbhGVPCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 11:02:24 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:48365 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbhGVPCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 11:02:23 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4GVxYB2TV3z1qy4L;
        Thu, 22 Jul 2021 17:42:54 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4GVxYB0jbnz1rmYB;
        Thu, 22 Jul 2021 17:42:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id bY5aEtjrg-3r; Thu, 22 Jul 2021 17:42:53 +0200 (CEST)
X-Auth-Info: PIjtPIK9afYCsoiZrRCgLg1D74hHiwqDc3Ol8FTCod9odBW8gn7GZlgUh/jJPM+a
Received: from igel.home (ppp-46-244-188-81.dynamic.mnet-online.de [46.244.188.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Thu, 22 Jul 2021 17:42:53 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id 8D6C92C2659; Thu, 22 Jul 2021 17:42:52 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Palmer Dabbelt <palmer@dabbelt.com>, tongtiangen@huawei.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next v2] riscv: add VMAP_STACK overflow detection
References: <87bl6yrcmd.fsf@igel.home>
        <mhng-e14c3232-cc4d-4146-8c93-c60ec81ed272@palmerdabbelt-glaptop>
        <CAOnJCU+Ss0cO1mqr=GDVnpxV075uR+KipSnr7dN93099dAH+vQ@mail.gmail.com>
        <20210722213724.1f12a0e7@xhacker>
X-Yow:  Don't hit me!!  I'm in the Twilight Zone!!!
Date:   Thu, 22 Jul 2021 17:42:52 +0200
In-Reply-To: <20210722213724.1f12a0e7@xhacker> (Jisheng Zhang's message of
        "Thu, 22 Jul 2021 21:37:24 +0800")
Message-ID: <87zguexslf.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 22 2021, Jisheng Zhang wrote:

> I think we need to pin the stack before calling get_wchan(), could you please
> try below patch?

Thanks, this fixes the crash for me.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
