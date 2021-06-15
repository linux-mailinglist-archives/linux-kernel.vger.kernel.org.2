Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7A8A3A7E69
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 14:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbhFOMx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 08:53:58 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:54916 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbhFOMx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 08:53:56 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15FCnn7n173425;
        Tue, 15 Jun 2021 12:51:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=jz/aERMgu0KWDk6VKuZP6FWkq3aPcHzm3Ht1KSa3uV0=;
 b=mFcp3vWSuyNTkR0IRHBsmjJ/mtDk6gjl4Ip0+14Pf72JxxqY+BThWhqYaJg1GVQ88VGi
 kVFROGMDTbTlBMQLENp4L9lblxvWPbVFsEvOhjUK/CyK2BSaNPsNKlLK6bQMn06y+dga
 yOsg8ucwNGdljtQNdpDlPxoMl+Kj4rFd4GBNiId60AloLqej6cxT0ANDoUxZ2Wz2XY7k
 dNb5VJNvr/DPB8mwl3jdFr8mmRY7yc0qKg4HIzDB+qSLciPqT1iPpMBjsZaeFPzHZ9uZ
 O6BDUVeJQBOHD5YRUwcpFv/SusEf13LEbCbIobgnlmVEeoHQfzCe3Rt/EJgLOLcCEnWy Bw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 394jece80q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Jun 2021 12:51:35 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15FColbW121187;
        Tue, 15 Jun 2021 12:51:34 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 394j1ufwje-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Jun 2021 12:51:34 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 15FCovHZ121691;
        Tue, 15 Jun 2021 12:51:33 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 394j1ufwhx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Jun 2021 12:51:33 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 15FCpW0F014562;
        Tue, 15 Jun 2021 12:51:32 GMT
Received: from kadam (/41.212.42.34)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 15 Jun 2021 05:51:32 -0700
Date:   Tue, 15 Jun 2021 15:51:25 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Phillip Potter <phil@philpotter.co.uk>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH 00/28] staging: rtl8188eu: remove DBG_88E callers and
 macro
Message-ID: <20210615125125.GC1861@kadam>
References: <20210615001507.1171-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210615001507.1171-1-phil@philpotter.co.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-ORIG-GUID: Q9JSm16mFjHefBX5kY1F1xDyNJ4W1aPh
X-Proofpoint-GUID: Q9JSm16mFjHefBX5kY1F1xDyNJ4W1aPh
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10015 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 phishscore=0
 bulkscore=0 clxscore=1015 mlxlogscore=999 adultscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106150084
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good.

The future is vast and unknowable but I feel pretty confident we will
never miss these at all.  :P

regards,
dan carpenter

