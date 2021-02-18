Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 663AC31E856
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 11:01:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbhBRJ5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 04:57:20 -0500
Received: from inva020.nxp.com ([92.121.34.13]:50430 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231446AbhBRIyK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 03:54:10 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id C6A931A075E;
        Thu, 18 Feb 2021 09:45:32 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id C4A1F1A13D7;
        Thu, 18 Feb 2021 09:45:29 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 2D4A240291;
        Thu, 18 Feb 2021 09:45:26 +0100 (CET)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     shawnguo@kernel.org, ping.bai@nxp.com
Cc:     linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: clk: imx8mp: Remove the none exist pcie clocks
Date:   Thu, 18 Feb 2021 16:33:45 +0800
Message-Id: <1613637226-31447-1-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH v2] clk: imx8mp: Remove the none exist pcie clocks
