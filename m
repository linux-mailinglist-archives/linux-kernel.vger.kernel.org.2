Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15BAE4443EE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 15:53:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbhKCOz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 10:55:57 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:54952 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230471AbhKCOzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 10:55:54 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A3EkECw020520;
        Wed, 3 Nov 2021 14:52:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : in-reply-to : mime-version;
 s=corp-2021-07-09; bh=JGGJ5zwgCbsyvEN3o+wOU0J2Q9wo78QLQSphKdwald0=;
 b=glneHps6d6SMlOOYN/ExFtVxN/+HfzaBT+AZJXgniDYpOCx2+ok868NzgjDbRMj2RXtl
 GAzFprnL7Mt00PbsZQ0m2+ZGVHOD8evEtXglrAgY6dao0eR6M3kHKcLFPOJWKBA9V9jJ
 J1/6P/tiEHmUQ/6vVK+5uGBcrFVDYGpFDwLqb+mPAAui6CnhimQtRwFVAinJfo1wgjmg
 mpoXFtpUXRJT4uiO8MXZQiDdO36iLuaLTTdXFpIr0GoDzFyvGT+EPh8DmoFrNyhifXVQ
 S+DNMtE4RFVN0a9+77khs+NHxLAJldwbpcHBJYFG7IqtcxJyD4Eh8cKd3/BkJ4+gVjcS Sg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c3n9xjchg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Nov 2021 14:52:53 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1A3EpvXc105753;
        Wed, 3 Nov 2021 14:52:52 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by aserp3020.oracle.com with ESMTP id 3c0wv6c1bw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Nov 2021 14:52:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZT4gvpxkv4p0HxDZoB7Nc72fPRaYJKkYiqVzwlZ7ER7iHzwYtLc49pKbJ7SJL/dpwfKSO6UY+48q15+1M65URUluUcFurou1F671/Vk8ccD1Knwq8TopR5tvdcmTrt8lrcKhJxn5TCMJVB5hUOcXFsnigGOYFd+NwWdVsTApjRq/oa/gw9CFujb5EJj4Wha4be9vXddFdzXwhvzfFucOaSiRiH3zeJ6IB6ay2qnnJiZsLe5jyG4Sk2fBgMlAFvFYAPA82l0w5iGBSraNGYX1yTrzk/c0vqssHTQ2miaxvyUJFKz8EbJLjOLglUhXZnaVh4XGHnjzyuYknAt3pqcZkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JGGJ5zwgCbsyvEN3o+wOU0J2Q9wo78QLQSphKdwald0=;
 b=JPgAZy02+2Pk27UJp50JaC3wufsDiipGwnEPCB/tpyd9y2UzR8lahu70K2zdMg1i4megCIkQbwg3lvxtyKSS8VoluI5dVhOCs7gGyaRsHmgx4GUEUOOCe8oO7pow9TQMIKS2QgzTrekuB2P70q1bUld6m9+h5CxLB5MJu+MwgAFhdRitOHi9wkk7RBPHBnh9ek2IPdW5lORsZ9kl6kETar8tCFRrIcUhcNiJvDkYmhtF2U4vb7pyLZnWYrp5gJfIgeY0MX82xksOZ4FPtPJVWxVckJamAM0sBYADM+SqxK5WNWrtm6ry5/fZmHK9osj4iMdyHu2OIk6liH/fE0trvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JGGJ5zwgCbsyvEN3o+wOU0J2Q9wo78QLQSphKdwald0=;
 b=JyrFXej1Ti8bQL4pDvnoGERrvdWeGId621x4OZoHczzGBlPGEI9S7VGE3Vvbvl5JZZ369PF11DMvSfiA6hSzwwV6ohlHDgxurdtdZfIdPFFc3ixHZy27zxy0XjA6mcbOAkRDabOg9hVu7oqi0JkRWzPMS+w/wblp2/6GKXIIILs=
Authentication-Results: lists.01.org; dkim=none (message not signed)
 header.d=none;lists.01.org; dmarc=none action=none header.from=oracle.com;
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 (2603:10b6:910:4a::32) by CY4PR10MB1814.namprd10.prod.outlook.com
 (2603:10b6:903:11d::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Wed, 3 Nov
 2021 14:52:50 +0000
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::e5e3:725b:4bb:7809]) by CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::e5e3:725b:4bb:7809%5]) with mapi id 15.20.4649.020; Wed, 3 Nov 2021
 14:52:50 +0000
