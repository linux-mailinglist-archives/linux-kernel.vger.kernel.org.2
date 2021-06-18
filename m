Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECF43ACF52
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 17:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235535AbhFRPnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 11:43:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48368 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230334AbhFRPnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 11:43:03 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15IFYdIk064313;
        Fri, 18 Jun 2021 11:40:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=/ASVPW5tmw2fSFNpuJSYnJnc7Fa49euiEaXNw7bQ//w=;
 b=hgd8LOO6/6WTKdj6E7b/hd1rK0Hw6VOyrCABvKb35KMcF21hMS1Vj99zW9DUeeI23Z/h
 pzpjCsQlX8la5C3GSvs/ZwNNwc0RELT+myoP7sYb8FJnOpStnQgj7BWFoypudU8tsg+w
 LPY9HjhxRFER+8xb32xlP0MhyDn4M9zy/5wzdvS33cjbewmjhIHayyI1oUrzhKJmduhh
 yh3ohKISf/vkyR6FGe23ue/ay6+1WzZv7ebw5PhYH0zoTxHpU8JDqkuYouOUS7T60mLG
 +GV9iC5e3//uvfvOLoAvqLfaAtfp7qcnqgXFjxN/zgPqFDWqwHdCSO1a5No2KwSLT1g4 6g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 398w2djs6w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Jun 2021 11:40:44 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 15IFZALL070917;
        Fri, 18 Jun 2021 11:40:43 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 398w2djs62-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Jun 2021 11:40:43 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15IFWu2w004557;
        Fri, 18 Jun 2021 15:40:42 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06ams.nl.ibm.com with ESMTP id 394m6huckw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Jun 2021 15:40:41 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15IFdURx29426092
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Jun 2021 15:39:30 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 63FFE5205A;
        Fri, 18 Jun 2021 15:40:39 +0000 (GMT)
Received: from li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com (unknown [9.171.8.15])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 0A2765204E;
        Fri, 18 Jun 2021 15:40:39 +0000 (GMT)
Date:   Fri, 18 Jun 2021 17:40:31 +0200
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Alexander Gordeev <lasaine@lvk.cs.msu.su>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rodolfo Giometti <giometti@enneenne.com>
Subject: Re: [PATCH v1 1/1] pps: generators: pps_gen_parport: Switch to use
 module_parport_driver()
Message-ID: <20210618154030.GA37071@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
References: <20210616143121.46059-1-andriy.shevchenko@linux.intel.com>
 <YMoOVrJ1ETVhRr4F@kroah.com>
 <CAHp75VeenUQxbaUmA8WXyJkjojnZvzF_PZUZgUPoVVR70+doQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VeenUQxbaUmA8WXyJkjojnZvzF_PZUZgUPoVVR70+doQg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 18aIQCsmFA8w_Zh-61BePH7GDZSieZkI
X-Proofpoint-ORIG-GUID: HV5T5VTFqJ3SxCdrdJq7axu5NWHUfStH
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-18_07:2021-06-18,2021-06-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 clxscore=1011
 adultscore=0 malwarescore=0 impostorscore=0 mlxscore=0 phishscore=0
 spamscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2106180091
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021 at 05:57:47PM +0300, Andy Shevchenko wrote:
> +Cc: Alexander (I believe he is the author of the original code, sorry if not)

Hi Andy,

No problem, but I am not the author, unfortunately. 
CC-ed another Alexander
> -- 
> With Best Regards,
> Andy Shevchenko
