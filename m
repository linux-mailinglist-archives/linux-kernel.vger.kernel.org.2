Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3B934CE05
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 12:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbhC2Ki0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 06:38:26 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:47982 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbhC2KiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 06:38:06 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4F88DP4njmz1qt3f;
        Mon, 29 Mar 2021 12:37:57 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4F88DP3XYVz1r1M0;
        Mon, 29 Mar 2021 12:37:57 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id qHhjco2SiS_B; Mon, 29 Mar 2021 12:37:56 +0200 (CEST)
X-Auth-Info: SY4jm4BlGYZhw3PVScWDgiAb4jYC06Zb+UoxBWZYT/IpA/DcokoI2XiNNWuYVXSw
Received: from igel.home (ppp-46-244-184-171.dynamic.mnet-online.de [46.244.184.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Mon, 29 Mar 2021 12:37:56 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id E93BA2C3258; Mon, 29 Mar 2021 12:37:55 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Zong Li <zong.li@sifive.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Pragnesh Patel <pragnesh.patel@openfive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Michael Turquette <mturquette@baylibre.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v7 0/5] clk: add driver for the SiFive FU740
References: <20201209094916.17383-1-zong.li@sifive.com>
        <87v99qyjaz.fsf@igel.home>
        <CANXhq0oLxFK1431WmTj5HRO5k_omYkQZCBTG+HORTk9=W_XyNg@mail.gmail.com>
        <CANXhq0p90Cgha_zLzxamK9mxmVPn3effh_cZq_CTLrcAkKZg2Q@mail.gmail.com>
        <87lfaj7cki.fsf@igel.home> <871rc4on36.fsf@igel.home>
        <CANXhq0pDge0BPgAjoLrX7Y2qtofb3dhV1_CPHBaCg0o4cEMrbQ@mail.gmail.com>
        <87a6qrk2pw.fsf@igel.home>
        <CANXhq0rOeAWnRYHAYKJfDeY4kYz6+5mU_dJSqU67+2p9u0STHQ@mail.gmail.com>
        <874kgyfetu.fsf@igel.home>
        <CANXhq0rE-ZcPBp02Pvozpk_s-j6NhxHUmso75uz6ji9bejO8gA@mail.gmail.com>
X-Yow:  I feel like I'm in a Toilet Bowl with a thumbtack in my forehead!!
Date:   Mon, 29 Mar 2021 12:37:55 +0200
In-Reply-To: <CANXhq0rE-ZcPBp02Pvozpk_s-j6NhxHUmso75uz6ji9bejO8gA@mail.gmail.com>
        (Zong Li's message of "Mon, 29 Mar 2021 18:18:42 +0800")
Message-ID: <87h7kukzy4.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mär 29 2021, Zong Li wrote:

> Yes, I could get the network problem by using the defconfig you
> provided, the system hung up when executing 'ifconfig' immediately
> after installing macb driver module, the network can work by only
> reverting the commit 732374a0b440d9a79c8412f318a25cd37ba6f4e2. But the
> network is fine by using the mainline's defconfig, this is a little
> bit weird, I will check that and try to find the difference.

My guess would be that it is an init dependency problem between the phy
driver and the clock driver, which causes the clock to be enabled too
late.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
