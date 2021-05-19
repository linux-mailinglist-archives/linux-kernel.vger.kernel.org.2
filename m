Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD95A389458
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 19:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355505AbhESRE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 13:04:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:45904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240979AbhESREy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 13:04:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9A1E66135C;
        Wed, 19 May 2021 17:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1621443813;
        bh=Olyw21P4gzzcLjjpXAzSOHmFYpToPxKOVR/ePBRl0IE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oEkSOTi8nA7PUrLaKt7CXH4oal0HVwVfXNhChNHTueimplNlkVtYwMzgVEQZkO+Xf
         huUvKFqDlu3NL+labUJ7sfGCO1mFvWyTFgvUCvRUI3Ez7aJkh7sYSYE5mzUciIUKRf
         X33qPAnKT+FAyHBmPO5e4vcvD+2/6li8Jb3XVf7s=
Date:   Wed, 19 May 2021 10:03:33 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: remove devm_request_free_mem_region
Message-Id: <20210519100333.b8255cf48fb5d43cc33accfb@linux-foundation.org>
In-Reply-To: <20210518063922.2910123-1-hch@lst.de>
References: <20210518063922.2910123-1-hch@lst.de>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 May 2021 08:39:22 +0200 Christoph Hellwig <hch@lst.de> wrote:

> Remove the unused devm_request_free_mem_region

drivers/gpu/drm/amd/amdkfd/kfd_migrate.c in -next added a new
callsite :(   What's the fix?
