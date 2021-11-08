Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F97944821C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 15:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237009AbhKHOuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 09:50:03 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44750 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230455AbhKHOuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 09:50:02 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A8CV17j020808;
        Mon, 8 Nov 2021 14:47:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=XfgYbd8v1IlUJL9o8E4V2sg4kt/L5aw4Y5kh8jOXQH0=;
 b=ckkH32upb1+9WH1jSLOTBbIl0+6FxJNzdZbhCkzCrXjfrlzPaO4GvaiuxCzwdSSqv2Or
 8o5kHby+DvTo0wmdaJ9UpVM/s8fSggnwk8oKkI08qmEjJZZd0b5Z5tAtR0X9lkQU1QNU
 XoErRu4wnlHwk6Ql3F/OcN3ydmcKrAl4apr2wKqH1J/fn3slCy47VWmTjrcv7rrW09Yw
 MsHeKm1VD7XO9M/ZvjpuZu8WfquR4XG36x8L4f2oeW6qkv4SXna1ZqxeWycHDPSW2+VN
 M6HQ7nCdsPtnFS2m+Eq1lTIvrBUlfyYmZusWAWKetNGA8X0OP6v8uJjeaQKFuJGqxMV2 bg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3c69dmyv96-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Nov 2021 14:47:10 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1A8DsUtQ037681;
        Mon, 8 Nov 2021 14:47:10 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3c69dmyv8u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Nov 2021 14:47:10 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1A8EhAZl019157;
        Mon, 8 Nov 2021 14:47:09 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma02dal.us.ibm.com with ESMTP id 3c5hbacuby-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Nov 2021 14:47:09 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1A8El7cK55378354
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 8 Nov 2021 14:47:07 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3AF4028068;
        Mon,  8 Nov 2021 14:47:07 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6F90F2806E;
        Mon,  8 Nov 2021 14:47:05 +0000 (GMT)
Received: from li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com (unknown [9.160.169.99])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTPS;
        Mon,  8 Nov 2021 14:47:05 +0000 (GMT)
Date:   Mon, 8 Nov 2021 08:47:02 -0600
From:   "Paul A. Clarke" <pc@us.ibm.com>
To:     Kajol Jain <kjain@linux.ibm.com>
Cc:     acme@kernel.org, maddy@linux.vnet.ibm.com, rnsastry@linux.ibm.com,
        jolsa@redhat.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, atrajeev@linux.vnet.ibm.com,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3] perf vendor events power10: Add metric events json
 file for power10 platform
Message-ID: <20211108144702.GB12060@li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com>
References: <20211108060010.177517-1-kjain@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211108060010.177517-1-kjain@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3sEfnXqXYv7Npkg5frIOJXre-p6FyeCP
X-Proofpoint-ORIG-GUID: v4yb8k9-4Xg4UWYZAB7R0MxwPs9uI59S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-08_05,2021-11-08_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 clxscore=1011 adultscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111080090
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 08, 2021 at 11:30:10AM +0530, Kajol Jain wrote:
> Add pmu metric json file for power10 platform.
> 
> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
> ---
> Changelog
> v2 -> v3:
> - Did nit changes in BriefDescription as suggested
>   by Paul A. Clarke and Michael Ellermen

LGTM.

Reviewed-by: Paul A. Clarke <pc@us.ibm.com>

PC
