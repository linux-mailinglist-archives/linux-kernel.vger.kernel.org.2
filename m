Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC5043591E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 05:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbhJUDpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 23:45:52 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:63236 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231360AbhJUDpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 23:45:36 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19L2ffsl029728;
        Thu, 21 Oct 2021 03:43:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=V2WYQpVJgmS3bKmyzbGipS5YkDsGFI0oiDAvXQcd6bo=;
 b=t1HL61YNoqHCJzp7Brv14zGzvkmlV8nWFIr1XS5qU9lSkb8zcN4v22GZgVZq86QNz0J0
 Y9Y+tL6swLIQRivQIcRyfvCwy4CDfnp+PPKqWHPy9nKFZqci29a0mVJhfKZte+K7OZkQ
 JOgGMa74aaSJDcMs06EXi61o7buMtQG9Whb9KIS0pXsUt85AAhseTT+0gOfQY2UbRS2R
 mHiZm3thCRktCV9YhWwgyt8UdvAuBggMKLfRv3DlnOSP14Jf09bm1dktG583YzrBg3ST
 MnITBD0+7vMJ87wrXcCFo9rmixg14NikWebq/A16ioC7XLAfM5z6Pr5I8/2BjW8AsW7L Rw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3btkwj3ww4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Oct 2021 03:43:13 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19L3esqv078053;
        Thu, 21 Oct 2021 03:43:12 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 3bqmshem99-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Oct 2021 03:43:12 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 19L3gu8I082116;
        Thu, 21 Oct 2021 03:43:11 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by aserp3030.oracle.com with ESMTP id 3bqmshekyd-17;
        Thu, 21 Oct 2021 03:43:11 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Sohaib Mohamed <sohaib.amhmd@gmail.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Bean Huo <beanhuo@micron.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Avri Altman <avri.altman@wdc.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Can Guo <cang@codeaurora.org>,
        Daejun Park <daejun7.park@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: Fix typo in sysfs-driver-ufs
Date:   Wed, 20 Oct 2021 23:42:48 -0400
Message-Id: <163478764102.7011.6561464376193121113.b4-ty@oracle.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211006154804.135184-1-sohaib.amhmd@gmail.com>
References: <20211006154804.135184-1-sohaib.amhmd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 12_XmlORFdxukQtqtfMNuf-euOcCZ2hi
X-Proofpoint-GUID: 12_XmlORFdxukQtqtfMNuf-euOcCZ2hi
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Oct 2021 17:48:03 +0200, Sohaib Mohamed wrote:

> Remove repeated word: "the The amount"
> 
> 

Applied to 5.16/scsi-queue, thanks!

[1/1] Documentation: Fix typo in sysfs-driver-ufs
      https://git.kernel.org/mkp/scsi/c/a4bcbf71914b

-- 
Martin K. Petersen	Oracle Linux Engineering
