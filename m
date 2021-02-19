Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81B013201F1
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Feb 2021 00:46:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbhBSXnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 18:43:24 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:18254 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229553AbhBSXnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 18:43:21 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11JNV1Nb174109;
        Fri, 19 Feb 2021 18:42:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=references : from : to :
 cc : subject : in-reply-to : date : message-id : mime-version :
 content-type; s=pp1; bh=W4HRt9rt7VE+dLmetxPYWNoKx7bCDFj1qgN3EA+vKec=;
 b=i9DhreR/jkELwna3Ud0e94tmCW13Paf8mfuUNHuHsCXS/ZQxgLxU8MIHW+65ArOw5Elw
 eD5lAtJk3wGJhCNNksV/V/BD8dIi1hngrQnTT9MrMRy9wOeFJey0poLBGRmWYh/t1A6M
 mnmYGYtI9RBvUIFELfHcyxfVq2wi4GoYfa5YY38fmRzQMv3EFsoqRr7z6SsK2eseYmKg
 YMJz2wXYBo089yub36i7GPl2gbgH/qfoQIu8AOoatoIBIW5ItqK9xuuTrDQ8ljhsU7af
 YLtHACTSsIseJ9Ufb4eDBbkPvfgExsTzo52TNt1lOxqCNnNkZeRlTzs4qem6UpNgKIaL 6w== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36tn71tsbw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Feb 2021 18:42:21 -0500
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11JNaf4F010472;
        Fri, 19 Feb 2021 23:42:20 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma02dal.us.ibm.com with ESMTP id 36p6dan744-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Feb 2021 23:42:20 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11JNgJRE20054442
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Feb 2021 23:42:19 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 91482112063;
        Fri, 19 Feb 2021 23:42:19 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D79BC112061;
        Fri, 19 Feb 2021 23:42:17 +0000 (GMT)
Received: from manicouagan.localdomain (unknown [9.85.174.98])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTPS;
        Fri, 19 Feb 2021 23:42:17 +0000 (GMT)
References: <20210219142552.762608-1-bauerman@linux.ibm.com>
 <5a28907e-9231-7a19-62ff-3ed1c0282642@linux.microsoft.com>
User-agent: mu4e 1.4.10; emacs 27.1
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org,
        Hari Bathini <hbathini@linux.ibm.com>,
        Rob Herring <robh@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/kexec_file: Restore FDT size estimation for
 kdump kernel
In-reply-to: <5a28907e-9231-7a19-62ff-3ed1c0282642@linux.microsoft.com>
Date:   Fri, 19 Feb 2021 20:42:16 -0300
Message-ID: <878s7jy693.fsf@manicouagan.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-19_08:2021-02-18,2021-02-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 spamscore=0 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102190187
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Lakshmi Ramasubramanian <nramas@linux.microsoft.com> writes:

> On 2/19/21 6:25 AM, Thiago Jung Bauermann wrote:
>
> One small nit in the function header (please see below), but otherwise the
> change looks good.
>
> Reviewed-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>

Thanks for your review. I incorporated your suggestion and will send v2
shortly.

>> --- a/arch/powerpc/kexec/file_load_64.c
>> +++ b/arch/powerpc/kexec/file_load_64.c
>> @@ -927,37 +927,27 @@ int setup_purgatory_ppc64(struct kimage *image, const void *slave_code,
>>   }
>>     /**
>> - * kexec_fdt_totalsize_ppc64 - Return the estimated size needed to setup FDT
>> - *                             for kexec/kdump kernel.
>> - * @image:                     kexec image being loaded.
>> + * kexec_extra_fdt_size_ppc63 - Return the estimated size needed to setup FDT
>
> Perhaps change to
>
> "Return the estimated additional size needed to setup FDT for kexec/kdump
> kernel"?

That's better indeed. I also hadn't noticed that I changed ppc64 to
ppc63. Fixed as well.

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
