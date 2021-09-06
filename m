Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2DC401816
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 10:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240865AbhIFIgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 04:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240795AbhIFIgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 04:36:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E10D2C061757
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 01:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M+/O7ce821iiv/HQnnFyTTL95PlfizLtv6Lr+/8yGMI=; b=lefMWr6RI+jmJrbDQu9reFQL5a
        iiwNf/2yk1p6vH/8lCgxDDG/hfCx9g8w4LeW6sKc1YcNoeCj+y+WJf9oTawZY0IyldeRltV332WhA
        RhEZ5gjHjOxYFw8RmaXI38keCcR24t17ApC+fmMUEW2x3TOfH6UMUCpgfLlPxVP94up0NDtxyeivm
        mFyHURTuZ27NlS7eQH7x8LOc2KWpMzdOqSyL5/nUuwK2W1v0M6sHzqK7PY+WOTW8Nbo7PovkRJRdS
        0fE0RRUg8ih4FHHhhVbK0ikghXAQKkvprxzsCjAk+V2GjYGPu4MxdZQEJRZwC/+R5Qhok4yNmRiFy
        ZlUuyZqg==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mNA4V-006mUT-8w; Mon, 06 Sep 2021 08:33:56 +0000
Date:   Mon, 6 Sep 2021 09:33:43 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Phillip Potter <phil@philpotter.co.uk>
Cc:     axboe@kernel.dk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cdrom: update uniform CD-ROM maintainership in
 MAINTAINERS file
Message-ID: <YTXSZ0HNd+vVJW+0@infradead.org>
References: <20210903213011.1319-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210903213011.1319-1-phil@philpotter.co.uk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Can you please also add the linux-block list to the entry?  I think we
should have all the CD-ROM bits on this list instead of disappearing
into the linux-kernel void.
