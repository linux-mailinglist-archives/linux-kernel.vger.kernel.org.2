Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C48E538948A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 19:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355589AbhESRTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 13:19:10 -0400
Received: from verein.lst.de ([213.95.11.211]:39227 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242519AbhESRTH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 13:19:07 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8D00767373; Wed, 19 May 2021 19:17:45 +0200 (CEST)
Date:   Wed, 19 May 2021 19:17:45 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: remove devm_request_free_mem_region
Message-ID: <20210519171745.GA12070@lst.de>
References: <20210518063922.2910123-1-hch@lst.de> <20210519100333.b8255cf48fb5d43cc33accfb@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210519100333.b8255cf48fb5d43cc33accfb@linux-foundation.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2021 at 10:03:33AM -0700, Andrew Morton wrote:
> On Tue, 18 May 2021 08:39:22 +0200 Christoph Hellwig <hch@lst.de> wrote:
> 
> > Remove the unused devm_request_free_mem_region
> 
> drivers/gpu/drm/amd/amdkfd/kfd_migrate.c in -next added a new
> callsite :(   What's the fix?

Just drop the removal then.
