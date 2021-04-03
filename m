Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59834353317
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 10:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235850AbhDCIQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 04:16:04 -0400
Received: from verein.lst.de ([213.95.11.211]:45977 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232146AbhDCIQC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 04:16:02 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8AC1768BEB; Sat,  3 Apr 2021 10:15:56 +0200 (CEST)
Date:   Sat, 3 Apr 2021 10:15:56 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Niklas Cassel <nks@flawful.org>
Cc:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        niklas.cassel@wdc.com, joshi.k@samsung.com, javier@javigon.com,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] nvme: disallow passthru cmd from targeting a nsid
 != nsid of the block dev
Message-ID: <20210403081556.GA26879@lst.de>
References: <20210402201808.31979-1-nks@flawful.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210402201808.31979-1-nks@flawful.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So it turns out that while git-am complained it did apply the patch
just fine and it didn't look whitespace mangled.  No idea what went
on there, but the patch is in nvme-5.13 now.
