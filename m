Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB1FA35DF8A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 14:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbhDMM5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 08:57:34 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:38884 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbhDMM53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 08:57:29 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13DCn8N7159369;
        Tue, 13 Apr 2021 12:56:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=kdLWZIMHb3SQudb0jxNMATYyODvy77jL7zBOLEtpNVw=;
 b=z6+dZckmzZhuYl2HFD91SDizhxB0Ag4v8uHgc/VNfz2EO9hiteFnxiJ5GWGu7doE5G/e
 vciQDRMQU33q4JdqbfZQ/JjDW8Vm9A7uhKW36t/61e5yptpJGaAmcqAqRs0jOd9lBbkr
 Y1YaFtQse8QRYCrfd5+m2WiOFRtKxprvIx8Ozrlz735iDyC/W+Yc4ViEav7PmJHTiiz/
 HA8xLRRi3icKLSx4kBBlFcV962z/9cqOlbG3a/ibPRcAklWtng0zuRsqj0zvspWv5c3s
 MKm+smub/NfZMfCwJZ7dPekRlztI3Aj67iLl12suN0lEpB50tzwKNveABNZZvk5yvp85 eA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 37u4nnewxb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Apr 2021 12:56:55 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13DCuK55057461;
        Tue, 13 Apr 2021 12:56:54 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 37unxwtcn2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Apr 2021 12:56:54 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 13DCupl1032142;
        Tue, 13 Apr 2021 12:56:51 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 13 Apr 2021 05:56:51 -0700
Date:   Tue, 13 Apr 2021 15:56:43 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Deborah Brouwer <deborahbrouwer3563@gmail.com>
Cc:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Subject: Re: [PATCH 3/4] staging: rtl8712: remove space after cast
Message-ID: <20210413125643.GD6021@kadam>
References: <cover.1617674639.git.deborahbrouwer3563@gmail.com>
 <b1ba94644f5204505623ffc64614671aac30bbd8.1617674639.git.deborahbrouwer3563@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1ba94644f5204505623ffc64614671aac30bbd8.1617674639.git.deborahbrouwer3563@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9952 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 malwarescore=0
 spamscore=0 adultscore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104130090
X-Proofpoint-ORIG-GUID: v4hqLfl9cFykEzjKPTu8wXtu5XpcM927
X-Proofpoint-GUID: v4hqLfl9cFykEzjKPTu8wXtu5XpcM927
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9952 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501
 clxscore=1011 lowpriorityscore=0 spamscore=0 impostorscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104130089
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch has already been applied, which is fine, but really all these
casts are totally pointless and should be removed.

regards,
dan carpenter

