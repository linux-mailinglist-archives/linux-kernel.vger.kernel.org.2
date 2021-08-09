Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66B853E4301
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 11:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234669AbhHIJkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 05:40:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58610 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234365AbhHIJkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 05:40:17 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1799Yibd128990;
        Mon, 9 Aug 2021 05:39:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=YlxCbW/CqcLdARJnlAirPQnky4qavkVOaD/Fdc4p0TY=;
 b=EKnNwZ8Ynw/Wt1pm0WhC/+lAbmzp1q09dlhdx12oaTmCpKrZzd0SuCq/FgwJxjXjp+0M
 bBnLaaKeirZxKrRX2D/mBEJMktLVJGm0inv9dE2fTjOp459vALetV8tlO7X4CeER8wNf
 cHaUC1tHeuU7DZXYIafxYZ1zncLp5u+l/g6cy0/t+paFfCuA0mJW/GPzC1JRndlM31JU
 L3Lbijb8x8sF/5QJi1e1joKn161Writ2+m/gZ2zAtejxpq4Bh7OIjmR81RsBfWXUH8HK
 Fj00JbUdZBEb64W2i0GHpmKrcDWzuqLC4Jr4hjyxi8GmoXdC3SVSo7TLlyTB+1FfhdN8 GA== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3aaa1qr6nw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Aug 2021 05:39:46 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1799ckKQ020162;
        Mon, 9 Aug 2021 09:39:45 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma02fra.de.ibm.com with ESMTP id 3a9ht8bbsq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Aug 2021 09:39:44 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1799dgg756492520
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 9 Aug 2021 09:39:42 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 03F3111C058;
        Mon,  9 Aug 2021 09:39:42 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9A07711C06F;
        Mon,  9 Aug 2021 09:39:41 +0000 (GMT)
Received: from p-imbrenda (unknown [9.145.6.223])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  9 Aug 2021 09:39:41 +0000 (GMT)
Date:   Mon, 9 Aug 2021 11:39:38 +0200
From:   Claudio Imbrenda <imbrenda@linux.ibm.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     <akpm@linux-foundation.org>, <kirill.shutemov@linux.intel.com>,
        <jack@suse.cz>, <jhubbard@nvidia.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/5] Cleanups and fixup for gup
Message-ID: <20210809113938.3c116c78@p-imbrenda>
In-Reply-To: <20210807093620.21347-1-linmiaohe@huawei.com>
References: <20210807093620.21347-1-linmiaohe@huawei.com>
Organization: IBM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: KUGqpINfKHIjWaAaVhyoh71Q2QkTZ_AV
X-Proofpoint-ORIG-GUID: KUGqpINfKHIjWaAaVhyoh71Q2QkTZ_AV
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-09_01:2021-08-06,2021-08-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=924 mlxscore=0 clxscore=1011 spamscore=0 priorityscore=1501
 suspectscore=0 malwarescore=0 bulkscore=0 adultscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108090075
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 Aug 2021 17:36:15 +0800
Miaohe Lin <linmiaohe@huawei.com> wrote:

> Hi all,
> This series contains cleanups to remove unneeded variable, useless
> BUG_ON and use helper to improve readability. Also we fix a potential
> pgmap refcnt leak. More details can be found in the respective
> changelogs. Thanks!
> 
> Miaohe Lin (5):
>   mm: gup: remove set but unused local variable major
>   mm: gup: remove unneed local variable orig_refs
>   mm: gup: remove useless BUG_ON in __get_user_pages()
>   mm: gup: fix potential pgmap refcnt leak in __gup_device_huge()
>   mm: gup: use helper PAGE_ALIGNED in populate_vma_page_range()
> 
>  mm/gup.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
> 

Whole series (including the fixup for the return value):

Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

