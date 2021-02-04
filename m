Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76CB230ECCE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 07:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233561AbhBDG5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 01:57:22 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51944 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232917AbhBDG5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 01:57:21 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 1146Z9Px129615;
        Thu, 4 Feb 2021 01:55:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=3Fsa80KhccCXc1vOs6hzr4/sCJRFJYobjsQWycJ1LVk=;
 b=MQMousRix8at/S6/QqQ2JnVJMkVsR6FUM2pTaDSEss4HPdozaXVhcpfzDI+mMglmp9yt
 j3gzPYTFdIaPvt6HTdXUvatyOQyBXwktZThQUC75mUw7G9DswRmx/JoefKRE7tQ+/550
 czyGkAO3nMivmcPmYe1pDpDA54IAeS0ODdbPnXhpFGTeZBvkBZMWtA4+c6/Lzte4ztYE
 HeAfHa5EQRnhJXISnKkEo3AqY7OFXytPh/AtxXT1rGq5MqmPcJohHpJrFaGjxZOUIJnK
 w0UUMahkDZVbJN3NALhrXVbQviY5RAakOGcpWodFwLTxDnMQ6rLCEQhIUtBGAdgUOFjc iQ== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36gbf2gw57-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Feb 2021 01:55:11 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 1146qjt1015209;
        Thu, 4 Feb 2021 06:55:09 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06ams.nl.ibm.com with ESMTP id 36evvf289w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Feb 2021 06:55:09 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1146suHu34341196
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 4 Feb 2021 06:54:56 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AF57842041;
        Thu,  4 Feb 2021 06:55:05 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3E24342052;
        Thu,  4 Feb 2021 06:55:05 +0000 (GMT)
Received: from localhost (unknown [9.85.87.37])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  4 Feb 2021 06:55:04 +0000 (GMT)
Date:   Thu, 4 Feb 2021 12:25:03 +0530
From:   "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ananth N Mavinakayanahalli <ananth@linux.ibm.com>,
        Wang ShaoBo <bobo.shaobowang@huawei.com>,
        Cheng Jian <cj.chengjian@huawei.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kprobes: Warn if the kprobe is reregistered
Message-ID: <20210204065503.GG210@DESKTOP-TDPLP67.localdomain>
References: <161236436734.194052.4058506306336814476.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161236436734.194052.4058506306336814476.stgit@devnote2>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-04_02:2021-02-03,2021-02-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=827
 priorityscore=1501 clxscore=1011 suspectscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102040036
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/02/03 11:59PM, Masami Hiramatsu wrote:
> Warn if the kprobe is reregistered, since there must be
> a software bug (actively used resource must not be re-registered)
> and caller must be fixed.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  kernel/kprobes.c |   13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)

Suggested-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Acked-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>


Thanks,
Naveen

