Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA5330B34A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 00:19:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbhBAXSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 18:18:24 -0500
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:36841 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbhBAXSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 18:18:16 -0500
X-Originating-IP: 86.202.109.140
Received: from localhost (lfbn-lyo-1-13-140.w86-202.abo.wanadoo.fr [86.202.109.140])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 8DDC620006;
        Mon,  1 Feb 2021 23:17:22 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     David Gow <davidgow@google.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Nicolas Pitre <npitre@baylibre.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-i3c@lists.infradead.org
Subject: Re: [PATCH] i3c/master/mipi-i3c-hci: Specify HAS_IOMEM dependency
Date:   Tue,  2 Feb 2021 00:17:20 +0100
Message-Id: <161222143405.3432488.2995169601612926467.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210127040636.1535722-1-davidgow@google.com>
References: <20210127040636.1535722-1-davidgow@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jan 2021 20:06:37 -0800, David Gow wrote:
> The MIPI i3c HCI driver makes use of IOMEM functions like
> devm_platform_ioremap_resource(), which are only available if
> CONFIG_HAS_IOMEM is defined.
> 
> This causes the driver to be enabled under make ARCH=um allyesconfig,
> even though it won't build.
> 
> [...]

Applied, thanks!

[1/1] i3c/master/mipi-i3c-hci: Specify HAS_IOMEM dependency
      commit: 9d909f1b1e91b4aa7d016ed14b7b76dbf2675414

Best regards,
-- 
Alexandre Belloni <alexandre.belloni@bootlin.com>
