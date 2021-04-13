Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ECDC35E3D0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 18:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244394AbhDMQZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 12:25:23 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:36996 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbhDMQZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 12:25:21 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 13DGOhCI050696;
        Tue, 13 Apr 2021 11:24:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1618331083;
        bh=gwnQlLFfjOtnC10hC+oYQoIcfSUphk969fe6ZO6bWqc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=RaGhtZJ3Nohy04axDv3bFqW6sXEhS6bgpX+BZg8vKdH+OGzsB4DrD1KBWurl89TO7
         S/2kq1ZxTIWZtpOsOKONAxbLnb2BLQ52an0RISAikDq25MTy3VyFQw4N+gza+WY54P
         Fd2Cr7OdE8ij1J0/Ke4arUUZn6l8amxNUUpIyl98=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 13DGOh8S038952
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 13 Apr 2021 11:24:43 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 13
 Apr 2021 11:24:43 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 13 Apr 2021 11:24:42 -0500
Received: from ula0132425.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 13DGOdDN098425;
        Tue, 13 Apr 2021 11:24:40 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     <linux-mtd@lists.infradead.org>,
        Colin King <colin.king@canonical.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] mtd: cfi: remove redundant assignment to variable timeo
Date:   Tue, 13 Apr 2021 21:53:26 +0530
Message-ID: <161833061201.9818.9751246290513017958.b4-ty@ti.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210325174514.486272-1-colin.king@canonical.com>
References: <20210325174514.486272-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Colin King,

On Thu, 25 Mar 2021 17:45:14 +0000, Colin King wrote:
> The variable timeo is being initialized with a value that is never read
> and it is being updated later with a new value.  The initialization is
> redundant and can be removed.

Fixed up $subject prefix to match existing convention for the file.

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git cfi/next, thanks!
[1/1] mtd: cfi: remove redundant assignment to variable timeo
      https://git.kernel.org/mtd/c/f3907773d6

--
Regards
Vignesh

