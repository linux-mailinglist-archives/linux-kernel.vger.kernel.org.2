Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF8E3F06AF
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 16:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238593AbhHRO1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 10:27:54 -0400
Received: from verein.lst.de ([213.95.11.211]:34110 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233320AbhHRO1x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 10:27:53 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id E380967373; Wed, 18 Aug 2021 16:27:15 +0200 (CEST)
Date:   Wed, 18 Aug 2021 16:27:15 +0200
From:   'Christoph Hellwig' <hch@lst.de>
To:     Brian Cain <bcain@codeaurora.org>
Cc:     'Christoph Hellwig' <hch@lst.de>, iommu@lists.linux-foundation.org,
        'Russell King' <linux@armlinux.org.uk>,
        'Dillon Min' <dillon.minfei@gmail.com>,
        'Vladimir Murzin' <vladimir.murzin@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org,
        "'Manning, Sid'" <sidneym@quicinc.com>
Subject: Re: [PATCH 7/7] hexagon: use the generic global coherent pool
Message-ID: <20210818142715.GA10755@lst.de>
References: <20210712061704.4162464-1-hch@lst.de> <20210712061704.4162464-8-hch@lst.de> <00a901d790af$b05165c0$10f43140$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00a901d790af$b05165c0$10f43140$@codeaurora.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,

I've pulled the whole series into the dma-mapping for-next tree.
