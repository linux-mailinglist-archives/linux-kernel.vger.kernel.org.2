Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88BC93F5FCF
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 16:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237558AbhHXOFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 10:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237451AbhHXOFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 10:05:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52938C061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 07:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Z5ZhwVX2hcxbnxUcTQcxvFWV7vbWD52vHQ50IYDMAbo=; b=scErgCctxKhX0mDZl1c/UqjgxF
        SbVD70nuog5HtV0ObBDyjeyKhDLSft+/DQrtJy3FIrgqewrQoq4CjihyvE/vPVXJxX2YTZwzJjg/R
        +x7FqKsJItPnJLXFQOfl/ObLyGITa6uW6sugtpUFkjrpS/LZoIeTtse+mxq4KuGs1Sx+ut7ODKTqK
        X4l7K4Wtc4bCer/Sl37QjALe6M3VQEtc6DEbPU99MRzhIpRiGxKaqswOrVl9pTQjR0Kd8DvFZYum0
        BRCOtAIxDWRyR8htxrKhvvW56fnrPgpOZeQiVoJyWQUWDzoZZswOsCcCeI6Yh4LRLWnF4wtve2Brm
        ozKhvRTQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mIWyH-00B8M4-Qh; Tue, 24 Aug 2021 14:00:37 +0000
Date:   Tue, 24 Aug 2021 15:00:09 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v3] nvme: revalidate paths during rescan
Message-ID: <YST7adHFG0XLlPVG@infradead.org>
References: <20210811152803.30017-1-dwagner@suse.de>
 <93e8d113-55bb-e859-bf3d-54433dd23683@grimberg.me>
 <20210824134457.x33n7ihoe23jhyfx@carbon.lan>
 <20210824134830.gdl4vojwhlsoypne@carbon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210824134830.gdl4vojwhlsoypne@carbon.lan>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2021 at 03:48:30PM +0200, Daniel Wagner wrote:
> I am blind. The patch is queued up in nvme-5.15.
> 
> @Christoph, do you want me to send fix on top of this patch or do you
> want an updated version of this patch?

Either way is fine.
