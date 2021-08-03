Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3673DF3F7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 19:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238259AbhHCReC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 13:34:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54012 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238204AbhHCReB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 13:34:01 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 173HWpWe087813;
        Tue, 3 Aug 2021 13:33:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=cCDpH0wxLgsG472IZpSQMxzENkGiSe8p50J19DEYlNc=;
 b=ptX4z8vZe4oAjAoCrqJg8A+lfmCLrrDWSwvqa/acZXZeKd06nYc4FlZlUy1h3NtjfXle
 xZT4su+HpMGXOuDyLsOEEgXofnY0a5PJG78+LgDZ2Yie404dAjX7hdnNJQzoRfVNnckg
 4zntITw6KXFcMEv3KWQTh2e9OQ3vTmnZn6EMVKJMz4Uox/8iHzpEOA1E/OVp6ImQzizL
 qPWLHDKbPz5toE4tcsJI7/CQQqIFzz7mFahu5N3wcG928ncl0q7X/RsaKcKtKo/I+R1s
 ezBfPCJ2IPxi6yb+RgYm51LfmfnykTJXipVcSKl3wvYABiEnwzLYxMq8nsrEAUnhW239 RA== 
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a76c3qna1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Aug 2021 13:33:30 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 173HXSAD022074;
        Tue, 3 Aug 2021 17:33:29 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma03wdc.us.ibm.com with ESMTP id 3a77h275pp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Aug 2021 17:33:29 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 173HWJNb17170872
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Aug 2021 17:32:19 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 746A9136059;
        Tue,  3 Aug 2021 17:32:19 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 415B8136066;
        Tue,  3 Aug 2021 17:32:19 +0000 (GMT)
Received: from localhost (unknown [9.211.83.167])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue,  3 Aug 2021 17:32:19 +0000 (GMT)
From:   Nathan Lynch <nathanl@linux.ibm.com>
To:     Laurent Dufour <ldufour@linux.ibm.com>, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Tyrel Datwyler <tyreld@linux.ibm.com>
Subject: Re: [PATCH v5] pseries/drmem: update LMBs after LPM
In-Reply-To: <20210517090606.56930-1-ldufour@linux.ibm.com>
References: <20210517090606.56930-1-ldufour@linux.ibm.com>
Date:   Tue, 03 Aug 2021 12:32:18 -0500
Message-ID: <87sfzqigd9.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 32U_qgmhxpb1IM8Qvg1WXhA3HHFJCxtI
X-Proofpoint-GUID: 32U_qgmhxpb1IM8Qvg1WXhA3HHFJCxtI
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-03_05:2021-08-03,2021-08-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=989
 priorityscore=1501 adultscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 mlxscore=0 suspectscore=0 spamscore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108030114
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Laurent Dufour <ldufour@linux.ibm.com> writes:
> V5:
>  - Reword the commit's description to address Nathan's comments.

Thanks. Still don't like the global variable usage but:

Reviewed-by: Nathan Lynch <nathanl@linux.ibm.com>
