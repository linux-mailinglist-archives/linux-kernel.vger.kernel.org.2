Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8EF83D260A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 16:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbhGVOD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 10:03:29 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:34754 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230343AbhGVOD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 10:03:28 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 16MEhiTZ010171
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Jul 2021 10:43:45 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 9126515C37C0; Thu, 22 Jul 2021 10:43:44 -0400 (EDT)
Date:   Thu, 22 Jul 2021 10:43:44 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Qualys Security Advisory <qsa@qualys.com>,
        Eric Sandeen <sandeen@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Make kvmalloc refuse to allocate more than 2GB
Message-ID: <YPmEIAQWUD4i/aPR@mit.edu>
References: <20210721184131.2264356-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210721184131.2264356-1-willy@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 21, 2021 at 07:41:31PM +0100, Matthew Wilcox (Oracle) wrote:
> It's generally dangerous to allocate such large quantities of memory
> within the kernel owing to our propensity to use 'int' to represent
> a length.  If somebody really needs it, we can add a kvmalloc_large()
> later, but let's default to "You can't allocate that much memory".

If we really need it, maybe we can add a GFP_LARGE_ALLOC to allow
allocations larger than 2GB later on?  I can't quite see why that
would ever be needed, but that's probably a failure of my imagination.  :-)

      	      	      	  	 - Ted
