Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96F1833DDEF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 20:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240648AbhCPTpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 15:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240635AbhCPTpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 15:45:17 -0400
Received: from mail-out.m-online.net (mail-out.m-online.net [IPv6:2001:a60:0:28:0:1:25:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE03EC06174A;
        Tue, 16 Mar 2021 12:45:14 -0700 (PDT)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4F0Nzp5fCLz1rxMm;
        Tue, 16 Mar 2021 20:45:10 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4F0Nzp42vgz1qqlD;
        Tue, 16 Mar 2021 20:45:10 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id HVprAfGCzxsU; Tue, 16 Mar 2021 20:45:09 +0100 (CET)
X-Auth-Info: SurgzyzvOEKJPZRKHt6wkP9W5Z0YUNK8ZVcNfo2fRZpxXEba/9GDDNhI7l/OoTV0
Received: from igel.home (ppp-46-244-163-222.dynamic.mnet-online.de [46.244.163.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Tue, 16 Mar 2021 20:45:09 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
        id E3E372C37EC; Tue, 16 Mar 2021 20:45:08 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Zong Li <zong.li@sifive.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com, sboyd@kernel.org,
        pragnesh.patel@openfive.com, aou@eecs.berkeley.edu,
        mturquette@baylibre.com, yash.shah@sifive.com,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v7 0/5] clk: add driver for the SiFive FU740
References: <20201209094916.17383-1-zong.li@sifive.com>
X-Yow:  When you said ``HEAVILY FORESTED'' it reminded me of an overdue
 CLEANING BILL..  Don't you SEE?  O'Grogan SWALLOWED a VALUABLE
 COIN COLLECTION and HAD to murder the ONLY MAN who KNEW!!
Date:   Tue, 16 Mar 2021 20:45:08 +0100
In-Reply-To: <20201209094916.17383-1-zong.li@sifive.com> (Zong Li's message of
        "Wed, 9 Dec 2020 17:49:11 +0800")
Message-ID: <87v99qyjaz.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Dez 09 2020, Zong Li wrote:

> Add a driver for the SiFive FU740 PRCI IP block, which handles more
> clocks than FU540. These patches also refactor the original
> implementation by spliting the dependent-code of fu540 and fu740
> respectively.

That breaks ethernet on the fu540.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
