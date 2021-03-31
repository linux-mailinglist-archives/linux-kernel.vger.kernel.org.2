Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8602A34FF8C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 13:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235303AbhCaLg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 07:36:28 -0400
Received: from mx1.tq-group.com ([93.104.207.81]:45674 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235325AbhCaLgM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 07:36:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1617190572; x=1648726572;
  h=from:to:cc:subject:date:message-id;
  bh=PduPPRM2NzqbWS0miuL9W7dSI7e2jWuOJrDqBANWxp0=;
  b=YpSzFzUvrDvAZnfLo1K7RWSUhtLuZjeXsehFLZn04wW3zn0NOUpJ9Suy
   2QjJMVJqAB9f8ft9DteBstXv8UULZBrwf6FbNlSd1udSMwljFTnhraQcF
   cM10Y4lGSti3cbbuBJ8mkeZkTAsYSCiEPfcZuj2MdBPJEQIta6PV1WtkT
   HRmFtPcKwND6vRux8hXeaLfEiGYMOm7O1+LLCfBomUQF25VvdKBNwZMEu
   mzix/N8ElvL+2ubhQANOfjFe7S9o9RTdg7o/Yx5c7smzDAcTfJ285xS1i
   2zxV2+sHAkz44GcxlYZg+DKVJYTmZuwOskM+F5cy8FMfdeSqcgFtk1u1Z
   g==;
IronPort-SDR: NMerk/w2FR/wZuA+hpH2m8wOa2iEJgKE51I8SCNLA8DzRvhCHDfzICg6HC5SaY2A+paESqJ2MJ
 oHwAeM2jrjeDQTzQAjs1TkjAqA9BrASQKgB5hWvkjeLb5dwo9Ozl9LX1jakbJHf7ScGG6XZCYD
 LZpg3xn64f9QiYb3tlxkMl368yb/QBFHPZi63awdNjEcjVfthuh1y/nERA/B16eZ8ZHaxcDwZn
 jjihyJECVgH4xtgvAhUUd+a6cTohEpGabGDQWVM+v42rMkS0wWh4t+NgA0IJy5U7q3pq7OFzu1
 5BQ=
X-IronPort-AV: E=Sophos;i="5.81,293,1610406000"; 
   d="scan'208";a="16742375"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 31 Mar 2021 13:36:10 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 31 Mar 2021 13:36:10 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 31 Mar 2021 13:36:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1617190570; x=1648726570;
  h=from:to:cc:subject:date:message-id;
  bh=PduPPRM2NzqbWS0miuL9W7dSI7e2jWuOJrDqBANWxp0=;
  b=FmojG0ilaDbk0qeByHlkt50tOiXSSrziN7gPzSDYU04L67XTKUJ3S6oo
   r1NxsCLaOU7ifs/JPiit6s4RLBQpJpvKKcjE1WzSZX9pCw+GF7zz7oeyk
   +UP/qaQXk9FP9Xe0v2rkhND4jrESjyad+apNtEM0lpde4q5iPa8fM+dOu
   HotQyHLy2PJvJMRbEDfP+dafhWWeSlWJQOhOtznfK4wUbExW5mlKC1MIg
   92PxZdAiB34/HK5IwafJacq0wc8+bF+sv3zdTtyYKVky5RTNbY+swWgtY
   EqGuPqVRhgU5GTDcO40TRqcH6fYNwGEomotOaLYx1PtvCXsV+DgRpl7jB
   w==;
IronPort-SDR: lSoEZDF/rnmI8sDFJbzN2P5HTbr2MGqeG8tNVxoVd3jgKmhQWUosRrnCjCG/l4V7lc0E3g2lNE
 8gZXcaUoPerwv4rKO7xvMFT879+OX5IV8W2RKYY6E/mIPQKe6Xdx1k0m5RRzpiFJyrLw4nvx4v
 fOxHdHXWWeeB1gWgtesIEPm8gM6TPoKyjxKqn1iI3SKjLmfQWEqn8X8RtfoOLEXb37CDXhCrsj
 zBTapWywROOJTbOkETSTxKHCTd/1++Xk7GTDjKCDQc5nj9cg6eQb7I7i64h+ba/l17JuAxF63a
 qsw=
X-IronPort-AV: E=Sophos;i="5.81,293,1610406000"; 
   d="scan'208";a="16742374"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 31 Mar 2021 13:36:10 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.121.48.12])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 1EAEE280070;
        Wed, 31 Mar 2021 13:36:10 +0200 (CEST)
X-CheckPoint: {60645E92-3-486672D-C0FA7804}
X-MAIL-CPID: E147051C322BD6D64161476F71C5EBFF_2
X-Control-Analysis: str=0001.0A782F29.60645EAA.0054,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH 0/3] tqmx86: TQMxE40M support
Date:   Wed, 31 Mar 2021 13:35:42 +0200
Message-Id: <cover.1617189926.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes a bug in the IRQ setup of the tqmx86 MFD / GPIO drivers and
adds support for our upcoming Elkhart Lake module TQMxE40M (as well as
future SoMs).

As patch 2 depends on patch 1, it would make sense to push the whole
series through the same tree.

Matthias Schiffer (3):
  gpio: tqmx86: really make IRQ optional
  mfd: tqmx86: clear GPIO IRQ resource when no IRQ is set
  mfd: tqmx86: add support for TQMxE40M

 drivers/gpio/gpio-tqmx86.c |  6 +++---
 drivers/mfd/tqmx86.c       | 13 ++++++-------
 2 files changed, 9 insertions(+), 10 deletions(-)

-- 
2.17.1

