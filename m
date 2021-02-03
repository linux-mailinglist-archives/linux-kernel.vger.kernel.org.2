Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03CA930D84A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 12:17:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234099AbhBCLQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 06:16:33 -0500
Received: from verein.lst.de ([213.95.11.211]:50646 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234046AbhBCLQb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 06:16:31 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id ACA1067357; Wed,  3 Feb 2021 12:15:48 +0100 (CET)
Date:   Wed, 3 Feb 2021 12:15:48 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Filippo Sironi <sironi@amazon.de>
Cc:     Christoph Hellwig <hch@lst.de>, serebrin@amazon.com,
        dwmw@amazon.co.uk, kbusch@kernel.org, axboe@fb.com,
        sagi@grimberg.me, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: Add 48-bit DMA address quirk
Message-ID: <20210203111548.GA11075@lst.de>
References: <20210203094338.19473-1-sironi@amazon.de> <20210203095148.GA8897@lst.de> <0c38f5eb-41ef-7934-940b-77b6e73c5239@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c38f5eb-41ef-7934-940b-77b6e73c5239@amazon.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 03, 2021 at 12:12:31PM +0100, Filippo Sironi wrote:
> I don't disagree on the first part of your sentence, this is a big 
> oversight.

But it is not what your commit log suggests.

> On the other hand, those controllers are out there and are in use by a lot 
> of customers.  We can keep relying on luck, hoping that customers don't run 
> into troubles or we can merge a few lines of code :)

Your patch does not just quirk a few controllers out there, but all
current and future controllers with an Amazon vendor ID.  We could
probably talk about quirking an existing vendor ID or two as long as
this doesn't happen for future hardware.
