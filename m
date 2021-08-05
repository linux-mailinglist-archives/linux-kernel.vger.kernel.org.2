Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7BA83E1000
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 10:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239246AbhHEINu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 04:13:50 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:47165 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237051AbhHEINt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 04:13:49 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4GgLwC2HM5z1qy54;
        Thu,  5 Aug 2021 10:13:31 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4GgLwC0JMPz1qvtY;
        Thu,  5 Aug 2021 10:13:31 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id xPOGeJl5EZxV; Thu,  5 Aug 2021 10:13:29 +0200 (CEST)
X-Auth-Info: Kw+0VKHwCc7/D60xsxiPGmSjDWShc6pKBsWCauRJElVomF3qtN3els56nsBMTkNT
Received: from igel.home (ppp-46-244-179-131.dynamic.mnet-online.de [46.244.179.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Thu,  5 Aug 2021 10:13:29 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id 929B52C02D9; Thu,  5 Aug 2021 10:13:28 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Drew Fustini <drew@pdp7.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>, atishp@atishpatra.org,
        drew@beagleboard.org, bmeng.cn@gmail.com, robh+dt@kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        michael.zhu@starfivetech.com, tekkamanninja@gmail.com,
        jack.zhu@starfivetech.com, leyfoon.tan@starfivetech.com,
        geert@linux-m68k.org, kernel@esmil.dk, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] dt-bindings: riscv: add starfive jh7100 bindings
References: <CAOnJCUL9uU5G1LOgfYPz9Ny77yFYaP5sgtdxG3_w=Zcsi+f96Q@mail.gmail.com>
        <mhng-c9300c9e-6877-492f-a290-7c51066d3920@palmerdabbelt-glaptop>
        <20210805023024.GA12312@x1>
X-Yow:  I HAVE to buy a new ``DODGE MISER'' and two dozen JORDACHE
 JEANS because my viewscreen is ``USER-FRIENDLY''!!
Date:   Thu, 05 Aug 2021 10:13:28 +0200
In-Reply-To: <20210805023024.GA12312@x1> (Drew Fustini's message of "Wed, 4
        Aug 2021 19:30:24 -0700")
Message-ID: <87fsvotil3.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 04 2021, Drew Fustini wrote:

> The arch_sync_dma RFC from Atish [1] is key to the board running
> mainline.

It still has issues, though.

https://github.com/starfive-tech/linux/issues/1#issuecomment-879910372

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
