Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D45331C6C5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 08:27:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbhBPHYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 02:24:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbhBPHYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 02:24:42 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656F6C061756
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 23:24:02 -0800 (PST)
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <jbe@pengutronix.de>)
        id 1lBuiG-0003lE-59; Tue, 16 Feb 2021 08:24:00 +0100
Received: from jbe by dude02.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <jbe@pengutronix.de>)
        id 1lBuiF-0002Mc-5N; Tue, 16 Feb 2021 08:23:59 +0100
From:   Juergen Borleis <jbe@pengutronix.de>
To:     Richard Weinberger <richard@nod.at>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        kernel@pengutronix.de
Subject: fs: ubifs: set s_uuid in super block to support ima/evm uuid options
Date:   Tue, 16 Feb 2021 08:23:33 +0100
Message-Id: <20210216072334.7575-1-jbe@pengutronix.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::28
X-SA-Exim-Mail-From: jbe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is V2 to support ima/evm uuid in ubifs.

- the previously used memcopy is now replaced by a helper function as suggested
  by Andy

jb


