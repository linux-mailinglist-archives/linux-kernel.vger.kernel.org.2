Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF2143569AD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 12:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346726AbhDGK33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 06:29:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:46120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233490AbhDGK3L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 06:29:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 48CD9613A3;
        Wed,  7 Apr 2021 10:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617791342;
        bh=DogvUKThPi1f04RxrMIdoe+3W13yimB7dOYn9wfbxbg=;
        h=From:To:Cc:Subject:Date:From;
        b=dtlEJLNZnVVQBA5UzNGlWFMsTZEe1YVrBzf+LrucKe4ntNrlyFy1JV4yCWO3tcg6u
         DtGUxTtM42sba+46yR2+uFyMTlz/zcdJkjuNQOEMS2qu/ekmPyfx1Xs6J3R9Vsd1xI
         W9wLcPkQFLyo0h4XR2Rvj/BxI6fqNesRadX7I37uj12e1QvB2Fa2lqCTpvJcWzEL/P
         Xm7aw/5R2CSbzYxwB/N3mY6CsFtxO7i9MWS3t4od7cx1KcUIrp2k+Yrgp31R1ZeBYP
         aV0fAm9RYh5XSd0ggg/hRMfsLkQOksr5Sf45Bu75lK1TP16TKCPhJCDU8I7gEEVGC8
         YGyeQXKF8gkrw==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lU5Qc-00004q-Jn; Wed, 07 Apr 2021 12:28:54 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Oliver Neukum <oneukum@suse.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 0/3] USB: cdc-acm: TIOCSSERIAL fixes
Date:   Wed,  7 Apr 2021 12:28:42 +0200
Message-Id: <20210407102845.32720-1-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes up a few issues with cdc-acm TIOCSSERIAL
implementation.

Johan


Johan Hovold (3):
  Revert "USB: cdc-acm: fix rounding error in TIOCSSERIAL"
  USB: cdc-acm: fix unprivileged TIOCCSERIAL
  USB: cdc-acm: fix TIOCGSERIAL implementation

 drivers/usb/class/cdc-acm.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

-- 
2.26.3

