Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10225305A60
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 12:53:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237404AbhA0Lwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 06:52:38 -0500
Received: from 8bytes.org ([81.169.241.247]:53114 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234383AbhA0Ltu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 06:49:50 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 0E5ED303; Wed, 27 Jan 2021 12:49:08 +0100 (CET)
Date:   Wed, 27 Jan 2021 12:49:06 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     trix@redhat.com
Cc:     will@kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/amd: remove h from printk format specifier
Message-ID: <20210127114906.GE32671@8bytes.org>
References: <20201215213021.2090698-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201215213021.2090698-1-trix@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 15, 2020 at 01:30:21PM -0800, trix@redhat.com wrote:
>  drivers/iommu/amd/init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.
