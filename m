Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71AB53989C0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 14:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbhFBMhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 08:37:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:30036 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229610AbhFBMhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 08:37:21 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 152CYVHZ135012;
        Wed, 2 Jun 2021 08:35:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=6k50fOEFi7RXAL8U0g6F+fY7m6rM8rdiM5Z6yO1JrRM=;
 b=KXcEZVzMU8fH0Kj2vqtNHwQLOwfapZzme5cTmzXY3qAbgk7xeM6z0Hlwd/AGCmDr+SgO
 bBX0pZJxBsbdGMNbtUlmHuxBPRTfd3Tq505uiJkmdaqfEeXgs/xnl5+WzW47RJed/s65
 bskrGH6Od4F0wTFWF1p8PkBwgtBzwIypSZEOiUe4eaiet/pkmshrgc4OuKOv1z8ca/B6
 A9GM0fp3EtBz/v4ZNyenhD3xemom7QtYZ1LdZGzDXshsSFS8wQPElxBBK4RlIeF37bGx
 hkxpS94MV1gcuk6B4H6uE1uQvOzLWpRyE7BAafpVOJXt+3tTrgUoHMEkrNf+ErpCSPlF +Q== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38x9hm16ku-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Jun 2021 08:35:36 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 152CSsvd023646;
        Wed, 2 Jun 2021 12:35:33 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06fra.de.ibm.com with ESMTP id 38ucvh99t0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Jun 2021 12:35:33 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 152CZV4Z23462178
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Jun 2021 12:35:31 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 67686AE053;
        Wed,  2 Jun 2021 12:35:31 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4726FAE05A;
        Wed,  2 Jun 2021 12:35:31 +0000 (GMT)
Received: from [9.145.65.140] (unknown [9.145.65.140])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  2 Jun 2021 12:35:31 +0000 (GMT)
Subject: Re: gcov: NULL pointer dereference with gcc 9.3.1
To:     Luis Henriques <lhenriques@suse.de>
Cc:     linux-kernel@vger.kernel.org
References: <YLZYwgs5hyzFZMlw@suse.de>
From:   Peter Oberparleiter <oberpar@linux.ibm.com>
Message-ID: <0a013450-75eb-de2c-f90a-3df193800cea@linux.ibm.com>
Date:   Wed, 2 Jun 2021 14:35:31 +0200
MIME-Version: 1.0
In-Reply-To: <YLZYwgs5hyzFZMlw@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: j7QsMlzIdIj-iRysBRinfblzFRBMw2gJ
X-Proofpoint-GUID: j7QsMlzIdIj-iRysBRinfblzFRBMw2gJ
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-02_07:2021-06-02,2021-06-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 suspectscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106020080
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.06.2021 17:56, Luis Henriques wrote:
> Hi!
> 
> Maybe this is a known (gcc?) issue, but I'm seeing a NULL pointer splat if
> I instrument my kernel (or a module, more specifically) using gcc 9.3.1.
> 
> It looks like, during initialization in __gcov_init(), gcov_info struct is
> invalid: the filename seems to be correct but ->function is NULL and
> ->n_functions contains garbage.

Thanks for reporting this issue. The symptoms you're seeing look similar
to those that occur when the struct gcov_info layout emitted by GCC does
not match the one used by the kernel. In particular a change in the
GCOV_COUNTER value can cause this behavior.

I've checked upstream GCC 9.3.1 and it seems to match what is used by
the kernel for that GCC version. Could you provide the exact version of
the compiler you are using? Both 'gcc --version' output and the GCC
package version should help. Also what architecture are you seeing this on?


Regards,
  Peter Oberparleiter

-- 
Peter Oberparleiter
Linux on Z Development - IBM Germany
