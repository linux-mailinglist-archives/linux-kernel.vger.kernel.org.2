Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF8243EF144
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 20:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232819AbhHQSFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 14:05:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:31266 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232807AbhHQSFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 14:05:01 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17HI3vFG125613;
        Tue, 17 Aug 2021 14:04:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=in-reply-to : from : to
 : cc : date : message-id : content-transfer-encoding : content-type :
 mime-version : references : subject; s=pp1;
 bh=1yTDSuh3lvruaheRyjoPWSNyf77kNw2SJEw8qBHoJK0=;
 b=Sm7A75+KL+jWkgk5LzAbLKqwcjYokEpHN9T1GoL8jlpU43pG8ZD+7D/7Lrf9+g0rqCUR
 /DqGPDrluApoWqviglA7RQWwsdJUR5WltAw4f0qUCx/a2IlEWZmFrF8mKW7g10keQT1i
 e1mQckS3wtBlJCvQKYZhNIv7aLROodDodVcN1skdcNKT5uGqL+8o7hfv6gyQFYzvKbVo
 gVd2nmu0shZdssjDVnrRcoGaN2bIAfeDw2Iodeh9gmsNoPhv5KuRg1JpjDYyfcM4X2dO
 oVW+ipdhH3bmqucf95Aer8VY9uH/9ODb+NC4WWtFU2v9566YmKaUALxHWzl2gbd+659/ AA== 
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3agc2fuuxn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Aug 2021 14:04:13 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17HHuuWG007453;
        Tue, 17 Aug 2021 18:04:12 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma03wdc.us.ibm.com with ESMTP id 3ae5fcrw4b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Aug 2021 18:04:12 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17HI4B4c38469920
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 18:04:11 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BB212BE063;
        Tue, 17 Aug 2021 18:04:11 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A7BFEBE05A;
        Tue, 17 Aug 2021 18:04:11 +0000 (GMT)
Received: from mww0332.dal12m.mail.ibm.com (unknown [9.208.69.80])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Tue, 17 Aug 2021 18:04:11 +0000 (GMT)
In-Reply-To: <YRhQJ4kdyu1Xs1Rb@piout.net>
From:   "Milton Miller II" <miltonm@us.ibm.com>
To:     "Alexandre Belloni" <alexandre.belloni@bootlin.com>
Cc:     "Paul Fertser" <fercerpav@gmail.com>,
        "Ivan Mikhaylov" <i.mikhaylov@yadro.com>,
        "Alessandro Zummo" <a.zummo@towertech.it>,
        openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Tue, 17 Aug 2021 18:04:09 +0000
Message-ID: <OFBF96A764.75CCED3A-ON00258734.0062B30C-00258734.00634222@ibm.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <YRhQJ4kdyu1Xs1Rb@piout.net>,<20210810154436.125678-1-i.mikhaylov@yadro.com>
 <20210814224215.GX15173@home.paul.comp>
X-Mailer: Lotus Domino Web Server Release 11.0.1FP2HF97   July 2, 2021
X-MIMETrack: Serialize by http on MWW0332/03/M/IBM at 08/17/2021 18:04:09,Serialize
 complete at 08/17/2021 18:04:10
X-Disclaimed: 37823
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Qf_VoVo0nIJeNA-pCOBcqbwjuGkq2De7
X-Proofpoint-GUID: Qf_VoVo0nIJeNA-pCOBcqbwjuGkq2De7
Subject: RE: [PATCH 0/2] rtc: pch-rtc: add Intel Series PCH built-in read-only RTC
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-17_06:2021-08-17,2021-08-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 suspectscore=0 malwarescore=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 clxscore=1011 lowpriorityscore=0 bulkscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108170113
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Aug 16, 2021, Alexandre Belloni wrote:
>On 15/08/2021 01:42:15+0300, Paul Fertser wrote:
>> On Tue, Aug 10, 2021 at 06:44:34PM +0300, Ivan Mikhaylov wrote:
>> > Add RTC driver with dt binding tree document. Also this driver
>adds one sysfs
>> > attribute for host power control which I think is odd for RTC
>driver.
>> > Need I cut it off and use I2C=5FSLAVE=5FFORCE? I2C=5FSLAVE=5FFORCE is =
not
>good
>> > way too from my point of view. Is there any better approach?
>>=20
>> Reading the C620 datasheet I see this interface also allows other
>> commands (wake up, watchdog feeding, reboot etc.) and reading
>statuses
>> (e.g Intruder Detect, POWER=5FOK=5FBAD).
>>=20
>> I think if there's any plan to use anything other but RTC via this
>> interface then the driver should be registered as an MFD.
>>=20
>
>This is not the current thinking, if everything is integrated, then
>there is no issue registering a watchdog from the RTC driver. I'll
>let
>you check with Lee...

I think the current statement is "if they are truly disjoint=20
hardware controls" then an MFD might suffice, but if they require=20
software cordination the new auxillary bus seems to be desired.

>>However, I'm not sure what is the correct interface for
>poweroff/reboot
>control.

While there is a gpio interface to a simple regulator switch,
the project to date has been asserting direct or indirect=20
gpios etc to control the host.   If these are events to=20
trigger a change in state and not a direct state change
that some controller trys to follow, maybe a message delivery=20
model?   (this is not to reboot or cycle the bmc).

milton
