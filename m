Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD8A3A5729
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jun 2021 10:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbhFMI52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Jun 2021 04:57:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35920 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229777AbhFMI50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jun 2021 04:57:26 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15D8nLgV193761;
        Sun, 13 Jun 2021 04:55:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=esj5tPQeJcpVec3YFOVQCWEg/G/ACHW+fjAwIVzKyGE=;
 b=E+aLP59bKP9foOqTDO8Dvr2hHt/84XVZGP4VheKc6ECvV9tSZglRf2KpGTSZYObZiHJO
 Qk18MzyqoLpgiBzenb2KoYrMMxRE226ByUkuqANldtlYTV8yWLKNznA6nn8tk0P/d0/+
 dWHwsrKThkgjYE5DYShT+Z4yyEviMABkjJdVqoFz1U+fnhwTBvu5uK1SiNfBeh40ZYHS
 lPQluVLf2raiYgSsfn+uS2zp6A7DB8qRO4yJwhLFCsSBkeuOEt1krT1yOfIvE9YUGHgc
 AsCHn1RzCgp8HQ9FKDnidcMYxcu7MRuStDELrgk3+sWsCops4AkJwGHAHaoFmctnZFHh Rw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 395euk8218-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 13 Jun 2021 04:55:02 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 15D8o6mj195548;
        Sun, 13 Jun 2021 04:55:02 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0b-001b2d01.pphosted.com with ESMTP id 395euk820w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 13 Jun 2021 04:55:02 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15D8qHDt017996;
        Sun, 13 Jun 2021 08:55:01 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma04wdc.us.ibm.com with ESMTP id 394mj8ypj0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 13 Jun 2021 08:55:01 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15D8t0eW22741264
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 13 Jun 2021 08:55:00 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F1C1DC6057;
        Sun, 13 Jun 2021 08:54:59 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 78886C6059;
        Sun, 13 Jun 2021 08:54:54 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.85.68.237])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Sun, 13 Jun 2021 08:54:54 +0000 (GMT)
X-Mailer: emacs 28.0.50 (via feedmail 11-beta-1 I)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>, tglx@linutronix.de,
        linuxram@us.ibm.com, sandipan@linux.ibm.com,
        akpm@linux-foundation.org, fweimer@redhat.com,
        desnesn@linux.vnet.ibm.com, mingo@kernel.org,
        bauerman@linux.ibm.com, mpe@ellerman.id.au, mhocko@kernel.org,
        msuchanek@suse.de, shuah@kernel.org, x86@kernel.org
Subject: Re: [PATCH 0/4] selftests/vm/pkeys: Bug fixes and a new test
In-Reply-To: <20210611164153.91B76FB8@viggo.jf.intel.com>
References: <20210611164153.91B76FB8@viggo.jf.intel.com>
Date:   Sun, 13 Jun 2021 14:24:50 +0530
Message-ID: <871r96b0v9.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4PGnVxs3JmjNcpMh8tEmaxzCWjgdiESr
X-Proofpoint-GUID: aHKAA9II48l7VeEN5pIxoKV2fFUPT7EP
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-13_02:2021-06-11,2021-06-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1011 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106130063
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen <dave.hansen@linux.intel.com> writes:

> There has been a lot of activity on the x86 front around the XSAVE
> architecture which is used to context-switch processor state (among
> other things).  In addition, AMD has recently joined the protection
> keys club by adding processor support for PKU.
>
> The AMD implementation helped uncover a kernel bug around the PKRU
> "init state", which actually applied to Intel's implementation but
> was just harder to hit.  This series adds a test which is expected
> to help find this class of bug both on AMD and Intel.  All the work
> around pkeys on x86 also uncovered a few bugs in the selftest.
>
> Any testing of this new code (especially from my powerpc friends)
> would be appreciated.

I tested this on ppc64.

Tested-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ram Pai <linuxram@us.ibm.com>
> Cc: Sandipan Das <sandipan@linux.ibm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Florian Weimer <fweimer@redhat.com>
> Cc: "Desnes A. Nunes do Rosario" <desnesn@linux.vnet.ibm.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Michal Suchanek <msuchanek@suse.de>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: x86@kernel.org
