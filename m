Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85124316024
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 08:39:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232783AbhBJHip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 02:38:45 -0500
Received: from verein.lst.de ([213.95.11.211]:49660 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232484AbhBJHim (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 02:38:42 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id EACAD67373; Wed, 10 Feb 2021 08:37:59 +0100 (CET)
Date:   Wed, 10 Feb 2021 08:37:59 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Filippo Sironi <sironi@amazon.de>
Cc:     serebrin@amazon.com, dwmw@amazon.co.uk, benh@amazon.com,
        kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] nvme: Add 48-bit DMA address quirk for Amazon NVMe
 controllers
Message-ID: <20210210073759.GA23269@lst.de>
References: <20210203094338.19473-1-sironi@amazon.de> <20210210003942.25700-1-sironi@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210003942.25700-1-sironi@amazon.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 01:39:42AM +0100, Filippo Sironi wrote:
> Amazon NVMe controllers do not support 64-bit DMA addresses; they are
> limited to 48-bit DMA addresses.  Let's add a quirk to ensure that we
> make use of 48-bit DMA addresses to avoid misbehavior.

This should probably say some, and mention that they do not follow
the spec.  But I can fix this up when applying the patch.
