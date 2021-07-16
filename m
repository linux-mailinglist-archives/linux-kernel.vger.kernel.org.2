Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF6AF3CBA27
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 17:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241060AbhGPP4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 11:56:53 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:53374 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241033AbhGPP4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 11:56:51 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4GRG4c1xpCz1qw9Q;
        Fri, 16 Jul 2021 17:53:52 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4GRG4c0k0Qz1qqy2;
        Fri, 16 Jul 2021 17:53:52 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id Ua9oCtw0oHIU; Fri, 16 Jul 2021 17:53:50 +0200 (CEST)
X-Auth-Info: hNFfgV+zdvt6oFzKbma464ONWGddgfQIitZc4eefrC0nK2UxpUd7lRGwoA+kAqVg
Received: from igel.home (ppp-46-244-181-162.dynamic.mnet-online.de [46.244.181.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Fri, 16 Jul 2021 17:53:50 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id 4EFB02C2532; Fri, 16 Jul 2021 17:53:50 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
Cc:     Tong Tiangen <tongtiangen@huawei.com>, <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next v2] riscv: add VMAP_STACK overflow detection
References: <20210621032855.130650-1-tongtiangen@huawei.com>
        <87pmvjtumc.fsf@igel.home> <20210716205332.5856df78@xhacker>
X-Yow:  YOW!!  Up ahead!  It's a DONUT HUT!!
Date:   Fri, 16 Jul 2021 17:53:50 +0200
In-Reply-To: <20210716205332.5856df78@xhacker> (Jisheng Zhang's message of
        "Fri, 16 Jul 2021 20:53:32 +0800")
Message-ID: <871r7yz241.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 16 2021, Jisheng Zhang wrote:

> I can't reproduce the panic error. Mind to share your .config?

https://github.com/openSUSE/kernel-source/blob/master/config/riscv64/default

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
