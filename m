Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A036D3F23F0
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 02:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237041AbhHTADM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 20:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234367AbhHTADL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 20:03:11 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35774C061575;
        Thu, 19 Aug 2021 17:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=iYm8DX9D+NwXIYjvDYP4YE8uh0d65zlmB+VOqtZf0H0=; b=L6dqOvuwQ8tCO8wl18+fwI9HNU
        As16InOjlEuoUudIzRaqGjQkBcCdgdsWF2gvT+K45KhSim6Z/gCqzxf22/Qe1yeTn79h8JBSmCXfh
        tImOw1E4KURii0OL/oKBxGn2qu1gAzrmLA5XT15Z5ibNyunMvMRby6digQe5QRNu2aTSyI1F3ejb0
        67JbfNZSftCyhR/yL2BklqQ/USgr9bg2FNLXiB5TKJp7ko6EG28ZQw2wNsCFrDOSd5mp8GXIiLt/z
        s9inVeknNIYFoLrMUNjhd5s+hRKV7dfMpLFXzWWKVIcATkXPnkZ2AaPqTXiqx4PPHtVS89tUbjDUA
        Pl9I+pyQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mGrzW-009mxs-Rb; Fri, 20 Aug 2021 00:02:34 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     fstests@vger.kernel.org
Cc:     hare@suse.de, dgilbert@interlog.com, jeyu@kernel.org,
        lucas.demarchi@intel.com, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v4 0/2] fstests: add patient module remover
Date:   Thu, 19 Aug 2021 17:02:32 -0700
Message-Id: <20210820000234.2333125-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v4:

  - Just adds a new comment to clarify why we use a string check
    for max_tries as requested by Eryu Guan.

Luis Chamberlain (2):
  common/module: add patient module rmmod support
  common/scsi_debug: use the patient module remover

 README            |   3 ++
 common/config     |  31 +++++++++++++
 common/module     | 108 ++++++++++++++++++++++++++++++++++++++++++++++
 common/scsi_debug |   6 ++-
 4 files changed, 146 insertions(+), 2 deletions(-)

-- 
2.30.2

