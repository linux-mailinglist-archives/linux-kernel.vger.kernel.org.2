Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9645A31F11A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 21:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbhBRUfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 15:35:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42558 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229636AbhBRUez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 15:34:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613680407;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kOXzwG2Geh6ZuY6IsnNNmxN56nyBkfgCRwzkOKH/tWg=;
        b=J2ccBcF3doqU7A5z2JBYC6MWXK9rIbzP5Ab9QDEJYINZRnnM5gYF7tP8Efc+AxtT7E5P/w
        YD7aKhOd7vAbLjft5NL9ZNBb7i83lfo1YA+3oy/oXGHoeEyAHq8rQAb8ArivyJgYz0rHYz
        +OJmkR4Zf/WDyuARn5Wmc/lFtbfQLvw=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157--v0FpxCbP4i3rq4SkeWQXw-1; Thu, 18 Feb 2021 15:33:25 -0500
X-MC-Unique: -v0FpxCbP4i3rq4SkeWQXw-1
Received: by mail-qk1-f199.google.com with SMTP id d66so2084549qke.9
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 12:33:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kOXzwG2Geh6ZuY6IsnNNmxN56nyBkfgCRwzkOKH/tWg=;
        b=JAKbyX1F8esPfWRLdl6Yc4gifOOygsV+k2XDezzan8gcLM2N9zs3U5UvhQZrRvVE4y
         jZACA9wREfAiDuteFqc09MUXsfE0uMi/tocbiXRSnP+aklI/sv9uuk5KYuE9do08CAnu
         Jx3HlJHzdXjdV43leslt6T6FcnGErZHo42PB5uga8/TVH71fJTCmqmC5PnhZ2IgON1nM
         FH3qPVcpgDZPRbbvG0iN/w5l6rcIECo0Lxew3O8Pk9g/vhl+OVdC23rGilywpZ/JvBKQ
         rlaUCiEw5vtksqGly6Hj447B1TiXgF+VLwYuvQGrSQOjX1pedmTfCCrYETK5Lv6jV/gl
         pmdQ==
X-Gm-Message-State: AOAM5334LSjDM6G7fcX3DagGTzmrnqwtlNVQULfa13PAo6NKMMYQFBiG
        7QGZ1hIK4Y+WIiCB/+wgQ04evc8fUGCJo50nHKFvTiVvsviJY0CZ3KlGHD5YGduH7uJdlGCTM2F
        yp2w/y/p2iLWztfBnob82tEF+
X-Received: by 2002:a37:73c3:: with SMTP id o186mr5911857qkc.194.1613680405350;
        Thu, 18 Feb 2021 12:33:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxApFx3hPHQju8LbKpNXRQr2yJVys8PmQRvnTxtTEhfm4TpK7G/KOJJ/xN4q0IleY5/pwP+zg==
X-Received: by 2002:a37:73c3:: with SMTP id o186mr5911837qkc.194.1613680405174;
        Thu, 18 Feb 2021 12:33:25 -0800 (PST)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-20-174-93-89-182.dsl.bell.ca. [174.93.89.182])
        by smtp.gmail.com with ESMTPSA id l128sm4698505qkf.68.2021.02.18.12.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 12:33:24 -0800 (PST)
Date:   Thu, 18 Feb 2021 15:33:23 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Linux MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH v2 0/4] hugetlb: Disable huge pmd unshare for uffd-wp
Message-ID: <20210218203323.GE108961@xz-x1>
References: <20210217204418.54259-1-peterx@redhat.com>
 <CAJHvVcjgAEk8ABkE0LC=OBsbQYACet7ui6ELqerx-v6KGB+tsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJHvVcjgAEk8ABkE0LC=OBsbQYACet7ui6ELqerx-v6KGB+tsg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 18, 2021 at 10:54:41AM -0800, Axel Rasmussen wrote:
> I reviewed these patches, rebased my minor fault handling series on
> top of this series, and then ran some stress tests of minor fault
> handling. Other than the one comment I left about !CONFIG_CMA, I
> didn't spot any issues. So:
> 
> Tested-By: Axel Rasmussen <axelrasmussen@google.com>
> 
> (Or Reviewed-By: , if that makes more sense.)

I'll add your r-b for the initial 3 patches, thanks Axel!

-- 
Peter Xu

