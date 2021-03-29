Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13B0D34C943
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 10:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbhC2I3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 04:29:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:35138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233349AbhC2ISf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 04:18:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 035FB61481;
        Mon, 29 Mar 2021 08:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617005912;
        bh=UTjRhRZipRt5fVqetDoXAozWE+ENWkTdY+VzugbfmhU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F3nimKNuQbItOb151ISWIu8QMPKKk1LFk3Syu970qYZy1I+h24R3v4DNPmfYqNhfO
         W6Zy5AV384hX5cCTJP10+wdtCE1uoiJJ7wc+S/xBXdzfnEztfJqFP0JtvgxSlx9s6X
         kes4NVjrVQoi2MfGPXqX3xjlq0a/tbadbp1zhWz0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Christoph Hellwig <hch@lst.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 049/221] nvme-core: check ctrl css before setting up zns
Date:   Mon, 29 Mar 2021 09:56:20 +0200
Message-Id: <20210329075630.816658126@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210329075629.172032742@linuxfoundation.org>
References: <20210329075629.172032742@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

[ Upstream commit 0ec84df4953bd42c6583a555773f1d4996a061eb ]

Ensure multiple Command Sets are supported before starting to setup a
ZNS namespace.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
[hch: move the check around a bit]
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 30e834d84f36..140f19cbe73a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4019,6 +4019,12 @@ static void nvme_validate_or_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 				nsid);
 			break;
 		}
+		if (!nvme_multi_css(ctrl)) {
+			dev_warn(ctrl->device,
+				"command set not reported for nsid: %d\n",
+				ns->head->ns_id);
+			break;
+		}
 		nvme_alloc_ns(ctrl, nsid, &ids);
 		break;
 	default:
-- 
2.30.1



