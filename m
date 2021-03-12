Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07FBD338991
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 11:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232822AbhCLKDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 05:03:07 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:52480 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232861AbhCLKDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 05:03:05 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12CA0EsK143158;
        Fri, 12 Mar 2021 10:02:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=akbLYMZRzQqZZpbJ+DtKwfG0zRi+SfnjQjeinw9NplI=;
 b=lYovsrs/X7GBkXTV9OEcuVPPBDNJLx1JaWxYK/kSgyQMi7uRNDQl5P9N5ZxOoVhXFAQP
 KPrWsnUpXfNgTQENI349Gi0EBewCqObDWW1eteu9i1iXnbSUrvV4sQXZmk5n1EUkrHeV
 dVr0F1jIznWu5PYUxzMjCIeM3rXQSHIszFau0x/4YKuYcn274SSgPkm9bj4msNCUQwLr
 /YJ94OON4U+aWefd8yVRplPRR6dfC/Wluxg2+w81U91nLA7RgdSHDixuCC6QwqcA124F
 bPOdqtvPUF8KXWB/Gg7AyC9gwzmPFVdqD4cABezfaPJ0PNUSues5Z8SMCmDB73GuFPKg 0g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 37415rhhgc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Mar 2021 10:02:56 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12CA1E9T070444;
        Fri, 12 Mar 2021 10:02:54 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 374kgwa7ax-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Mar 2021 10:02:54 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 12CA2rBe026796;
        Fri, 12 Mar 2021 10:02:53 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 12 Mar 2021 02:02:52 -0800
Date:   Fri, 12 Mar 2021 13:02:44 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Hao Peng <penghaob@uniontech.com>
Cc:     gregkh@linuxfoundation.org, ross.schm.dev@gmail.com,
        izabela.bakollari@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: add initial value
Message-ID: <20210312100244.GN2087@kadam>
References: <20210311063838.19756-1-penghaob@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210311063838.19756-1-penghaob@uniontech.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9920 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103120067
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9920 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 lowpriorityscore=0
 impostorscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0 adultscore=0
 phishscore=0 spamscore=0 priorityscore=1501 bulkscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103120067
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 02:38:38PM +0800, Hao Peng wrote:
> Add initial value for some uninitialized variable and array.
> 

None of these are ever used uninitialized.  It's weird that you would
even think that.

>  			if (pmlmeext->active_keep_alive_check) {
> -				int stainfo_offset;
> +				int stainfo_offset = 0;
>  
>  				stainfo_offset = rtw_stainfo_offset(pstapriv, psta);
                                ^^^^^^^^^^^^^^^^
This one is initialized on the very next line so all the patch does is
introduce static checker warnings for no reason.

regards,
dan carpenter

