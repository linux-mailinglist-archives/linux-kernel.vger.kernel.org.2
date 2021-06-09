Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64DB83A081C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 02:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbhFIAFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 20:05:09 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:60757 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbhFIAFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 20:05:06 -0400
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 68A3F1BF205;
        Wed,  9 Jun 2021 00:03:12 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org, linux-i3c@lists.infradead.org
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        miquel.raynal@bootlin.com
Subject: Re: [PATCH -next v2] i3c: master: svc: drop free_irq of devm_request_irq allocated irq
Date:   Wed,  9 Jun 2021 02:03:10 +0200
Message-Id: <162319698188.1230434.16937256801626257846.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602084935.3977636-1-yangyingliang@huawei.com>
References: <20210602084935.3977636-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Jun 2021 16:49:35 +0800, Yang Yingliang wrote:
> irq allocated with devm_request_irq() will be freed in devm_irq_release(),
> using free_irq() in ->remove() will causes a dangling pointer, and a
> subsequent double free. So remove the free_irq() in svc_i3c_master_remove().

Applied, thanks!

[1/1] i3c: master: svc: drop free_irq of devm_request_irq allocated irq
      commit: 59a61e69c4252b4e8ecd15e752b0d2337f0121b7

Best regards,
-- 
Alexandre Belloni <alexandre.belloni@bootlin.com>
