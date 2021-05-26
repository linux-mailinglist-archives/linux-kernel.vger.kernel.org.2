Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E740D391348
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 11:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233346AbhEZJEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 05:04:32 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:65485 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233484AbhEZJE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 05:04:28 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 1BC544001D;
        Wed, 26 May 2021 09:02:53 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     dingsenjie@163.com, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ding Senjie <dingsenjie@yulong.com>
Subject: Re: [PATCH v3] mtd: devices: Remove superfluous "break"
Date:   Wed, 26 May 2021 11:02:53 +0200
Message-Id: <20210526090253.180708-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210514124451.20352-1-dingsenjie@163.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'5c1ce1fb8a2d434a485175d6ae38aea40ebd5de4'
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-05-14 at 12:44:51 UTC, dingsenjie@163.com wrote:
> From: Ding Senjie <dingsenjie@yulong.com>
> 
> Remove superfluous "break", as there is a "return" before it.
> 
> Signed-off-by: Ding Senjie <dingsenjie@yulong.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
