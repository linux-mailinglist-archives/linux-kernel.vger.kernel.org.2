Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E54F32D8CF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 18:46:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235289AbhCDRnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 12:43:18 -0500
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:55171 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232304AbhCDRm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 12:42:56 -0500
X-Originating-IP: 90.65.108.55
Received: from localhost (lfbn-lyo-1-1676-55.w90-65.abo.wanadoo.fr [90.65.108.55])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id C8DBB20005;
        Thu,  4 Mar 2021 17:42:04 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-i3c@lists.infradead.org,
        Conor Culhane <conor.culhane@silvaco.com>,
        Colin King <colin.king@canonical.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH][next] i3c: master: svc: remove redundant assignment to cmd->read_len
Date:   Thu,  4 Mar 2021 18:42:04 +0100
Message-Id: <161487966787.3455951.17740404517515431971.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224151349.202332-1-colin.king@canonical.com>
References: <20210224151349.202332-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Feb 2021 15:13:49 +0000, Colin King wrote:
> The assignment of xfer_len to cmd->read_len appears to be redundant
> as the next statement re-assigns the value 0 to it.  Clean up the
> code by removing the redundant first assignment.

Applied, thanks!

[1/1] i3c: master: svc: remove redundant assignment to cmd->read_len
      commit: 437f5e2af73081ec08ec5d73d82c650377a4bb17

Best regards,
-- 
Alexandre Belloni <alexandre.belloni@bootlin.com>
