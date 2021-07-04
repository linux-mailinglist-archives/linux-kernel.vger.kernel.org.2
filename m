Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0B43BAF40
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jul 2021 23:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbhGDVvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jul 2021 17:51:45 -0400
Received: from mx0a-00110701.pphosted.com ([148.163.144.83]:5956 "EHLO
        mx0a-00110701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229649AbhGDVvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jul 2021 17:51:44 -0400
Received: from pps.filterd (m0163002.ppops.net [127.0.0.1])
        by mx0a-00110701.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 164LmuXZ009067
        for <linux-kernel@vger.kernel.org>; Sun, 4 Jul 2021 17:49:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uml.edu; h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=dkim20180810;
 bh=44prtHN+QwOjM88WMYYVMU9v89j79i00Lssc1FfshQs=;
 b=Ven8otf3EDNAGJRITQ68yTa2bwSsJ4y+mCAhkWxythRnTiAOHOxMyWVRT8gXSBuP2JvD
 7i49JU8nTkOajfrc1PuZzLDvUbNQKPBLb9wZc0x9cLqRxYNfwuj3F8H6T5+92AmxbgqC
 id2zJZETIMD2VJO2GDMsAxi9lHQRSdgj7zfFKIvBxQzMwAi0T1TWBC3ZXq044f8jjeqF
 rSk++X3Pf1Ouijp8VIcVwHNfSG5YdJSUakNfwMbG4JPRn2MOaof3Sn3OYoNlKf6Ua9eH
 PqoaE+aVFcfvvwuV3FUcYcsY/6dr1fNW2hv+Sb6OQxhv48bLgb+uZvzI/cXfSFAhSyti XA== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by mx0a-00110701.pphosted.com with ESMTP id 39jgxx121b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 04 Jul 2021 17:49:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V0b8v0TO0MARAM/S0NzqHfkkbnwkccAktJV+9XhkzqCSygsNTKSlsa0GyfEDlr81HkortKzlHHEAAzg/Z6U7dVCqjHua1UChdyhDRZHlED3xYGFKwqCD1amxCAauhvI247TazAp7sciYosNKqtPypjtEGbtE6sohjyJ4sccZ2/0aAVOBW5exf26qHwbwFqTpACJ+/SKpn+nFrtyu5sk3QpHpfhevTQP9GB/xyrLru/DWe1McLUqKF3da3jHDSL4rljk0WdJQiKYtrZZPAw/AdsNQv6/zkfhAp8Na+hRNLM2japnm/uK9DJkFYQbID53vTWyT5hg/AxqDCu3xp4apTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=44prtHN+QwOjM88WMYYVMU9v89j79i00Lssc1FfshQs=;
 b=ZGa7EOiguAXo29Y03kZEmlGa9sd3FiOJaJt+72ZGFCVjWXRnb78nf8cpq2/yQ3yXy/c37D6GvThKrpJsqx2rmjTX7vUvRPywsJebDiBc70UYJ4CIc3hmOQxTGm7gMCiUAZg8HLICl9Z8hU0Tu2YGkOcs5ZbOKWYj9NeJQzOpod069cJXM6bTPhNOx+1p7o+D8KewA2AT3ATvf0ReMHkeNOG2JWwjbtAUjTFgoU5etEXBDsDuuLFRrFjvKWf/+jEIVbLg2rwpgRwqvsNVx5FeM7B5ZR/k2ebeZmLHbxCc4BI9rjlB7gvC16WMkruc2z1TcI7snKV4ZPWGr9Wp2SEFjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=student.uml.edu; dmarc=pass action=none
 header.from=student.uml.edu; dkim=pass header.d=student.uml.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=studentuml.onmicrosoft.com; s=selector2-studentuml-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=44prtHN+QwOjM88WMYYVMU9v89j79i00Lssc1FfshQs=;
 b=lSuRQtGKU8DcvXyofSFZy8t09e4lb8D+7z48OaaJerhhvy+Z8XMK1wQuju4/Z3t5nyvOxpIwu5Rham+vqEdGIJNdzKFwQQ42IeNqaWqdmK+s6nQItVaX9a+mb8NxoTDFX+sEjXJbC1tU1aHAmeNoAdwkV+j8nRhRPs/fSXaULSA=
Received: from BL0PR02MB4737.namprd02.prod.outlook.com (2603:10b6:208:52::15)
 by BL0PR02MB5537.namprd02.prod.outlook.com (2603:10b6:208:88::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.23; Sun, 4 Jul
 2021 21:49:06 +0000
Received: from BL0PR02MB4737.namprd02.prod.outlook.com
 ([fe80::a464:b77a:934a:7985]) by BL0PR02MB4737.namprd02.prod.outlook.com
 ([fe80::a464:b77a:934a:7985%6]) with mapi id 15.20.4287.033; Sun, 4 Jul 2021
 21:49:06 +0000
From:   "Mukherjee, Sunip K" <Sunip_Mukherjee@student.uml.edu>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Linux Kernel Driver for Silicon Labs Si446x Transceivers
Thread-Topic: Linux Kernel Driver for Silicon Labs Si446x Transceivers
Thread-Index: AddxHgvCOwE0j2JXTViYmlTZDTA0bg==
Date:   Sun, 4 Jul 2021 21:49:06 +0000
Message-ID: <BL0PR02MB4737E26D889B65A33565A773DB1D9@BL0PR02MB4737.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=student.uml.edu;
x-originating-ip: [73.142.18.15]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e7cf7fea-8c72-4402-51bb-08d93f358bed
x-ms-traffictypediagnostic: BL0PR02MB5537:
x-microsoft-antispam-prvs: <BL0PR02MB55377EC3CA483B8369974F64DB1D9@BL0PR02MB5537.namprd02.prod.outlook.com>
x-uml:  student-to-external
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1SUTFk13J929A6eZ+Q6jCf5l4Fu3Yr5pz0vKDyJfsOMvvz4o1zkdqBWDBMtJyLBPgBze9Cy2F6+OcIF9vWF4i2RS/aX9IiZguYT8ShdIQsoLte8Zfy+qJEG8MV2fNoo/eDuvqtTjMalr3MYuTl13irIZBeiFeCJxHPv4PCXfwNjgMszsCMF3XXe7fA5wRE+ncA8j9IFxsCfInsDOOGyKGfb+ioj9NPROtjdHGlPzi6oLHYjsQbNqhP+qQCSzafbqhYo58UOmqnPdKIya+Sqb5udGl7bsxgKrYIDuWnIIlORWsUYVOSqFNjw2SYVah3kolMbXBqmhRYWPmBYg7fInEieIMae2erJLp/+j79UaPQakjTx5Y/DnuoVUtG/a/eXBXJM9G2hPFjqoR2Itt+TkzpOUwgUWQCFz1Ldf/h8/lkP6RTDtoUOUO+79dJkRU/kUc9drmKF5NBgoat8x39IUZ0NVux6MnMZ7LbYl1ggGbcVLVF6co/H8+lIL1JV4jig2O7EcBXgwNJuq50q9XneQ4SWScXLFlPhTTyCxS11tyz/RUtrsHs1Ww1GyAIQue48/hQN7Ii73Pk1Y6xMa9h6h98Dm0OlUY4DXEsYdVX7ky68XkXZtUoEvi0TyaxLni/iTmoCLxfMi8uz5aNJ1t9hEJ+spPAHk7g2uf70nLvlTfuqSVP24rfnkgB+Yi8dTfcOmjzlhkKDq76WrOCwEkkrfKY7/AbGoov8tXoCK6h7ySBWzFXNYRtg+mqFHcv7w1dSg6cqRYiQgVVuIqfe4+ptweyLGp5R8OYuNxiz1kBCJR4kSbfCeb3fKoTJWPYyIgbFdwyNc98Gn8l6jVPQdNGXIdg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR02MB4737.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(376002)(396003)(366004)(136003)(346002)(64756008)(55016002)(86362001)(6916009)(66556008)(66476007)(76116006)(8676002)(66446008)(66946007)(786003)(122000001)(7696005)(316002)(5660300002)(38100700002)(9686003)(186003)(52536014)(6506007)(71200400001)(83380400001)(8936002)(478600001)(33656002)(75432002)(966005)(26005)(2906002)(554374003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TdG8Lj5bj42YthR+szKv+m9fcP12+ups3qNp65u08NXBR26V7XBpAUZ5DcBH?=
 =?us-ascii?Q?r0eHTCggKqrQRfe5gCZIzA7XGhUBo6N1gs805vhk2Ux5a0XETZJaRUxVwS1g?=
 =?us-ascii?Q?x/XfWLLTVSd9ytrtA9Eeb3+TmGVTCYRF8TKZ6YySy2JeNepyKm/xbGbD+PDD?=
 =?us-ascii?Q?EQ/vvZuao/OD4V9gJuBos6doNlpnhrZqmiHmtKXuyY6dTSfMeZq61PChH79N?=
 =?us-ascii?Q?FAjKYZPfBnVwxJ5XwbL2LVqymCyjPRSiktF8pmVkIh55cnaRo07KgxhS6UYt?=
 =?us-ascii?Q?BYnd36b8I4FQW61I1V9wtG7O6IWTlmEquoWQm59+Df8nywuL+zUXPb1Q3x8y?=
 =?us-ascii?Q?DEH00Ik+sW06CHyQgIgutsC9uGIXo+WY9Jx9O/xX4yn4CEfpbI7+aki3VjKq?=
 =?us-ascii?Q?I3q/q2DR2fEYT7P6D4jJ4G9kr4ZODHgNNg/GPH9YNgfy4mh7/bRK1VAOmjmh?=
 =?us-ascii?Q?h/8O0jBXy1xfMjgB0wrqtNhffVpaOnZZLPBPfNDo7h2oigSkcmqgPuTbVblA?=
 =?us-ascii?Q?JNfhxd89qM2jdP4Zikr+vs0HPIlNeH9z5+IMfWjuYO6slEMvRN6yRe4MG1E4?=
 =?us-ascii?Q?AhTT0FJtdW1BvzLs/EsTTi5pbh7UfHs2Rng/dcZCMExlRSQMsrFdNdMHXU2X?=
 =?us-ascii?Q?c0xTaPXskYlRiC8g+izuK8JCrlU1wLMceDsmW2y2BaaJLdjZr6LCAXV+OucO?=
 =?us-ascii?Q?kfvq+JOKWHBv/VAzpgPCRlhMos9losxDnba7qsfRmTV+nJOlMrjW201PBVJQ?=
 =?us-ascii?Q?woW+RIL7LoyQKZWS/emyvBoes1rhm9sIGVF8G1avSxOwrpQ+Mreuy4QBGibs?=
 =?us-ascii?Q?BI3mZV++S9gmmEWqYlwvIqJtCM4Hw+4nP/nbIaApfLIC/Dw3i7ZScQvV5Q2l?=
 =?us-ascii?Q?r8AhOYe1xenPUNxs3Ub7nkr8Lucc5glonAAtTWTeuqerVGGMJvBDzZLcQwKb?=
 =?us-ascii?Q?Mai8xhC03qVw+O7WikoTdj6wZK1SKFcIv46zHtcigqeJP57qxNAcqMhrWn90?=
 =?us-ascii?Q?JF2l3dE3px6MOj9LxBEucnyYnPjjb7CWdUfBVxslKDniAOxZ4VUnQfl7CIdJ?=
 =?us-ascii?Q?bNXbKrbUr0OjjcqMP4gwadRi/kwl1JY1nfO2hPG55nUJB/Gx22f/YTR9i8eH?=
 =?us-ascii?Q?ecB3cmLmFzc60q9/YsuFnnyfR7dK4zvX7EJ/2eAGV3hMoDl90HSKGxnfC8Jd?=
 =?us-ascii?Q?m+y1xmlWIkcq7kYjLZ8amEjwPFvhF8UBfdHu6h/UAzDJRxcX2dz9m4QHPKxZ?=
 =?us-ascii?Q?DVODBjiHTWpk/s/ciQkkgXgfdSTxtWN/KCY39MDLE2HLZxuRVuA9oFiV69Tm?=
 =?us-ascii?Q?8uw=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: student.uml.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR02MB4737.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7cf7fea-8c72-4402-51bb-08d93f358bed
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2021 21:49:06.0240
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4c25b8a6-17f7-46f9-83f0-54734ab81fb1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DCEsKweyTeGHrvGTv2QrMYGhCfqV4EuENPEuHKOF4Mil9HPPZuLfU7usIcmMiatQGd+7nfgqmtOxIODac44kbuADhx0tDXTKkWfIi/jd/AU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB5537
X-Proofpoint-ORIG-GUID: SV9fLVKjjHieMhoNNGmQbDtNeex5k6In
X-Proofpoint-GUID: SV9fLVKjjHieMhoNNGmQbDtNeex5k6In
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-04_17:2021-07-02,2021-07-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 mlxlogscore=999 adultscore=0 impostorscore=0 phishscore=0
 mlxscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107040135
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am very new to the kernel community; this is my first message in the LKML=
 so my apologies if I am doing things wrong.

I have been using an Si4463 transceiver for UHF communication with cubesat =
I developed. I could not find any code to control the transceiver on Linux.=
 The closest thing I could find was an AVR implementation by Zak Kemble (ht=
tps://blog.zakkemble.net/si4463-radio-library-avr-arduino/).
I followed the API docs and rewrote the whole thing at first for userland o=
nly (can be found here: https://github.com/SPACE-HAUC/si446x_linux/releases=
/tag/v3.1), and then I decided it would be a great learning opportunity for=
 me to port it to the kernel.=20

The kernel port has gone mostly smoothly. The transceiver communicates with=
 the host MCU over SPI, and requires a pin for RESET, and another pin for I=
RQ.
I have implemented the driver to provide a char device to the userland for =
open, read, write, poll and ioctl (/dev/ttyUHF#, even though it is not exac=
tly a tty device).
I had initially set up a pull request for the driver and the device tree ov=
erlay to the Raspberry Pi kernel community. They have agreed to accept the =
device tree overlay for the device, however the driver needs to be included=
 by the Linux Kernel community. I want to use this opportunity to find some=
 people who have access to a Si446x transceiver and a Raspberry Pi, so that=
 the code I have can be tested, and if deemed worthy, included in the kerne=
l tree.

My code is hosted here: https://github.com/sunipkmukherjee/silabs.git

Any suggestions/criticisms are welcome.

Thanks,

Sunip Mukherjee,
PhD Candidate,
University of Massachusetts, Lowell

Email: sunip_mukherjee@student.uml.edu | sunipkmukherjee@gmail.com=20

