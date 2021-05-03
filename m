Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D755371532
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 14:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233520AbhECMXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 08:23:48 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:50822 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230009AbhECMXq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 08:23:46 -0400
Received: from andrew by vps0.lunn.ch with local (Exim 4.94)
        (envelope-from <andrew@lunn.ch>)
        id 1ldXb7-002HuR-9P; Mon, 03 May 2021 14:22:49 +0200
Date:   Mon, 3 May 2021 14:22:49 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 mvebu + mvebu/dt64 1/6] firmware: turris-mox-rwtm: fix
 reply status decoding function
Message-ID: <YI/rGQfWdMdanPcN@lunn.ch>
References: <20210308153703.23097-1-kabel@kernel.org>
 <20210429083636.22560-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210429083636.22560-1-pali@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2021 at 10:36:31AM +0200, Pali Rohár wrote:
> From: Marek Behún <kabel@kernel.org>
> 
> The status decoding function mox_get_status() currently contains a dead
> code path: if the error status is not MBOX_STS_SUCCESS, it always
> returns -EIO, so the comparison to MBOX_STS_FAIL is never executed and
> we don't get the actual error code sent by the firmware.
> 
> Fix this.
> 
> Signed-off-by: Marek Behún <kabel@kernel.org>
> Fixes: 389711b37493 ("firmware: Add Turris Mox rWTM firmware driver")

You have put a fixes tag here, meaning you want it in stable? How does
dead code elimination fulfil the stable requirements?

Do any of these changes contain real fixes?

   Andrew
