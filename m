Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75FE33D2AAB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 19:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235107AbhGVQRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 12:17:15 -0400
Received: from verein.lst.de ([213.95.11.211]:35149 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231166AbhGVQNK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 12:13:10 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9F5F167373; Thu, 22 Jul 2021 18:53:42 +0200 (CEST)
Date:   Thu, 22 Jul 2021 18:53:42 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Andreas Gruenbacher <andreas.gruenbacher@gmail.com>
Subject: Re: [PATCH v6] iomap: support tail packing inline read
Message-ID: <20210722165342.GA11435@lst.de>
References: <20210722031729.51628-1-hsiangkao@linux.alibaba.com> <20210722053947.GA28594@lst.de> <20210722165109.GD8639@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210722165109.GD8639@magnolia>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 22, 2021 at 09:51:09AM -0700, Darrick J. Wong wrote:
> The commit message is a little misleading -- this adds support for
> inline data pages at nonzero (but page-aligned) file offsets, not file
> offsets into the page itself.  I suggest:

It actually adds both.  pos is the offset into the file.
