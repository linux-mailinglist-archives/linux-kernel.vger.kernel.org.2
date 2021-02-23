Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3873322F04
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 17:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233538AbhBWQqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 11:46:43 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:20256 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233168AbhBWQqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 11:46:39 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11NGYOp0129865;
        Tue, 23 Feb 2021 11:45:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=MJV/cnmAmSyNoAGOhEkvsRQHzj98zw4n7wFNlBEnk4M=;
 b=c8TdMIhcEsxlBk1d21NZb0lQPWZKjgJqCHQ0H3Qzpx+gT87yGrU1OvB2eRs2qBLGiR4f
 d1TVPzQs+S+kift/vjNTwghTnkVSd4HRLOYZnzE72MhDE8IxWXeEp/bl7hyJ6sw3zWhD
 DNecjrU1M/lOahgWB3CoICuPmU+N4SwVlD5XQlvuCDvfKHuqg9bOeJHdDipSo0Hu0Mrk
 fshvoC+5p4soMM85wrdWx0IJ23+9EpSJpO8q1FWTxiFpf6F0L15k2qW6cSPWJ8j/0TNT
 jKZUpGzokdGOEB8pWUTlyfI/u/y/muFY4f0DuHJHk6cxX0rhTG71fD0ZDDm2NnTq1VZ8 bA== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36vkn1gt7p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Feb 2021 11:45:47 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11NGgFOe024042;
        Tue, 23 Feb 2021 16:45:45 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 36tt28asgw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Feb 2021 16:45:45 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11NGjhBn39780644
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Feb 2021 16:45:43 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E5642AE053;
        Tue, 23 Feb 2021 16:45:42 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 89017AE051;
        Tue, 23 Feb 2021 16:45:42 +0000 (GMT)
Received: from thinkpad (unknown [9.171.72.176])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Tue, 23 Feb 2021 16:45:42 +0000 (GMT)
Date:   Tue, 23 Feb 2021 17:45:40 +0100
From:   Gerald Schaefer <gerald.schaefer@linux.ibm.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [RFC] linux-next panic in hugepage_subpool_put_pages()
Message-ID: <20210223174540.5526d843@thinkpad>
In-Reply-To: <20210223155740.553df3ee@thinkpad>
References: <20210223155740.553df3ee@thinkpad>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-23_08:2021-02-23,2021-02-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 clxscore=1015 suspectscore=0 impostorscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102230138
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Feb 2021 15:57:40 +0100
Gerald Schaefer <gerald.schaefer@linux.ibm.com> wrote:

[...]
> What I do not understand is how __free_huge_page() would be called at all
> in the call trace below (set_max_huge_pages -> alloc_pool_huge_page ->
> __free_huge_page -> hugepage_subpool_put_pages). From the code it seems
> that this should not be possible, so I must be missing something.

Ok, looking more closely at the dump and code, I see that __free_huge_page()
was called via alloc_pool_huge_page -> put_page() -> destroy_compound_page()
-> compound_page_dtors[2].

It doesn't feel right that alloc_pool_huge_page() ends up freeing the
newly allocated page again. Maybe some refcounting race, so that put_page()
wrongly assumes it was the last reference?

Also from the dump, I could reconstruct the (head) struct page pointer
that __free_huge_page() was called with. Here is the content of the
head and the first tail page, maybe it can help. page->private in the tail
page was zeroed already in __free_huge_page(), but its original value was
the broken *spool pointer 0000004e00000000, as seen in the register output
of the backtrace.

