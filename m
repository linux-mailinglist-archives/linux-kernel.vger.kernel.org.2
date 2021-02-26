Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5C2326525
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 17:01:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbhBZQB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 11:01:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbhBZQBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 11:01:01 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 249C3C061574;
        Fri, 26 Feb 2021 08:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EamPPS3h7fVjeEpI3tKYviNwqcgB413i1NxGP8NfeLs=; b=DOVv70XUKQtdKygFHek5cnEJ85
        0aTTboqAAgZ9qXyU+wvlxiSzxHtP1ym4mKpFkpWJ3QrVxX0cg6HLjlMEa8smCT5d8MQt61EDedcdp
        +cTZQS6QIMEX7e410ahtRCLv73gL+enUpX0Wom3/7llnYOMvelDCfuonLeizIRAR1SdOneLRseMPl
        +1yqeJqd3wMbIB2+lHxnZefZs6Iwd3dwFPaxBSuzi7SJX4SRmj6HqKThuHBIGN0eQ78vYpHSlanSp
        RTjuTNxJkP+R1AKO1M0JYbI4J9klNvewkX6eyN/pVf5SdMMndMiYrQSVRic0CMcp8m3gG1o/L4yHJ
        PlEtnshw==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lFfXA-00CD8f-0u; Fri, 26 Feb 2021 16:00:04 +0000
Date:   Fri, 26 Feb 2021 16:00:04 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     linux-mm@kvack.org, nouveau@lists.freedesktop.org,
        bskeggs@redhat.com, akpm@linux-foundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, jhubbard@nvidia.com,
        rcampbell@nvidia.com, jglisse@redhat.com, jgg@nvidia.com,
        hch@infradead.org, daniel@ffwll.ch
Subject: Re: [PATCH v3 2/8] mm/swapops: Rework swap entry manipulation code
Message-ID: <20210226160004.GB2907711@infradead.org>
References: <20210226071832.31547-1-apopple@nvidia.com>
 <20210226071832.31547-3-apopple@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210226071832.31547-3-apopple@nvidia.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 26, 2021 at 06:18:26PM +1100, Alistair Popple wrote:
> Both migration and device private pages use special swap entries which
> are manipluated by a range of inline functions. The arguments to these
> are somewhat inconsitent so rework them to remove flag type arguments
> and to make the arguments similar for both a read and write entry
> creation.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
