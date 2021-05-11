Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEF5737AC67
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 18:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbhEKQwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 12:52:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:32790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230315AbhEKQw2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 12:52:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 091D2613C6;
        Tue, 11 May 2021 16:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620751881;
        bh=36FOm/vubAEI0n2qxF3dc7ltKmZVubRWdCsf6LaDk8s=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=gO6+6kWfZzUSTxw2kbO6cTxuKglMDkF/V6jBMXaPjqGwC1vBJlt8oRXf2y22D/D/f
         h3ec4bZ36ZUQLYx/+rueldWcwYZZpjBrrmxaP1NLduZWCtgnykKt6u3Tq8Gm1NXu6Q
         IwjAhx5NWHNz/FkO71dMPx57gAvY1vNnR9hCwcTuaKoclxxteV1TOIbesBucfqhIMl
         1z6IZRpACDIot0Pg/Rth55+IITCQvd3xDbZdxucxGL2+3QSYBhPzAbTfiSYoRb5nTE
         1BwXhe9J4XZND5YgTRauuZ4YronUvWPzodXuoWixRNBKwHhMpiAhANdOcQhps6tn8Z
         Qa6gavxx/4WYA==
Date:   Tue, 11 May 2021 09:51:20 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To:     Christoph Hellwig <hch@lst.de>
cc:     Stefano Stabellini <sstabellini@kernel.org>,
        Julien Grall <julien@xen.org>, f.fainelli@gmail.com,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        linux-kernel@vger.kernel.org,
        osstest service owner <osstest-admin@xenproject.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        iommu@lists.linux-foundation.org
Subject: Re: Regression when booting 5.15 as dom0 on arm64 (WAS: Re: [linux-linus
 test] 161829: regressions - FAIL)]
In-Reply-To: <20210511164933.GA19775@lst.de>
Message-ID: <alpine.DEB.2.21.2105110950580.5018@sstabellini-ThinkPad-T480s>
References: <osstest-161829-mainreport@xen.org> <4ea1e89f-a7a0-7664-470c-b3cf773a1031@xen.org> <20210510084057.GA933@lst.de> <alpine.DEB.2.21.2105101818260.5018@sstabellini-ThinkPad-T480s> <20210511063558.GA7605@lst.de> <alpine.DEB.2.21.2105110925430.5018@sstabellini-ThinkPad-T480s>
 <20210511164933.GA19775@lst.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 May 2021, Christoph Hellwig wrote:
> On Tue, May 11, 2021 at 09:47:33AM -0700, Stefano Stabellini wrote:
> > That's a much better plan. It is also not super urgent, so maybe for now
> > we could add an explicit check for io_tlb_default_mem != NULL at the
> > beginning of xen_swiotlb_init? So that at least we can fail explicitly
> > or ignore it explicitly rather than by accident.
> 
> Fine with me.  Do you want to take over from here and test and submit
> your version?

I can do that. Can I add your signed-off-by for your original fix?
