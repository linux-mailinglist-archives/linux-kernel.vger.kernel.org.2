Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0953E3A0BDA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 07:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236150AbhFIFcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 01:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbhFIFcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 01:32:16 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5440AC061574
        for <linux-kernel@vger.kernel.org>; Tue,  8 Jun 2021 22:30:06 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id v6so8204940qta.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 22:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=NN7xmTnHOJkFIgJqmIQHYCemTkBXultHJB0UVCrZGJU=;
        b=lKzfwxvZYmXMio6DxcohP6UZ0VciCjemrQxWd/Wo4qqmgYF2Kw0+5kLAN7z/fwkDKy
         CMV4dTuWzd4b7yedIkBvfi16W4eG3HU0wDjNVmQrry+FtDpDJmpUKhCjwKWvVedGPIwf
         +j+c2DPRMfYzvW+kZM4dce49dDqa17muJgH0Vwi+d3ThcjVZ2y25P9KM7fGgM1OQnGwK
         1Tpmx6W77SsIcd07ri9QThEVp208q+R33tneycV7Vy4ljxuYwzj0yNAT/7aYbShIon47
         v2hSeJu/41txZYKiOjqJDfeAuO6rIEJvsMK2IZT5hkdmRIdg+GQ16XfW/F4gzxPrMyI9
         9bcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=NN7xmTnHOJkFIgJqmIQHYCemTkBXultHJB0UVCrZGJU=;
        b=s6s+xD0NTDgLw/K3wFAdwOaGzhxmGZFmlT7j9QYrOM/a2OWQQsOzywxLQ3enilIaQ1
         8uuquYm4s26WkXgfqUh1ucvzvIVrbhYEXIv/PVHm43ucbm+ad7p0wAdWDNpZo3+tM25u
         UOHul5uNMy8fsKVVJvye2uPLixx6OF3X9gzSyFCle72hXb+w+1BCjc3RQ6G8yrQxHxZw
         byx8X/SC67iJYzZvQ9W4uPj2mvmm9Rk2IqPxP5J4c+I/quoXUXnciY7En1GvtLmnd3R7
         8J+3FG5aFS6sIDgW7sxNvDRUdJs1D+NH/JQA1eAjM8qhev4Ogp+kPBXSyFbSakIS2oZE
         Zh/A==
X-Gm-Message-State: AOAM533EVE7KmBCGnVxxdaUWCCzptP1kJ1Fe9hRKbJUZWjJHOl4VU7EE
        eI9LF6tasWfpwGVjFLtShd8=
X-Google-Smtp-Source: ABdhPJyNarADNIgx5i6021RzYgKXFMSTP9Xz/qNJbnqV2oKGzxx1S0Sz/8dqbhP4KEJgsnRW5BQVUA==
X-Received: by 2002:ac8:5202:: with SMTP id r2mr19484392qtn.86.1623216605538;
        Tue, 08 Jun 2021 22:30:05 -0700 (PDT)
Received: from ?IPv6:2804:14c:482:87bb::1000? ([2804:14c:482:87bb::1000])
        by smtp.gmail.com with ESMTPSA id y20sm12122386qtv.64.2021.06.08.22.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 22:30:05 -0700 (PDT)
Message-ID: <fa7a0e981a067445beb1ae01d53db932990717b7.camel@gmail.com>
Subject: Re: [PATCH v2 3/3] powerpc/mm/hash: Avoid multiple HPT resize-downs
 on memory hotunplug
From:   Leonardo =?ISO-8859-1?Q?Br=E1s?= <leobras.c@gmail.com>
To:     David Gibson <david@gibson.dropbear.id.au>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Sandipan Das <sandipan@linux.ibm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Scott Cheloha <cheloha@linux.ibm.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Wed, 09 Jun 2021 02:30:36 -0300
In-Reply-To: <YL2sjKM7ByS0Xeko@yekko>
References: <20210430143607.135005-1-leobras.c@gmail.com>
         <20210430143607.135005-4-leobras.c@gmail.com> <YL2sjKM7ByS0Xeko@yekko>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-06-07 at 15:20 +1000, David Gibson wrote:
> On Fri, Apr 30, 2021 at 11:36:10AM -0300, Leonardo Bras wrote:
> > During memory hotunplug, after each LMB is removed, the HPT may be
> > resized-down if it would map a max of 4 times the current amount of
> > memory.
> > (2 shifts, due to introduced histeresis)
> > 
> > It usually is not an issue, but it can take a lot of time if HPT
> > resizing-down fails. This happens  because resize-down failures
> > usually repeat at each LMB removal, until there are no more bolted
> > entries
> > conflict, which can take a while to happen.
> > 
> > This can be solved by doing a single HPT resize at the end of
> > memory
> > hotunplug, after all requested entries are removed.
> > 
> > To make this happen, it's necessary to temporarily disable all HPT
> > resize-downs before hotunplug, re-enable them after hotunplug ends,
> > and then resize-down HPT to the current memory size.
> > 
> > As an example, hotunplugging 256GB from a 385GB guest took 621s
> > without
> > this patch, and 100s after applied.
> > 
> > Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
> 
> Hrm.  This looks correct, but it seems overly complicated.
> 
> AFAICT, the resize calls that this adds should in practice be the
> *only* times we call resize, all the calls from the lower level code
> should be suppressed. 

That's correct.

>  In which case can't we just remove those calls
> entirely, and not deal with the clunky locking and exclusion here.
> That should also remove the need for the 'shrinking' parameter in
> 1/3.


If I get your suggestion correctly, you suggest something like:
1 - Never calling resize_hpt_for_hotplug() in
hash__remove_section_mapping(), thus not needing the srinking
parameter.
2 - Functions in hotplug-memory.c that call dlpar_remove_lmb() would in
fact call another function to do the batch resize_hpt_for_hotplug() for
them

If so, that assumes that no other function that currently calls
resize_hpt_for_hotplug() under another path, or if they do, it does not
need to actually resize the HPT.

Is the above correct?

There are some examples of functions that currently call
resize_hpt_for_hotplug() by another path:

add_memory_driver_managed
	virtio_mem_add_memory
	dev_dax_kmem_probe

reserve_additional_memory
	balloon_process
	add_ballooned_pages

__add_memory
	probe_store

__remove_memory
	pseries_remove_memblock

remove_memory
	dev_dax_kmem_remove
	virtio_mem_remove_memory

memunmap_pages
	pci_p2pdma_add_resource
	virtio_fs_setup_dax


Best regards,
Leonardo Bras

