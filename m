Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC70B3BC358
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 22:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbhGEUS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 16:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbhGEUS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 16:18:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B4DC061574
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jul 2021 13:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cHJoMBPoqsS6VIVZNAuTsCESFJ7feq3dFA9cLcq4xmA=; b=D1zngPFjaraCLiltD0U9yxBX5A
        kIMC9/R+DfJbPFWbxRozfUqe9136feg/Kr6BoNXvWvtm/XIW9SwZy3izXGiMYCgWX+Ym70KenbpQe
        ezSvZvnaCC45B/8btVNs0RScJA+xPsaH6ZVm//YELSSSRsIGiF/n9SEIf64hLzXAtyhalxU1R49UP
        APxCJJwB0JQTQbNK9VuINLaYN0QwlCF3ghVn6R29hMefxMlqdcbOhE9Xc/XZ37+y+6n/GVaUfnOog
        ZzedbwMTrw5xZZIGrhjzjZrDMftyygVn/lfgKTBG1X6Yo/v6gs0hubZQs35II+taREN02/LF6NSzi
        F03mz0wQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m0V02-00AZ6w-Fs; Mon, 05 Jul 2021 20:15:36 +0000
Date:   Mon, 5 Jul 2021 21:15:26 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Gao Xiang <xiang@kernel.org>
Cc:     linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 2/2] erofs: directly traverse pages in
 z_erofs_readahead()
Message-ID: <YONoXm1ksYgWWi/r@casper.infradead.org>
References: <20210705183253.14833-1-xiang@kernel.org>
 <20210705183253.14833-2-xiang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210705183253.14833-2-xiang@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 06, 2021 at 02:32:53AM +0800, Gao Xiang wrote:
> In that way, pages can be accessed directly with xarray.

I didn't mean "open code readahead_page()".  I meant "Wouldn't it be
great if z_erofs_do_read_page() used readahead_expand() in order to
allocate the extra pages in the extents that cover the start and end of
the requested chunk".  That way the pages would already be in the page
cache for subsequent reads.

