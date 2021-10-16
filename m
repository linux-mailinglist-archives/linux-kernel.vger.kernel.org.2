Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48D0A4303FC
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 19:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244496AbhJPRjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 13:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244457AbhJPRiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 13:38:15 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA53C061765
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 10:36:06 -0700 (PDT)
Received: from ipservice-092-217-067-147.092.217.pools.vodafone-ip.de ([92.217.67.147] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mbnbG-0006dq-1A; Sat, 16 Oct 2021 19:36:02 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 0/3] staging: r8188eu: clean up the Makefile
Date:   Sat, 16 Oct 2021 19:35:41 +0200
Message-Id: <20211016173544.25376-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up the Makefile, make it similar to other drivers.

Please apply this after the "staging: r8188eu: remove CONFIG_BT_COEXIST"
series.

Martin Kaiser (3):
  staging: r8188eu: Makefile: remove unused driver config
  staging: r8188eu: Makefile: don't overwrite global settings
  staging: r8188eu: Makefile: use one file list

 drivers/staging/r8188eu/Makefile | 146 ++++++++++++-------------------
 1 file changed, 55 insertions(+), 91 deletions(-)

-- 
2.20.1

