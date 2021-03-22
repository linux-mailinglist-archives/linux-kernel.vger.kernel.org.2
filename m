Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 943D7344096
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 13:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbhCVMPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 08:15:00 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:40068 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230263AbhCVMOZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 08:14:25 -0400
Received: from andrew by vps0.lunn.ch with local (Exim 4.94)
        (envelope-from <andrew@lunn.ch>)
        id 1lOJRu-00COZM-Nx; Mon, 22 Mar 2021 13:14:22 +0100
Date:   Mon, 22 Mar 2021 13:14:22 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Marcin Wojtas <mw@semihalf.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregory.clement@bootlin.com,
        robh+dt@kernel.org
Subject: Re: [PATCH] arm64: dts: ensure backward compatibility of the AP807
 Xenon
Message-ID: <YFiKHu3hlAk+joOn@lunn.ch>
References: <20210322003915.3199775-1-mw@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210322003915.3199775-1-mw@semihalf.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 01:39:15AM +0100, Marcin Wojtas wrote:
> A recent switch to a dedicated AP807 compatible string for the Xenon
> SD/MMC controller result in the driver not being probed when
> using updated device tree with the older kernel revisions.
> It may also be problematic for other OSs/firmware that use
> Linux device tree sources as a reference. Resolve the problem
> with backward compatibility by restoring a previous compatible
> string as secondary one.
> 
> Signed-off-by: Marcin Wojtas <mw@semihalf.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
