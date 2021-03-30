Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E84C234ED50
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 18:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231812AbhC3QRg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 12:17:36 -0400
Received: from verein.lst.de ([213.95.11.211]:59533 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231951AbhC3QRR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 12:17:17 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4252368B05; Tue, 30 Mar 2021 18:17:15 +0200 (CEST)
Date:   Tue, 30 Mar 2021 18:17:15 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Joel Stanley <joel@jms.id.au>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Christoph Hellwig <hch@lst.de>,
        "William A . Kennington III" <wak@google.com>,
        Lei YU <mine260309@gmail.com>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] jffs2: Hook up splice_write callback
Message-ID: <20210330161715.GA12783@lst.de>
References: <20210330134537.423447-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210330134537.423447-1-joel@jms.id.au>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31, 2021 at 12:15:37AM +1030, Joel Stanley wrote:
> overlayfs using jffs2 as the upper filesystem would fail in some cases
> since moving to v5.10. The test case used was to run 'touch' on a file
> that exists in the lower fs, causing the modification time to be
> updated. It returns EINVAL when the bug is triggered.
> 
> A bisection showed this was introduced in v5.9-rc1, with commit
> 36e2c7421f02 ("fs: don't allow splice read/write without explicit ops").
> Reverting that commit restores the expected behaviour.
> 
> Some digging showed that this was due to jffs2 lacking an implementation
> of splice_write. (For unknown reasons the warn_unsupported that should
> trigger was not displaying any output).
> 
> Adding this patch resolved the issue and the test now passes.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
