Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A498334093D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 16:52:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbhCRPwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 11:52:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:54660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231245AbhCRPwA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 11:52:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2D48264F30;
        Thu, 18 Mar 2021 15:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616082720;
        bh=76/koNfEwuDQOP5Aa62tcz9o3VOiUvAeCO3j2tg7o2c=;
        h=From:To:Cc:Subject:Date:From;
        b=W1uPGaPB4Ty/24a2fNQ+hXKidNuD9NsLncu33KnO+vPgE2Jsv0/CyE2vdQloDloIL
         mSD6m0xyVG2dC7Zc0Fk44rOXJ+xX0aPJJP9QXQ130HH8IzStr4iLjHDJ321k8Geai/
         q9NX1ZzjqwDmG2hGkuaCLbXeYoR2OZnEJeusSSgKvuCdhKPdhbUMT9ta1cqC5u2eQF
         PKiuM3ZJdTANUXDk+Z5XYCBWoPFfyv7KwGaRL5g6a4/xjv49pS6qNA//4/viADcKX/
         Eq5JUdrAx4kzlCywINN+h/t2GnxxuJXJM6b2EIamm1YikgC6zsvis8F9PgLljIMBkn
         UVtWAOMnhdwOg==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lMuwb-0005nO-RW; Thu, 18 Mar 2021 16:52:17 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Oliver Neukum <oneukum@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 0/7] USB: cdc-acm: probe fixes
Date:   Thu, 18 Mar 2021 16:51:55 +0100
Message-Id: <20210318155202.22230-1-johan@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes a couple of bugs in the probe errors paths and does
some clean up in preparation for adding the missing error handling when
claiming the data interface.

The first two should probably go into 5.12-rc, while the rest could be
held off for 5.13 if preferred.

Johan


Johan Hovold (7):
  USB: cdc-acm: fix double free on probe failure
  USB: cdc-acm: fix use-after-free after probe failure
  USB: cdc-acm: drop redundant driver-data assignment
  USB: cdc-acm: drop redundant driver-data reset
  USB: cdc-acm: clean up probe error labels
  USB: cdc-acm: use negation for NULL checks
  USB: cdc-acm: always claim data interface

 drivers/usb/class/cdc-acm.c | 54 +++++++++++++++++++++----------------
 1 file changed, 31 insertions(+), 23 deletions(-)

-- 
2.26.2

