Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAF5D3EC176
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 10:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237574AbhHNIyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 04:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237272AbhHNIyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 04:54:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F374C06175F
        for <linux-kernel@vger.kernel.org>; Sat, 14 Aug 2021 01:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QYtBZcQe1AYKFmFlbIK09tv77w22darIoGRUI9QRx4Q=; b=h8VSaeKeTYKSUjNY2+l/UHQ+hH
        f76xrh1QUEmye8pmdbUDzToCSsMGGiAZ4xmxxAJsqcQ219C5QxCPU0HYdXxEuZE0y0CbN3MGsqNOt
        d0PTDgfgmqjh/cII/Tnj9BjS6H1epuL1VyGBkXZK6p6wg/xBs0l6ZolEugo80fd2kbGb3dsoIs88f
        3SY91mqS1QRY2SxzwIZQ1cReuyXfhPjzXtGbu0ORczogDVGacAtveaAucXMWehWfP3sFto2niuJmJ
        c4l64TiUm1GbMS9nvSzVk/a6PBYDmbzSYOCS6iTB5I3qrJUyZV43B5whiyuzOXWjWODrIGOTthy0D
        0qjhj08Q==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mEpPN-00GYAD-K5; Sat, 14 Aug 2021 08:53:03 +0000
Date:   Sat, 14 Aug 2021 09:52:49 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     jaegeuk@kernel.org, chao@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] f2fs: introduce proc/fs/f2fs/<dev>/fsck_stack node
Message-ID: <YReEYTPl5ErJNiyj@infradead.org>
References: <20210813123221.185591-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210813123221.185591-1-frank.li@vivo.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please don't add new non-process files to procfs.
