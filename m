Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A872131F540
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 07:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbhBSG4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 01:56:10 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:60510 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbhBSG4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 01:56:08 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11J6sg9D185063;
        Fri, 19 Feb 2021 06:55:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=Go6tYAvLQ82oAZm5BANsgOmrCr9tlT6pOAyjkofCBIU=;
 b=Xl9C0ymufrJ1ihTm8RRtsV/tzWWFdcvYrJnkKtvVLxI+mVS0/a6VUXI0pQsBSRR3cfzt
 oNPau9ZpBAWqyzY3/gsvh066Gg9fmXu4dM+Tp/Bp8pbIyzwgd+W5jfc+LV9eCQcEjkqq
 28LEltCR8ydP1QORf8Ba0sF2ctpCOyUdfR8BwKQd/zC6Mme206JAfLoaSGxkWXGVnodo
 n6Brm0n05K4X8Cxw0ny4AJ/wQ2hgEuq3/l33Y4ZFpDqZuFqrVh7AbEkZOEpdlfe4Wbv/
 gFytw5ULZPb2KiXMnk5XKp+wjFyfOttoRGbu/x6DAzVoUfVFvdxChm3nBj0nfgJUIS70 eQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 36pd9afxx5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Feb 2021 06:55:24 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11J6jkYK068090;
        Fri, 19 Feb 2021 06:55:22 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 36prhv9tw6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Feb 2021 06:55:22 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 11J6tLuT021888;
        Fri, 19 Feb 2021 06:55:22 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 18 Feb 2021 22:55:21 -0800
Date:   Fri, 19 Feb 2021 09:55:14 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Atul Gopinathan <atulgopinathan@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] staging: comedi: cast function output to assigned
 variable type
Message-ID: <20210219065514.GN2222@kadam>
References: <20210218084404.16591-1-atulgopinathan@gmail.com>
 <8f73b7a1-02dd-32ef-8115-ad0f38868692@mev.co.uk>
 <20210218104755.GA7571@atulu-nitro>
 <YC5bsXa+1KSuIh+v@kroah.com>
 <20210218125220.GA19456@atulu-nitro>
 <20210218155159.GL2087@kadam>
 <20210218164128.GA9289@atulu-nitro>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210218164128.GA9289@atulu-nitro>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9899 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102190049
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9899 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 impostorscore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102190050
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No problem.  These days I have fibre to my house, but I still remember
trying to clone the kernel when I could only buy 20MB of data at a
time.  :P

regards,
dan carpenter

