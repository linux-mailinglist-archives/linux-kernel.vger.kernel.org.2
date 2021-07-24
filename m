Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 533E33D4714
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 12:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235217AbhGXJoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jul 2021 05:44:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:40256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235157AbhGXJmS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jul 2021 05:42:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5A77F60E76;
        Sat, 24 Jul 2021 10:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627122165;
        bh=yRMjGPbNC8pj/QkOrpz8KPfNLpiv6H4CXvigKhPY2+I=;
        h=From:To:Cc:Subject:Date:From;
        b=IwFgly4obSEVgIuexGRER2QbNz1gPqjf1L966Br6vjp4JLDoRjgtgIa90+DVjCa/r
         sFlkkj8BRr5LuOBvCMANQuwBlZG5xZVBIbPUj8x+RVSPQd9047lB4zZVa+gZC7qdwX
         wi/qb/nb67WkjlZXQbLtOcuDnXZHbG9eW7rqJ39v/6RnocBEMi+RpwsOfJ7qr6TmU7
         KsOiuELMlGPishTerPDibnyGzHFDJZowoZ7/u4ISnaLtjzOSg/gWuiiIEMs4Dft2Sj
         w7Lko+M5Tx+2700YaqL5yY1c+/40Cjs2tDJQo10y0aaXZZJKEPu6w3ufQFLAWWoVX5
         Gzkh4n2JcZcRQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1m7Enr-00BJmt-0x; Sat, 24 Jul 2021 12:22:43 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Address some issues at hi6421v600 regulator driver
Date:   Sat, 24 Jul 2021 12:22:40 +0200
Message-Id: <cover.1627121912.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

Patch 1 on this series address a review made by Rob Herring for the dt-bindings.
It basically use "ldo" instead of "LDO", in order to match the patch I wrote to
dt-bindings:
	https://lore.kernel.org/lkml/b7a775808d9c3a87fbe1c5a6dd71f8f18be7e649.1627116034.git.mchehab+huawei@kernel.org/T/#u

Patch 2 is just a cleanup patch, changing the namespace for the voltage
range arrays. IMO, the new names fit better than the previous ones.

Mauro Carvalho Chehab (2):
  regulator: hi6421v600: use lowercase for ldo
  regulator: hi6421v600: rename voltage range arrays

 drivers/regulator/hi6421v600-regulator.c | 48 ++++++++++++------------
 1 file changed, 24 insertions(+), 24 deletions(-)

-- 
2.31.1


