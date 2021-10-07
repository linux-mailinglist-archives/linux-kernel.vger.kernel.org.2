Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0356424DF9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 09:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240323AbhJGHUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 03:20:23 -0400
Received: from mx1.tq-group.com ([93.104.207.81]:37348 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240221AbhJGHUT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 03:20:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1633591106; x=1665127106;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uScYYFUX8iG0TWB1RqIb8XXKjjNY6/uZlWQo8MkDwlo=;
  b=X5Gy3+5xB6lUayUAt7HN9+sht9hYF3djFqiS7i4fqbI0yvGgn/VwhwCm
   uztSMuH/g6Crb4M3iHfga1/wpNohIjEtpC+YSXRbRoIy2ytbKWX5chEyg
   7GHbjzInJA/bByIjtOVZhCzdQcf12eOYNlgxq8ITxRpLr9Zz2dkluFFnD
   semP1tdEBn0vhG2PLFn4DT5WJMxuO5hGXL3FDifdQwt22bymBdRGTfwPI
   acjpNFaNfy/n3JeiKV70I4P5O41Tvl2IbWsJlJnHmEAgEJy4h1paFgTPj
   mF13JJ1dZktUQ1hK3GPK/fnEelOKUVujOa4n1bQEr7b3y7ePBKdxioO9p
   g==;
X-IronPort-AV: E=Sophos;i="5.85,354,1624312800"; 
   d="scan'208";a="19910223"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 07 Oct 2021 09:18:25 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Thu, 07 Oct 2021 09:18:25 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Thu, 07 Oct 2021 09:18:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1633591105; x=1665127105;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uScYYFUX8iG0TWB1RqIb8XXKjjNY6/uZlWQo8MkDwlo=;
  b=SZ5F1wclGGxBTyZbeYQbiYWKd7FJHY3Mi/0iF6o3P5EjVnNLR7H3I3x/
   doL0zsLtsJpJYnourchCsFxOh7Vu7h8doPNXkn25DHXe7zv//rO9+Xy9b
   B1pWnd5y5OcRANs0jsyDnUi87D47DlFwpyY2gJZ5fBjj8zqYtdNfbG1H2
   8lkdSe9lUB5Yfwb+RHkhYpphDxUskhXPIYPYbwSKWfqJhqzcYA3HXjHlo
   5SECyST0JbydlQh4UYDN5JzEJxS2ptaP+Je5PYHi0r8KYY++aJH1GbMqq
   4oYfvwASbiC8oMGqIxTiNY9Xcl93nic7EDArYWSKjTy5CbseDjGuhbv0y
   g==;
X-IronPort-AV: E=Sophos;i="5.85,354,1624312800"; 
   d="scan'208";a="19910222"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 07 Oct 2021 09:18:25 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.121.48.12])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 02C4B280065;
        Thu,  7 Oct 2021 09:18:24 +0200 (CEST)
Message-ID: <0e2ad27b00d85c1dfa489d91b54d2a3af41f5edb.camel@ew.tq-group.com>
Subject: Re: (EXT) Re: (EXT) Re: [PATCH 1/2] mtd: spi-nor: micron-st: sync
 flags of mt25ql02g and mt25qu02g with other mt25q
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Michael Walle <michael@walle.cc>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Thu, 07 Oct 2021 09:18:22 +0200
In-Reply-To: <969e9169b77bb314aaa2e97789c76c00@walle.cc>
References: <c7b6c666aef9a8a2195acabe9954a417f04b6582.1627039534.git.matthias.schiffer@ew.tq-group.com>
         <f3dbab898e9f1946129e5733095bdf3c@walle.cc>
         <3258026683c916a3a42e98ba76628228cddacb23.camel@ew.tq-group.com>
         <969e9169b77bb314aaa2e97789c76c00@walle.cc>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-10-07 at 09:08 +0200, Michael Walle wrote:
> Am 2021-10-06 14:32, schrieb Matthias Schiffer:
> > On Tue, 2021-07-27 at 09:09 +0200, Michael Walle wrote:
> > > Am 2021-07-23 13:27, schrieb Matthias Schiffer:
> > > > All mt25q variants have the same features.
> > > > 
> > > > Unlike the smaller variants, no n25q with 2G exists, so we don't need
> > > > to
> > > > match on the extended ID to distinguish n25q and mt25q series for these
> > > > models.
> > > 
> > > But why shouldn't we? What if there will be another flash with
> > > the same first three id bytes?
> > 
> > How do you suggest we proceed here? At the moment there are entries
> > matching on 0x20b[ab]22 (ignoring the extended ID) with the name
> > mt25q[lu]02g.
> > 
> > Should I change these entries to match on on the extended ID
> > 0x20b[ab]22 / 0x104400 instead when I add the bits for the features
> > specific to the variant, removing support for other 0x20b[ab]22
> > variants that may or may not actually exist? Keeping both entries (with
> > and without extended ID match) would preserve compatiblity with such
> > variants, but this approach seems problematic to me as well, as I can't
> > even give a name to the more generic entries (and there is no natural
> > extension of the n25q naming scheme to a 2G variant).
> 
> Mh, what do you think of adding three entries and make the last one,
> the one with the short id, as a fallback so to speak. This should
> retrain backwards compatibility, right? It should probably have a
> comment because the order will matter then.
> 
> -michael

Is it okay for multiple entries to use the same value for the "name"
field? In the existing definitions I couldn't find any example of
different ID matches mapping to the same name.

