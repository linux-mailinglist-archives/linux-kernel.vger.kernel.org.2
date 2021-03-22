Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78FF63449DC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 16:53:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbhCVPxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 11:53:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:49018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230353AbhCVPxP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 11:53:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B0FE0619A4;
        Mon, 22 Mar 2021 15:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616428394;
        bh=OrZ34x4VzWgzB6mFcm36gexXK3VuPXtVUhy3Q4haMT8=;
        h=From:To:Cc:Subject:Date:From;
        b=Wl13jYQ2Jka88RvyNqGRf4mNvnWa8h/lGw6j17jeS7KnMDq0h4J5CrJe++Y1Gcuyf
         8TnH9vOvNyQqt64DB71NaKjb83x2VbGpEMXDTril4ofi5K4VL6iRVvjjhdRO7Xlq6O
         FoUYKhSceikhAi3Av4w28o7vwTm5gs3y9Ti07TvKr9k6TrpalXHd/K+x+JizTxV3X5
         YZoPe3pdDrIlKgjX+EQt4+idvKZw2vb734hY1K43AYoyLgq/2sUBGHqvsiUTj6YGh+
         Ua6elAaKsLZeM1JNqmmWSHcG9iqybnQX1fZa03l3InWOm93l+S5aIRJ9KMOEyPUirT
         C9X9Qh3bVorXw==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lOMrz-0002ZW-Ou; Mon, 22 Mar 2021 16:53:32 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Oliver Neukum <oneukum@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH v2 0/8] USB: cdc-acm: probe fixes
Date:   Mon, 22 Mar 2021 16:53:10 +0100
Message-Id: <20210322155318.9837-1-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
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


Changes in v2
 - clarify that the driver already had a check for a bound data
   interface and remove the now redundant check (Oliver) (7/8)
 - add Oliver's ack to patches 1 through 6
 - add new to avoid logging a successful probe message on late errors
   (8/8)

Johan Hovold (8):
  USB: cdc-acm: fix double free on probe failure
  USB: cdc-acm: fix use-after-free after probe failure
  USB: cdc-acm: drop redundant driver-data assignment
  USB: cdc-acm: drop redundant driver-data reset
  USB: cdc-acm: clean up probe error labels
  USB: cdc-acm: use negation for NULL checks
  USB: cdc-acm: always claim data interface
  USB: cdc-acm: do not log successful probe on later errors

 drivers/usb/class/cdc-acm.c | 65 +++++++++++++++++++------------------
 1 file changed, 33 insertions(+), 32 deletions(-)

-- 
2.26.3

