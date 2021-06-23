Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D09023B1104
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 02:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbhFWAXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 20:23:20 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:43650 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbhFWAXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 20:23:19 -0400
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 4DE13891B0;
        Wed, 23 Jun 2021 12:21:01 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1624407661;
        bh=FtxX17e9/52rfQNOmEuTSm7vQJjFtGwG5oLmILrvfWw=;
        h=From:To:Cc:Subject:Date;
        b=iO6Ux74zv5dT3YRhDeWDDBcyh98lILw87kxLedmSnY+3Yjb0whJ3/l1q1UR+n2fe+
         QfUwyu3UhcDZqlwzyP7gESGNPu9YyypkWtHINvFX8wY/DmTeAPCr2ZmVSnpgSejQQs
         Fjy06S9uGyc2yb20SDPpL5/RLtY/sA/dqi6IlPB1D5B525+ZJC6W7E8l3M/pi4E7Xn
         tHx+gJr7sJiuBAf4+tgUfb4yYsvWtqO3QpvMTznR0ieENJdmXn8KhXmt/LCeUFoLfJ
         fO072D8cKVmfGVEyrhNNYULxsIZHTPamGqzJI9BxLkiHFoi4xOpGgiqbvpvGFFjVdt
         9TPvzqBjeROkg==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B60d27e6d0000>; Wed, 23 Jun 2021 12:21:01 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.20])
        by pat.atlnz.lc (Postfix) with ESMTP id 2F79F13EE59;
        Wed, 23 Jun 2021 12:21:01 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 2B5CC28397C; Wed, 23 Jun 2021 12:21:01 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH 0/2] hwmon: (adt7470) Clean up
Date:   Wed, 23 Jun 2021 12:20:56 +1200
Message-Id: <20210623002058.3133-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=IOh89TnG c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=r6YtysWOX24A:10 a=eydtoQEJPQk_bK1cFrsA:9
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This does some cleanup of the adt7470. The major benefit is the added err=
or
handling. The volume of code decreases a little but it's kind of a wash b=
etween
the removal of attribute handling code vs the addition of code to drive t=
he
hwmon core.

Chris Packham (2):
  hwmon: (adt7470) Convert to devm_hwmon_device_register_with_info API
  hwmon: (adt7470) Use standard update_interval property

 drivers/hwmon/adt7470.c | 1146 +++++++++++++++++++--------------------
 1 file changed, 550 insertions(+), 596 deletions(-)

--=20
2.32.0

