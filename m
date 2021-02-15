Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A26D31B9ED
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 14:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbhBONEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 08:04:33 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:50268 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbhBONEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 08:04:31 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11FCpV8d070029;
        Mon, 15 Feb 2021 13:03:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=a7O2AzcgdmNTLSB0e5P7HJf4199xphcSBLjlzcGk4lQ=;
 b=mqp5i/e8p+nbIW4JH+GQUQ2yH1WFEeaRxh6cnN1M9432Hpqak2gEYRvRQQGUeAbLslw1
 h22l3r95hm44iR0dwEXnL53cWOXFKPIGB9SPD6jE5Gxzky9H5yE3n2Psptn1O7Ml6BBq
 lj3JOmNS1qCWPGuNhqMO8cLnEORSJguUP5qNHAwBhS9Io8/fYPU61SmXgReNU3Zs8Obg
 bc/3GsRDozIAz6OaBdTQ5QmTPTMxeYM9FX4NvkAr+Ng0NsbYsXx80TG6sQzjfDo7LrBK
 bwZq7wEw9hhJDsK2k/pABBDAChwEEoBOcAt7CU+iJDRSjPKnMyz5qg2x4zlIfkAeiDq8 eg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 36p49b44yx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Feb 2021 13:03:45 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11FCkIlQ042787;
        Mon, 15 Feb 2021 13:03:44 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 36prbm0yx5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Feb 2021 13:03:43 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 11FD3fEs030201;
        Mon, 15 Feb 2021 13:03:42 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 15 Feb 2021 05:03:40 -0800
Date:   Mon, 15 Feb 2021 16:03:34 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     William Durand <will+git@drnd.me>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8192e: fix typo in a function name
Message-ID: <20210215130334.GM2087@kadam>
References: <20210213092014.29466-1-will+git@drnd.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210213092014.29466-1-will+git@drnd.me>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9895 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 mlxscore=0
 phishscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102150105
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9895 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 impostorscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 phishscore=0 clxscore=1011 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102150105
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 13, 2021 at 09:20:14AM +0000, William Durand wrote:
> Other function names use the verb 'query' so this function should
> probably use it too and that's what this patch is about. I didn't
> find any other occurrence and the code compiles.
> 

It's really just assumed that the code still compiles afterwards.
Sometimes, it's hard for me to right commit messages confidently because
I don't know if static checker bugs affect real life.  But in this case
I really think the commit message could be written more confidently.

Please write it like this:
"There is a typo here where it says "qurey" but "query" was intended."

regards,
dan carpenter

