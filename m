Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7F07380804
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 13:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbhENLE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 07:04:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:27200 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230525AbhENLEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 07:04:53 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14EB2oTQ066963;
        Fri, 14 May 2021 07:03:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : mime-version :
 content-type; s=pp1; bh=trM4RvVKWsggwPkZQfHTLqfcekUi7iRQiTHlwo0qPQQ=;
 b=qMfSAkl3vLYMlRiZPKQ4TUkwSFD6PPIurI5XqiR7sOUOsLnTeqZEoflwo8Mg/4d3VF6w
 VYqBSMRtkyZ5UbDIzlZ3ramFDtPWeUkfLJLaHyYHvPFgs1Z9J+/8iihODrvckBi0TUBB
 khz6Z7giGV3lFEwdx2bcTId92A9ZFl4u7n0D/zHNL+wqnahD+GdzC0YFEGMtsPvMNhMH
 m9U8I5KAViqU3zpmd4ckI9/xeF6ExVC4+6LCuMpGBRTMFs2fNgKtCuLOJK2y6bA8lxuk
 WBZtSfEMH6BLtiRGFYpCQkZN0pSy5e9tKhydzAkQez4Ep7D/lDlkAqh4KAC/SkG8yU+A OA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38hj2xyv26-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 May 2021 07:03:41 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14EB38E0069351;
        Fri, 14 May 2021 07:03:40 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38hj2xyv1d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 May 2021 07:03:40 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14EB3cG3013243;
        Fri, 14 May 2021 11:03:38 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma01fra.de.ibm.com with ESMTP id 38hc6u84fd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 May 2021 11:03:38 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14EB3aoo27394458
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 May 2021 11:03:36 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F360CA4054;
        Fri, 14 May 2021 11:03:35 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C29EDA405C;
        Fri, 14 May 2021 11:03:35 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 14 May 2021 11:03:35 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Marco Elver <elver@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Alexander Potapenko <glider@google.com>
Subject: Re: [PATCH 1/2] kfence: add function to mask address bits
References: <20210514092139.3225509-1-svens@linux.ibm.com>
        <20210514092139.3225509-2-svens@linux.ibm.com>
        <CANpmjNNB=KTDBb65qtNwrPbwnbD2ThAFchA1HSCg9HKETkQvCg@mail.gmail.com>
Date:   Fri, 14 May 2021 13:03:35 +0200
In-Reply-To: <CANpmjNNB=KTDBb65qtNwrPbwnbD2ThAFchA1HSCg9HKETkQvCg@mail.gmail.com>
        (Marco Elver's message of "Fri, 14 May 2021 12:54:11 +0200")
Message-ID: <yt9dfsypinlk.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: WLxwDTnW79MZMK5F4j3qlMRIvVaEa87j
X-Proofpoint-GUID: rik4xugDhTQ30p5phi8M9e28La1f_tPy
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-14_04:2021-05-12,2021-05-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 bulkscore=0 adultscore=0 spamscore=0 impostorscore=0 mlxscore=0
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105140085
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marco Elver <elver@google.com> writes:

>> diff --git a/mm/kfence/core.c b/mm/kfence/core.c
>> index e18fbbd5d9b4..bc15e3cb71d5 100644
>> --- a/mm/kfence/core.c
>> +++ b/mm/kfence/core.c
>> @@ -50,6 +50,11 @@ static unsigned long kfence_sample_interval __read_mostly = CONFIG_KFENCE_SAMPLE
>>  #endif
>>  #define MODULE_PARAM_PREFIX "kfence."
>>
>> +unsigned long __weak kfence_arch_mask_addr(unsigned long addr)
>> +{
>> +       return addr;
>> +}
>
> I don't think this belongs here, because it's test-specific,
> furthermore if possible we'd like to put all arch-specific code into
> <asm/kfence.h> (whether or not your arch will have 'static inline'
> functions only, like x86 and arm64, or not is up to you).
>
> Because I don't see this function being terribly complex, also let's
> just make it a macro.
>
> Then in kfence_test.c, we can have:
>
> #ifndef kfence_test_mask_address
> #define kfence_test_mask_address(addr) (addr)
> #endif
>
> and then have it include <asm/kfence.h>. And in your <asm/kfence.h>
> you can simply say:
>
> #define kfence_test_mask_address(addr) (.........)
>
> It also avoids having to export kfence_test_mask_address, because
> kfence_test can be built as a module.
 
Ok, i'll change my patch accordingly. Thanks!

Sven
