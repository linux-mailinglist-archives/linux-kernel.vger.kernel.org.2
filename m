Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3900F357524
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 21:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355666AbhDGTs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 15:48:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:64962 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347438AbhDGTs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 15:48:56 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 137JXuub050484;
        Wed, 7 Apr 2021 15:48:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=agNhum4PDDzPx6WMBBM+gy6P2qjJ+8WKlt8/mCOSlQw=;
 b=q0neIZmQd8t9Czq6/qEplwHJkve94E1lLwnXowBl4eLqYiDTmUu0S7liID8qqR2S+EPw
 5cE+E8fsMPtobEjG7QUgTrRJbJGaB4wGey4vflSqFzz6g5pyZszWwFsEew2JA2YfBU8m
 1z5Sf0N8FrP/qJ9oysuA0HGk3R9DuwbSxWm/nV0xYXGwnhLD9ulyFoLjCjhFAd0ADdHi
 Gw6iVfAPcHTOJiSgyIQthY2pCXX+pgqQ7HAseWbAxFsWfV4FvXFKH/Dyolxlz7avUJBg
 iO0XSs8dFG60exarGM4cdP97oFIxBX9onQaR0tkFQ09stzqfTWLlZj9OgjiJam7JpGke 6g== 
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37rvn0umc8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Apr 2021 15:48:30 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 137Jhp1w007590;
        Wed, 7 Apr 2021 19:48:29 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma04dal.us.ibm.com with ESMTP id 37rvc41tdd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Apr 2021 19:48:29 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 137JmSoj24642000
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 7 Apr 2021 19:48:28 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2154DBE053;
        Wed,  7 Apr 2021 19:48:28 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E2B1ABE04F;
        Wed,  7 Apr 2021 19:48:27 +0000 (GMT)
Received: from localhost (unknown [9.211.35.170])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed,  7 Apr 2021 19:48:27 +0000 (GMT)
From:   Nathan Lynch <nathanl@linux.ibm.com>
To:     Laurent Dufour <ldufour@linux.ibm.com>
Cc:     cheloha@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org
Subject: Re: [PATCH v4] pseries: prevent free CPU ids to be reused on
 another node
In-Reply-To: <20210407153808.59993-1-ldufour@linux.ibm.com>
References: <20210407153808.59993-1-ldufour@linux.ibm.com>
Date:   Wed, 07 Apr 2021 14:48:27 -0500
Message-ID: <875z0xlvuc.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _DF6cQbtfRXmnkPQ9q6cHUT0abp3qKQj
X-Proofpoint-ORIG-GUID: _DF6cQbtfRXmnkPQ9q6cHUT0abp3qKQj
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-07_10:2021-04-07,2021-04-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 mlxlogscore=999 bulkscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 spamscore=0 mlxscore=0 malwarescore=0 impostorscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104070135
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Laurent Dufour <ldufour@linux.ibm.com> writes:
>
> Changes since V3, addressing Nathan's comment:
>  - Rename the local variable named 'nid' into 'assigned_node'
> Changes since V2, addressing Nathan's comments:
>  - Remove the retry feature
>  - Reduce the number of local variables (removing 'i')
>  - Add comment about the cpu_add_remove_lock protecting the added CPU mask.
> Changes since V1 (no functional changes):
>  - update the test's output in the commit's description
>  - node_recorded_ids_map should be static
>
> Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>

Thanks Laurent.

Reviewed-by: Nathan Lynch <nathanl@linux.ibm.com>
