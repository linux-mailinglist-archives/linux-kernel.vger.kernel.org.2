Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28EAD42B96B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 09:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238561AbhJMHrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 03:47:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:58522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238509AbhJMHrs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 03:47:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1077660EDF;
        Wed, 13 Oct 2021 07:45:43 +0000 (UTC)
Date:   Wed, 13 Oct 2021 08:45:40 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memblock: exclude NOMAP regions from kmemleak
Message-ID: <YWaOpMhO6LoiiD+S@arm.com>
References: <20211013054756.12177-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013054756.12177-1-rppt@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 08:47:56AM +0300, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> Vladimir Zapolskiy reports:
> 
> commit a7259df76702 ("memblock: make memblock_find_in_range method private")
> invokes a kernel panic while running kmemleak on OF platforms with nomaped
> regions:
> 
>   Unable to handle kernel paging request at virtual address fff000021e00000
>   [...]
>     scan_block+0x64/0x170
>     scan_gray_list+0xe8/0x17c
>     kmemleak_scan+0x270/0x514
>     kmemleak_write+0x34c/0x4ac
> 
> Indeed, NOMAP regions don't have linear map entries so an attempt to scan
> these areas would fault.
> 
> Prevent such faults by excluding NOMAP regions from kmemleak.
> 
> Link: https://lore.kernel.org/all/8ade5174-b143-d621-8c8e-dc6a1898c6fb@linaro.org
> Fixes: a7259df76702 ("memblock: make memblock_find_in_range method private")
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> Tested-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
