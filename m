Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46A583C9959
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 09:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237859AbhGOHHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 03:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbhGOHHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 03:07:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFEBCC06175F;
        Thu, 15 Jul 2021 00:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=UnV8xCRrF3G+u1AN+ZvRgn/CJr
        FXucuD+RDoI8fY2Uky0338EvscYQ5DVrUqub9pKHU3hHTPhb/sE1xMM66dpMBIQPBiJeXMW4bOWq0
        0wDZYWj54515CUFytAfJXeijFIho3qFMmBlcj7j2VRQwjeoDpM1DdYtQ4uArv2AY6CQPrbKCdjsoa
        HfnTtAubv3pxGINzzZ0sx05q0svegwvk5XMDxC7ZHtKfDmBiP0PKqtVqlSlkBaizkS1f7Uoz5+rtb
        wxPlG6+tg5I2bWfmay3mLTETgPXXmgkgxg7mJKfhVR5TGGuzasSF0JBvmOOa8wZC3E4IDUYeqHiS7
        6/lvPDrw==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3vOK-00352z-6h; Thu, 15 Jul 2021 07:02:49 +0000
Date:   Thu, 15 Jul 2021 08:02:40 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     axboe@kernel.dk, hare@suse.de, bvanassche@acm.org,
        ming.lei@redhat.com, hch@infradead.org, jack@suse.cz,
        osandov@fb.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] block: refcount the request_queue early in
 __device_add_disk()
Message-ID: <YO/dkNzKlRAQq18E@infradead.org>
References: <20210715045531.420201-1-mcgrof@kernel.org>
 <20210715045531.420201-2-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715045531.420201-2-mcgrof@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
