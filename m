Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A87D3372005
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 20:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbhECS6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 14:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbhECS6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 14:58:03 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2073DC061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 May 2021 11:57:10 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id q2so4862500pfh.13
        for <linux-kernel@vger.kernel.org>; Mon, 03 May 2021 11:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/pily0HpN1x5+Ozbgf6AOQkMDZLIvNBV5p8HbBJ96dI=;
        b=d5N4+y207tw1B9Ars4YNORHt0h3gnQOoXM3ES9WAA/lO79LZGqIwCTSvSH5JZu2c/Q
         TAu09194W735k/O/vCx+1RXBEml/OzMJQyJAD8hqf88zVvc2A+WNQdNi3rG4VcaD7bvm
         1KAd6aZjWC8PcDSHk933ba4TmOGp2OPCPTp0/rqI4fOSdKcPqLgk8fyK1Ds7hyyKS15K
         Fcp0rhJkSH7yIzch4TRqg+SmSBApiLXbblODsn9P/bkfpnnP25pCIAF/BzvjWKU6SPkk
         cmTC6+5lC7VZg0m4WYCazPOUDTaSUQmgR5tMS/RmwIri8mmGuxi2g2lAUP8JKY4iOcgp
         P+7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/pily0HpN1x5+Ozbgf6AOQkMDZLIvNBV5p8HbBJ96dI=;
        b=eguNWyHJYdpPWdKV8BoEvFrQpg7LSxji4TIObDwZGqXepVqLtRKUbML7sVbwkrEQuj
         E6Ww4O8M0cj6YyhYhyqF3irKCDQRwJFA+B73Bh4qNka+GGUMdrsPg/6u6wUeiD4GcmiW
         XqviYht07GPI0N14+GrGg4nJK/hIB+ZKJmYOA3g+jLkTPK0OaCi2p+Q9MC06l6b9yg4R
         ld1bP+AGodvY4PTEIcxpvrl01kSSXEYCG9X/9Dpo4GjsYON6n3ahIr05/1QJfZTytqZx
         dBGX0LFtKTSM+OkHK5h5bQc7d7WvziVelxo5xwMteSoshOdIRD3t62TPVmir3FS7IX9L
         wiSw==
X-Gm-Message-State: AOAM531PITBNpw0bnzZ04Iv9oCSDVBVyTTaHVDjAS9d1vi9XsAiaLkjk
        Vr+5v3GtrJnO0SJ/uK5BuF1GV/RAze4=
X-Google-Smtp-Source: ABdhPJzddpsfgU33C8kH/bNzZwBZP2s0UkO2OAcZoSBCAaFMwMsP4EMCpJ+2vpLi1IZedOBJrvxuaw==
X-Received: by 2002:a17:90b:370a:: with SMTP id mg10mr22685147pjb.219.1620068229597;
        Mon, 03 May 2021 11:57:09 -0700 (PDT)
Received: from [192.168.2.112] ([50.38.35.18])
        by smtp.googlemail.com with ESMTPSA id z12sm203307pjt.29.2021.05.03.11.57.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 May 2021 11:57:09 -0700 (PDT)
Subject: Re: [PATCH 1/2] mm/hugetlb: Fix F_SEAL_FUTURE_WRITE
To:     Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Axel Rasmussen <axelrasmussen@google.com>
References: <20210501144110.8784-1-peterx@redhat.com>
 <20210501144110.8784-2-peterx@redhat.com>
From:   Mike Kravetz <mjk.linux@gmail.com>
Message-ID: <be33c24e-cf2d-3894-a450-7432fd976802@gmail.com>
Date:   Mon, 3 May 2021 11:55:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20210501144110.8784-2-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/1/21 7:41 AM, Peter Xu wrote:
> F_SEAL_FUTURE_WRITE is missing for hugetlb starting from the first day.
> There is a test program for that and it fails constantly.
> 
> $ ./memfd_test hugetlbfs
> memfd-hugetlb: CREATE
> memfd-hugetlb: BASIC
> memfd-hugetlb: SEAL-WRITE
> memfd-hugetlb: SEAL-FUTURE-WRITE
> mmap() didn't fail as expected
> Aborted (core dumped)
> 
> I think it's probably because no one is really running the hugetlbfs test.
> 
> Fix it by checking FUTURE_WRITE also in hugetlbfs_file_mmap() as what we do in
> shmem_mmap().  Generalize a helper for that.
> 
> Reported-by: Hugh Dickins <hughd@google.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  fs/hugetlbfs/inode.c |  5 +++++
>  include/linux/mm.h   | 32 ++++++++++++++++++++++++++++++++
>  mm/shmem.c           | 22 ++++------------------
>  3 files changed, 41 insertions(+), 18 deletions(-)

Thanks Peter and Hugh!

One question below,

> 
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index a2a42335e8fd2..39922c0f2fc8c 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -131,10 +131,15 @@ static void huge_pagevec_release(struct pagevec *pvec)
>  static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
>  {
>  	struct inode *inode = file_inode(file);
> +	struct hugetlbfs_inode_info *info = HUGETLBFS_I(inode);
>  	loff_t len, vma_len;
>  	int ret;
>  	struct hstate *h = hstate_file(file);
>  
> +	ret = seal_check_future_write(info->seals, vma);
> +	if (ret)
> +		return ret;
> +
>  	/*
>  	 * vma address alignment (but not the pgoff alignment) has
>  	 * already been checked by prepare_hugepage_range.  If you add

The full comment below the code you added is:

	/*
	 * vma address alignment (but not the pgoff alignment) has
	 * already been checked by prepare_hugepage_range.  If you add
	 * any error returns here, do so after setting VM_HUGETLB, so
	 * is_vm_hugetlb_page tests below unmap_region go the right
	 * way when do_mmap unwinds (may be important on powerpc
	 * and ia64).
	 */

This comment was added in commit 68589bc35303 by Hugh, although it
appears David Gibson added the reason for the comment in the commit
message:

"If hugetlbfs_file_mmap() returns a failure to do_mmap_pgoff() - for example,
because the given file offset is not hugepage aligned - then do_mmap_pgoff
will go to the unmap_and_free_vma backout path.

But at this stage the vma hasn't been marked as hugepage, and the backout path
will call unmap_region() on it.  That will eventually call down to the
non-hugepage version of unmap_page_range().  On ppc64, at least, that will
cause serious problems if there are any existing hugepage pagetable entries in
the vicinity - for example if there are any other hugepage mappings under the
same PUD.  unmap_page_range() will trigger a bad_pud() on the hugepage pud
entries.  I suspect this will also cause bad problems on ia64, though I don't
have a machine to test it on."

There are still comments in the unmap code about special handling of
ppc64 PUDs.  So, this may still be an issue.

I am trying to dig into the code to determine if this is still and
issue.  Just curious if you looked into this?  Might be simpler and
safer to just put the seal check after setting the VM_HUGETLB flag?

--
Mike Kravetz


