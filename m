Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27496439539
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 13:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232834AbhJYLtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 07:49:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:39234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233253AbhJYLso (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 07:48:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 843506108D;
        Mon, 25 Oct 2021 11:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635162381;
        bh=frbBx4Cvan4bEpszMIiMs7IANL/KFIL4Nu3BnoOMJ5g=;
        h=From:To:Cc:Subject:Date:From;
        b=nXz6jfn70XAQMAZnTfvabq599IUwam8RCAUtkNJRBk/+u6440XB8hs2NhLxLOqDHn
         zfer4Bpx/M4FbiPzatDFoRrYJVl7YaGSfGOHp9bF2gU+fYXaStiCoM5kcveT1Tg5sa
         Vu5RMnHA+pw7tmwVAvp76c+yyprbwgf1SR33KuEeGclfYR+fGkL5WNu1bDlHMtI893
         iiQhO8vHBMFO+hvp3GCzK7lmR7/z8wUTTN3s/XaOifWsHGI4PyedA7WJ0L4OYs5CzR
         4vIPirQotiUT7p+PoDZmrvr4ORTgt/pOXrlSc7Dmbx7+xCUAON/+G5NiLKNAPonh2S
         ZkdtQ0FJAKpsQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1meyQV-0001DB-CB; Mon, 25 Oct 2021 13:46:04 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 0/5] comedi: misc fixes
Date:   Mon, 25 Oct 2021 13:45:27 +0200
Message-Id: <20211025114532.4599-1-johan@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes a number of issues in the comedi drivers that were
found through inspection.

Johan


Johan Hovold (5):
  comedi: ni_usb6501: fix NULL-deref in command paths
  comedi: dt9812: fix DMA buffers on stack
  comedi: vmk80xx: fix transfer-buffer overflows
  comedi: vmk80xx: fix bulk-buffer overflow
  comedi: vmk80xx: fix bulk and interrupt message timeouts

 drivers/comedi/drivers/dt9812.c     | 109 +++++++++++++++++++++-------
 drivers/comedi/drivers/ni_usb6501.c |   8 ++
 drivers/comedi/drivers/vmk80xx.c    |  28 +++----
 3 files changed, 105 insertions(+), 40 deletions(-)

-- 
2.32.0