crash> struct -x page 0000037203dec000
struct page {
  flags = 0x3ffff00000010000, 
  {
    {
      lru = {
        next = 0x37203dec008, 
        prev = 0x37203dec008
      }, 
      mapping = 0x0, 
      index = 0x0, 
      private = 0x0
    }, 
    {
      dma_addr = 0x37203dec008
    }, 
    {
      {
        slab_list = {
          next = 0x37203dec008, 
          prev = 0x37203dec008
        }, 
        {
          next = 0x37203dec008, 
          pages = 0x372, 
          pobjects = 0x3dec008
        }
      }, 
      slab_cache = 0x0, 
      freelist = 0x0, 
      {
        s_mem = 0x0, 
        counters = 0x0, 
        {
          inuse = 0x0, 
          objects = 0x0, 
          frozen = 0x0
        }
      }
    }, 
    {
      compound_head = 0x37203dec008, 
      compound_dtor = 0x0, 
      compound_order = 0x0, 
      compound_mapcount = {
        counter = 0x3dec008
      }, 
      compound_nr = 0x0
    }, 
    {
      _compound_pad_1 = 0x37203dec008, 
      hpage_pinned_refcount = {
        counter = 0x372
      }, 
      deferred_list = {
        next = 0x0, 
        prev = 0x0
      }
    }, 
    {
      _pt_pad_1 = 0x37203dec008, 
      pmd_huge_pte = 0x37203dec008, 
      _pt_pad_2 = 0x0, 
      {
        pt_mm = 0x0, 
        pt_frag_refcount = {
          counter = 0x0
        }
      }, 
      ptl = {
        {
          rlock = {
            raw_lock = {
              lock = 0x0
            }
          }
        }
      }
    }, 
    {
      pgmap = 0x37203dec008, 
      zone_device_data = 0x37203dec008
    }, 
    callback_head = {
      next = 0x37203dec008, 
      func = 0x37203dec008
    }
  }, 
  {
    _mapcount = {
      counter = 0xffffffff
    }, 
    page_type = 0xffffffff, 
    active = 0xffffffff, 
    units = 0xffffffff
  }, 
  _refcount = {
    counter = 0x0
  }, 
  memcg_data = 0x0
}


crash> struct -x page 0000037203dec040
struct page {
  flags = 0x3ffff00000000000, 
  {
    {
      lru = {
        next = 0x37203dec001, 
        prev = 0x2080372ffffffff
      }, 
      mapping = 0x10000000400, 
      index = 0x2, 
      private = 0x0
    }, 
    {
      dma_addr = 0x37203dec001
    }, 
    {
      {
        slab_list = {
          next = 0x37203dec001, 
          prev = 0x2080372ffffffff
        }, 
        {
          next = 0x37203dec001, 
          pages = 0x2080372, 
          pobjects = 0xffffffff
        }
      }, 
      slab_cache = 0x10000000400, 
      freelist = 0x2, 
      {
        s_mem = 0x0, 
        counters = 0x0, 
        {
          inuse = 0x0, 
          objects = 0x0, 
          frozen = 0x0
        }
      }
    }, 
    {
      compound_head = 0x37203dec001, 
      compound_dtor = 0x2, 
      compound_order = 0x8, 
      compound_mapcount = {
        counter = 0xffffffff
      }, 
      compound_nr = 0x100
    }, 
    {
      _compound_pad_1 = 0x37203dec001, 
      hpage_pinned_refcount = {
        counter = 0x2080372
      }, 
      deferred_list = {
        next = 0x10000000400, 
        prev = 0x2
      }
    }, 
    {
      _pt_pad_1 = 0x37203dec001, 
      pmd_huge_pte = 0x2080372ffffffff, 
      _pt_pad_2 = 0x10000000400, 
      {
        pt_mm = 0x2, 
        pt_frag_refcount = {
          counter = 0x0
        }
      }, 
      ptl = {
        {
          rlock = {
            raw_lock = {
              lock = 0x0
            }
          }
        }
      }
    }, 
    {
      pgmap = 0x37203dec001, 
      zone_device_data = 0x2080372ffffffff
    }, 
    callback_head = {
      next = 0x37203dec001, 
      func = 0x2080372ffffffff
    }
  }, 
  {
    _mapcount = {
      counter = 0xffffffff
    }, 
    page_type = 0xffffffff, 
    active = 0xffffffff, 
    units = 0xffffffff
  }, 
  _refcount = {
    counter = 0x0
  }, 
  memcg_data = 0x0
}
