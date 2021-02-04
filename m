Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73E6130ED80
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 08:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234102AbhBDHib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 02:38:31 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:61226 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233516AbhBDHi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 02:38:26 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 1147WVCh081037;
        Thu, 4 Feb 2021 02:36:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=reply-to : subject : to
 : cc : references : from : message-id : date : mime-version : in-reply-to
 : content-type : content-transfer-encoding; s=pp1;
 bh=TJR3Tk1aFST8qdXh/a914iqptdMPK9i2vtz1+sNSTJc=;
 b=bqURimFFPWmJdO5/psTrw+95u7nP8DNE6ZhMmH5Zza6NscSMkKV+tjhQM00fLY4mgPuH
 AfhiMg7LcHVprwQvWiRjJf4NrMaOcQqBtBiC70VRxIahqD1yy7TZ6gImcJSSBOmHZEx4
 xqCQzyxFqWbJodFpQxt3Q5mUPtm5i5Yvsn7jp2Zj67KYJVJBYryS03LFHrIqk/gC9ob8
 VBb1J6g3g0uPWubYteb7sZEyYgVnMSCdqdl7Z4zBJYjd/I4VZsD305/ILQXBKxveeWWG
 nR3av80yZ5xuJAv/IG7G4VK1fYWKQVzdYdNHwSM9JkrCzCtlwIi9YKU3OgM7H0mvzVy5 NQ== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36gcd0re53-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Feb 2021 02:36:28 -0500
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 1147W88c004759;
        Thu, 4 Feb 2021 07:36:28 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma03dal.us.ibm.com with ESMTP id 36f3kvkjr2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Feb 2021 07:36:28 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1147aRo912583308
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 4 Feb 2021 07:36:27 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 491B1AC05F;
        Thu,  4 Feb 2021 07:36:27 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D95ABAC05B;
        Thu,  4 Feb 2021 07:36:24 +0000 (GMT)
Received: from [9.85.93.213] (unknown [9.85.93.213])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  4 Feb 2021 07:36:24 +0000 (GMT)
Reply-To: ananth@linux.ibm.com
Subject: Re: [PATCH] kprobes: Warn if the kprobe is reregistered
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Wang ShaoBo <bobo.shaobowang@huawei.com>,
        Cheng Jian <cj.chengjian@huawei.com>,
        linux-kernel@vger.kernel.org
References: <161236436734.194052.4058506306336814476.stgit@devnote2>
From:   Ananth N Mavinakayanahalli <ananth@linux.ibm.com>
Organization: IBM
Message-ID: <c2b78276-1083-5cd3-909f-b2478b195d47@linux.ibm.com>
Date:   Thu, 4 Feb 2021 13:06:23 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <161236436734.194052.4058506306336814476.stgit@devnote2>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-04_03:2021-02-04,2021-02-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1011
 mlxlogscore=876 malwarescore=0 lowpriorityscore=0 spamscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 mlxscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102040041
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/3/21 8:29 PM, Masami Hiramatsu wrote:
> Warn if the kprobe is reregistered, since there must be
> a software bug (actively used resource must not be re-registered)
> and caller must be fixed.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>

Acked-by: Ananth N Mavinakayanahalli <ananth@linux.ibm.com>
