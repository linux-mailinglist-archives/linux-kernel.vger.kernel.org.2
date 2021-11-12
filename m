Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C28244E384
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 09:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234630AbhKLI5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 03:57:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbhKLI5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 03:57:00 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF2FC061766;
        Fri, 12 Nov 2021 00:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qkqb8wjvU5XPR5JV1TM7oSNkeFocrJ6ggI1gff00Zq8=; b=NOwzkBMfrLheziPs8gVZzmUXGu
        hiZzMsT76A2U0UA6Q9lcdag/DkJsqS82fvDqikvHySDkmD6GcL4bXllAQwAoOE2uogkchGn+r5OY4
        ZoH+452cu8yi4g1xCSP2hsFnG1GqBcZttrQ7pr0oQpClsB513COR574p+Q9mpmeyilm7Xb31veraF
        nG9B1MhVq1FowmVMZoqQrSuo4dFWl7ir44/z7r5UNLOXVnIha/dxe6y4coELx6/zKENfdYuNjDEmw
        QsiA/PBj1r13+ETCg41d92doZwV4K8kku8ZFHkr1sI82Imuw1sO2+eBgyf6jTGb6OK6FctmZqz+bU
        dtagsK+w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mlSJs-009nEc-Tc; Fri, 12 Nov 2021 08:54:00 +0000
Date:   Fri, 12 Nov 2021 00:54:00 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Laibin Qiu <qiulaibin@huawei.com>
Cc:     axboe@kernel.dk, dennis@kernel.org, tj@kernel.org,
        bo.liu@linux.alibaba.com, josef@toxicpanda.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] blkcg: Remove extra blkcg_bio_issue_init
Message-ID: <YY4rqNbtVk/qud1s@infradead.org>
References: <20211112081006.3336263-1-qiulaibin@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211112081006.3336263-1-qiulaibin@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 12, 2021 at 04:10:06PM +0800, Laibin Qiu wrote:
>  	if (blk_throtl_bio(bio)) {
> -		blkcg_bio_issue_init(bio);
>  		return false;
>  	}

Please also drop the now superflous braces.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
