Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19172434785
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 11:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbhJTJDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 05:03:51 -0400
Received: from first.geanix.com ([116.203.34.67]:37394 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229683AbhJTJDt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 05:03:49 -0400
Received: from skn-laptop (unknown [185.233.254.173])
        by first.geanix.com (Postfix) with ESMTPSA id AC7E2C7ED6;
        Wed, 20 Oct 2021 09:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1634720493; bh=0TDUefSKSTAfFL2Uv7HVije8SZ09HaYEgndQJR2AUrg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=K0bTCdHvzy6hsDfRq+p0+IVzDX/bc9Ahv6jiOoF8VX/VmiDA127VpWk/htZopBl6p
         HEAgV1o7w5NEgg7bVOLqwIOS9H7icU952jvUa+4/s0fkcLYg0WsnpYBhBJS3bIMs1u
         WUuZsKgXdvwToj3gPB56QZfJ+oMElYjex3J14NtGnbgfm11sueeSU3DJm3AzX4StIF
         b/30EEWmHwK3i1dTsR8YAS9m5ES4+QUIyxxtjXo+I1TohRjce8hUxDRS+WKOYU8JLh
         Z93NyuC/b6bEoGKtHHaDAylQy0P9oDo+mcSWB048RwjSpsxdiPDi7/IC0pRFAS7elM
         IZP2Fw42+AXsw==
Date:   Wed, 20 Oct 2021 11:01:32 +0200
From:   Sean Nyekjaer <sean@geanix.com>
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] mtd: rawnand: nand_bbt: hide suspend/resume hooks
 while scanning bbt
Message-ID: <20211020090132.zuxojg6cnwsm4dwg@skn-laptop>
References: <20211020084534.2472305-1-sean@geanix.com>
 <20211020084534.2472305-2-sean@geanix.com>
 <20211020105326.0dca864a@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211020105326.0dca864a@collabora.com>
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on 13e2a5895688
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2021 at 10:53:26AM +0200, Boris Brezillon wrote:
> On Wed, 20 Oct 2021 10:45:31 +0200
> Sean Nyekjaer <sean@geanix.com> wrote:
> 
> > From: Boris Brezillon <boris.brezillon@collabora.com>
> > 
> > The BBT scan logic use the MTD helpers before the MTD layer had a
> > chance to initialize the device, and that leads to issues when
> > accessing the uninitialized suspend lock. Let's temporarily set the
> > suspend/resume hooks to NULL to skip the lock acquire/release step.
> > 
> > Fixes: 013e6292aaf5 ("mtd: rawnand: Simplify the locking")
> > Tested-by: Sean Nyekjaer <sean@geanix.com>
> 
> It's missing our Signed-off-by tags.
> 

Patch is from you ;)
If you are okay with it, I will add your Signed-off-by tag.

/Sean
