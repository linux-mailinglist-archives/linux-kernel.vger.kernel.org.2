Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86D853B66D0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 18:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234241AbhF1Qfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 12:35:42 -0400
Received: from verein.lst.de ([213.95.11.211]:37970 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234009AbhF1Qfk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 12:35:40 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id D62886736F; Mon, 28 Jun 2021 18:33:12 +0200 (CEST)
Date:   Mon, 28 Jun 2021 18:33:12 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Rob Landley <rob@landley.net>
Cc:     Christoph Hellwig <hch@lst.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: dma_declare_coherent_memory and SuperH
Message-ID: <20210628163312.GA29659@lst.de>
References: <20210623133205.GA28589@lst.de> <1a55cf69-8fe1-dca0-68c7-f978567f9ca0@landley.net> <20210628133858.GA21602@lst.de> <4d6b7c35-f2fa-b476-b814-598a812770e6@landley.net> <20210628134955.GA22559@lst.de> <1141b20f-7cdf-1477-ef51-876226db7a37@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1141b20f-7cdf-1477-ef51-876226db7a37@landley.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 28, 2021 at 09:29:59AM -0500, Rob Landley wrote:
> > No.  My hope is to kill dma_declarare_coherent, an API for board
> > support files to declare device-specific regions to be used for
> > coherent DMA.
> 
> Q) If I haven't got regression test hardware to make sure I properly converted
> each of these entire boards to device tree, Is there anything else I can do to
> help you remove this function from common code, such as inlining some portion of
> this function?
> 
> A) You can convert the board to device tree.
> 
> Which part of this exchange have I misunderstood?

The part that there is no easy way out without the device tree
conversion.
