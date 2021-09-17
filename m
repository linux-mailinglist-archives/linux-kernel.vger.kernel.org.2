Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF9540F6DB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 13:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344029AbhIQLvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 07:51:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:34186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242149AbhIQLv0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 07:51:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 14BF361241;
        Fri, 17 Sep 2021 11:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631879404;
        bh=19iJui3Wb9/G6Xw/hWHtbTl0GlH1HsEhxOEVYM8MrZw=;
        h=From:To:Cc:Subject:Date:From;
        b=kRa0K618nTe0qm9rF4hUUiGNPYy89r5aZNgKA0ROnqJV4t2QW8PlxhmVHJs0UgdEB
         Vzxvh4VuWAwRgrmAJZzdUdGpw+eNLDjCSsgbY5rQC/qghKVk/Nq3rRTMppPsnw8xzw
         IrWvGoF8F/kqAYzck5LfrvyHLgVtdixmy6tX1rrE0iP2ntlxI/Wdi/r4mZp1LKGHwD
         IWZ99Q5KHJeQNsEN3W7pn7JYUbnwQSqhjS3sKJrG5yHGugPaCPQUgTnynjqZacYQbX
         lGRn4QODA7bEXPJDlPf/Q5X/xqrKqhxp5Jj4Blzt6fl+nGbAwvMNMCfgSbroH7IEV8
         elmLVWVofGl4w==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1mRCNZ-0001RN-Go; Fri, 17 Sep 2021 13:50:05 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Samuel Iglesias Gonsalvez <siglesias@igalia.com>,
        Jens Taprogge <jens.taprogge@taprogge.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     industrypack-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 0/6] ipack: ipoctal: fix info leak and other bugs
Date:   Fri, 17 Sep 2021 13:46:16 +0200
Message-Id: <20210917114622.5412-1-johan@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes a stack info leak and a number of other bugs all found
through inspection. Included is also a related cleanup.

Note that the series has only been compile tested.

Johan


Johan Hovold (6):
  ipack: ipoctal: fix stack information leak
  ipack: ipoctal: fix tty registration race
  ipack: ipoctal: fix tty-registration error handling
  ipack: ipoctal: fix missing allocation-failure check
  ipack: ipoctal: fix module reference leak
  ipack: ipoctal: rename tty-driver pointer

 drivers/ipack/devices/ipoctal.c | 101 +++++++++++++++++++++-----------
 1 file changed, 66 insertions(+), 35 deletions(-)

-- 
2.32.0

