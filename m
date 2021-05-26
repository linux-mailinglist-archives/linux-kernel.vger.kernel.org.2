Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD113391417
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 11:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233615AbhEZJwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 05:52:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:27806 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233371AbhEZJwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 05:52:40 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14Q9XG0s172539;
        Wed, 26 May 2021 05:51:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Ri0pKesxv9W+MdnJzkWGEK8TYJm5vDy5ZDY6249VDI8=;
 b=En3Eyr+hjFavai3W6H1y/PPYH5yXbEuIFWLCynILv4yw2IIDS96e5k7UVw3ym+gTt1zc
 iIWDf4qCI2Y6ssKvuzlX1lIBByV578E8j3f6AUt55hBlr7+zSUbo42zgL67bnbp8VtMR
 4Nm6s8mTyp7TJtBnaa6ZMP3riUWVCQyideV3FcR3zbWVZsO2c47Sgtrld46UR0FKfn/D
 sSLuKTcNqbuqzVlQXJQPHxYiH6MPTeTsK9sUNWO+YNPm8ZvmNJuzZ6v6PoiieWa9o8T/
 rY2plKrlyECADDxjoAvGXIHf5JvkBKyEG8tspNwcnZBmtG26upgrg7ERAC2Zx2BOW4Qa 6g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38sh3m5g41-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 May 2021 05:51:06 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14Q9XMZ4173220;
        Wed, 26 May 2021 05:51:06 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38sh3m5g3h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 May 2021 05:51:06 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 14Q9lX4C006835;
        Wed, 26 May 2021 09:51:04 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma01fra.de.ibm.com with ESMTP id 38s1hq88ec-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 May 2021 09:51:04 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14Q9p1GE19464448
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 May 2021 09:51:01 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7B876AE058;
        Wed, 26 May 2021 09:51:01 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8F2E4AE057;
        Wed, 26 May 2021 09:50:59 +0000 (GMT)
Received: from [9.199.44.68] (unknown [9.199.44.68])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 26 May 2021 09:50:59 +0000 (GMT)
Subject: Re: [PATCH] tools/perf: doc: Add permission and sysctl notice
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, jolsa@redhat.com,
        linux-kernel@vger.kernel.org,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        acme@kernel.org, Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20210525043744.193297-1-ravi.bangoria@linux.ibm.com>
 <162201967838.287555.4257117900130102987.stgit@devnote2>
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Message-ID: <ebaefebf-76d0-790a-2062-6f451b683be8@linux.ibm.com>
Date:   Wed, 26 May 2021 15:20:58 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <162201967838.287555.4257117900130102987.stgit@devnote2>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: RT_4IJfMdW-sAa2FkvR_nll3nYbR_u8I
X-Proofpoint-GUID: h9fC0KkVj-SH4Tg4p0OIH69C5_-4FXQO
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-26_06:2021-05-25,2021-05-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 suspectscore=0 spamscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 malwarescore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105260063
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/26/21 2:31 PM, Masami Hiramatsu wrote:
> Add a section to notify the permission and sysctl setting
> for perf probe. And fix some indentations.

Yes, it makes sense to have this detail in man page.

Few minor points below ...

>   
> +PERMISSIONS AND SYSCTL
> +----------------------
> +Since perf probe depends on ftrace (tracefs) and kallsyms (/proc/kallsyms), you have to care about the permission and some sysctl knobs.
> +
> + - Since tracefs and kallsyms requires root or privileged user to access it, the following perf probe commands also require it; --add, --del, --list (except for --cache option)
> +
> + - /proc/sys/kernel/kptr_restrict = 2 (restrict all users) also prevents perf probe to retrieve the important information from kallsyms. You also need to set to 1 (restrict non CAP_SYSLOG users) for the above commands.
> +
> + - Since the perf probe commands read the vmlinux and/or the debuginfo file, you need to ensure that you can read those files.

1) Last two points are applicable to kprobes only, not uprobes. Would
    it make sense to clarify that?
2) For 3rd point, simple perf probe on function entry will work without
    vmlinux/debuginfo (by using kallsyms). Should we mention that?

In any case,

Acked-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>

Ravi
