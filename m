Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 917423BA0C9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 14:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbhGBNAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 09:00:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:5948 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230241AbhGBNAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 09:00:49 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 162CoWFI026101;
        Fri, 2 Jul 2021 08:58:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=xs/6hlZjQuoUQvWGcjJhhbaIAz6wjASnn/gi1LXJyiw=;
 b=FmrmJ08I9nwX/WWz5Fn9hcyD4oXK3DAG0Tq/mKw3CQQ1lAIro0uqSFUaGvsr8O33gI/4
 mRl7c6OepMtiT1oi8lNO/OoSPs93ZFDjyq4cioW3jXzQ45a0anjmLRlS16wstAKvE0X5
 MECji/Rntg3MQcdya5TWaXT07TRMvNONM7+qWqSAptR4jJA0d4jAkVFfqnHDlBQ3wgeu
 VfEgxVZkNu6Nbz7GzUDtv6oRnPNcVIxUcGS37PcKcWJ0rJFS4u9eV8Ti8g89SW0S5wbG
 Xr+kum9F1+xnRmRt6xobGJQs8vDRqH69xvFDhqAskcD3LFr+JXBpcPcVF12+RItbj2hA NQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39j1r2jt4x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Jul 2021 08:58:10 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 162Cp5v2031411;
        Fri, 2 Jul 2021 08:58:10 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39j1r2jt3j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Jul 2021 08:58:10 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 162Cw7mO013841;
        Fri, 2 Jul 2021 12:58:07 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06fra.de.ibm.com with ESMTP id 39dugh9hcx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Jul 2021 12:58:07 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 162Cw5YX35062246
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 2 Jul 2021 12:58:05 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2600EA4065;
        Fri,  2 Jul 2021 12:58:05 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 39051A405B;
        Fri,  2 Jul 2021 12:58:04 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.56.105])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri,  2 Jul 2021 12:58:04 +0000 (GMT)
Date:   Fri, 2 Jul 2021 15:58:02 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Ohhoon Kwon <ohoono.kwon@samsung.com>
Cc:     david@redhat.com, akpm@linux-foundation.org, mhocko@suse.com,
        bhe@redhat.com, ohkwon1043@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] mm: sparse: remove __section_nr() function
Message-ID: <YN8NWgf5yTHbsVlG@linux.ibm.com>
References: <CGME20210702094457epcas1p295611b5799befffd016b8fccf3adceff@epcas1p2.samsung.com>
 <20210702094132.6276-1-ohoono.kwon@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210702094132.6276-1-ohoono.kwon@samsung.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: YYDbHV_vzNz1fbfLO-0P3ZwY3K0sPTYN
X-Proofpoint-ORIG-GUID: ZHtTQqajxKLgkXyeXZRm-n6NcH_KE2fK
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-02_04:2021-07-02,2021-07-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 clxscore=1011 spamscore=0
 mlxlogscore=867 phishscore=0 priorityscore=1501 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107020070
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 02, 2021 at 06:41:29PM +0900, Ohhoon Kwon wrote:
> This series contains cleanups to remove __section_nr().
> 
> When CONFIG_SPARSEMEM_EXTREME is enabled, __section_nr() could be
> costly since it iterates all section roots to check if the given
> mem_section is in its range.
> 
> On the other hand, __nr_to_section which converts section_nr to
> mem_section can be done in O(1).
> 
> The only users of __section_nr() was section_mark_present() and
> find_memory_block().
> 
> PATCH 1 & 2 changes both functions to use section_nr instead of
> mem_section.
> PATCH 3 finally removes __section_nr() function.
> 
> More details can be found in each changelogs.
> 
> Ohhoon Kwon (3):
>   mm: sparse: pass section_nr to section_mark_present
>   mm: sparse: pass section_nr to find_memory_block
>   mm: sparse: remove __section_nr() function
> 
>  .../platforms/pseries/hotplug-memory.c        |  4 +--
>  drivers/base/memory.c                         |  4 +--
>  include/linux/memory.h                        |  2 +-
>  include/linux/mmzone.h                        |  1 -
>  mm/sparse.c                                   | 35 +++----------------
>  5 files changed, 9 insertions(+), 37 deletions(-)
> 
> -- 
> 2.17.1
 
For the series:

Acked-by: Mike Rapoport <rppt@linux.ibm.com>

-- 
Sincerely yours,
Mike.
