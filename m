Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F011D388A80
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 11:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343495AbhESJWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 05:22:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:44188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344960AbhESJVt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 05:21:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3A4706139A;
        Wed, 19 May 2021 09:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621416029;
        bh=Ibw/zQM+d/sALTpQspjHYltUcbAA2yu1YtiHvBMW5jQ=;
        h=From:To:Cc:Subject:Date:From;
        b=XN34e3ia7ztY1n3NbNFSCDQjQTMGcp5S+hrRxqJI/dpe2OSHfIUMd7OZqnDfSv4a7
         UFjpH8dcjL5KGnzNh5FDljLAOkQ8YQy2tuSSqMwQv0nuBPSdXKtzN/3faRlcXRcXvu
         WesO8qDWliM57EYqiPNb50KJBZK14FwhzwjNYo2opgZC9UdfZEVBhTjUb2R3Nt+hVa
         RK25/t2yL2hhJPvFTth+QqS8/7a+kngcNouMo8w3ZYHf7JC3ZM4l4U3qvOpYddFvA9
         VmryhTqAJr76dvLzEtE+MQ0yju0pWHiXLoTi61rmNrr/s+6O91mcXt+JbJUt/T4GMS
         bDK2bXIpQ5Zpw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ljINQ-0002YW-EP; Wed, 19 May 2021 11:20:28 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] USB: serial: buffer-callback clean ups
Date:   Wed, 19 May 2021 11:20:00 +0200
Message-Id: <20210519092006.9775-1-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series clean up a few things related to the chars_in_buffer and
write_room callbacks that were found during review of the recent
conversion to have these callbacks return an unsigned int.

Johan


Johan Hovold (6):
  USB: serial: digi_acceleport: reduce chars_in_buffer over-reporting
  USB: serial: digi_acceleport: add chars_in_buffer locking
  USB: serial: io_edgeport: drop buffer-callback sanity checks
  USB: serial: mos7720: drop buffer-callback sanity checks
  USB: serial: mos7840: drop buffer-callback return-value comments
  USB: serial: drop irq-flags initialisations

 drivers/usb/serial/digi_acceleport.c | 34 ++++++++++++++--------------
 drivers/usb/serial/io_edgeport.c     | 27 +---------------------
 drivers/usb/serial/metro-usb.c       | 12 +++++-----
 drivers/usb/serial/mos7720.c         | 17 ++------------
 drivers/usb/serial/mos7840.c         |  5 ----
 drivers/usb/serial/quatech2.c        |  2 +-
 6 files changed, 27 insertions(+), 70 deletions(-)

-- 
2.26.3

