Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0BA535C532
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 13:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240233AbhDLLcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 07:32:08 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:40195 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238951AbhDLLcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 07:32:07 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4FJmm10FGFz1s3pb;
        Mon, 12 Apr 2021 13:31:45 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4FJmm0627zz1r1MK;
        Mon, 12 Apr 2021 13:31:44 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id EglLZHD-29yn; Mon, 12 Apr 2021 13:31:43 +0200 (CEST)
X-Auth-Info: Ck3cUIHyMwTSrvrWjSo1RAiYHd/m6J6UJHJ+UhZhLBByE9hnwtEAV9Tz9dURqEKH
Received: from igel.home (ppp-46-244-166-146.dynamic.mnet-online.de [46.244.166.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Mon, 12 Apr 2021 13:31:43 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id 63F852C3644; Mon, 12 Apr 2021 13:31:43 +0200 (CEST)
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
        <87h7kukzy4.fsf@igel.home>
        <CANXhq0r5_xhFu3W9mUFkp_7BYUVBzvHZE1A6jpBDcL_KwTc1cA@mail.gmail.com>
X-Yow:  LOOK!!  Sullen American teens wearing MADRAS shorts and
 ``Flock of Seagulls'' HAIRCUTS!
Date:   Mon, 12 Apr 2021 13:31:43 +0200
In-Reply-To: <CANXhq0r5_xhFu3W9mUFkp_7BYUVBzvHZE1A6jpBDcL_KwTc1cA@mail.gmail.com>
        (Zong Li's message of "Wed, 31 Mar 2021 16:11:20 +0800")
Message-ID: <87tuob7n8g.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mär 31 2021, Zong Li wrote:

> I found that the gemgxlpll was disabled immediately by power
> management after macb driver install. The mainline's defconfig doesn't
> enable CONFIG_PM, so the network is fine on it. The opensuse defconfig
> enables CONFIG_PM, and the patch
> 732374a0b440d9a79c8412f318a25cd37ba6f4e2 added the enable/disable
> callback functions, so the gemgxlpll PLL, I have no idea why power
> management disable it, I would keep trace it.

Does that mean that CONFIG_PM also affects the FU740?

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
