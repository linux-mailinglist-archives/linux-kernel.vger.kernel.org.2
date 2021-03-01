Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A060B3278A7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 08:56:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232655AbhCAHym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 02:54:42 -0500
Received: from verein.lst.de ([213.95.11.211]:52655 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232644AbhCAHyh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 02:54:37 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1CE7E68BEB; Mon,  1 Mar 2021 08:53:53 +0100 (CET)
Date:   Mon, 1 Mar 2021 08:53:52 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-mm@kvack.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Generalize HUGETLB_PAGE_SIZE_VARIABLE
Message-ID: <20210301075352.GA27659@lst.de>
References: <1614577853-7452-1-git-send-email-anshuman.khandual@arm.com> <20210301062358.GA25761@lst.de> <89f2d77c-f4bc-8f7b-a6b0-1c04e422fb77@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89f2d77c-f4bc-8f7b-a6b0-1c04e422fb77@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 01, 2021 at 01:13:41PM +0530, Anshuman Khandual wrote:
> > doesn't this need a 'if HUGETLB_PAGE'
> 
> While making HUGETLB_PAGE_SIZE_VARIABLE a generic option, also made it
> dependent on HUGETLB_PAGE. Should not that gate HUGETLB_PAGE_SIZE_VARIABLE
> when HUGETLB_PAGE is not available irrespective of the select statement on
> the platforms ?

depends doesn't properly work for variables that are selected.
