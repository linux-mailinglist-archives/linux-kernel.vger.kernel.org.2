Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD4AB369522
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 16:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242796AbhDWOxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 10:53:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:32936 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229871AbhDWOxP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 10:53:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9DE01B140;
        Fri, 23 Apr 2021 14:52:38 +0000 (UTC)
Subject: Re: [PATCH 2/6] mm/debug: Factor PagePoisoned out of __dump_page
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <20210416231531.2521383-1-willy@infradead.org>
 <20210416231531.2521383-3-willy@infradead.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <df134504-5bf6-5e6f-ec7c-d06aa6d2d1b1@suse.cz>
Date:   Fri, 23 Apr 2021 16:52:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210416231531.2521383-3-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/17/21 1:15 AM, Matthew Wilcox (Oracle) wrote:
> Move the PagePoisoned test into dump_page().  Skip the hex print
> for poisoned pages -- we know they're full of ffffffff.  Move the
> reason printing from __dump_page() to dump_page().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
