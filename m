Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34C3140B3CB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 17:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234845AbhINPys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 11:54:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:3686 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231928AbhINPyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 11:54:46 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 18EE8Fdu010177;
        Tue, 14 Sep 2021 11:53:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=KFb6nBQIfkaFJU9ZnrtlTcOOn7WD3tZetdiy3JZSC8E=;
 b=RjYGBAykH1D2WRrM1qAnoAlKYCUjZr+kNIjmGMN5SmANzkxMCeAWRI9gHAWk97BivMnv
 zri5T8ZcbqJFeBUFu2TdWqNiMbaYkzIZKwaa7vpNp/T4KggjS4WJnrjweX7MnJV8XquD
 p8OpuuE960FxHT/BeBzKmqOo6AqbNTm0WrfdwUKseM9sU4cEDzwiEhquUF7L6DOJq1l2
 xKHBx6nY2KTYc91fdzndGYLKNuC+LefhrDmpaZXacTYRW72Fe4DStrSb/MjBkVVek/JW
 AcCheNLAeCRvEdaxFv0Qo01KTAXRxPDML4Wge1bnzIhZ6ZAJXE9sCHXQM575bPt+xQO5 Gg== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3b2w82awgk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Sep 2021 11:53:14 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18EFmENE021250;
        Tue, 14 Sep 2021 15:53:11 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma05fra.de.ibm.com with ESMTP id 3b0m39vujd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Sep 2021 15:53:11 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 18EFr8hB57999738
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Sep 2021 15:53:08 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5322AA405C;
        Tue, 14 Sep 2021 15:53:08 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2E2F2A4054;
        Tue, 14 Sep 2021 15:53:06 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.116.105])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 14 Sep 2021 15:53:05 +0000 (GMT)
Message-ID: <97aaea3035252e74d82e2f5314ef2ecdf7f3dcdc.camel@linux.ibm.com>
Subject: Re: [PATCH v2 04/29] ABI: security: fix location for evm and
 ima_policy
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Raphael Gianotti <raphgi@linux.microsoft.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        THOBY Simon <Simon.THOBY@viveris.fr>,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        linux-kernel@vger.kernel.org
Date:   Tue, 14 Sep 2021 11:53:05 -0400
In-Reply-To: <d81b75a86e927ed33cb2b7df12965e832f968f72.1631629496.git.mchehab+huawei@kernel.org>
References: <cover.1631629496.git.mchehab+huawei@kernel.org>
         <d81b75a86e927ed33cb2b7df12965e832f968f72.1631629496.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bRP1_Q-xnEW1JYhDjXYWhjNGQms4cjO_
X-Proofpoint-ORIG-GUID: bRP1_Q-xnEW1JYhDjXYWhjNGQms4cjO_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 phishscore=0 suspectscore=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109140082
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-09-14 at 16:32 +0200, Mauro Carvalho Chehab wrote:
> The What: definitions there are wrong, pointing to different
> locations than what's expected.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Thanks,

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

