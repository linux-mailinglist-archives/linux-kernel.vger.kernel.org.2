Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C74CD370F34
	for <lists+linux-kernel@lfdr.de>; Sun,  2 May 2021 23:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232568AbhEBVJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 May 2021 17:09:51 -0400
Received: from h04.kommunity.net ([138.201.86.160]:42683 "EHLO
        h04.kommunity.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232457AbhEBVJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 May 2021 17:09:50 -0400
Received: from notebook.fritz.box (p4fc26c70.dip0.t-ipconnect.de [79.194.108.112])
        by h04.kommunity.net (Postfix) with ESMTPSA id 9EF41F85628;
        Sun,  2 May 2021 23:08:56 +0200 (CEST)
Authentication-Results: h04.kommunity.net;
        spf=pass (sender IP is 79.194.108.112) smtp.mailfrom=alec@vc-celle.de smtp.helo=notebook.fritz.box
Received-SPF: pass (h04.kommunity.net: connection is authenticated)
From:   Alexander Vorwerk <alec@vc-celle.de>
To:     forest@alittletooquiet.net, gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Alexander Vorwerk <alec@vc-celle.de>
Subject: [PATCH 0/2] staging: vt6655: remove multiple assignments
Date:   Sun,  2 May 2021 23:08:24 +0200
Message-Id: <20210502210826.10323-1-alec@vc-celle.de>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These two patches fix two multiple assignments coding-style
issues reported by checkpatch.pl.

Alexander Vorwerk (2):
  staging: vt6655: remove multiple assignment
  staging: vt6655: remove multiple assignment

 drivers/staging/vt6655/device_main.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

-- 
2.17.1

