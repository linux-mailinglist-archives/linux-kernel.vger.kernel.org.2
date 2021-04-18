Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65B0D3637BE
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Apr 2021 23:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231924AbhDRVJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Apr 2021 17:09:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52696 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229470AbhDRVJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Apr 2021 17:09:25 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13IL4EN8140026;
        Sun, 18 Apr 2021 17:08:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=GlpfFybMxhX3l/tszkEhB1wun0R3HDvFs5Opdi6MidI=;
 b=nulhOh7+FwMip4woMgONOjsRlUKMV0pY9QO9QMAxKCsZ7hKHNdVfm6+utRRZp4s5DWU1
 JrTXMHMIStlv3KfK+VGnrOZGhUUl0zzyGvt2jooed7NWi9+ZnhBYZLcscOrNhnRfjc2L
 p6qZBZC02ha2n9wuV/gOufnn+paH86e2tZ1afs0x9+yEGJ+tnpYYKiW635pPbj/EoYEm
 aStsTVXJ6Avt+aGeFMfC14KYRNNm64pJ65DR+98gajM+t2k9LsMxaThQoDtSfGiwZ8+d
 rZvUTzHwhI0GU97Wva67QdQFNewfQgEBgaUuKMIY4OEGzljRq1j/nZy7iuSbCDQ5em20 fQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 380d6u4wbb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 18 Apr 2021 17:08:45 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 13IL8WUq151285;
        Sun, 18 Apr 2021 17:08:44 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 380d6u4way-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 18 Apr 2021 17:08:44 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13IL6MsT016479;
        Sun, 18 Apr 2021 21:08:43 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma04wdc.us.ibm.com with ESMTP id 37yqa94vpb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 18 Apr 2021 21:08:43 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13IL8gXw31654160
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 18 Apr 2021 21:08:42 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 33FAA6E04C;
        Sun, 18 Apr 2021 21:08:42 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F09FE6E052;
        Sun, 18 Apr 2021 21:08:40 +0000 (GMT)
Received: from li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com (unknown [9.80.215.120])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Sun, 18 Apr 2021 21:08:40 +0000 (GMT)
Date:   Sun, 18 Apr 2021 16:08:38 -0500
From:   "Paul A. Clarke" <pc@us.ibm.com>
To:     Kajol Jain <kjain@linux.ibm.com>
Cc:     acme@kernel.org, maddy@linux.vnet.ibm.com,
        atrajeev@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        jolsa@redhat.com, mpe@ellerman.id.au, ravi.bangoria@linux.ibm.com,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] perf vendor events: Initial json/events list for power10
 platform
Message-ID: <20210418210838.GA1845018@li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com>
References: <20210417091850.596023-1-kjain@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210417091850.596023-1-kjain@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: iTPRTMvvFGLqYmLdim0CnCBl82P3s02-
X-Proofpoint-ORIG-GUID: L5DE-voB-aJlTPQ_WJmS-rh889xGRRmB
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-18_14:2021-04-16,2021-04-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1011 phishscore=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104180151
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 17, 2021 at 02:48:50PM +0530, Kajol Jain wrote:
> Patch adds initial json/events for POWER10.

I was able to apply, build, and run perf with these changes,
and every new event at least ran successfully with
`perf stat`.

Pedantically, there is a lot of inconsistency as to whether
the `BriefDescription` ends with a period or not, and whether
there is an extra space at the end.

Regardless, LGTM.

Tested-by: Paul A. Clarke <pc@us.ibm.com>
Reviewed-by: Paul A. Clarke <pc@us.ibm.com>

PC
