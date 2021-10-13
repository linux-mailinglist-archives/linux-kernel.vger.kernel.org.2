Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91E3A42B2E1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 04:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236720AbhJMCvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 22:51:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46220 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236878AbhJMCvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 22:51:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634093353;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R+0oNJdHTqOxAaH5moaEK3403j+y86OhqVlmztOpaVo=;
        b=CMr8NtvsjpCOYHMilfxJMdS90e4Dq5+twxeiTqf1Ot4/gzeTotWhA6xnSXLMAHGbmCgrYs
        9y02LUwWcMNdCV2ZBWvF+A7h+F95rSZyVgOOjgXdKvspfFx25M9EtbC1vkR8qobz5u+60E
        S3RDiO3MQBm86pj+qZBvIw5rl9lRwl8=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-565-DpBUk7m8MEqCuIBkEtIsyQ-1; Tue, 12 Oct 2021 22:49:12 -0400
X-MC-Unique: DpBUk7m8MEqCuIBkEtIsyQ-1
Received: by mail-pg1-f197.google.com with SMTP id g26-20020a63521a000000b0029524f04f5aso640325pgb.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 19:49:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R+0oNJdHTqOxAaH5moaEK3403j+y86OhqVlmztOpaVo=;
        b=wlogmBNWppLt8YFXNJ8mT9+QT2IfrIm7sbEA92GBBbnx68TudlMb6fsD0HE1iWMXxG
         UmEbRhWqP7h6XdzMmxVOO/8eCi4RCJxwPNU1CoEh1jQMs74bxKrTzTX74q4+NGDiWaBn
         2p/72Ypfa6LczZvOsE1okVZNJC3cfZguIXPabnmN8DCyHRzM/5CC5w8j57cZRq97noc7
         CWODh1S5ePudpjXIgpnz4rZY9eIx3VT9K/Jznj9Z8h1tkThfvpHd2bIcq3hi5s4e8x9/
         zxZPDpyGg63aDJoufGJRYkYMNN0+ivNjSzBCp7A0a6WdzQhHy5FD8rkhPM9Y5RPn50re
         ypww==
X-Gm-Message-State: AOAM530pd2CVAxWHx1e8k9TLWsi8IQv6RHPzLkNqfWAo3McrE7Ywr2VY
        9Eo2/Jtwx3eepieHDae3mkClGywDDZ4zrfsHuhCXiqJkJiR9HQl3nyrReTL4JJra9HrqNasC1Gx
        txInTVyTU3F8tnQCP/7zP5Mp7
X-Received: by 2002:a05:6a00:a0a:b0:44c:52c9:bf25 with SMTP id p10-20020a056a000a0a00b0044c52c9bf25mr35654797pfh.24.1634093351142;
        Tue, 12 Oct 2021 19:49:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyMViZ0sgxMYWlr6yHux2NLvCKNqAhqb/tfqmxDDtN6oX4y3JX1XVULHqOH0ScmrQtPFfn4hA==
X-Received: by 2002:a05:6a00:a0a:b0:44c:52c9:bf25 with SMTP id p10-20020a056a000a0a00b0044c52c9bf25mr35654777pfh.24.1634093350788;
        Tue, 12 Oct 2021 19:49:10 -0700 (PDT)
Received: from t490s ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id s8sm4017477pjm.32.2021.10.12.19.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 19:49:10 -0700 (PDT)
Date:   Wed, 13 Oct 2021 10:49:04 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Alistair Popple <apopple@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Bin Wang <wangbin224@huawei.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mm, pagemap: expose hwpoison entry
Message-ID: <YWZJIKsn6Sry5P6k@t490s>
References: <20211004115001.1544259-1-naoya.horiguchi@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211004115001.1544259-1-naoya.horiguchi@linux.dev>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Naoya,

On Mon, Oct 04, 2021 at 08:50:01PM +0900, Naoya Horiguchi wrote:
> +static inline struct page *hwpoison_entry_to_page(swp_entry_t entry)
> +{
> +	struct page *p = pfn_to_page(swp_offset(entry));
> +
> +	WARN_ON(!PageHWPoison(p));
> +	return p;
> +}

This is more a pure question..

I'm wondering whether that WARN_ON() could trigger.

IOW, what if we poison an anonymous page and then unpoison it?  Will there be a
hwpoison swap entry leftover in the ptes that it used to map?  Will it crash
the program when the page is accessed?

I had a feeling that when handling the page fault in do_swap_page before we
SIGBUS the program, we should double-check the PageHWPoison on the pfn page,
but I could be missing something..

Thanks,

-- 
Peter Xu

