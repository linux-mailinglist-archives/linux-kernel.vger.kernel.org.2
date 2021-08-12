Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98FBC3E9BFB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 03:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233421AbhHLBk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 21:40:29 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:54311 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233364AbhHLBk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 21:40:28 -0400
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 09767806B6;
        Thu, 12 Aug 2021 13:40:02 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1628732402;
        bh=dftXrHA1Nb4OOp2kk3B2WS3OMgeEL0M1qiZccxQChds=;
        h=From:To:Cc:Subject:Date;
        b=yp5WTbSprPaV9uQiSdfgMjBEhc8Vt+Tr3TBrBwSsjS9ytipfr12iciedzGvMukr1N
         Dwt8s5Hc54YNAnN+gqoHj2rcSa7gQKIVc9yic/0/+iKPFkxpMg9IoYuusb4un8R2u8
         o2nCMDGeJdnj1EPsITWG5CxxTSXsbkwPDcg0lXrqrFJVspW7i7NfByiGmX//32Jnch
         JVpxb2wbcCru5/UoIVs+gngKcwOAiB3epqTEDs4SL+F+6owezHL7ghhzm6pukR6JWC
         TQ9nYIP4JGtM55jSIl44PIhVY42EvIw6vf/1cuycTr30VDh/63ldwSjeyukHp+Rlf4
         ngcJxrwgtmjzA==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B61147bf10000>; Thu, 12 Aug 2021 13:40:01 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.20])
        by pat.atlnz.lc (Postfix) with ESMTP id C535A13EE8E;
        Thu, 12 Aug 2021 13:40:01 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id C899B280E9D; Thu, 12 Aug 2021 13:40:01 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     linux@roeck-us.net, jdelvare@suse.com
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v2 0/2] hwmon: (pmbus/bpa-rs600) cleanup and workaround
Date:   Thu, 12 Aug 2021 13:39:58 +1200
Message-Id: <20210812014000.26293-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=aqTM9hRV c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=MhDmnRu9jo8A:10 a=VwQbUJbxAAAA:8 a=D5RLDSlNI1LxkMvazOUA:9 a=AjGcO6oz07-iQ99wixmX:22
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series should apply cleanly without the BPD-RS600 support[1] which i=
s in
Guenter's tree by hasn't made it to Linus' yet. Patch 2/2 technically fix=
es a
problem that is only present on the BPD-RS600. Patch 1/2 might need to he=
ad to
stable but it's probably not the end of the world if it doesn't.

[1] - https://lore.kernel.org/linux-hwmon/20210708220618.23576-1-chris.pa=
ckham@alliedtelesis.co.nz/

Chris Packham (2):
  hwmon: (pmbus/bpa-rs600) Don't use rated limits as warn limits
  hwmon: (pmbus/bpa-rs600) Add workaround for incorrect Pin max

 drivers/hwmon/pmbus/bpa-rs600.c | 48 ++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 25 deletions(-)

--=20
2.32.0

