Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 626444395BD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 14:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232958AbhJYMOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 08:14:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:53120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232679AbhJYMOh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 08:14:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A5F4060FE8;
        Mon, 25 Oct 2021 12:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635163935;
        bh=/7AhjSeqSanvWP2tDzbI1wBAh38yZx6pj7kvM8uB4Ws=;
        h=From:To:Cc:Subject:Date:From;
        b=Bocb6vQcv1rJ/p1ekv21CSPRT/wmro22cUdAvF04+WClbe/1F+/NapNgrk/xWej1K
         3Q1QJYr2ajuuX7LycpTaYR/7CZcOWCivc3RlmDq9R8yxdI5TawAEwouwRpz6P6/9Uk
         GhxReO0lHJb4pwW7PWmyvn9J4N71g82+doz0BTlEx9r52VoI+y0NtHn5tAaiF9gevS
         f2vWFeKb6jNhsUYdi6Jc4qc1dCMHcs7LEcnjjetZ33AH/G3RFkOVs8fhUVqnkfKUQk
         o0EkECpYnxKcaGeFgE0DTiqV6hnEPeQIQrFiYnMqsdcwYYWIDZJvOEpFiOi3I3DRyz
         RJ79gOQDTdnDg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1meypa-0001iF-8u; Mon, 25 Oct 2021 14:11:58 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Takashi Iwai <tiwai@suse.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 0/2] sound: fix USB message timeouts
Date:   Mon, 25 Oct 2021 14:11:40 +0200
Message-Id: <20211025121142.6531-1-johan@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A number of drivers throughout the tree were incorrectly specifying USB
message timeout values in jiffies instead of milliseconds.

This series fixes the two sound drivers that got it wrong.

Johan


Johan Hovold (2):
  sound: 6fire: fix control and bulk message timeouts
  sound: line6: fix control and interrupt message timeouts

 sound/usb/6fire/comm.c     |  2 +-
 sound/usb/6fire/firmware.c |  6 +++---
 sound/usb/line6/driver.c   | 14 +++++++-------
 sound/usb/line6/driver.h   |  2 +-
 sound/usb/line6/podhd.c    |  6 +++---
 sound/usb/line6/toneport.c |  2 +-
 6 files changed, 16 insertions(+), 16 deletions(-)

-- 
2.32.0

