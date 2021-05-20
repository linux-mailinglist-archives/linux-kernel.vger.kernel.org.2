Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B93F438ACE3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 13:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243785AbhETLvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 07:51:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:57154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241757AbhETLgx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 07:36:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 064C461057;
        Thu, 20 May 2021 11:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621510532;
        bh=EcCPPne5hWVCotDRWTVBnxbpXJHdAFT3tn+a9vbStb8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cbWGEr/s9szSnBchCy0TS02MyvQqvEzNnrArf9vdaw/SZJDmO3iwb2INpgT4sffHq
         yPZwe2iHcgOu4BX1STdOV2Wzl5NdPUwlL4D6S3RPHwrThjQIW9VjUjvLXZC8tw2ovZ
         dcVBzljtuj2o3u5U3bGZ2PqLm59CS327g7sXdGdXetpby+q9xUyPWe3nH/NNycSFc/
         jr6Q/E2HHHW9eqBImkg0rlwmiJ5/nUx1zlmW1fPXLY8jFbJZErHy4S7XqVRpip/BS5
         E4TRnzzmUzQ4maq2a38CmOyTtHlx3P/Ic/swEJOqsTuE7VyTZ7k+Vyy+JArmqDtAgK
         1X0HS+HnJKj3Q==
Received: by pali.im (Postfix)
        id 5F96A9D1; Thu, 20 May 2021 13:35:29 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>
Cc:     =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 mvebu 0/4] firmware: turris-mox-rwtm: fixups
Date:   Thu, 20 May 2021 13:35:16 +0200
Message-Id: <20210520113520.32240-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210308153703.23097-1-kabel@kernel.org>
References: <20210308153703.23097-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These 4 patches are just fixups. Per Andrew's request I have split them
from V3 series, so they can be applied to stable.

Marek Behún (2):
  firmware: turris-mox-rwtm: fix reply status decoding function
  firmware: turris-mox-rwtm: report failures better

Pali Rohár (2):
  firmware: turris-mox-rwtm: fail probing when firmware does not support
    hwrng
  firmware: turris-mox-rwtm: show message about HWRNG registration

 drivers/firmware/turris-mox-rwtm.c | 55 +++++++++++++++++++++++++-----
 1 file changed, 47 insertions(+), 8 deletions(-)

-- 
2.20.1

