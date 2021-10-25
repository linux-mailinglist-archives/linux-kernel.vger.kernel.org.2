Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6240543A140
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 21:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236193AbhJYTh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 15:37:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:48430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234844AbhJYTbk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 15:31:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 64EA7610C8;
        Mon, 25 Oct 2021 19:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1635190065;
        bh=OUv7N9wsLoXbm/vtjTvBM+lAVo4HBcOkZSejorIWfg4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jyW94prrKODUZKIr8/oGwes9q++M5ZkVTUiGeKDOO2sl+t2bNmTEDB7IkG7/DcrkC
         6onK/20W/8vfEar1asPdk/d2EpCvq1PKOqQsz3KmVJcx8iTSm/e5CDvaQtpKODV+3d
         sDtUmGby8T/mpAjCEBqos5dpfQ5gJBbfBQT9dCzU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Lin Ma <linma@zju.edu.cn>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 41/58] nfc: nci: fix the UAF of rf_conn_info object
Date:   Mon, 25 Oct 2021 21:14:58 +0200
Message-Id: <20211025190944.151272926@linuxfoundation.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211025190937.555108060@linuxfoundation.org>
References: <20211025190937.555108060@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lin Ma <linma@zju.edu.cn>

commit 1b1499a817c90fd1ce9453a2c98d2a01cca0e775 upstream.

The nci_core_conn_close_rsp_packet() function will release the conn_info
with given conn_id. However, it needs to set the rf_conn_info to NULL to
prevent other routines like nci_rf_intf_activated_ntf_packet() to trigger
the UAF.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Signed-off-by: Lin Ma <linma@zju.edu.cn>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/nfc/nci/rsp.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/net/nfc/nci/rsp.c
+++ b/net/nfc/nci/rsp.c
@@ -277,6 +277,8 @@ static void nci_core_conn_close_rsp_pack
 							 ndev->cur_conn_id);
 		if (conn_info) {
 			list_del(&conn_info->list);
+			if (conn_info == ndev->rf_conn_info)
+				ndev->rf_conn_info = NULL;
 			devm_kfree(&ndev->nfc_dev->dev, conn_info);
 		}
 	}


