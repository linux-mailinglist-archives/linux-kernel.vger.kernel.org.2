Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7743B36A2F4
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 22:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234715AbhDXU0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 16:26:38 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:35817 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232708AbhDXU0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 16:26:37 -0400
X-Originating-IP: 176.177.118.122
Received: from localhost (unknown [176.177.118.122])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 57191C0005;
        Sat, 24 Apr 2021 20:25:55 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Qinglang Miao <miaoqinglang@huawei.com>,
        Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-i3c@lists.infradead.org
Subject: Re: [RESEND PATCH] Revert "i3c master: fix missing destroy_workqueue() on error in i3c_master_register"
Date:   Sat, 24 Apr 2021 22:25:41 +0200
Message-Id: <161929592285.189809.16598700064500451755.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210408172803.24599-1-jae.hyun.yoo@linux.intel.com>
References: <20210408172803.24599-1-jae.hyun.yoo@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Apr 2021 10:28:03 -0700, Jae Hyun Yoo wrote:
> Adding the destroy_workqueue call in i3c_master_register introduced below
> kernel warning because it makes duplicate destroy_workqueue calls when
> i3c_master_register fails after allocating the workqueue. The workqueue will
> be destroyed by i3c_masterdev_release which is called by put_device at the
> end of the i3c_master_register function eventually in failure cases so the
> workqueue doesn't need to be destroyed in i3c_master_register.
> 
> [...]

Applied, thanks!

[1/1] Revert "i3c master: fix missing destroy_workqueue() on error in i3c_master_register"
      commit: 0d95f41ebde40d552bb4fea64b1d618607915fd6

Best regards,
-- 
Alexandre Belloni <alexandre.belloni@bootlin.com>
