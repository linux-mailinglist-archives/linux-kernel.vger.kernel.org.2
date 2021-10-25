Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB2B04395AA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 14:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232838AbhJYML7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 08:11:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:51180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231355AbhJYML4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 08:11:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3D2F36105A;
        Mon, 25 Oct 2021 12:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635163774;
        bh=0YIEYuLhVMqGscQwr/BKZcjwZawy0J/ApKLjk7OIjXk=;
        h=From:To:Cc:Subject:Date:From;
        b=jGRSvlYipbY76uSqkDqLsfQ/Ipoab5C99ks7IMRJULrkxYvTIAv6SIktxhyr0piJt
         N0ORvseywQmXXp60iuWCVxT3Wy8VYoFJDvD9uQKAjBfsdbU1ImfMFeFpZ62h4mm/4E
         acRA1pJRxnpmQDfl+a4Ilg17Q2loqGjQ4qY6jULrnQEadYMdniqiiqJM9125KYOJbJ
         ygL/5oqfyVnE081FIa8ImOPZDGGjUlFVqx2H9UwWSW8kythOqJv7OWTZKg9NdHl1Oz
         gdkNwxZPs3X7cprkzH03TIHFm3t8DVQIT2ECYrFG70vcI/zBQVBuVbn8GuJ6eVoJr5
         Dbr25m/ru1NbQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1meymy-0001f5-UO; Mon, 25 Oct 2021 14:09:17 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        linux-staging@lists.linux.dev, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 0/2] staging: fix control-message timeouts
Date:   Mon, 25 Oct 2021 14:09:08 +0200
Message-Id: <20211025120910.6339-1-johan@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A number of drivers throughout the tree were incorrectly specifying USB
message timeout values in jiffies instead of milliseconds.

This series fixes the staging drivers that got it wrong.

Johan


Johan Hovold (2):
  staging: rtl8192u: fix control-message timeouts
  staging: r8712u: fix control-message timeout

 drivers/staging/rtl8192u/r8192U_core.c  | 18 +++++++++---------
 drivers/staging/rtl8712/usb_ops_linux.c |  2 +-
 2 files changed, 10 insertions(+), 10 deletions(-)

-- 
2.32.0

