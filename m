Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2123930F521
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 15:38:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236810AbhBDOhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 09:37:06 -0500
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:18701 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236648AbhBDOff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 09:35:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1612449334; x=1643985334;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=p9V03q8GnkdefDZv70lYQwNtLWDpb3uW9mg5FD1upMQ=;
  b=NrTUm8t6LDmEC4r5fVu6uqnWIBric6BtazQA/RHQdiNIJ2S9cLZquWG8
   fZnuVjIhwqpSM7OHKY5KrG94a0VYeCUOeAOEvBb2ILay4HChVKD7TNVTn
   0TGgQy2wPDTsM9red2M0s7yoNBuCynwo1TlyUh45dVwNRSsRFyxqar8iL
   c=;
X-IronPort-AV: E=Sophos;i="5.79,401,1602547200"; 
   d="scan'208";a="82458978"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2a-e7be2041.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 04 Feb 2021 14:33:00 +0000
Received: from EX13D19EUB003.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2a-e7be2041.us-west-2.amazon.com (Postfix) with ESMTPS id C11EBA066A;
        Thu,  4 Feb 2021 14:32:58 +0000 (UTC)
Received: from 8c85908914bf.ant.amazon.com (10.43.162.124) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 4 Feb 2021 14:32:50 +0000
Subject: Re: [PATCH 0/4] mm/hugetlb: Early cow on fork, and a few cleanups
To:     Peter Xu <peterx@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
CC:     Wei Zhang <wzam@amazon.com>, Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Christoph Hellwig <hch@lst.de>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jan Kara <jack@suse.cz>,
        Kirill Shutemov <kirill@shutemov.name>,
        David Gibson <david@gibson.dropbear.id.au>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210203210832.113685-1-peterx@redhat.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <de213e3e-01c7-0fef-d5cf-6a69ec670c70@amazon.com>
Date:   Thu, 4 Feb 2021 16:32:45 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210203210832.113685-1-peterx@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.162.124]
X-ClientProxiedBy: EX13D24UWB004.ant.amazon.com (10.43.161.4) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/02/2021 23:08, Peter Xu wrote:
> As reported by Gal [1], we still miss the code clip to handle early cow for
> 
> hugetlb case, which is true.  Again, it still feels odd to fork() after using a
> 
> few huge pages, especially if they're privately mapped to me..  However I do
> 
> agree with Gal and Jason in that we should still have that since that'll
> 
> complete the early cow on fork effort at least, and it'll still fix issues
> 
> where buffers are not well under control and not easy to apply MADV_DONTFORK.
> 
> 
> 
> The first two patches (1-2) are some cleanups I noticed when reading into the
> 
> hugetlb reserve map code.  I think it's good to have but they're not necessary
> 
> for fixing the fork issue.
> 
> 
> 
> The last two patches (3-4) is the real fix.
> 
> 
> 
> I tested this with a fork() after some vfio-pci assignment, so I'm pretty sure
> 
> the page copy path could trigger well (page will be accounted right after the
> 
> fork()), but I didn't do data check since the card I assigned is some random
> 
> nic.  Gal, please feel free to try this if you have better way to verify the
> 
> series.

Thanks Peter, once v2 is submitted I'll pull the patches and we'll run the tests
that discovered the issue to verify it works.
