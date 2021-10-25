Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42351439550
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 13:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbhJYLy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 07:54:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:41520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230168AbhJYLyr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 07:54:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 037B860F9D;
        Mon, 25 Oct 2021 11:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635162745;
        bh=BbRoaahLOM0ZqWpMw3lcnu/Lch2p4ofSfI1jLBp3uOg=;
        h=From:To:Cc:Subject:Date:From;
        b=f5kL+YvBvxP3e+oGifJv/Ip5eL6rdwgLjzIsw5xGW/6+frqqlKfNiJiYcAHvrXRRc
         +aMbygkQ5JEeq6cj5klREh4jFe6mHPYllKIeaYW+JBCrGY9DmNhVQngFZXebt0Yb+X
         Zu5SqnLEzCrf88mDPuUoH3cTySPJngKLxbtoUA+DVWhVQVdtpiFh8AA+o7aoTb6U9n
         GH1EjB5ecFXkc0Xx1rW6gPP+NT4ukp1vy1io+nagG55Bh+csLkL6p/1wmkYflNiiBo
         tDvBWcUe6O1hRtj/DdGaZxIIAzmIJSJBwIBuUKn40sSCmSYlCrRd0I3ErNXs4HoxQz
         eCUA1I7nL0ICQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1meyWN-0001Ik-Kr; Mon, 25 Oct 2021 13:52:07 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 0/2] USB: fix control-message timeouts
Date:   Mon, 25 Oct 2021 13:51:57 +0200
Message-Id: <20211025115159.4954-1-johan@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A number of drivers throughout the tree were using timeout values in
jiffies instead of milliseconds.

This series fixes a broken USB documentation example and the single
driver in the USB subtree that got it wrong.

Johan


Johan Hovold (2):
  Documentation: USB: fix example bulk-message timeout
  USB: iowarrior: fix control-message timeouts

 Documentation/driver-api/usb/writing_usb_driver.rst | 2 +-
 drivers/usb/misc/iowarrior.c                        | 8 ++------
 2 files changed, 3 insertions(+), 7 deletions(-)

-- 
2.32.0

