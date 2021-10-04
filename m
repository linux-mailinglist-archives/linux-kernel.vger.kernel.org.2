Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24FEB420AAC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 14:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233167AbhJDMMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 08:12:44 -0400
Received: from mx1.tq-group.com ([93.104.207.81]:63046 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233109AbhJDMMn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 08:12:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1633349454; x=1664885454;
  h=subject:from:to:cc:date:mime-version:
   content-transfer-encoding:message-id;
  bh=b/VbAVXf8V1rUtjjhY58TDRgAT82p9nbfmXylEq2ISQ=;
  b=UPzGUrMd1M1DIA1sL98TWyyEIKlxzjTXUVtpUEERAT5UF6dRlZ38rCfN
   frUDkY5le8LwnhGG6kLhopDZ9zwPIFNNiEfomZbrOZ0p0WjS1BEgYwDTa
   yuQDlks5TxIoUsl5T8AG0ljJDIB8AkLB3XMnnK5KgDSjY0pYR0Ltc0JVX
   ipSicv2FOLAFPEEec1wCFtz3sTZhAh8OABGasKvLSk/I9IsEX3A5jgpp5
   twbbhc8OzjrqgGwrxgpX9m8qRqTr8ssntB88oDqE5NvFFAWUaZDk0XW9s
   M+OkZ04k5vD9wg0+1f41Q5uzFdWjDoUQ43zTQKSePqPde5dbb1KfSyK8r
   w==;
X-IronPort-AV: E=Sophos;i="5.85,345,1624312800"; 
   d="scan'208";a="19848754"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 04 Oct 2021 14:10:53 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Mon, 04 Oct 2021 14:10:53 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Mon, 04 Oct 2021 14:10:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1633349453; x=1664885453;
  h=subject:from:to:cc:date:mime-version:
   content-transfer-encoding:message-id;
  bh=b/VbAVXf8V1rUtjjhY58TDRgAT82p9nbfmXylEq2ISQ=;
  b=g1t2Pyc0oLZTY1MwNYw53DQSbKRCv9pKnrQ6VzbING+jEmGnn0ytL16A
   EwOuOFbl5c6CAb1ZRG01W7dpghAoZ27ksRiwyY9WrPWQZNXGIldrnH1l7
   x3PNcGY8fNfX/9CcQbdMwrRSTq0sddMUaxgd8fJ/3OgvQsv+8udG02LDl
   IrbhYpLYoCUNlw7DYoTt2qCd+aMNXQZArBA7gAyI9DhZ9VHleiCkJvHsh
   XSpQUBsHcgzlT4yT9IuMFgJTBoTfUnG0LRVFdHC/LUthtAiuOj8iKzsHd
   kLhuyLms9jsIuNFpi6oMvdXmJUdBGi4zMrbAhmz77N6njiIfl1Weqeaq1
   g==;
X-IronPort-AV: E=Sophos;i="5.85,345,1624312800"; 
   d="scan'208";a="19848753"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 04 Oct 2021 14:10:53 +0200
Received: from vtuxmail01.tq-net.de (localhost [127.0.0.1])
        by vtuxmail01.tq-net.de (Postfix) with ESMTP id 6058F280065;
        Mon,  4 Oct 2021 14:10:53 +0200 (CEST)
Received: by vtuxmail01 (kopano-spooler) with MAPI; Mon, 4 Oct 2021 14:10:53
 +0200
Subject: AW: (EXT) Re: [PATCH 2/2] mtd: spi-nor: micron-st: Add support for
 output-driver-strength
From:   "Alexander Stein" <Alexander.Stein@ew.tq-group.com>
To:     =?us-ascii?Q?Tudor=2EAmbarus=40microchip=2Ecom?= 
        <Tudor.Ambarus@microchip.com>,
        =?us-ascii?Q?Alexander=2EStein=40tq-sys?=
         =?us-ascii?Q?tems=2Ecom?= <Alexander.Stein@tq-systems.com>,
        =?us-ascii?Q?miquel=2Eraynal=40bootlin=2Ecom?= 
        <miquel.raynal@bootlin.com>,
        =?us-ascii?Q?richard=40nod=2Eat?= <richard@nod.at>,
        =?us-ascii?Q?vigneshr=40ti=2Ecom?= <vigneshr@ti.com>,
        =?us-ascii?Q?robh+dt=40kernel=2Eorg?= <robh@kernel.org>,
        =?us-ascii?Q?p=2Eyadav=40ti=2Ecom?= <p.yadav@ti.com>,
        =?us-ascii?Q?michael=40walle=2Ecc?= <michael@walle.cc>
Cc:     =?us-ascii?Q?linux-mtd=40lists=2Einfradead=2Eorg?= 
        <linux-mtd@lists.infradead.org>,
        =?us-ascii?Q?devicetree=40vger=2Ekern?= =?us-ascii?Q?el=2Eorg?= 
        <devicetree@vger.kernel.org>,
        =?us-ascii?Q?linux-kernel=40vger=2Ekernel=2Eorg?= 
        <linux-kernel@vger.kernel.org>
Date:   Mon, 4 Oct 2021 12:10:53 +0000
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Priority: 3 (Normal)
X-Mailer: Kopano 8.7.82
Message-Id: <kcEE.Dc11rDoPQ8iRcxif5TBAOA.gESl4Bi51wE@vtuxmail01.tq-net.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> Does the micron flash define the SCCR SFDP map=3F

As far as I can tell, it only defines the Basis SPI protocol and the 4-byte Adress Instruction Table.
Dunno when the SCCR SFDP map was added, but this flash only announces JESD216B (SFDP 1.6)

Is there some tool for dumping/decoding the SFDP available=3F

Best regards,
Alexander

