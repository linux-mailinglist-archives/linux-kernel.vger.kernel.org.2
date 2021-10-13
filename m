Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 397AF42BDB2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 12:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbhJMKtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 06:49:13 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:51539 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbhJMKtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 06:49:10 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20211013104706euoutp0181d83511489f4a062eef0418d8a82c49~tkVNMgL_m1173911739euoutp01E
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 10:47:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20211013104706euoutp0181d83511489f4a062eef0418d8a82c49~tkVNMgL_m1173911739euoutp01E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1634122026;
        bh=dHMs6MEBX0Y9Rf5ShY89Zq9xX3qBrYdQyKIe/fbf5iQ=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=O0wBmLSzBu0JV2+J+0bwqS0CHk/B/lZHA0ZMX902yeO+UzBQLduSzM6GCN7XYv4b4
         1lFWUpAp5DU8w0RXuucbVzk0KFfiUt7s7NshryzNqFI5aVI+2o7rYB+K6v/0RlFswb
         K/b5ld4UyWDLra/jIlCK9WVgj2nUMP1exOrGlVe0=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20211013104706eucas1p288f1c0cc97546756439941be0457396d~tkVMzjxcA1267512675eucas1p2n;
        Wed, 13 Oct 2021 10:47:06 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id FF.A3.42068.A29B6616; Wed, 13
        Oct 2021 11:47:06 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20211013104705eucas1p15920a955339efc81f4f4415c8627de04~tkVMMlZkW2030720307eucas1p1y;
        Wed, 13 Oct 2021 10:47:05 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20211013104705eusmtrp2143c38045e4142a0b725a81025f8971d~tkVMLurC33127031270eusmtrp2M;
        Wed, 13 Oct 2021 10:47:05 +0000 (GMT)
X-AuditID: cbfec7f4-c89ff7000002a454-ee-6166b92a6ff9
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 71.F7.20981.929B6616; Wed, 13
        Oct 2021 11:47:05 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20211013104704eusmtip1657771ce8ee49d07a2b7dddda778f342~tkVLWkmxa1095010950eusmtip1R;
        Wed, 13 Oct 2021 10:47:04 +0000 (GMT)
Subject: Re: [PATCH] mm/thp: decrease nr_thps in file's mapping on THP split
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?B?6rmA7ISx7ZuI?= <sfoon.kim@samsung.com>,
        Song Liu <songliubraving@fb.com>,
        Rik van Riel <riel@surriel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hillf Danton <hdanton@sina.com>,
        Hugh Dickins <hughd@google.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Yang Shi <yang.shi@linux.alibaba.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <5eafae55-f207-38a8-d6d3-8bda74ae9c60@samsung.com>
