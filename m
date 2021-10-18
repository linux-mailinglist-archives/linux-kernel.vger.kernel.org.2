Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B947431212
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 10:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbhJRIXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 04:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbhJRIXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 04:23:11 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A189C06161C;
        Mon, 18 Oct 2021 01:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hcBrJIfX8KRG2y624/3+06nv2sO8QewOZ0r46Ig7gv4=; b=k9tK5SH7oPrpZoslvPkWh+8I8v
        DoLD7hprHMc8sniAebV0jgWUfqAnXp5vsAqTxsW4l9jCI+w8MaoC2ngJMcPFEDWrntK8LH2TQ7m6j
        2ECb6cA5QZWESl/dAjjs4uPxigyVQQNB8B3+fq2E5tizhsoKc7YKVm7zq4RsR9azwfzk5W3DLF75p
        hC8qGcVMPL0pJMlg+qBApfJLlDJEV91iqJPHGB7enTDr0Q/UWbt8HyZl0H0QW4pWZ1sqThoUUkz+s
        D8LSUhmLluk+8fpfS+XSppr3V5XIFnxjGBHs3u0r+KQDbprpLCRMmhuQjHp06Ofy9Dg/N2F7Q1hd5
        wrfiSkpw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mcNtB-00EcnB-Gt; Mon, 18 Oct 2021 08:20:57 +0000
Date:   Mon, 18 Oct 2021 01:20:57 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Pavel Begunkov <asml.silence@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 0/5] cache request_queue pointer
Message-ID: <YW0uaa+5E07MWDZI@infradead.org>
References: <cover.1634219547.git.asml.silence@gmail.com>
 <dba463cb-3f1e-0972-aeaf-099d7c12bd0e@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dba463cb-3f1e-0972-aeaf-099d7c12bd0e@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 17, 2021 at 06:59:22AM -0600, Jens Axboe wrote:
> > All patches are self contained and don't rely on others from
> > the set including 1/5 and can be taken separately. And some
> > changes go in separate patches to minimise conflicts. When
> > we agree on the approach, I'll send the rest converting some
> > other spots out of block.
> 
> Looks fine to me. Christoph, any concerns?

No huge fan of the extra pointer, but if it helps.. 
