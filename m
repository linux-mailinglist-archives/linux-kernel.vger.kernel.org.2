Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08B2434FBE3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 10:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234470AbhCaItA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 04:49:00 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:57548 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbhCaIsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 04:48:35 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12V8mVSW017955;
        Wed, 31 Mar 2021 08:48:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=+oc1CtFc57IVSoTNJ+wtqCopJ0F9XhVs7KCPIzeefuY=;
 b=FwLRlxN0enoo1TJQ0aRPClp2si4X+bRnyIiZHxPrvBWsuRDfkOayx1mt2IDZr525sISy
 H0jdaW+VJp2X3jPaUZdPtOkMa/xL510S+HCr193Sv8w2WJ/sHCU+EZaenBat7NEE4utu
 5Ph3bmHbk2Iq+nR4QqGDgzjy+n0mm6LCA2UK31wFVRFx/KT+XJa/zN3CEu+yDsx8HcrY
 tjU1aRGDo9GVKj1LcbDov5JZCBiwKaEGxa5PBoQTqGqS8AJwScXPhxymOo3mE2Y08o15
 kkPj+7pt7dbZT+u6G/pOFaMJNKUQdQcmD/lECQ3a1NJ2Gu3wP/QvvASyX9D6RaBT4l6h 3Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 37mab3hgyb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Mar 2021 08:48:31 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12V8epmK181419;
        Wed, 31 Mar 2021 08:48:29 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 37mac8d3g8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Mar 2021 08:48:29 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 12V8mPUO014479;
        Wed, 31 Mar 2021 08:48:25 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 31 Mar 2021 01:48:24 -0700
Date:   Wed, 31 Mar 2021 11:48:17 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Muhammad Usama Anjum <musamaanjum@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        colin.king@canonical.com
Subject: Re: [PATCH] io_uring: Initialize variable before use
Message-ID: <20210331084817.GH2088@kadam>
References: <20210322184158.GA2095479@LEGION>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210322184158.GA2095479@LEGION>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 spamscore=0 malwarescore=0 phishscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103300000
 definitions=main-2103310063
X-Proofpoint-ORIG-GUID: jIREcGX6vfH5-BUdG9Bo4chJpod9k4PI
X-Proofpoint-GUID: jIREcGX6vfH5-BUdG9Bo4chJpod9k4PI
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0 suspectscore=0
 clxscore=1011 impostorscore=0 adultscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103300000
 definitions=main-2103310064
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 11:41:58PM +0500, Muhammad Usama Anjum wrote:
> 1) Initialize the struct msghdr msg in the start of the function
> 2) Uninitialized variable msg.msg_flags can get used if branch happens to
> out_free before initialization.
> 
> So initialize variable in question in the start of the function for
> simplicity in logic and use.
> 
> Addresses-Coverity: ("Uninitialized variable")
> Addresses-Coverity: ("Uninitialized variable read")

This bug is a false positive.

When msg.msg_flags is uninitialized then ret is negative and min_ret is
zero.

fs/io_uring.c
  4666                  ret = -EINTR;
  4667  out_free:
  4668          if (req->flags & REQ_F_BUFFER_SELECTED)
  4669                  cflags = io_put_recv_kbuf(req);
  4670          if (ret < min_ret || ((flags & MSG_WAITALL) && (msg.msg_flags & (MSG_TRUNC | MSG_CTRUNC))))
                    ^^^^^^^^^^^^^                               ^^^^^^^^^^^^^
The first part of the condition is true so the second part is not used.

  4671                  req_set_fail_links(req);
  4672          __io_req_complete(req, issue_flags, ret, cflags);
  4673          return 0;
  4674  }

regards,
dan carpenter

