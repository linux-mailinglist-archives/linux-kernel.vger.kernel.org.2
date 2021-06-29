Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01BCA3B751E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 17:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234705AbhF2P1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 11:27:38 -0400
Received: from atlmailgw2.ami.com ([63.147.10.42]:49814 "EHLO
        atlmailgw2.ami.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234549AbhF2P1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 11:27:34 -0400
X-Greylist: delayed 901 seconds by postgrey-1.27 at vger.kernel.org; Tue, 29 Jun 2021 11:27:34 EDT
X-AuditID: ac10606f-903ff70000006d35-7a-60db37ccab66
Received: from atlms1.us.megatrends.com (atlms1.us.megatrends.com [172.16.96.144])
        (using TLS with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by atlmailgw2.ami.com (Symantec Messaging Gateway) with SMTP id D2.DB.27957.DC73BD06; Tue, 29 Jun 2021 11:10:05 -0400 (EDT)
Received: from ami-us-wk.us.megatrends.com (172.16.98.207) by
 atlms1.us.megatrends.com (172.16.96.144) with Microsoft SMTP Server (TLS) id
 14.3.498.0; Tue, 29 Jun 2021 11:10:04 -0400
From:   Hongwei Zhang <hongweiz@ami.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Michael Walle <michael@walle.cc>,
        Pratyush Yadav <p.yadav@ti.com>
CC:     Hongwei Zhang <hongweiz@ami.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 0/1] mtd: spi-nor: Add some M45PEx ids
Date:   Tue, 29 Jun 2021 11:08:45 -0400
Message-ID: <20210629150846.21547-1-hongweiz@ami.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.98.207]
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNLMWRmVeSWpSXmKPExsWyRiBhgu5Z89sJBt8nS1lc3jWHzWJ30zJ2
        i7enN7Bb3H3+g93i4xIHB1aPzUvqPe78WMrocfzGdiaPz5vkPA7sbWELYI3isklJzcksSy3S
        t0vgyph4bwVbwUvGildv97A1MG5i7GLk5JAQMJH4MPUYkM3FISSwi0mibV8vG5TDKLFy3wuw
        KjYBNYm9m+cwgdgiAiUSa9q/gNnMAukSr76eZwaxhQUsJaZdbmcBsVkEVCWWz/jOBmLzCphK
        bJn8lwVim7zE6g0HmCHighInZz5hgZgjIXHwxQuwuJCArMStQ4+ZIOoVJR78+s46gZFvFpKW
        WUhaFjAyrWIUSizJyU3MzEkvN9JLzM3US87P3cQICcD8HYwfP5ofYmTiYDzEKMHBrCTC+zbv
        VoIQb0piZVVqUX58UWlOavEhRmkOFiVx3lXuR+OFBNITS1KzU1MLUotgskwcnFINjOcmnxJb
        WnDu0YJtrlGdcz5F7tvgsn+jd0DHHrazwokP8903nt5f3un3Ityw8MiLe/t3ijH+Xa1dtc7c
        iOEUm9267VUdbe7f7XdPtDE4+vx/Iv9qpVsfczZHK923enb3YrFZdIlNm/v7v5V/s788Sle6
        fnT7+hzbhRseXbReL9V2snzFk0C/ldpKLMUZiYZazEXFiQAhBnBLLgIAAA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Reviewer,

Add some Micron M45PEx flash memeories into the IDs table.

Hongwei Zhang (1):
  mtd: spi-nor: Add some M45PEx ids

 drivers/mtd/spi-nor/micron-st.c | 4 ++++
 1 file changed, 4 insertions(+)

-- 
2.17.1

