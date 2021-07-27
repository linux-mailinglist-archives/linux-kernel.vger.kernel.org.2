Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06AD93D7A4E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 17:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237062AbhG0P60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 11:58:26 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:47596 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229537AbhG0P6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 11:58:24 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 16R501c1028545;
        Tue, 27 Jul 2021 10:57:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=FyAhOEWl+YeTFxeCh3K/9ygpjimOlhxxgM8BuepYUfo=;
 b=exuAFiDG8CxhUWpSOEaceXYJ3cvIEGi/wZJDBhxTXrvDuhxiU1ZgLdjnJ0Z0vNIZ0WwW
 XqVOlxevsEVev728TCGKElQdY9RO5RiHLxDd9r+5Zb0XJO5q+cBdEgjX2ZJuua/xqKf4
 zulCKhJiqYgJNWVfj/VHHdiAF78yLw3ZapFWJdaGmGD0tJ7AhcCBOC9LYBGED3mAzd5h
 hIzrj0c1rr/0LmDTXdedz2+Czs2KxtJTNNunpv8kUbNT+lUvLjtW1ji1pklTSx59ONeh
 rkI5Zmtn0mgQ1h7Wwm3pOMCrX4ELOIInGolPo0dM0AZRkBFMwv0FCkgavnzQZglPyMHQ MA== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 3a233y9921-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 27 Jul 2021 10:57:44 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 27 Jul
 2021 16:27:38 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Tue, 27 Jul 2021 16:27:38 +0100
Received: from [10.0.2.15] (AUSNPC0LSNW1.ad.cirrus.com [198.61.65.56])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 1069E45D;
        Tue, 27 Jul 2021 15:27:38 +0000 (UTC)
Subject: Re: [PATCH v1 1/1] lib/test_scanf: Handle n_bits == 0 in random tests
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>, <linux-kernel@vger.kernel.org>
CC:     Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        kernel test robot <oliver.sang@intel.com>
References: <20210727150132.28920-1-andriy.shevchenko@linux.intel.com>
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
Message-ID: <db516512-2f52-9526-f5f5-0571061c5990@opensource.cirrus.com>
Date:   Tue, 27 Jul 2021 16:27:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210727150132.28920-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: _UJ7O4EqP6jH5X5dLHNdgYXwCJBDNd8u
X-Proofpoint-GUID: _UJ7O4EqP6jH5X5dLHNdgYXwCJBDNd8u
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 priorityscore=1501
 phishscore=0 malwarescore=0 bulkscore=0 clxscore=1011 mlxlogscore=814
 mlxscore=0 adultscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2107270096
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/07/2021 16:01, Andy Shevchenko wrote:
> UBSAN reported (via LKP)
> 
> [   11.021349][    T1] UBSAN: shift-out-of-bounds in lib/test_scanf.c:275:51
> [   11.022782][    T1] shift exponent 32 is too large for 32-bit type 'unsigned int'
> 
> When n_bits == 0, the shift is out of range. Switch code to use GENMASK
> to handle this case.
> 
> Fixes: 50f530e176ea ("lib: test_scanf: Add tests for sscanf number conversion")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---

Reviewed-by: Richard Fitzgerald <rf@opensource.cirrus.com>

Sorry about that. Would have been sensible to use GENMASK anyway.
