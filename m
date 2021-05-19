Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99C9F388AB6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 11:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345626AbhESJen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 05:34:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:51596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345515AbhESJek (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 05:34:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8A643613AF;
        Wed, 19 May 2021 09:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621416801;
        bh=e0oxAEFqluwWuK9Dt5UM57AUgJda98ZQIvNzXAIM8Bg=;
        h=From:To:Cc:Subject:Date:From;
        b=N1i5tPDxOfHF03zsx++S59ngkhAMiNeKbOEPh0aL4BUj6RKdXbOaAPI/y2+0ZLQYd
         v+wFHi3b8KgbjzSsRvPx4pG5gq2i892eSc5UH3IWKhJYi0VlGmANRQsvVe1oWLZyZN
         f8rjcH4mAqfsmNf7BtoyoPtIuoO/UPz491N1S3Lzd5a4vQz9pG10+lx4LaBUtoS74I
         nbIxrUbSsIDNVd9yZZ5tW4pXLnaNbERmHsyBBzUPZFHqMVnaTh6IVbQTPOONA9cO9C
         twJdngvs8S81qa5fb97K/nGjCkZmFroVhI+v8O8+CfSpHdGAqQRuEQM0TSXJpmx9DF
         pl7hj+P+8q57Q==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ljIZs-0002pQ-4d; Wed, 19 May 2021 11:33:20 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 0/3] USB: drop irq-flags initialisations
Date:   Wed, 19 May 2021 11:33:00 +0200
Message-Id: <20210519093303.10789-1-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series drops the remaining redundant irq-flags initialisations from
the USB subsystem, which all happened to be in gadget-related code.

Johan


Johan Hovold (3):
  USB: cdnsp: drop irq-flags initialisations
  USB: dwc2: drop irq-flags initialisations
  USB: gadget: drop irq-flags initialisations

 drivers/usb/cdns3/cdnsp-gadget.c      |  4 ++--
 drivers/usb/dwc2/gadget.c             | 12 ++++++------
 drivers/usb/gadget/udc/fsl_udc_core.c |  8 ++++----
 drivers/usb/gadget/udc/mv_u3d_core.c  |  2 +-
 drivers/usb/gadget/udc/mv_udc_core.c  |  2 +-
 5 files changed, 14 insertions(+), 14 deletions(-)

-- 
2.26.3

