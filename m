Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 595554415A1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 09:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbhKAItC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 04:49:02 -0400
Received: from first.geanix.com ([116.203.34.67]:37486 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231386AbhKAItB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 04:49:01 -0400
Received: from skn-laptop (unknown [185.233.254.173])
        by first.geanix.com (Postfix) with ESMTPSA id E567BD67A8;
        Mon,  1 Nov 2021 08:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1635756385; bh=qdJTJ4CPDrPjfrnJBTByEIdvM1m6Qg5yx5K523AlXXQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=GCtcjycbJl3C/4nAE3IqLI264dlNq7UPcV/1hDtFGSbF8aakLclr99bklD2TpAhiv
         pLk7ptUWdT0FTLv2fgC/yh3tOISJfe+VxISPJyoa4aCKmWe+vkHJHMuwaXRnIb/2tF
         yWXT1SbThjb5ITL4MKlQdaHey43kO6xLbdOddUeDUU8MZ5099MKZ1oDSXwlpgMgDGA
         hX9kYPyuHapdhC0chyahO3qamlzixKHrkcOcqBlCvQq5RlFwy0DmDH7KWyRmlh7Hga
         BRtW705rsSnFQBoQKtpFCIZJuDlWtIjw93yyJhyAXrppVgxSqTgrCIJvUA5ieRP1gy
         cEdCT+NHD9ppw==
Date:   Mon, 1 Nov 2021 09:46:23 +0100
From:   Sean Nyekjaer <sean@geanix.com>
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/4] mtd: rawnand: nand_bbt: hide suspend/resume hooks
 while scanning bbt
Message-ID: <20211101084623.xrpwwvweez24svib@skn-laptop>
References: <20211026055551.3053598-1-sean@geanix.com>
 <20211026055551.3053598-2-sean@geanix.com>
 <20211101083824.236b9983@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211101083824.236b9983@collabora.com>
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on 13e2a5895688
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 01, 2021 at 08:38:24AM +0100, Boris Brezillon wrote:
> On Tue, 26 Oct 2021 07:55:48 +0200
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
> 
> I think I already mentioned this Fixes tag should not be there.
> 

No, I didn't recall that, but nevermind :)

Hmm when ('mtd: core: protect access to MTD devices while in suspend')
is backported we want to live with the use before init of the rwsem?

/Sean
