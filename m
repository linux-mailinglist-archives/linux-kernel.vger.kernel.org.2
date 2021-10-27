Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4A043C699
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 11:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241240AbhJ0Jj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 05:39:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:42316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238831AbhJ0JjV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 05:39:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B11526103B;
        Wed, 27 Oct 2021 09:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635327416;
        bh=uv3Rw1jiqkkcMxomTAnpibpfpLO+bDpNzrdfhFp8TXY=;
        h=From:To:Cc:Subject:Date:From;
        b=tzx8sBbmvwFmuSb/ZCfpQupN7vSk1G0A1hRrBRdDrVZNwTNbKt5n+ByDrdPgW0qHo
         VEK+TUGrHxHj7l0CLLB0tyZUX466rP1dmr0Rpwokusp6w8y63kiYOU5U/+4SfSwYIB
         i44L0dOzJAHeu99b0PzRAOE+KMqD1FGos5UPo639gl9KjTiERGsfiy0yT26ZSR6D2a
         NIbOjDHQFkwToypZDgYFUeQj409TeLxCRFA1LA3XY+0B1rdu9rh7QUzjGXZXbNjcGN
         HW+RFo7YPuW/8X/d9eg6HCnm9nVz+x8qIRkrwhxfcnwgxUa6yF5CHDjxrDjTQcJL+w
         +HVn2h614JFlA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1mffMO-00083Y-AE; Wed, 27 Oct 2021 11:36:41 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH v2 0/2] comedi: misc fixes
Date:   Wed, 27 Oct 2021 11:35:27 +0200
Message-Id: <20211027093529.30896-1-johan@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes a number of issues in the comedi drivers that were
found through inspection.

Johan

Changes in v2:
 - drop the three patches already applied
 - move max-packet check after the ni_usb6501 endpoint lookup
 - use a single transfer buffer for both TX and RX in dt9812 (suggested
   by Ian Abbott)


Johan Hovold (2):
  comedi: ni_usb6501: fix NULL-deref in command paths
  comedi: dt9812: fix DMA buffers on stack

 drivers/comedi/drivers/dt9812.c     | 115 +++++++++++++++++++++-------
 drivers/comedi/drivers/ni_usb6501.c |  10 +++
 2 files changed, 96 insertions(+), 29 deletions(-)

-- 
2.32.0

