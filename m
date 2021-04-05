Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D585F35437A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 17:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238339AbhDEPet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 11:34:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38720 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238291AbhDEPer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 11:34:47 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 135FXEes169467;
        Mon, 5 Apr 2021 11:33:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=i59gJf6QV5OOFLztYOzO62bClKSZvoUaFbvj6IBLlJU=;
 b=V+OrkvfU+Ux94324RKrQzIVP1+NnjWliTCS35VdPOLiaqMQKd+wwb7s/XwaxZ5PStRLU
 0WbEe2sD6v+tHcHeuSYp/IJ6MkfAyu1dX5DgVnM8FVB+g/1nAQ0VZIa+pwHbrh6rF8eB
 yFQzrrpqeQFxqZxqV7XqCby7cqz2Deb5JZphnT2yHD83oxBsiWcHCe52TOEn0EclzG+L
 0orIPFFDIfoexVM0y8S0qejuZp2dgpST+3vFnFOhCp4dqct7UmSwcWnTqmg9Fw5ki40v
 cC0eswXZ4f4Qt9uWdX03Lo89AEw02vJuNbKdRf1j+y7DnTZ8KnNV7LgLMEFYmprNW/Id vw== 
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37q5vucukw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Apr 2021 11:33:57 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 135FRW2n016716;
        Mon, 5 Apr 2021 15:33:56 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma04dal.us.ibm.com with ESMTP id 37q2n63xgj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Apr 2021 15:33:56 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 135FXtkk19071380
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 5 Apr 2021 15:33:55 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 72BD36A057;
        Mon,  5 Apr 2021 15:33:55 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 110DF6A04D;
        Mon,  5 Apr 2021 15:33:54 +0000 (GMT)
Received: from v0005c16 (unknown [9.211.34.122])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon,  5 Apr 2021 15:33:54 +0000 (GMT)
Message-ID: <38abb74465bacad2ab4a62424d7cef06f344dc4c.camel@linux.ibm.com>
Subject: Re: [PATCH 0/4] occ: fsi and hwmon: Fixes for polling
 un-initialized OCC
From:   Eddie James <eajames@linux.ibm.com>
To:     joel@jms.id.au
Cc:     linux-fsi@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        jk@ozlabs.org, alistair@popple.id.au, jdelvare@suse.com,
        linux@roeck-us.net, linux-hwmon@vger.kernel.org
Date:   Mon, 05 Apr 2021 10:33:54 -0500
In-Reply-To: <20210209171235.20624-1-eajames@linux.ibm.com>
References: <20210209171235.20624-1-eajames@linux.ibm.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: AlvOtbRQOb80Bu-CwsIOw6WQCyzSgFyg
X-Proofpoint-ORIG-GUID: AlvOtbRQOb80Bu-CwsIOw6WQCyzSgFyg
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-04-05_13:2021-04-01,2021-04-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 mlxscore=0 priorityscore=1501 phishscore=0 bulkscore=0 spamscore=0
 mlxlogscore=937 impostorscore=0 clxscore=1011 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104030000 definitions=main-2104050106
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-02-09 at 11:12 -0600, Eddie James wrote:
> In the event that the OCC is not initialized when the driver sends a
> poll
> command, the driver may receive an invalid response. This isn't an
> error
> condition unless there is no valid response before the timeout
> expires. So
> change the starting sequence number and check for the un-initialized
> OCC
> state before returning the response in order to detect this condition
> and
> continue waiting if necessary.

Hi Joel,

Do you have any comments on the FSI side of this series?

Thanks,
Eddie

> 
> Eddie James (4):
>   fsi: occ: Don't accept response from un-initialized OCC
>   fsi: occ: Log error for checksum failure
>   hwmon: (occ) Start sequence number at one
>   hwmon: (occ) Print response status in first poll error message
> 
>  drivers/fsi/fsi-occ.c      | 11 ++++++++---
>  drivers/hwmon/occ/common.c |  7 +++++--
>  2 files changed, 13 insertions(+), 5 deletions(-)
> 

