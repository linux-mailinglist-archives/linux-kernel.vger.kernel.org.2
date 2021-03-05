Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD7F32E7BB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 13:13:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbhCEMMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 07:12:52 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:45505 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229493AbhCEMMZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 07:12:25 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4DsRSN3xc3z9sWL;
        Fri,  5 Mar 2021 23:12:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1614946342;
        bh=aHL61nbJ14YVMtmcKw3QkQlg65ehKSOR2fQhnK5ASNM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=RFYtcy26f5gmzrJqSk1tcWhWWPFLaSE81tlUXQAhECBh8eMXEYNMO5tZ9x4rlR8jh
         aNvIJrxJ/KmdEYHZknj6TSuxKWmFcA5Ahn5HuXY6RKlHn0zLhKnT3RXI/3y38ia5MS
         JkNgJS5vB2TLrVgU75ml8aRn1avbmPb42hmMFoIyONZ0zH2RQ66HoBu5hckN36yYSX
         c6IsYOwVt0tKTVEy8CRxFy0qXSx2/aGRzvp/C0J5lSsB+Qj6mO71whKVsYAjDwlnEr
         ADmQCjQyL7/fhfJQsTxKjOIZ/Fp8LwqKPrnZuuqyFhzKrTE5Anp2GVIzL4dN/VvP3R
         QdNjEwMOMox4A==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] mm: Generalize HUGETLB_PAGE_SIZE_VARIABLE
In-Reply-To: <1614914928-22039-1-git-send-email-anshuman.khandual@arm.com>
References: <1614914928-22039-1-git-send-email-anshuman.khandual@arm.com>
Date:   Fri, 05 Mar 2021 23:12:17 +1100
Message-ID: <87pn0dre8u.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Anshuman Khandual <anshuman.khandual@arm.com> writes:
> HUGETLB_PAGE_SIZE_VARIABLE need not be defined for each individual
> platform subscribing it. Instead just make it generic.
>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: linux-ia64@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> This change was originally suggested in an earilier discussion. This
> applies on v5.12-rc1 and has been build tested on all applicable
> platforms i.e ia64 and powerpc.
>
> https://patchwork.kernel.org/project/linux-mm/patch/1613024531-19040-3-git-send-email-anshuman.khandual@arm.com/
>
> Changes in V3:
>
> - Dropped the bool desciption that enabled user selection
> - Dropped the dependency on HUGETLB_PAGE for HUGETLB_PAGE_SIZE_VARIABLE
>
> Changes in V2:
>
> https://patchwork.kernel.org/project/linux-mm/patch/1614661987-23881-1-git-send-email-anshuman.khandual@arm.com/
>
> - Added a description for HUGETLB_PAGE_SIZE_VARIABLE
> - Added HUGETLB_PAGE dependency while selecting HUGETLB_PAGE_SIZE_VARIABLE
>
> Changes in V1:
>
> https://patchwork.kernel.org/project/linux-mm/patch/1614577853-7452-1-git-send-email-anshuman.khandual@arm.com/
>
>  arch/ia64/Kconfig    | 6 +-----
>  arch/powerpc/Kconfig | 6 +-----

LGTM.

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers
