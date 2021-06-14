Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89D183A6601
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 13:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235922AbhFNLsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 07:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236310AbhFNLrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 07:47:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544B0C061574
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 04:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tER/9yntskfsYogplE2UHT4/vwtYhzr4VR/dY/qdVM8=; b=B4dNlMd7n3ZdsQUA7uiwxajkWN
        RVQzR1mW9siJ4BN91NHDdVQpiyw763JpbznjXtkj34vQLwTId3IF1HFPgzX2Q8thstZtuTNbdUabg
        povYqKd8eHLH1np7mG+s76KQDLk8fp7Z/W5afpMQlwD4+Ll1hHLT7crV6IbFpVZZNtq1c62Mi1cNg
        nh0lLdCRQ16L8wTC+yKKpZYbCUyfbXt51ERWGC6nJNnqJzyr+atsfgnv3SfcdpLBryAeDp2ewJoMY
        0CwpWNFkg1FwrZqITsGv9yQJuc/amquo8TEIQOaqGrhm1HJqe/jUG/JpOIxDa1P7uMYeuSWppMhBH
        q7dLiYGA==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lsl0S-005N7K-G0; Mon, 14 Jun 2021 11:43:55 +0000
Date:   Mon, 14 Jun 2021 12:43:52 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org, sudeep.holla@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com,
        igor.skalkin@opensynergy.com, peter.hilber@opensynergy.com,
        alex.bennee@linaro.org, jean-philippe@linaro.org,
        mikhail.golubev@opensynergy.com, anton.yakovlev@opensynergy.com,
        Vasyl.Vavrychuk@opensynergy.com,
        Andriy.Tryshnivskyy@opensynergy.com
Subject: Re: [PATCH v4 00/16] Introduce SCMI VirtIO transport
Message-ID: <YMdA+GkgJ+GONuJr@infradead.org>
References: <20210611165937.701-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210611165937.701-1-cristian.marussi@arm.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 11, 2021 at 05:59:21PM +0100, Cristian Marussi wrote:
> Hi all,
> 
> I'm posting this V4 series starting from the work done up to V3 by
> OpenSynergy.

Who is 'OpenSynergy'?

> The main aim of this rework is to simplify where possible the SCMI VirtIO
> support added in V3 by adding upfront and then using some new mechanisms in
> the SCMI Core Transport layer.

And what is 'SCMI', and why would anyone want a new virtio transport?
