Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA3D38E1DC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 09:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232381AbhEXHif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 03:38:35 -0400
Received: from verein.lst.de ([213.95.11.211]:53564 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232266AbhEXHie (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 03:38:34 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5756668AFE; Mon, 24 May 2021 09:37:05 +0200 (CEST)
Date:   Mon, 24 May 2021 09:37:03 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Keith Busch <kbusch@kernel.org>, Daniel Wagner <dwagner@suse.de>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] nvme: Use NN for max_namespaces if MNAN is zero
Message-ID: <20210524073703.GA24372@lst.de>
References: <20210521144734.90044-1-dwagner@suse.de> <20210521145306.ld7jc6alchimyzny@beryllium.lan> <20210521152702.GB29013@redsun51.ssa.fujisawa.hgst.com> <f89bf79e-937c-96ba-4622-4a29fce00b0e@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f89bf79e-937c-96ba-4622-4a29fce00b0e@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2021 at 01:19:26PM -0700, Sagi Grimberg wrote:
>
>>> Forgot to mention: During testing dynamically adding namespaces it was
>>> possible to trigger the WARNINGs in the nvme_parse_ana_log(). Initially
>>> the subsystem started with 8 namespaces and during runtime another 8
>>> namespaces was added.
>>
>> The controller is required to have a non-zero MNAN value if it supports
>> ANA:
>>
>>    If the controller supports Asymmetric Namespace Access Reporting, then
>>    this field shall be set to a non-zero value that is less than or equal
>>    to the NN value.
>
> That was my thought exactly

I think we should add a sanity check for that and reject the broken
controller if that is not the case rather than working around it.
