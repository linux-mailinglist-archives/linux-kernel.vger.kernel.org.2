Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E924398B0C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 15:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbhFBNx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 09:53:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37726 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229586AbhFBNx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 09:53:27 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 152DgEDC168782;
        Wed, 2 Jun 2021 09:51:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=qfNM/XhBX5lWNVZn2ehIENB7gU1KS89SDpB1ynLYkBQ=;
 b=psmPypP4PYkDCWpl+ks/+ZPbf60VRONdS7zOFTfRU8XzPII9WIeT4wB3qAnCChfOgoSe
 lyCjZJ/THp9WC2/jPv8+oK0xzuMBuK2FTxEqEvq+O/TUTjMG8GfZ0wPQBRkgq2IQR249
 mR79yPCv78B6KcQu4B9Y6p9qKB6WNVBRvhbr/IW2kkWi+n5NoEgbQfy40brfBEqHJ2RP
 HvZzz4/2gpvgWSWL5gqQKtg9+AXJY2lWDKGY3QT6KW5hy8qYZBHg+RcRqCkHp1B+7vEA
 r3W+wqvNl0Lh49XM1+ibGXYFCeCqPb0XBE2iqSpBOt7M+iB+VlnZbi1fRGMXCXu0JTuN ag== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38xb3u0884-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Jun 2021 09:51:43 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 152DhtX1179375;
        Wed, 2 Jun 2021 09:51:43 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38xb3u0876-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Jun 2021 09:51:43 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 152DlFlc029681;
        Wed, 2 Jun 2021 13:51:40 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 38ucvhacnu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Jun 2021 13:51:40 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 152DpbRC33751452
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Jun 2021 13:51:37 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 196F14C04E;
        Wed,  2 Jun 2021 13:51:37 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 506404C050;
        Wed,  2 Jun 2021 13:51:35 +0000 (GMT)
Received: from [9.199.40.47] (unknown [9.199.40.47])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  2 Jun 2021 13:51:35 +0000 (GMT)
Subject: Re: [PATCH v2] tools/perf: doc: Add permission and sysctl notice
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>, jolsa@redhat.com,
        linux-kernel@vger.kernel.org,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <162201967838.287555.4257117900130102987.stgit@devnote2>
 <162204068898.388434.16842705842611255787.stgit@devnote2>
 <YLdxL9QVh5n6xGeP@kernel.org>
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Message-ID: <e12e3fcb-15a7-42c3-7994-2fc9e8b854a1@linux.ibm.com>
Date:   Wed, 2 Jun 2021 19:21:34 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YLdxL9QVh5n6xGeP@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: h3w06jUYOOWQNfE0svOMe0vmkQCoqDAQ
X-Proofpoint-ORIG-GUID: BQcaJBW992kVslz0jV1W336dBQ92Vryp
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-02_07:2021-06-02,2021-06-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 phishscore=0 priorityscore=1501 mlxlogscore=999 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106020088
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/2/21 5:23 PM, Arnaldo Carvalho de Melo wrote:
> Em Wed, May 26, 2021 at 11:51:29PM +0900, Masami Hiramatsu escreveu:
>> Add a section to notify the permission and sysctl setting
>> for perf probe. And fix some indentations.
>>
>> Reported-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> 
> Ravi, can I have your Reviewed-by?

Yes please. Thanks for checking.

Reviewed-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