Date:   Wed, 13 Oct 2021 12:47:03 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0)
        Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YWWC9+93pHQ77Ir3@casper.infradead.org>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBKsWRmVeSWpSXmKPExsWy7djPc7paO9MSDd784bGYs34Nm8XqTb4W
        B34+Z7F4+qmPxeLm8zksFpd3zWGzuLfmP6vF1v2tjBbXNm1ltWictpzd4ufhM8wWmxd3MVn8
        /gFU8rHpHpsDn8fhN++ZPSY2v2P3WLCp1GPzCi2PTZ8msXucmPGbxWPnQ0uPeScDPT4+vcXi
        8X7fVTaPvi2rGD0mvXD32LPqKqPH501yAXxRXDYpqTmZZalF+nYJXBnnbjWxFVznqvg7bT9b
        A+MFji5GTg4JAROJk8vXsoPYQgIrGCVu3tLrYuQCsr8wSmz6c54NwvnMKLF53ilWmI7V+1Yz
        QySWM0oce3YEquojo0TTuSdgVcICPhLf+7cBzeXgEBHQkHizxQikhlngL7NET+slRpAaNgFD
        ia63XWwgNq+AncTx1V9ZQGwWAVWJ22s+gdWICiRLTPvbxAxRIyhxcuYTsBpOoCs+vdgEtotZ
        QF5i+9s5zBC2uMStJ/OZQJZJCJzilDjUfZYZ4mwXiVv/ZrBD2MISr45vgbJlJP7vhGloZpR4
        eA4UGiBOD6PE5aYZjBBV1hJ3zv1iA3mHWUBTYv0ufYiwo0TrvU3MIGEJAT6JG28FIY7gk5i0
        bTpUmFeio00IolpNYtbxdXBrD164xDyBUWkWktdmIXlnFpJ3ZiHsXcDIsopRPLW0ODc9tdgo
        L7Vcrzgxt7g0L10vOT93EyMwMZ7+d/zLDsblrz7qHWJk4mA8xCjBwawkwmuYkZooxJuSWFmV
        WpQfX1Sak1p8iFGag0VJnDdpy5p4IYH0xJLU7NTUgtQimCwTB6dUA5OoEG9tTv2XAOmjW/e+
        ZJawf+zzVklQkfHK1L+K/vyqaz8ZvmateNSvNtdCxVBij9/h7WbvT2Rdbzx67axGVbmyuqx7
        gNv2hxeio5oPhFxiFZpn+Cpk3bZtDsa+z5M4oh4suMr1yNl+/prbsneFJxQIzPJ//PnZce61
        j+NK9oQ+qvptZN69mHnDXxWzxmARlg3zitcv3FxjapO1yZ31rr6n+eovu0/GOv861p1eGdt2
        +kDUjBtxrJJ9LYIJQVlHkw7dEPj/jfP0Ybem1exiu7+2dBi/jplV/ujeTs2Lyp6JXw/aaG6y
        Tde9l7s5/yRvc0dO2vyXj/gOXN7bdJPhhNEDdp25X1NU7t22yEpY7KrEUpyRaKjFXFScCAAF
        agzf+wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNIsWRmVeSWpSXmKPExsVy+t/xu7qaO9MSDV7cVLCYs34Nm8XqTb4W
        B34+Z7F4+qmPxeLm8zksFpd3zWGzuLfmP6vF1v2tjBbXNm1ltWictpzd4ufhM8wWmxd3MVn8
        /gFU8rHpHpsDn8fhN++ZPSY2v2P3WLCp1GPzCi2PTZ8msXucmPGbxWPnQ0uPeScDPT4+vcXi
        8X7fVTaPvi2rGD0mvXD32LPqKqPH501yAXxRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6
        hsbmsVZGpkr6djYpqTmZZalF+nYJehnnbjWxFVznqvg7bT9bA+MFji5GTg4JAROJ1ftWM3cx
        cnEICSxllJjw+QU7REJG4uS0BlYIW1jiz7UuNoii94wS777tZgNJCAv4SHzv3wbUwMEhIqAh
        8WaLEUgNs8B/Zon1TW2MEA27GCX+TW9nBGlgEzCU6HrbBdbMK2AncXz1VxYQm0VAVeL2mk9g
        NaICyRJvX39ngqgRlDg58wlYDSfQqZ9ebAK7iFnATGLe5ofMELa8xPa3c6BscYlbT+YzTWAU
        moWkfRaSlllIWmYhaVnAyLKKUSS1tDg3PbfYSK84Mbe4NC9dLzk/dxMjMBVsO/Zzyw7Gla8+
        6h1iZOJgPMQowcGsJMJrmJGaKMSbklhZlVqUH19UmpNafIjRFOificxSosn5wGSUVxJvaGZg
        amhiZmlgamlmrCTOa3JkTbyQQHpiSWp2ampBahFMHxMHp1QDE/8dty/uoQe/XXg//2Jgt5Hz
        aZH+rtlvMjdeUUpL2yloxLJArEQ2vcD0TX/H5wdBUfKH6p4ynfpo1Djx6Zkam4JvHedrb2cv
        9nJeqWQw7Su3I4Mj0/kpp2oe8HlbXM7bLn1vWbrI3Ol5vGI5scu52i+/8Qlo2CliU2IwM69S
        /uYUtjduLDuvScjMLg7yWzb1yoWFfPe3OGtZK6rt/bfY8Jx3Ec/7N2yll6Kylqdl2LQeSJnj
        6L0zsE8944Gk27/LdlyLQq1NTU4u8XP/IePzykv9z4sdBovV5ztfy9uhuWdfxEu2E49d9E+e
        PHZgU/vnqfzJZueFtnLm6d/wn77O/gnT3IpS8bJdnayHVh5gV2Ipzkg01GIuKk4EAJOclVaO
        AwAA
X-CMS-MailID: 20211013104705eucas1p15920a955339efc81f4f4415c8627de04
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20211012120247eucas1p1f66926c6fc334216cdbdd39285601aa8
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20211012120247eucas1p1f66926c6fc334216cdbdd39285601aa8
References: <CGME20211012120247eucas1p1f66926c6fc334216cdbdd39285601aa8@eucas1p1.samsung.com>
        <20211012120237.2600-1-m.szyprowski@samsung.com>
        <YWWC9+93pHQ77Ir3@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.10.2021 14:43, Matthew Wilcox wrote:
> On Tue, Oct 12, 2021 at 02:02:37PM +0200, Marek Szyprowski wrote:
>> Decrease nr_thps counter in file's mapping to ensure that the page cache
>> won't be dropped excessively on file write access if page has been
>> already splitted.
>>
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> Fixes: 09d91cda0e82 ("mm,thp: avoid writes to file with THP in pagecache")
>> Fixes: 06d3eff62d9d ("mm/thp: fix node page state in split_huge_page_to_list()")
>> ---
>> I've analyzed the code a few times but either I missed something or the
>> nr_thps counter is not decremented during the THP split on non-shmem file
>> pages.
> This looks OK to me, but have you tested it?  If so, what workload did
> you use?  The way you wrote this changelog makes it sound like you only
> read the code and there have been rather too many bugs introduced recently
> that way :-(

Well, indeed I've found it while reading the code. However I've just 
tried a test scenario, where one runs a big binary, kernel remaps it 
with THPs, then one forces THP split with 
/sys/kernel/debug/split_huge_pages. During any further open of that 
binary with O_RDWR or O_WRITEONLY kernel drops page cache for it, 
because of non-zero thps counter.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

