Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E20543E7D1E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 18:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbhHJQGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 12:06:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:21702 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229474AbhHJQGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 12:06:30 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17AG4YdS114311;
        Tue, 10 Aug 2021 12:05:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=K5k6END1W3qwJlF2N3XDgRvOvSEtCNrlBqDC+kWyl8Q=;
 b=UCKYaaFgTDpH/HlcQuuMXHZIm40es6tA5L+d2ne0Mo0e33fI1S0aE7winQGURpVyj/Fk
 ZxYh20eFMEeBrVQKacBg/30JO2r42T6Rno+aca4OJohIO37sHQz2O4g2fjiN/JxRYSWd
 Al9MNiTZEW7CZIHNBOxn6sgC4bXgemcmfJehkCoB2+NO1w5WWwVRvLn6YM+NVks2Zh7G
 qdpF4kWZQY/EGkYDcuWHZwRl8WTlxjOJ61AL5+7h0dKnlctvkYRKgIA0uqqc1LXTYAe8
 NAALhCvhdsxqYoPnrUsSHXocixr2IcBoHUv/s1sSWmSwOwNlFx3my02tkc5ux4IhsT5i Nw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ab8kkfrr1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Aug 2021 12:05:45 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 17AG53oS116848;
        Tue, 10 Aug 2021 12:05:45 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ab8kkfrnx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Aug 2021 12:05:44 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17AG2QSF016591;
        Tue, 10 Aug 2021 16:05:42 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma05fra.de.ibm.com with ESMTP id 3a9ht8wquu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Aug 2021 16:05:42 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17AG5cA754133014
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Aug 2021 16:05:38 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9DCD8A405B;
        Tue, 10 Aug 2021 16:05:38 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E5671A406D;
        Tue, 10 Aug 2021 16:05:37 +0000 (GMT)
Received: from thinkpad (unknown [9.171.16.74])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Tue, 10 Aug 2021 16:05:37 +0000 (GMT)
Date:   Tue, 10 Aug 2021 18:05:35 +0200
From:   Gerald Schaefer <gerald.schaefer@linux.ibm.com>
To:     Gavin Shan <gshan@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        anshuman.khandual@arm.com, aneesh.kumar@linux.ibm.com,
        christophe.leroy@csgroup.eu, cai@lca.pw, catalin.marinas@arm.com,
        will@kernel.org, vgupta@synopsys.com, akpm@linux-foundation.org,
        chuhu@redhat.com, shan.gavin@gmail.com
Subject: Re: [PATCH v6 00/12] mm/debug_vm_pgtable: Enhancements
Message-ID: <20210810180535.08ecc800@thinkpad>
In-Reply-To: <20210809092631.1888748-1-gshan@redhat.com>
References: <20210809092631.1888748-1-gshan@redhat.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zWF7Qhj4HWT4pW8UtNdggW5Hu3RrQYgZ
X-Proofpoint-ORIG-GUID: a6ZPyDn27JGKN-_qpm6GlZDsPXK3rMZL
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-10_07:2021-08-10,2021-08-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 clxscore=1011 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0
 mlxscore=0 priorityscore=1501 mlxlogscore=999 adultscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108100103
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  9 Aug 2021 17:26:19 +0800
Gavin Shan <gshan@redhat.com> wrote:

> There are couple of issues with current implementations and this series
> tries to resolve the issues:
> 
>   (a) All needed information are scattered in variables, passed to various
>       test functions. The code is organized in pretty much relaxed fashion.
> 
>   (b) The page isn't allocated from buddy during page table entry modifying
>       tests. The page can be invalid, conflicting to the implementations
>       of set_xxx_at() on ARM64. The target page is accessed so that the
>       iCache can be flushed when execution permission is given on ARM64.
>       Besides, the target page can be unmapped and accessing to it causes
>       kernel crash.
> 
> "struct pgtable_debug_args" is introduced to address issue (a). For issue
> (b), the used page is allocated from buddy in page table entry modifying
> tests. The corresponding tets will be skipped if we fail to allocate the
> (huge) page. For other test cases, the original page around to kernel
> symbol (@start_kernel) is still used.
> 
> The patches are organized as below. PATCH[2-10] could be combined to one
> patch, but it will make the review harder:
> 
>   PATCH[1] introduces "struct pgtable_debug_args" as place holder of all
>            needed information. With it, the old and new implementation
>            can coexist.
>   PATCH[2-10] uses "struct pgtable_debug_args" in various test functions.
>   PATCH[11] removes the unused code for old implementation.
>   PATCH[12] fixes the issue of corrupted page flag for ARM64

Tested on s390, all seems to work fine.

Gerald
