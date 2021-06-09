Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA283A081B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 02:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbhFIAFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 20:05:07 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:55793 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbhFIAFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 20:05:06 -0400
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id A20F220002;
        Wed,  9 Jun 2021 00:03:11 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org, linux-i3c@lists.infradead.org
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        miquel.raynal@bootlin.com
Subject: Re: [PATCH -next] i3c: master: svc: fix doc warning in svc-i3c-master.c
Date:   Wed,  9 Jun 2021 02:03:09 +0200
Message-Id: <162319698188.1230434.17817139640415078043.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602085544.4101980-1-yangyingliang@huawei.com>
References: <20210602085544.4101980-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Jun 2021 16:55:44 +0800, Yang Yingliang wrote:
> Fix the following make W=1 warning:
> 
>   drivers/i3c/master/svc-i3c-master.c:207: warning: expecting prototype for struct svc_i3c_i3c_dev_data. Prototype was for struct svc_i3c_i2c_dev_data instead

Applied, thanks!

[1/1] i3c: master: svc: fix doc warning in svc-i3c-master.c
      commit: 3e5feb11a82945c88a1518fd2682ca8de66c37d3

Best regards,
-- 
Alexandre Belloni <alexandre.belloni@bootlin.com>
