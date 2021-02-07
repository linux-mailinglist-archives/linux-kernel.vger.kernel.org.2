Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45D7F312300
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 10:12:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbhBGJKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 04:10:42 -0500
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:32562 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbhBGJKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 04:10:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1612689035; x=1644225035;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=reTf7FHuLE5z07yV0uu5T5OrL3BGw0KiDOGzaJuoIE4=;
  b=Rwbk7kXoT/qfrlUHybJOMENKGSx9hbCrXCDB5Xl3jfQcGU+iir/dZSYG
   Q9IafS2jERGU5GQeEb91YPUsIKHhGPlbNfMTFereCjV+Q0GrteGphRU61
   3QWppdbbZ2szT8JDxLl55aOb70MzwdH9lNDL5iBzV1YEN4Mq0t5RNPuQd
   Y=;
X-IronPort-AV: E=Sophos;i="5.81,159,1610409600"; 
   d="scan'208";a="84393680"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1e-c7c08562.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 07 Feb 2021 09:09:48 +0000
Received: from EX13D19EUB003.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-1e-c7c08562.us-east-1.amazon.com (Postfix) with ESMTPS id DAAD3240BED;
        Sun,  7 Feb 2021 09:09:42 +0000 (UTC)
Received: from 8c85908914bf.ant.amazon.com (10.43.160.66) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Sun, 7 Feb 2021 09:09:34 +0000
Subject: Re: [PATCH v2 4/4] hugetlb: Do early cow when page pinned on src mm
To:     Peter Xu <peterx@redhat.com>, "Zhang, Wei" <wzam@amazon.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kirill Shutemov <kirill@shutemov.name>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jan Kara <jack@suse.cz>, Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        David Gibson <david@gibson.dropbear.id.au>,
        Christoph Hellwig <hch@lst.de>
References: <20210204145033.136755-1-peterx@redhat.com>
 <20210204145033.136755-5-peterx@redhat.com>
 <329ADC08-552E-423B-9230-99643B81C14A@amazon.com>
 <20210205155114.GY6468@xz-x1>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <10d5cdce-4748-1b9e-b433-6f3d1bde63db@amazon.com>
Date:   Sun, 7 Feb 2021 11:09:29 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210205155114.GY6468@xz-x1>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.43.160.66]
X-ClientProxiedBy: EX13D44UWC001.ant.amazon.com (10.43.162.26) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/02/2021 17:51, Peter Xu wrote:
> On Fri, Feb 05, 2021 at 02:58:33PM +0000, Zhang, Wei wrote:
>> Hi Peter,
> 
> Hi, Wei,
> 
>>
>> Gal and I worked together. We tested the patch v2 and can confirm it is working as intended.
>>
>> Thank you very much for your quick response!
> 
> My thanks too on the quick testing!  Sorry that I'll need to post v3; please
> feel free to hold off the testing until I got some r-bs with the new version.

BTW, it might already be fixed in v3, but I encountered a compilation warning
with this series:

mm/memory.c: In function ‘copy_present_page’:
mm/memory.c:800:20: warning: unused variable ‘src_mm’ [-Wunused-variable]
  struct mm_struct *src_mm = src_vma->vm_mm;
                    ^~~~~~