Date:   Wed, 3 Nov 2021 17:52:32 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Nathan Rossi <nathan@nathanrossi.com>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        Nathan Rossi <nathan@nathanrossi.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 2/2] hwmon: Driver for Texas Instruments INA238
Message-ID: <202110281334.zCoIMxK7-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211025025805.618566-2-nathan@nathanrossi.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0065.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::7)
 To CY4PR1001MB2358.namprd10.prod.outlook.com (2603:10b6:910:4a::32)
MIME-Version: 1.0
Received: from kadam (62.8.83.22) by JNAP275CA0065.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend Transport; Wed, 3 Nov 2021 14:52:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 36c93e11-146c-4e18-e9a7-08d99ed99b3e
X-MS-TrafficTypeDiagnostic: CY4PR10MB1814:
X-Microsoft-Antispam-PRVS: <CY4PR10MB18141E3657B0C57C832203BE8E8C9@CY4PR10MB1814.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6OTHbqpECrJl6NtibZMUJnmQmzOP4D6bqjWLGy3+2PAEUpsPoN6j9u7s0XotPpQmfprPyEctJWxi2KFI+EhwopQJjNIsZ+PNoP+rCbFomjX3Oo8YNOthsve2SckXMbEHW65042FODRsHmjok0X6F23xqYcD0wAvkOXXjpjgsp/HCJWd1pcqOwmXjuztgRc828eHtp/7TjyZePUomqaVaU4BZ4vpIVQfYXegtbVOVa+he4TfyscoOg7/owrZNjm5tr3n9SF7L8gDoWsdghV6ZLBsFRqP+0FURl/PxujHe8Loo0VGzkMvVP4nxeG2QGxHZ6qX3gyvv8YR6qa2LuU3v2w0kY2xOxEnIPFo9qhxBgsnTDDkbZQqjrY+Sc0Nze22y8rRR6TNN8yeZX2YVX2NjyMbkmnrTcsBL1lteqdtwQGNGXP74Eq/CCbro3O8xufjjANijr8+vU2VolxvVLe3rlJ7+xqvMFlm0dvBnvdFS0WB60Dxz+KrZmKPyqpAZxevkNHxi88HVtfZH9I7kH5JEG0QToO9mKPqQKK70nbeuWjoLGm6+TyDBBx/HZtOBXK6LOBjjuNPcUXPAeM0KlH/R01cyyWY5gTWk2O9ktimXDaLLJDU2gimqaBP9VUKGEjREEY+zHc2+2SkkN0QXz3QD7EDlLCwXxz0u7T61oCclb4dUyPGLCQGevUzdllIABHiajJiVpw0xNCvmkmvSmICc/EznBrz0e902/OiWKYn1u91aGTPsZRzWoE9Iy9qSSf4PACC/ATPEvUDzEV4Fpwf1o3NyDOYb/zanH92WWOVancKNBcrxWk+RXxMTRp9HksuduS6AorujIJ0ZtwqTgG9b9A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2358.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(4326008)(66476007)(66556008)(5660300002)(508600001)(966005)(316002)(54906003)(6486002)(9686003)(66946007)(2906002)(1076003)(956004)(44832011)(186003)(8936002)(8676002)(6666004)(26005)(7416002)(83380400001)(38350700002)(6496006)(38100700002)(52116002)(36756003)(4001150100001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZthwbWx/W+a04IXuv8xhKeqOprH9Kq97X9HrKHHD4dkcFMGakaU3Uk+gpjb1?=
 =?us-ascii?Q?zUiBzxalBN8/VX9a/LcqkmYf7e9vUn5Mwz0FcoLj+bkJ7R4QzqLkBMvp/Gln?=
 =?us-ascii?Q?7cnByyhX52MWHlro3NQVwrnw3LQAZr9U/wVgVZnQ5S56YRLgQ5Z633o67oPt?=
 =?us-ascii?Q?SmO2A6EItFBap1hMED0SCn3Pj9OeL0jJMV1FBDpLzjp09r6iXva6/ZwN+TeL?=
 =?us-ascii?Q?J4H8ysZme7z5q47uU8rkRDZW7LTtQHqkk2cXzfX/m5K8oSZ0vRbl+DjeN030?=
 =?us-ascii?Q?3lhPns1X/tzO3D13bYHNRceEY91MSjYpJGL0nWaY34E72X9SgTUcCeAXBDPO?=
 =?us-ascii?Q?bU2kAKB4rYOiKaWNmz8W/BvEaptjJiSH4vXnzTrYmmYJJObtz16536MDHkEY?=
 =?us-ascii?Q?1q00qMLkqDeOt1YoZ1/x2lHv18R3Wg2xFs4Mub04wmr+cGMO+LnkRTXyADYG?=
 =?us-ascii?Q?NBlOblJ5W7kCLIxSKZGnMXKTVsEbeB/UxHBZRpOq5fRaytZLcByBw5OTklmu?=
 =?us-ascii?Q?/RqPuO7/m3QZttUwEeWMXjkm9Khn24D71yFuZ/K610V0Z5eGET9UVUv75AZ2?=
 =?us-ascii?Q?OUa4WVAOwmBvVbSn4k66BsNRq+9hNMVwiqAguHDZPrFjPryCOc39JtahMhm4?=
 =?us-ascii?Q?r57ngV36NHpgqIN8yQfe+Vny9GjpZeXTRDdv8iOZXjoBwcErIDgSZSauyHle?=
 =?us-ascii?Q?FORza+yqGiIAu5d1ETd2r6RH3x2jTitog+s7NozMg+0O+0Rk4I8Nr3pSowBe?=
 =?us-ascii?Q?hcWTjOXp1vbgiVRzJDMGkPR/79nxcsdLg7IUuc4T/i0UDfeyrx0xfAXXbZz9?=
 =?us-ascii?Q?NJ8qOkmSbqx5zvc81IKzC7cTXQxJBws3qzls/WBJq4eW/g3/0jdBnxafqZ1Y?=
 =?us-ascii?Q?zEsFkrvuybtZ21ZoqCYu3vgHpwj02WDv7al7AId8HIn/Hi7atXgX+TGskERB?=
 =?us-ascii?Q?OzK0ECPGz4eudA90uaq7S3ZIs3sdwuOwThq+jJ0hmGDam47tpE4d0gvDe2N1?=
 =?us-ascii?Q?ZHsBSgAklENQJ+NS2naCAfSatct9Oa1juUV09cnZgO0nIdFrNk7dNTFOEItL?=
 =?us-ascii?Q?7nLfgoX2f1WXcPPisagupFkxcO5CEXZIH6cmloUWyighZTAvX0cimfd7+vS+?=
 =?us-ascii?Q?6blWcTeihdeRTLlTlJGZ3OlJQlDxsiBFqlMrNuq3n8KjnHrCapUxmcmmrCiU?=
 =?us-ascii?Q?2GXAI1x+kj1CFQ5emvRRs9DN7XS5zxbWIamGdDHoleaCmHBIKHnjnSz4GufJ?=
 =?us-ascii?Q?wib8108hVMNlbr0uSQL13+N4AQzdPTUFBi8gv7DFfPEKVpGQ2Iq1Trj/t1md?=
 =?us-ascii?Q?Vukkl63KrfkbpqUi6F7tfCmPZy7p37SzM16XWmK3M/4sEw3ZI3HTZz3zrop4?=
 =?us-ascii?Q?mwSLfGmNkuiAoGUVmacEo4mnR6JLmqDuZvHMTumTfIkyysYIMLdMTPeZt4Ry?=
 =?us-ascii?Q?/B1K1iDQawOW73KADZSm/tmQc70+IaRQhqFsZ05AcOPwM2tJwlUsS7FxsY1/?=
 =?us-ascii?Q?G/Gg+wecTPz2MYJI46aaP7RGKSbTzCUayK3+2tTnqWYe9snQHgIiw3trloSY?=
 =?us-ascii?Q?ASTnaJlK/fOYf4ezpR7KiJXezvcPbLRRGRLqA4KKL/5qpK9/FghEH4cdOcI2?=
 =?us-ascii?Q?G6kGbG92WCsfSPyYR+BOKRbe1A+MCA7bmcEUlmlmZ/Ev1OWFuatq/s+AbhTu?=
 =?us-ascii?Q?Z9Gy+A=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36c93e11-146c-4e18-e9a7-08d99ed99b3e
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2358.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2021 14:52:50.1857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cBLfSm+OpGPfKolVugtQnqhNawVT9sieZ1kv50fbjVh24UBgl15XrAhzllm3vTkYwXHEaXKi4FYiNn0ubhApHjVHK3LhkDX0xo4Fy5oA7vc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1814
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10156 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111030085
X-Proofpoint-ORIG-GUID: PuQ9nFiDrxCyoN9aOp7DQT2BFkH3lK2I
X-Proofpoint-GUID: PuQ9nFiDrxCyoN9aOp7DQT2BFkH3lK2I
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nathan,

url:    https://github.com/0day-ci/linux/commits/Nathan-Rossi/Driver-for-TI-INA238-I2C-Power-Monitor/20211025-105911
base:   https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-next
config: x86_64-randconfig-m001-20211027 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/hwmon/ina238.c:304 ina238_alert_store() error: uninitialized symbol 'regval'.

vim +/regval +304 drivers/hwmon/ina238.c

aafb1ad1e44aa2 Nathan Rossi 2021-10-25  243  static ssize_t ina238_alert_store(struct device *dev,
aafb1ad1e44aa2 Nathan Rossi 2021-10-25  244  				  struct device_attribute *da,
aafb1ad1e44aa2 Nathan Rossi 2021-10-25  245  				  const char *buf, size_t count)
aafb1ad1e44aa2 Nathan Rossi 2021-10-25  246  {
aafb1ad1e44aa2 Nathan Rossi 2021-10-25  247  	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
aafb1ad1e44aa2 Nathan Rossi 2021-10-25  248  	struct ina238_data *data = dev_get_drvdata(dev);
aafb1ad1e44aa2 Nathan Rossi 2021-10-25  249  	long long val;
aafb1ad1e44aa2 Nathan Rossi 2021-10-25  250  	int regval;
aafb1ad1e44aa2 Nathan Rossi 2021-10-25  251  	int ret;
aafb1ad1e44aa2 Nathan Rossi 2021-10-25  252  
aafb1ad1e44aa2 Nathan Rossi 2021-10-25  253  	ret = kstrtoll(buf, 10, &val);
aafb1ad1e44aa2 Nathan Rossi 2021-10-25  254  	if (ret < 0)
aafb1ad1e44aa2 Nathan Rossi 2021-10-25  255  		return ret;
aafb1ad1e44aa2 Nathan Rossi 2021-10-25  256  
aafb1ad1e44aa2 Nathan Rossi 2021-10-25  257  	/* convert decimal to register value */
aafb1ad1e44aa2 Nathan Rossi 2021-10-25  258  	switch (attr->index) {
aafb1ad1e44aa2 Nathan Rossi 2021-10-25  259  	case INA238_SHUNT_OVER_VOLTAGE:
aafb1ad1e44aa2 Nathan Rossi 2021-10-25  260  	case INA238_SHUNT_UNDER_VOLTAGE:
aafb1ad1e44aa2 Nathan Rossi 2021-10-25  261  		/* signed */
aafb1ad1e44aa2 Nathan Rossi 2021-10-25  262  		regval = div_s64((val * 1000), INA238_SHUNT_VOLTAGE_LSB);
aafb1ad1e44aa2 Nathan Rossi 2021-10-25  263  		if (regval > S16_MAX || regval < S16_MIN) {
aafb1ad1e44aa2 Nathan Rossi 2021-10-25  264  			ret = -EINVAL;
aafb1ad1e44aa2 Nathan Rossi 2021-10-25  265  			goto abort;
aafb1ad1e44aa2 Nathan Rossi 2021-10-25  266  		}
aafb1ad1e44aa2 Nathan Rossi 2021-10-25  267  		break;
aafb1ad1e44aa2 Nathan Rossi 2021-10-25  268  	case INA238_BUS_OVER_VOLTAGE:
aafb1ad1e44aa2 Nathan Rossi 2021-10-25  269  	case INA238_BUS_UNDER_VOLTAGE:
aafb1ad1e44aa2 Nathan Rossi 2021-10-25  270  		regval = div_u64((val * 1000), INA238_BUS_VOLTAGE_LSB);
aafb1ad1e44aa2 Nathan Rossi 2021-10-25  271  		if (regval > U16_MAX || regval < 0) {
aafb1ad1e44aa2 Nathan Rossi 2021-10-25  272  			ret = -EINVAL;
aafb1ad1e44aa2 Nathan Rossi 2021-10-25  273  			goto abort;
aafb1ad1e44aa2 Nathan Rossi 2021-10-25  274  		}
aafb1ad1e44aa2 Nathan Rossi 2021-10-25  275  		break;
aafb1ad1e44aa2 Nathan Rossi 2021-10-25  276  	case INA238_POWER_LIMIT:
aafb1ad1e44aa2 Nathan Rossi 2021-10-25  277  		/*
aafb1ad1e44aa2 Nathan Rossi 2021-10-25  278  		 * Compared against the 24-bit power register, lower 8-bits are
aafb1ad1e44aa2 Nathan Rossi 2021-10-25  279  		 * truncated. Same conversion to/from uW as POWER register.
aafb1ad1e44aa2 Nathan Rossi 2021-10-25  280  		 */
aafb1ad1e44aa2 Nathan Rossi 2021-10-25  281  		regval = div_u64(val * 5 * data->rshunt,
aafb1ad1e44aa2 Nathan Rossi 2021-10-25  282  				 1000 * INA238_FIXED_SHUNT) >> 8;
aafb1ad1e44aa2 Nathan Rossi 2021-10-25  283  		if (regval > U16_MAX || regval < 0) {
aafb1ad1e44aa2 Nathan Rossi 2021-10-25  284  			ret = -EINVAL;
aafb1ad1e44aa2 Nathan Rossi 2021-10-25  285  			goto abort;
aafb1ad1e44aa2 Nathan Rossi 2021-10-25  286  		}
aafb1ad1e44aa2 Nathan Rossi 2021-10-25  287  		break;
aafb1ad1e44aa2 Nathan Rossi 2021-10-25  288  	case INA238_TEMP_LIMIT:
aafb1ad1e44aa2 Nathan Rossi 2021-10-25  289  		/* Bits 15-4 of register */
aafb1ad1e44aa2 Nathan Rossi 2021-10-25  290  		regval = (div_s64(val, INA238_DIE_TEMP_LSB) << 4);
aafb1ad1e44aa2 Nathan Rossi 2021-10-25  291  		if (regval > S16_MAX || regval < S16_MIN) {
aafb1ad1e44aa2 Nathan Rossi 2021-10-25  292  			ret = -EINVAL;
aafb1ad1e44aa2 Nathan Rossi 2021-10-25  293  			goto abort;
aafb1ad1e44aa2 Nathan Rossi 2021-10-25  294  		}
aafb1ad1e44aa2 Nathan Rossi 2021-10-25  295  		regval = regval & 0xfff0;
aafb1ad1e44aa2 Nathan Rossi 2021-10-25  296  		break;
aafb1ad1e44aa2 Nathan Rossi 2021-10-25  297  	default:
aafb1ad1e44aa2 Nathan Rossi 2021-10-25  298  		WARN_ON_ONCE(1);

regval isn't set on this path.

aafb1ad1e44aa2 Nathan Rossi 2021-10-25  299  		break;
aafb1ad1e44aa2 Nathan Rossi 2021-10-25  300  	}
aafb1ad1e44aa2 Nathan Rossi 2021-10-25  301  
aafb1ad1e44aa2 Nathan Rossi 2021-10-25  302  	mutex_lock(&data->config_lock);
aafb1ad1e44aa2 Nathan Rossi 2021-10-25  303  
aafb1ad1e44aa2 Nathan Rossi 2021-10-25 @304  	ret = regmap_write(data->regmap, attr->index, regval);
aafb1ad1e44aa2 Nathan Rossi 2021-10-25  305  	if (ret < 0)
aafb1ad1e44aa2 Nathan Rossi 2021-10-25  306  		goto abort;
aafb1ad1e44aa2 Nathan Rossi 2021-10-25  307  
aafb1ad1e44aa2 Nathan Rossi 2021-10-25  308  	ret = count;
aafb1ad1e44aa2 Nathan Rossi 2021-10-25  309  abort:
aafb1ad1e44aa2 Nathan Rossi 2021-10-25  310  	mutex_unlock(&data->config_lock);
aafb1ad1e44aa2 Nathan Rossi 2021-10-25  311  	return ret;
aafb1ad1e44aa2 Nathan Rossi 2021-10-25  312  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

