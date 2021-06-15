Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B92D3A8C7B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 01:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbhFOXa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 19:30:28 -0400
Received: from mailgate.ics.forth.gr ([139.91.1.2]:20850 "EHLO
        mailgate.ics.forth.gr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231524AbhFOXa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 19:30:27 -0400
Received: from av3.ics.forth.gr (av3in.ics.forth.gr [139.91.1.77])
        by mailgate.ics.forth.gr (8.15.2/ICS-FORTH/V10-1.8-GATE) with ESMTP id 15FNSLee058431
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 02:28:21 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; d=ics.forth.gr; s=av; c=relaxed/simple;
        q=dns/txt; i=@ics.forth.gr; t=1623799696; x=1626391696;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=p/3MC/QA7PBUvaqQB1NOM6ogYciz+/iFHdbIBY6EVIw=;
        b=oWA5UGGsmxFarttwaCy3W20nohyePUKeHyyYjGAQUingnx9Tbb9YVskp1tveTf5f
        /TrG0uoUEOu1KXmvDoswDIzEpckGnsG4rp+EjzXq+YDlBbgnB8eOnXzFNzxGfyPV
        dyYSKSOzqngxPnnGheGyX8uKYwsFmdeCxjtE4i9ceVFC3wGoNgMg4NIMc3Jpumev
        pq5+xKjDGbpnI5Sovr+bStPrFcb3B5Bb+/XgN1ko2XpYKsFJDsrdoFrP8EavhVrt
        dQSU+rAaJ1j7S1fNLBXCc0jAO57jqZCVESowVsZYkTxdcNi6GsUKaue06RuFNZjI
        XUBYfCyrtK1ijAFy4qZ8sQ==;
X-AuditID: 8b5b014d-962f1700000067b6-4f-60c9378fd979
Received: from enigma.ics.forth.gr (enigma.ics.forth.gr [139.91.151.35])
        by av3.ics.forth.gr (Symantec Messaging Gateway) with SMTP id 9B.05.26550.F8739C06; Wed, 16 Jun 2021 02:28:16 +0300 (EEST)
X-ICS-AUTH-INFO: Authenticated user:  at ics.forth.gr
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Wed, 16 Jun 2021 02:28:15 +0300
From:   Nick Kossifidis <mick@ics.forth.gr>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Nick Kossifidis <mick@ics.forth.gr>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Frank Rowand <frowand.list@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] of: fdt: Add generic support for parsing elf core
 header properties
Organization: FORTH
In-Reply-To: <8661d652968d050489852ccb50df5ad4cc048900.1623780059.git.geert+renesas@glider.be>
References: <cover.1623780059.git.geert+renesas@glider.be>
 <8661d652968d050489852ccb50df5ad4cc048900.1623780059.git.geert+renesas@glider.be>
Message-ID: <96476719da53fe67dbb91268e2ad7492@mailhost.ics.forth.gr>
X-Sender: mick@mailhost.ics.forth.gr
User-Agent: Roundcube Webmail/1.3.16
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkkeLIzCtJLcpLzFFi42Lpjp6urDvB/GSCQcdLJoutv2exW7xf1sNo
        Mf/IOVaLmW/+s1nMnT2J0WLT42usFpd3zWGz2Pa5hc2i+d05douXl3uYLdpm8Vu07j3CbtFy
        x9SB12PNvDWMHm9evmTxONzxhd1j4lldj52z7rJ7PNx0iclj06pONo/NS+o9LjVfZ/f4vEku
        gCuKyyYlNSezLLVI3y6BK+PJjvdMBRsYK66tvsjcwDiVsYuRk0NCwETi5+ud7F2MXBxCAkcZ
        JU48fwKVMJWYvbcTzOYVEJQ4OfMJC4jNLGAhMfXKfkYIW16ieetsZhCbRUBV4uTO72wgNpuA
        psT8SwfB6kUEDCS2nn/GBrKAWeA3s8S+w+2sIAlhgTiJjlUPmUBsfgFhiU93L4LFOYHi2zvW
        sUFc1McocW3SB2aIK1wkdr+dzAZxnYrEh98PgM7m4BAFsjfPVZrAKDgLya2zkNw6C8mtCxiZ
        VzEKJJYZ62UmF+ul5ReVZOilF21iBMcWo+8Oxtub3+odYmTiYDzEKMHBrCTCq1t8IkGINyWx
        siq1KD++qDQntfgQozQHi5I4L6/ehHghgfTEktTs1NSC1CKYLBMHp1QD086AWBaDEJ/KVTPZ
        3SdvcNj+bf0SWceVlxf+uM3H4VL0x8vutoGU/aZL71oLP1pOYRLUObf5v+GvPZFv21rXfUhs
        OD9Ta2VeVW9+SfEd/+e2nw4fztta82l6w76k2Qs0pSds+/tL59cEn/uVsoXX2n6nL5lnctz4
        Ktd75SdKteLbNqw5vUNUjk94/tLASSccPOb2y4XLqNfoZ9THvJ8s8ufnhXPvnls9bZpR5FK2
        PlpJe9MNY17Tw6uvb0lS67qm7PhLSeoii+v9hQFZ6i4Bp7wf5xt53eeV82PpbtU+19Wk97Oo
        ikUzKZ6hdane3T0yYYJ/EmsfSqc/euXoPpmNh7Mhedcym4/pSqXmpnO3KrEUZyQaajEXFScC
        AD8ZoywcAwAA
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Στις 2021-06-15 21:17, Geert Uytterhoeven έγραψε:
> 
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c

I believe drivers/of/kexec.c is better suited for this.
