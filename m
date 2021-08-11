Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF713E892A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 06:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233551AbhHKESL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 00:18:11 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:53185 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbhHKESI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 00:18:08 -0400
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id A0DA8806AC;
        Wed, 11 Aug 2021 16:17:42 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1628655462;
        bh=bFIwFgPZTWno3sKE4bEbi+ZnJW3J5TE+GC1coFxyLYI=;
        h=From:To:Cc:Subject:Date;
        b=roP1rB7uTaabgCkGNpNseCUAV+1oF02ShWYT+EJfD9h8CZ1E1ATgqCATn3I7GBTUM
         5rrT91W2KJeu5bL8Xj0+J5TRIgqvyJo/MYaOcJMmud2DL3T13vYPpQDagX8UqM8Dzp
         evC9iB9R/Y/a/iEp3oikdO9BDbKpn5rUt9qzvN48yd7pYJii/BSI5bglVwdTCazZKu
         WYcURZ7AlOOzCKHhMCKttQXY8GhCpe0Pk3gmpRNYsqPUo6G8YBVxGEAGUUGipwqdHa
         9WL92rm8TIZjaQso+LhC9r1xcrV6P0ninNk4dbsmDmd+zZlEb1u4KoO5A2HuoOEX8I
         r8MRPKZ9QAIzw==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B61134f660000>; Wed, 11 Aug 2021 16:17:42 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.20])
        by pat.atlnz.lc (Postfix) with ESMTP id 6332C13EEBA;
        Wed, 11 Aug 2021 16:17:42 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 5F6AD280E9D; Wed, 11 Aug 2021 16:17:42 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     linux@roeck-us.net, jdelvare@suse.com
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH 0/2] hwmon: (pmbus/bpa-rs600) cleanup and workaround
Date:   Wed, 11 Aug 2021 16:17:36 +1200
Message-Id: <20210811041738.15061-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=aqTM9hRV c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=MhDmnRu9jo8A:10 a=VwQbUJbxAAAA:8 a=rgRPi9HOQUPSZn2HmNcA:9 a=AjGcO6oz07-iQ99wixmX:22
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series builds on top of the BPD-RS600 support[1] which is in Guenter=
's
tree by hasn't made it to Linus' yet. They might actually cleanly apply w=
ithout
it since they touch different parts of the file.

[1] - https://lore.kernel.org/linux-hwmon/20210708220618.23576-1-chris.pa=
ckham@alliedtelesis.co.nz/

Chris Packham (2):
  hwmon: (pmbus/bpa-rs600) Remove duplicate defininitions
  hwmon: (pmbus/bpa-rs600) Add workaround for incorrect Pin max

 drivers/hwmon/pmbus/bpa-rs600.c | 44 ++++++++++++++++++++-------------
 1 file changed, 27 insertions(+), 17 deletions(-)

--=20
2.32.0

