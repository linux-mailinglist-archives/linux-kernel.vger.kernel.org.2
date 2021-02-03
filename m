Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA02130D8AA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 12:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234398AbhBCL3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 06:29:13 -0500
Received: from verein.lst.de ([213.95.11.211]:50696 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234158AbhBCL12 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 06:27:28 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0361B67357; Wed,  3 Feb 2021 12:26:46 +0100 (CET)
Date:   Wed, 3 Feb 2021 12:26:45 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Filippo Sironi <sironi@amazon.de>
Cc:     Christoph Hellwig <hch@lst.de>, serebrin@amazon.com,
        dwmw@amazon.co.uk, kbusch@kernel.org, axboe@fb.com,
        sagi@grimberg.me, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: Add 48-bit DMA address quirk
Message-ID: <20210203112645.GA11942@lst.de>
References: <20210203094338.19473-1-sironi@amazon.de> <20210203095148.GA8897@lst.de> <0c38f5eb-41ef-7934-940b-77b6e73c5239@amazon.de> <20210203111548.GA11075@lst.de> <396b45d5-3dd5-8159-34c2-5668510d1d68@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <396b45d5-3dd5-8159-34c2-5668510d1d68@amazon.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 03, 2021 at 12:22:31PM +0100, Filippo Sironi wrote:
> To avoid issues, it is easier to apply the quirk to all Amazon NVMe 
> controllers for now till the new lines of controllers with the fix comes 
> out.  At that point, we'll be able to restrict the application to the known 
> bad controllers.

No, that is simply not acceptable.  For one we've had enough cases where
knowlege about old devices was lost after a decade or so.  And secondly
shipping more of these broken devices should be as painful as possible
for you so that it preferably does not happen at all.
