Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB7631F691
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 10:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbhBSJa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 04:30:26 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:52378 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbhBSJaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 04:30:20 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11J9OGcV136160;
        Fri, 19 Feb 2021 09:29:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=uEvDR6iEpvcnB2NVWUiZUFmWvogbhov45lrrnx2ri0g=;
 b=atzN55G24QS1hqwNj/djdC8BksvwywD7eX/pPiInGMNpMG7iYTP2vGunD0F50eN3q8Eq
 zOHMwvZBGz7PC0FnCK0qEqOAl6tFScE2ul6szAtZbSP5TjBxIUntw6GxJKoSoGu3Uaen
 sJLXfwJaW66if0uPWMJN/Vya0rslmqEQ5fqkXRqrHsZNa/aCWbwIitQoKal1dcxtI6l9
 uJJ598HKICxj1jR7/xLUHH+hYyflfgLhmSIYeIZv82JkBZtnUJbqpyxghBp+P0Gtxf0x
 DwcTLWOhAxTz8zgnSaACJMdqjb2pvhfvVoq9JdUZiaJ3mrHQRY2DJa0NdGumUJ3Zus32 wA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 36p7dnrq2p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Feb 2021 09:29:35 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11J9KVNw115305;
        Fri, 19 Feb 2021 09:29:34 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 36prbrxf3x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Feb 2021 09:29:33 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 11J9TSv1016782;
        Fri, 19 Feb 2021 09:29:28 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 19 Feb 2021 01:29:28 -0800
Date:   Fri, 19 Feb 2021 12:29:18 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Nikolay Kyx <knv418@gmail.com>
Cc:     gregkh@linuxfoundation.org, adawesomeguy222@gmail.com,
        dinghao.liu@zju.edu.cn, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: fwserial: match alignment with open
 parenthesis
Message-ID: <20210219092918.GV2087@kadam>
References: <YC9zX1aIgj/sVnQY@kroah.com>
 <20210219090318.20795-1-knv418@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210219090318.20795-1-knv418@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9899 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 mlxscore=0
 phishscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102190073
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9899 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 spamscore=0 adultscore=0 clxscore=1011 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102190073
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 19, 2021 at 12:03:18PM +0300, Nikolay Kyx wrote:
> This patch fixes the following checkpatch.pl check:
> 
> CHECK: Alignment should match open parenthesis
> 
> in file fwserial.c
> 
> Additionally some style warnings remain valid here and could be fixed by
> another patch.
> 

Don't put comments like this in the git log, put them under the ---
cut off line.

> Signed-off-by: Nikolay Kyx <knv418@gmail.com>
> ---
> 

