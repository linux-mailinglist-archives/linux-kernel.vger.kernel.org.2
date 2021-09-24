Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD715416C8B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 09:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244297AbhIXHK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 03:10:29 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:27740 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231415AbhIXHK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 03:10:28 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18O78hc6004099;
        Fri, 24 Sep 2021 03:08:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=gekK1Ey3BsVMUva1NOyE8x7YSwJQ2QyivMqpVGpAWYE=;
 b=R24ZCJxUNi+oKVQemjeq9EZNAU1h3BFtSDwPlaq/RSHsJW01Zut4fxTiTFndewwJUG8M
 XC9JUz2KUAsx+EAUKcb7Z42q+HqnY9EoJTswcZcAPz3o6RDKq9tasSGcJMC/wbtTXlD8
 zP1KmC7BXGcuapilzScTSjX/Tut/WwXWbCH6KSF5MfKmgnbg5eIUWmEPyAnmw0/h1u8s
 bwIZoVQcHhcB7ws8MWDXrqcDKwsYGQq/gCmW8Vio1aZUV+sJRqytfoWhtjIplOPhxrKI
 7YX3PvVxF00tEmNthngWyUW+MhT9pH1wJcUEA+5wXtR2VQ1IwypoY3sthJhbbCwM6fjS Jw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3b979uumqe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Sep 2021 03:08:43 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 18O78g6Y031357;
        Fri, 24 Sep 2021 03:08:42 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3b979uumpy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Sep 2021 03:08:42 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18O77bBM001509;
        Fri, 24 Sep 2021 07:08:41 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma04dal.us.ibm.com with ESMTP id 3b93g1yep2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Sep 2021 07:08:41 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 18O78e7f13238702
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Sep 2021 07:08:40 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D042E28067;
        Fri, 24 Sep 2021 07:08:40 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2145528060;
        Fri, 24 Sep 2021 07:08:37 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.43.56.34])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 24 Sep 2021 07:08:36 +0000 (GMT)
X-Mailer: emacs 28.0.50 (via feedmail 11-beta-1 I)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>, Zi Yan <ziy@nvidia.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH v2 1/4] hugetlb: add demote hugetlb page sysfs interfaces
In-Reply-To: <20210923175347.10727-2-mike.kravetz@oracle.com>
References: <20210923175347.10727-1-mike.kravetz@oracle.com>
 <20210923175347.10727-2-mike.kravetz@oracle.com>
Date:   Fri, 24 Sep 2021 12:38:33 +0530
Message-ID: <878rzma1se.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jVg9Jfb5GYPIrwfpw4F3tf4-SV-YVcde
X-Proofpoint-ORIG-GUID: -V9dfMZYkHiG2u7vVoEA14SBaEqmmkj_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-24_02,2021-09-23_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 malwarescore=0 adultscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 mlxlogscore=999 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109230001 definitions=main-2109240041
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Kravetz <mike.kravetz@oracle.com> writes:

> Two new sysfs files are added to demote hugtlb pages.  These files are
> both per-hugetlb page size and per node.  Files are:
>   demote_size - The size in Kb that pages are demoted to. (read-write)
>   demote - The number of huge pages to demote. (write-only)
>
> By default, demote_size is the next smallest huge page size.  Valid huge
> page sizes less than huge page size may be written to this file.  When
> huge pages are demoted, they are demoted to this size.
>
> Writing a value to demote will result in an attempt to demote that
> number of hugetlb pages to an appropriate number of demote_size pages.
>
> NOTE: Demote interfaces are only provided for huge page sizes if there
> is a smaller target demote huge page size.  For example, on x86 1GB huge
> pages will have demote interfaces.  2MB huge pages will not have demote
> interfaces.

Should we also check if the platform allows for
gigantic_page_runtime_supported() ? 

-aneesh

