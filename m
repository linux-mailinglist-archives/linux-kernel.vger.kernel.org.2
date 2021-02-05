Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8996A310ADF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 13:06:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbhBEMFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 07:05:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:47360 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232152AbhBEMCv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 07:02:51 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8EF68ADE3;
        Fri,  5 Feb 2021 12:02:08 +0000 (UTC)
Subject: Re: [PATCH v2] mm/page_owner: Record the timestamp of all pages
 during free
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        akpm@linux-foundation.org, linux-mm@kvack.org
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210203175905.12267-1-georgi.djakov@linaro.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <db54c41c-2bb2-43e8-eb0d-5869a5cff10f@suse.cz>
Date:   Fri, 5 Feb 2021 13:02:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210203175905.12267-1-georgi.djakov@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/3/21 6:59 PM, Georgi Djakov wrote:
> Collect the time when each allocation is freed, to help with memory
> analysis with kdump/ramdump. Add the timestamp also in the page_owner
> debugfs file and print it in dump_page().
> 
> Having another timestamp when we free the page helps for debugging
> page migration issues. For example both alloc and free timestamps
> being the same can gave hints that there is an issue with migrating
> memory, as opposed to a page just being dropped during migration.
> 
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

Thanks.
