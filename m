Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 457EE369169
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 13:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242413AbhDWLnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 07:43:11 -0400
Received: from mx01-muc.bfs.de ([193.174.230.67]:45342 "EHLO mx01-muc.bfs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236815AbhDWLnK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 07:43:10 -0400
Received: from SRVEX01-SZ.bfs.intern (exchange-sz.bfs.de [10.129.90.31])
        by mx01-muc.bfs.de (Postfix) with ESMTPS id F0FD820389;
        Fri, 23 Apr 2021 13:42:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bfs.de; s=dkim201901;
        t=1619178152;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dQDZaEXB4OrIze3umzwdepSHeanpp8Bw7/iC8vF911c=;
        b=BYo0BU9gHsBa1L+z/XrlTrnUm40R1SANUPOKkCzrFSb+pnvNmRh/w5ApRsFJ+Gp27jlzL/
        y/Kv0O1gPbRPodBrPUW3cWrnHnyPFN0cmXIAsPlNUWKeXbRSfzqDSIfhIdYbqDnYBn+nYk
        sd8YbKttk5Am7YjQEaUYUrfr0fch+/nNWEtw5MhHqPbAzZre61qau9oeg7tAxrcc7o3ICP
        n6VM6VOpY2Ko51si/YNRDoda/uUEOFRZe9vcybcfwLBEKEZ4icgMnGY/OdVGuol8mpQaKE
        7eAxfQ7diKZjMD/QwDyx4ySvBPESA/pHXihqCnLtfEVEXLLsXnSe2NXCQ273Hg==
Received: from SRVEX01-SZ.bfs.intern (10.129.90.31) by SRVEX01-SZ.bfs.intern
 (10.129.90.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2242.4; Fri, 23 Apr
 2021 13:42:31 +0200
Received: from SRVEX01-SZ.bfs.intern ([fe80::7d2d:f9cb:2761:d24a]) by
 SRVEX01-SZ.bfs.intern ([fe80::7d2d:f9cb:2761:d24a%13]) with mapi id
 15.01.2242.008; Fri, 23 Apr 2021 13:42:31 +0200
From:   Walter Harms <wharms@bfs.de>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "thomas.petazzoni@free-electrons.com" 
        <thomas.petazzoni@free-electrons.com>
CC:     "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: AW: [PATCH 1/4] clk: mvebu: Fix a memory leak in an error handling
 path
Thread-Topic: [PATCH 1/4] clk: mvebu: Fix a memory leak in an error handling
 path
Thread-Index: AQHXOAlra2sQAacEjUWcDYHHPtnRKKrB+sUc
Date:   Fri, 23 Apr 2021 11:42:30 +0000
Message-ID: <3e38da0e86c045d3aefd46f375e8b48e@bfs.de>
References: <cover.1619157996.git.christophe.jaillet@wanadoo.fr>,<27db232fdd14e14d493f29a5404d9e643f09cc96.1619157996.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <27db232fdd14e14d493f29a5404d9e643f09cc96.1619157996.git.christophe.jaillet@wanadoo.fr>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.137.16.39]
x-tm-as-product-ver: SMEX-14.0.0.3080-8.6.1012-26108.007
x-tm-as-result: No-10-1.572100-5.000000
x-tmase-matchedrid: q51PvYY4nNTRubRCcrbc5grcxrzwsv5u3dCmvEa6IiGoLZarzrrPmcEr
        mnVGYuv6U6QXwKi+8hAd28n/9SVHwfs9SDPkW26p9u1rQ4BgXPKxT02+VRUpqcz/SxKo9mJ4Vlm
        LeeCmr+Qwg90qZP2xjEE5MsiOdQppIbz6NfTUBu6EeJva4+0wXZHVxrCMbhjZ8voDjR2X7lwVWL
        q9OD+dxP4CUcmo4PggvBnXDRQDOdPINUBYpHy9LRouoVvF2i0ZF4r8H5YrEqxjLp8Cm8vwF0Ac6
        DyoS2rIj6kCfX0Edc48czWEGg4ankElpwBtHoIxkIA1wW1nvBPrixWWWJYrH79ZdlL8eonaC24o
        EZ6SpSk6XEE7Yhw4FlreFBI5y8oAjFCXwwTXuHzp+utPzpWkMirkU1Y1dRQr9801gjeZKajkPpd
        Jh5DqM6tiiq3HBpTM3SC0Pa604d54wdSwiqr5giis9jscQpKczRtC/fI/GzL62iqv7ym1n2PqXS
        KGf39Kj0FRshmKgblnIxZyJs78kg==
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10-1.572100-5.000000
x-tmase-version: SMEX-14.0.0.3080-8.6.1012-26108.007
x-tm-snts-smtp: 887BBBFA70AA266C9F2956588BCB59E064FB8E878BF7F67343E1EED0825C71E22000:9
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Spamd-Result: default: False [-18.00 / 7.00];
         ARC_NA(0.00)[];
         TO_DN_EQ_ADDR_SOME(0.00)[];
         HAS_XOIP(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[wanadoo.fr];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[bfs.de:s=dkim201901];
         WHITELIST_LOCAL_IP(-15.00)[10.129.90.31];
         RCPT_COUNT_SEVEN(0.00)[8];
         FREEMAIL_TO(0.00)[wanadoo.fr,baylibre.com,kernel.org,bootlin.com,free-electrons.com];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         MID_RHS_MATCH_FROM(0.00)[];
         BAYES_HAM(-3.00)[99.99%]
Authentication-Results: mx01-muc.bfs.de;
        none
X-Spam-Status: No, score=-18.00
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nitpicking:
 clk_name could be replaced with cpuclk[cpu].clk_name

and the commit msg is from the other patch (free  cpuclk[cpu].clk_name)

jm2c,

re,
 wh
________________________________________
Von: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Gesendet: Freitag, 23. April 2021 08:25:01
An: mturquette@baylibre.com; sboyd@kernel.org; gregory.clement@bootlin.com;=
 thomas.petazzoni@free-electrons.com
Cc: linux-clk@vger.kernel.org; linux-kernel@vger.kernel.org; kernel-janitor=
s@vger.kernel.org; Christophe JAILLET
Betreff: [PATCH 1/4] clk: mvebu: Fix a memory leak in an error handling pat=
h

WARNUNG: Diese E-Mail kam von au=DFerhalb der Organisation. Klicken Sie nic=
ht auf Links oder =F6ffnen Sie keine Anh=E4nge, es sei denn, Sie kennen den=
/die Absender*in und wissen, dass der Inhalt sicher ist.


If an error occurs in the for_each loop, clk_name must be freed.

In order to do so, sightly rearrange the code:
   - move the allocation to simplify error handling
   - use kasprintf instead of kzalloc/sprintf to simplify code and avoid a
     magic number

Fixes: ab8ba01b3fe5 ("clk: mvebu: add armada-370-xp CPU specific clocks")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
The { } around the 1 line block after kasprintf is intentional and makes
sense with 2/2
---
 drivers/clk/mvebu/clk-cpu.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/mvebu/clk-cpu.c b/drivers/clk/mvebu/clk-cpu.c
index c2af3395cf13..a11d7273fcc7 100644
--- a/drivers/clk/mvebu/clk-cpu.c
+++ b/drivers/clk/mvebu/clk-cpu.c
@@ -195,17 +195,17 @@ static void __init of_cpu_clk_setup(struct device_nod=
e *node)
        for_each_of_cpu_node(dn) {
                struct clk_init_data init;
                struct clk *clk;
-               char *clk_name =3D kzalloc(5, GFP_KERNEL);
+               char *clk_name;
                int cpu, err;

-               if (WARN_ON(!clk_name))
-                       goto bail_out;
-
                err =3D of_property_read_u32(dn, "reg", &cpu);
                if (WARN_ON(err))
                        goto bail_out;

-               sprintf(clk_name, "cpu%d", cpu);
+               clk_name =3D kasprintf(GFP_KERNEL, "cpu%d", cpu);
+               if (WARN_ON(!clk_name)) {
+                       goto bail_out;
+               }

                cpuclk[cpu].parent_name =3D of_clk_get_parent_name(node, 0)=
;
                cpuclk[cpu].clk_name =3D clk_name;
--
2.27.0

