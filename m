Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6A7418480
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Sep 2021 22:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbhIYUuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Sep 2021 16:50:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:47204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229842AbhIYUuU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Sep 2021 16:50:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6DC1760FDC;
        Sat, 25 Sep 2021 20:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632602925;
        bh=NggOH7O/zGplTburqq3IZcOMmY+4gej0SMCZZNCnimY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=goylx51MfdTmhiW2K8fU4jNFQL4dzr6tzJumETyia3nS4hy2sIH1ZGTi4dVIX84b8
         M4HqM48oHoJqbLv85egpScRQq3isO+N/eHEGAVBVvHoZgl6rKNoTCpajxRblPEkelJ
         eP2JGnF7As9iaiLDA+/6sKyuRqB52/0mrym1sMpUTVJeKR5Cmu1X+jbro+6R8YVRyz
         4fh35QskMDsEtMyUSBjmTNaLoz07rPlY2CpWHzU0348dSxXSlHrW7+9ungfAvMpe4C
         SKUc/0LY/X594U8D6EjqFJkK5Y3vHbDR8QDHt9yv5XIyB4+ccOkPH5sHdnw2iGLXoQ
         KvXi5q+zlE7SQ==
Date:   Sat, 25 Sep 2021 13:48:42 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Aditya Garg <gargaditya08@live.com>,
        "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "james.smart@broadcom.com" <james.smart@broadcom.com>,
        "chaitanya.kulkarni@wdc.com" <chaitanya.kulkarni@wdc.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "trivial@kernel.org" <trivial@kernel.org>
Subject: Re: [PATCH] Urgent bug fix causing Apple SSDs to not work.
Message-ID: <20210925204842.GD116968@dhcp-10-100-145-180.wdc.com>
References: <PNZPR01MB4415600ACD3C8D9944F15058B8A59@PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM>
 <CAHk-=wgML11x9afCvmg9yhVm9wi5mvnjBvmX+i7OfMA0Vd4FWA@mail.gmail.com>
 <20210925195425.GB116968@dhcp-10-100-145-180.wdc.com>
 <7e75e292-3073-f1f9-287a-badf92c8e4e8@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e75e292-3073-f1f9-287a-badf92c8e4e8@grimberg.me>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 25, 2021 at 11:34:31PM +0300, Sagi Grimberg wrote:
> Exactly the patch that I was going to propose. The only downside
> is that we need to access the controller in the hot-path...

I initially had the same concern but noticed we already access 'ctrl' in
nvme_setup_rw() in this path, so I don't think we will be able to
measure the cost of the added check.
