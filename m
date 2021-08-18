Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB333F059F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 16:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238584AbhHROFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 10:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238542AbhHROFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 10:05:08 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF64C061764;
        Wed, 18 Aug 2021 07:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=mQ9SSlzHtfuq8JpnmX8ZdV0e+tMR7XQKTsDldhH1vrg=; b=ZUt1o/DXbYnZPEajfsxv37RVBj
        eM0s0gI0REORwKgtY4VYaZYYdwASU4K+e1eh++UVMVKCxFhHdNxx7kvcN114qznvqiWiCaWoNs4Q5
        xr3fbN4wi1QVbW3NPLvRggoSDpGxBQQj/cmwS977yEans0krCTCtLsJKkhEE/H/UO+fs8ORVWPwoQ
        wU1v4uJ0mZM5vRPHx0wmp0wMdx1S1+U0OW8Z7C/j8JvIiKzgj65iVHtGq2zUnTprs13uOnHelFU/f
        g+56fl4p34ZmjA2Me0Keqtn7g5Hu5A5u0KM9reQsDUnjz8eHl05RJQ68rGajo4XhEUuKJVbDM1W+a
        fUVQ/4sg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mGMBF-005oCY-5E; Wed, 18 Aug 2021 14:04:33 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     fstests@vger.kernel.org
Cc:     hare@suse.de, dgilbert@interlog.com, jeyu@kernel.org,
        lucas.demarchi@intel.com, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v3 0/2] fstests: add patient module remover
Date:   Wed, 18 Aug 2021 07:04:30 -0700
Message-Id: <20210818140432.1384562-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This v3 addresses the issues noted by Eryu, it also drops
the patches already merged.

Luis Chamberlain (2):
  common/module: add patient module rmmod support
  common/scsi_debug: use the patient module remover

 README            |   3 ++
 common/config     |  31 ++++++++++++++
 common/module     | 105 ++++++++++++++++++++++++++++++++++++++++++++++
 common/scsi_debug |   6 ++-
 4 files changed, 143 insertions(+), 2 deletions(-)

-- 
2.30.2

