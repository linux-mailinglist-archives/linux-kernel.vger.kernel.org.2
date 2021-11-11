Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF1144D524
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 11:39:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232885AbhKKKlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 05:41:47 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:64106 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229668AbhKKKlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 05:41:45 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AB98iYY024936;
        Thu, 11 Nov 2021 10:38:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=M548A6gqPjFAziz4KL+uV858UUg7rNaUUw91dLkvt+8=;
 b=TXssXDdsBv8stontAnwTo3U7cG0kkQI5pk+r5nMZcS2r3qn4H9WexOUEStlz0FhMdX4b
 4YS7xmWyKUeEmsNCp964w5OS7FUFPdfFHPf/Sk9lwWzAvHN1yBX1y9B9GX4/harF+t8M
 HGmLXIl2ObKHjsJ/PH1Td/3mITvER6p3pIqr7XdO/2BtWfNY3FF57LyP2VSaqLsYDnav
 xDJWFZoGrKWMTzXbnKjyKYLahkTJ390/RJHiY710Buq/ixdYTIsflst9vlPxmp3PtNFi
 BGmsbPOyUmpCQmHn1KJJx/+CFAYbjER8yjkR9XZQhBeobA+Y4OlVgR6iWkn28d2g7/+2 BQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c87vxryfj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Nov 2021 10:38:52 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1ABAUkRH187227;
        Thu, 11 Nov 2021 10:38:51 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by userp3020.oracle.com with ESMTP id 3c63fw32t6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Nov 2021 10:38:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I+okB9v0I8XWhk3qPZPl5DdNJuJNGMjaOHhYtmcbm0ILV7oXm5cvjKVupZslTxbtYeJ2xeqKv3YhlgjWJueTF0n2S4WCvg1XwMQKxNNWr1hC8/y9hWO9uzXTPIHZPYE22Jb8bmuUk2vVUBKdj2gMnkmDEHU1+Od0/aJ4YtpjI9Egyc8YBEKbhz7DN1ghOvdOWy4Adw3i2nOC6V2CHG8yD9vajTZRklm7SP/UF66OdlIu90O/3vlSC5yVDhTf54gYP43IsapiGed3SRKUS4UDxPVj3l62JVTZCZ1ahY1MAII9fvAstVOyDKQeJJuJMvMcSObgEi1vptiRkdH23tN55A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M548A6gqPjFAziz4KL+uV858UUg7rNaUUw91dLkvt+8=;
 b=hatWuBQDrkCO8jTVyjjSd7mQPys+DGg3R4npl3R1JlZmxVgL8mAzjxrdMeIUunx+vlgcoTyXweIe1KKRhcC00bGdnS8tzYL2ZKZLM70Sp7bzlrAqUYNyxF00kp3RYNkSoaKNRcaQNw/Cr2atbyN5yCBdFiRG+O4u1owkG3kpPqVIpQs8CmRhsy2397sFcKt54o8W5J5VzeODB4nU2rYwMFQ7LAzpjiRxuWojMsHO9PcoA17RVyQ8oBufhiI0kXFjeoVDAYajy6GVz4P7BtOMfzx4pTkDxi/XBvl7H1k8uGKDIYXiF3r+UK2B1mbzRvQI6RmYfBG4sPfj9OdmgNzM7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M548A6gqPjFAziz4KL+uV858UUg7rNaUUw91dLkvt+8=;
 b=WDhEggun4UjQyVhj5T192Bsp7Fla7npGqBijJ3C5FEwDPi4p5EoRiDigfMzKfGrvTykWn5HpENR1i8pUHe5Nm0NGyFpGCsyYEsd2XnQiiqd3lyp9TfT2DVDHXCtImeRmfG0gNJ+CcXFGacR6en0MMj+l1Dyxu+3Od8wJzJgKlBw=
Authentication-Results: lists.01.org; dkim=none (message not signed)
 header.d=none;lists.01.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1550.namprd10.prod.outlook.com
 (2603:10b6:300:25::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Thu, 11 Nov
 2021 10:38:49 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4690.016; Thu, 11 Nov 2021
 10:38:49 +0000
Date:   Thu, 11 Nov 2021 13:38:33 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Megha Dey <megha.dey@intel.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Tomasz Kantecki <tomasz.kantecki@intel.com>
Subject: [meghadey-crypto:crypto-avx512 5/6]
 arch/x86/crypto/aesni-intel_glue.c:725 gcmaes_crypt_by_sg() warn: possible
 memory leak of 'data'
Message-ID: <202111111630.gYWe04Fl-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0028.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::13)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by JNAP275CA0028.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15 via Frontend Transport; Thu, 11 Nov 2021 10:38:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ce5b1c4-fcf1-4ee6-e79b-08d9a4ff7219
X-MS-TrafficTypeDiagnostic: MWHPR10MB1550:
X-Microsoft-Antispam-PRVS: <MWHPR10MB1550C08ED6DAFCCFC05FF9068E949@MWHPR10MB1550.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:357;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fqoIIsBq8jQoVxHRfbAMkvhFs5TXA1LxPaA+Po8wrcVgGZijhd11BVRneo65BDN1r51WX4+ZeojpgDhY2vtDIprv8uNqzzdfleI4oDvs5llb/NoY1366ZcD5kw6MDBiLMkHcQl7ATex7VaEkad4hjxZ9jAg4EvyeMCwkbtOT08MKU3/sEhjw1kd+m4mBuC8xP58v+7R6mqDRBs/kAHx/O/5tjyuZZGm4KZ4sKaSkGd/FCU4yMBpUx5YCahv89MecjfZhqA8PV999HOPAfW+AnMZQDDBwb6HZtgMl7ANo3Jo2v2H6KUFfUaVapN5iYgm3Okz4REfIb2v9pS26sJ4q5JMJWlZPIhPJB2ynD1xRm+SiAbW+K5Hy0Pgvcc/vLZ1ak3fS9wZQfOCeJHktiOoIIonn6kb/fb0asS8N8fO1T8CJ3uojLQqhvgppafbBlvzNi11fgmAjM9oTXY0Y6Qdwuzv90rUJcHWF0gK7buVEPsYlUWmidyTjyw997qXRV6NmuVxRgz2OD07sSY1MDVnF7IUMJ4TLmE8qKp+fO+GzULsLfr17yrvL058Gqoq0pWILlzKc0Zq1CClrulRW342dnaDtis4ZURotcz2jxj0Bj7mNr/d5gOtqFTO3xjWQqW6Vhpt4vhUWEo0OZIgsBf22Bh2If4KdlJgiqeXkY+sHscol+fkPbNqaLvcPpVPYUn+uezbrMcH6NNQo0P56jJq1mLnnZFoRJY9BCSE+oo3lh2I0qc74ot/n6xJwPCMJ2fW1qa4P6WiyBqhHQeWc0mKdMeFdsXD6wdfEB79M64nM1tMphBp5Zq6yde8hmtI5g6XJ3Zc+gVuYRMvFKoRYgJfW1w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(5660300002)(9686003)(86362001)(52116002)(38100700002)(83380400001)(37006003)(36756003)(6486002)(1076003)(38350700002)(4001150100001)(66946007)(186003)(6496006)(4326008)(8676002)(26005)(956004)(6666004)(316002)(44832011)(6916009)(66556008)(66476007)(508600001)(966005)(30864003)(2906002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sB/+atMTvPOsT32oRkyVyoWQDEV8d6iZZJ1/DsW2SmE217FHGLnu7+SwJ4dw?=
 =?us-ascii?Q?SRF1V5YAVxhrwUQYD9XAFeKMGn2uRtxjH0vikY8enS1uC5hbalyvz6/+33+1?=
 =?us-ascii?Q?nOfh9spfidRBUsdmB8oT8g7XEfVcp1eMY4p4I36jsTZHSX9aFDo23JdV368A?=
 =?us-ascii?Q?KJYjb/VKHvUHVWZqNSumsJv3OrX1n8/+UYaksR0Kt0O9JnFYy+naw0N+e5/f?=
 =?us-ascii?Q?mgpel51uYEBseK0AB4PcDWD8oSKxQ2bviTfzcU9YdhkFBXl+QqeCHJoKr/0t?=
 =?us-ascii?Q?5+LDiX9uIkNZAwArr1w164mtqFQXLB595wsViKoVgOLf0JSqUG69ONpbQQ/s?=
 =?us-ascii?Q?rM6NgfoMUXD7R1bZMKmxYm9ZZq1E/QxM2V/3murew1o1tny5A2t39+XyXee8?=
 =?us-ascii?Q?UdGdyNijNrZ/ySX4qMDW1znOuQxyrOC3JW8YHPp1TDMi9mhiw5BqnPJG3QcV?=
 =?us-ascii?Q?zajdzm+Ha3PDEgBAu+/rN3XKQMBy/yGytsAmmNnktQRKfdhYCQq89CsEZ7k1?=
 =?us-ascii?Q?DgQRUKR6or6TyaT2uqVSgyWbfE2+eLbF0CTCxTZ710csIenVMv9No5goSViF?=
 =?us-ascii?Q?s9nRdppNfeUp1H5BGHBOBL/RzN6/eaOyS2NBJoPU1atSlkqen0xK0yj3KP9G?=
 =?us-ascii?Q?fYHSpJIiQXM/r+di1OnvFTa4PmoVNnhNLUYPaKATa8MHh5cIe4g0vwHHCbZP?=
 =?us-ascii?Q?k0KzryY9KztO14onrZIU2hstpjmmpKHQ0Rq8fNEhUdkuIPqY+z0l28M2VCC6?=
 =?us-ascii?Q?CSM+6uOaS8FWNSb8a5S7HA/XdMIjLCWR4gu6Jye6l5rdrZ1Uw6u08l9MMsE4?=
 =?us-ascii?Q?+pxlZQWmjlTjwmtuB80/ayB/tVpd6q0TTfgAVDQuF542HpKEXOnqrQeQcgk4?=
 =?us-ascii?Q?hvP6Y2jwOgrMkqTsUPkWnYIA3XqV9+6mcxSiihElkcioc96Kis1V/vwBAAb6?=
 =?us-ascii?Q?4gR2t7HeyIfiZdi9mZqH+nUB8AJMR191GCmsaCWK2J3Af1msPCWdDoMVXlIm?=
 =?us-ascii?Q?6PbmMUspHsZLpquEjt73hCRNiWszL+/PfD+2+uMW+kgCCBsPGaMiGKDiYVDF?=
 =?us-ascii?Q?qy9rJ7mdQXNeBzC/ieXppiHrdZc1PkL7snpoAlYcoF/+DAmbQ1aet2j27rbc?=
 =?us-ascii?Q?PCpl+72imLstQkO/icKAR/vIVj9qDhUUVc8FGaoAz0cAFQEReHw73omMoH3w?=
 =?us-ascii?Q?yHsyU8aT9rns/szP+aZKS08dvCxcBQ3LC88hm1rbNIhgZBPOT+0L0YHr0mo2?=
 =?us-ascii?Q?l0MOUioW1e/tZrdFwVS12jy8yJTUUh9L8XLVRMAcT+DnK/oWdI2RowcfYP+M?=
 =?us-ascii?Q?Q5PdHFQ6nwwpTZ47QPVUu9FVzimZU8KKJTnc4cdrsyRBQZKicHv8BeZcg7OV?=
 =?us-ascii?Q?OYH2WpD8y3ssVBRwti3tN8859JWwWd/rlAngpAKFARRQVq7t/52AMYxsOs6Q?=
 =?us-ascii?Q?UI0pAqExhWrlGxA3snIckS0i+oB1Ux7/vU3kgPAKspbrHxRBCLMc8E63u2Hc?=
 =?us-ascii?Q?82UN2+j0TDI2H/FIaIvc5v7mGlR9PNXbU11LVDIMp8whowJfnmYbWkMs9WTX?=
 =?us-ascii?Q?Mho7F8a47rYgZH4OppKziUTTEAL2KbwQbsX73J5vDRQ4DYml5zPBoa+MDIqU?=
 =?us-ascii?Q?EERPvvksInlfs0NKHcDbEdAibu+UTx5TFZD8cISrqmO0U4Hunbvs5WILEriB?=
 =?us-ascii?Q?TLAfReSKEn3ltpGR1p3ZpucdlHY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ce5b1c4-fcf1-4ee6-e79b-08d9a4ff7219
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2021 10:38:49.0969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W6ryNnecc2JshizwYqEuUpkgQSjOTC6eTiza/NR9dPQ3G+oIJlli1ry6V/D6KxcJDFSc3LxbX8Udwf8dmZipQW8iRU7lCLqu0jLVu1zYGLw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1550
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10164 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 mlxscore=0
 bulkscore=0 phishscore=0 suspectscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111110064
X-Proofpoint-ORIG-GUID: _ZuVkM0wh3i1c7t9vZ0yKEPi6N8IhzGx
X-Proofpoint-GUID: _ZuVkM0wh3i1c7t9vZ0yKEPi6N8IhzGx
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/meghadey/crypto crypto-avx512
head:   9c8c2ca77f6e2575a130bddb9767d068e1162d71
commit: 377aede9f10ee28be954473668bc6d33c6c9db75 [5/6] crypto: aesni - AVX512 version of AESNI-GCM using VPCLMULQDQ
config: x86_64-randconfig-m001-20210930 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
arch/x86/crypto/aesni-intel_glue.c:725 gcmaes_crypt_by_sg() warn: possible memory leak of 'data'

vim +/data +725 arch/x86/crypto/aesni-intel_glue.c

e845520707f85c Dave Watson     2018-02-14  677  static int gcmaes_crypt_by_sg(bool enc, struct aead_request *req,
e845520707f85c Dave Watson     2018-02-14  678  			      unsigned int assoclen, u8 *hash_subkey,
83c83e658863e4 Ard Biesheuvel  2021-01-04  679  			      u8 *iv, void *aes_ctx, u8 *auth_tag,
83c83e658863e4 Ard Biesheuvel  2021-01-04  680  			      unsigned long auth_tag_len)
e845520707f85c Dave Watson     2018-02-14  681  {
a13ed1d15b07a0 Ard Biesheuvel  2021-01-04  682  	u8 databuf[sizeof(struct gcm_context_data) + (AESNI_ALIGN - 8)] __aligned(8);
a13ed1d15b07a0 Ard Biesheuvel  2021-01-04  683  	struct gcm_context_data *data = PTR_ALIGN((void *)databuf, AESNI_ALIGN);
e845520707f85c Dave Watson     2018-02-14  684  	unsigned long left = req->cryptlen;
e845520707f85c Dave Watson     2018-02-14  685  	struct scatter_walk assoc_sg_walk;
83c83e658863e4 Ard Biesheuvel  2021-01-04  686  	struct skcipher_walk walk;
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  687  	bool do_avx, do_avx2;
e845520707f85c Dave Watson     2018-02-14  688  	u8 *assocmem = NULL;
83c83e658863e4 Ard Biesheuvel  2021-01-04  689  	u8 *assoc;
83c83e658863e4 Ard Biesheuvel  2021-01-04  690  	int err;
377aede9f10ee2 Megha Dey       2021-01-20  691  	int hash_key_size;
377aede9f10ee2 Megha Dey       2021-01-20  692  
377aede9f10ee2 Megha Dey       2021-01-20  693  	if (static_branch_likely(&gcm_use_avx512))
377aede9f10ee2 Megha Dey       2021-01-20  694  		hash_key_size = 16 * GCM_AVX512_NUM_HASH_KEYS;
377aede9f10ee2 Megha Dey       2021-01-20  695  	else
377aede9f10ee2 Megha Dey       2021-01-20  696  		hash_key_size = 16 * GCM_BLOCK_LEN;
377aede9f10ee2 Megha Dey       2021-01-20  697  
377aede9f10ee2 Megha Dey       2021-01-20  698  	/* Allocate gcm_context_data structure on the heap. With the
377aede9f10ee2 Megha Dey       2021-01-20  699  	 * VPCLMULQDQ version of GCM needing 48 hashkeys, allocating
377aede9f10ee2 Megha Dey       2021-01-20  700  	 * this structure on the stack will inflate its size significantly.
377aede9f10ee2 Megha Dey       2021-01-20  701  	 */
377aede9f10ee2 Megha Dey       2021-01-20  702  	data = kzalloc(sizeof(*data) + hash_key_size, GFP_KERNEL);
377aede9f10ee2 Megha Dey       2021-01-20  703  	if (!data) {
377aede9f10ee2 Megha Dey       2021-01-20  704  		kfree(data);

No need for this kfree.

377aede9f10ee2 Megha Dey       2021-01-20  705  		return -ENOMEM;
377aede9f10ee2 Megha Dey       2021-01-20  706  	}
e845520707f85c Dave Watson     2018-02-14  707  
e845520707f85c Dave Watson     2018-02-14  708  	if (!enc)
e845520707f85c Dave Watson     2018-02-14  709  		left -= auth_tag_len;
e845520707f85c Dave Watson     2018-02-14  710  
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  711  	do_avx = (left >= AVX_GEN2_OPTSIZE);
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  712  	do_avx2 = (left >= AVX_GEN4_OPTSIZE);
603f8c3b0dbbe2 Dave Watson     2018-12-10  713  
e845520707f85c Dave Watson     2018-02-14  714  	/* Linearize assoc, if not already linear */
2694e23ffd210c Ard Biesheuvel  2021-01-04  715  	if (req->src->length >= assoclen && req->src->length) {
e845520707f85c Dave Watson     2018-02-14  716  		scatterwalk_start(&assoc_sg_walk, req->src);
e845520707f85c Dave Watson     2018-02-14  717  		assoc = scatterwalk_map(&assoc_sg_walk);
e845520707f85c Dave Watson     2018-02-14  718  	} else {
2694e23ffd210c Ard Biesheuvel  2021-01-04  719  		gfp_t flags = (req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP) ?
2694e23ffd210c Ard Biesheuvel  2021-01-04  720  			      GFP_KERNEL : GFP_ATOMIC;
2694e23ffd210c Ard Biesheuvel  2021-01-04  721  
e845520707f85c Dave Watson     2018-02-14  722  		/* assoc can be any length, so must be on heap */
2694e23ffd210c Ard Biesheuvel  2021-01-04  723  		assocmem = kmalloc(assoclen, flags);
e845520707f85c Dave Watson     2018-02-14  724  		if (unlikely(!assocmem))
e845520707f85c Dave Watson     2018-02-14 @725  			return -ENOMEM;

"data" leaked on this path and the next.

e845520707f85c Dave Watson     2018-02-14  726  		assoc = assocmem;
e845520707f85c Dave Watson     2018-02-14  727  
e845520707f85c Dave Watson     2018-02-14  728  		scatterwalk_map_and_copy(assoc, req->src, 0, assoclen, 0);
e845520707f85c Dave Watson     2018-02-14  729  	}
e845520707f85c Dave Watson     2018-02-14  730  
e845520707f85c Dave Watson     2018-02-14  731  	kernel_fpu_begin();
377aede9f10ee2 Megha Dey       2021-01-20  732  
377aede9f10ee2 Megha Dey       2021-01-20  733  	if (static_branch_likely(&gcm_use_avx512) &&
377aede9f10ee2 Megha Dey       2021-01-20  734  				IS_ENABLED(CONFIG_CRYPTO_AES_GCM_AVX512))
377aede9f10ee2 Megha Dey       2021-01-20  735  		aesni_gcm_init_avx_512(aes_ctx, data, iv, hash_subkey, assoc,
377aede9f10ee2 Megha Dey       2021-01-20  736  				       assoclen);
377aede9f10ee2 Megha Dey       2021-01-20  737  	else if (static_branch_likely(&gcm_use_avx2) && do_avx2)
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  738  		aesni_gcm_init_avx_gen4(aes_ctx, data, iv, hash_subkey, assoc,
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  739  					assoclen);
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  740  	else if (static_branch_likely(&gcm_use_avx) && do_avx)
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  741  		aesni_gcm_init_avx_gen2(aes_ctx, data, iv, hash_subkey, assoc,
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  742  					assoclen);
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  743  	else
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  744  		aesni_gcm_init(aes_ctx, data, iv, hash_subkey, assoc, assoclen);
e845520707f85c Dave Watson     2018-02-14  745  	kernel_fpu_end();
e845520707f85c Dave Watson     2018-02-14  746  
e845520707f85c Dave Watson     2018-02-14  747  	if (!assocmem)
e845520707f85c Dave Watson     2018-02-14  748  		scatterwalk_unmap(assoc);
e845520707f85c Dave Watson     2018-02-14  749  	else
e845520707f85c Dave Watson     2018-02-14  750  		kfree(assocmem);
e845520707f85c Dave Watson     2018-02-14  751  
83c83e658863e4 Ard Biesheuvel  2021-01-04  752  	err = enc ? skcipher_walk_aead_encrypt(&walk, req, false)
83c83e658863e4 Ard Biesheuvel  2021-01-04  753  		  : skcipher_walk_aead_decrypt(&walk, req, false);
e845520707f85c Dave Watson     2018-02-14  754  
83c83e658863e4 Ard Biesheuvel  2021-01-04  755  	while (walk.nbytes > 0) {
83c83e658863e4 Ard Biesheuvel  2021-01-04  756  		kernel_fpu_begin();
377aede9f10ee2 Megha Dey       2021-01-20  757  		if (static_branch_likely(&gcm_use_avx512)
377aede9f10ee2 Megha Dey       2021-01-20  758  				&& IS_ENABLED(CONFIG_CRYPTO_AES_GCM_AVX512)) {
377aede9f10ee2 Megha Dey       2021-01-20  759  			if (enc)
377aede9f10ee2 Megha Dey       2021-01-20  760  				aesni_gcm_enc_update_avx_512(aes_ctx, data,
377aede9f10ee2 Megha Dey       2021-01-20  761  							     walk.dst.virt.addr,
377aede9f10ee2 Megha Dey       2021-01-20  762  							     walk.src.virt.addr,
377aede9f10ee2 Megha Dey       2021-01-20  763  							     walk.nbytes);
377aede9f10ee2 Megha Dey       2021-01-20  764  			else
377aede9f10ee2 Megha Dey       2021-01-20  765  				aesni_gcm_dec_update_avx_512(aes_ctx, data,
377aede9f10ee2 Megha Dey       2021-01-20  766  							     walk.dst.virt.addr,
377aede9f10ee2 Megha Dey       2021-01-20  767  							     walk.src.virt.addr,
377aede9f10ee2 Megha Dey       2021-01-20  768  							     walk.nbytes);
377aede9f10ee2 Megha Dey       2021-01-20  769  		} else if (static_branch_likely(&gcm_use_avx2) && do_avx2) {
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  770  			if (enc)
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  771  				aesni_gcm_enc_update_avx_gen4(aes_ctx, data,
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  772  							      walk.dst.virt.addr,
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  773  							      walk.src.virt.addr,
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  774  							      walk.nbytes);
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  775  			else
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  776  				aesni_gcm_dec_update_avx_gen4(aes_ctx, data,
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  777  							      walk.dst.virt.addr,
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  778  							      walk.src.virt.addr,
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  779  							      walk.nbytes);
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  780  		} else if (static_branch_likely(&gcm_use_avx) && do_avx) {
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  781  			if (enc)
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  782  				aesni_gcm_enc_update_avx_gen2(aes_ctx, data,
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  783  							      walk.dst.virt.addr,
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  784  							      walk.src.virt.addr,
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  785  							      walk.nbytes);
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  786  			else
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  787  				aesni_gcm_dec_update_avx_gen2(aes_ctx, data,
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  788  							      walk.dst.virt.addr,
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  789  							      walk.src.virt.addr,
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  790  							      walk.nbytes);
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  791  		} else if (enc) {
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  792  			aesni_gcm_enc_update(aes_ctx, data, walk.dst.virt.addr,
83c83e658863e4 Ard Biesheuvel  2021-01-04  793  					     walk.src.virt.addr, walk.nbytes);
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  794  		} else {
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  795  			aesni_gcm_dec_update(aes_ctx, data, walk.dst.virt.addr,
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  796  					     walk.src.virt.addr, walk.nbytes);
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  797  		}
83c83e658863e4 Ard Biesheuvel  2021-01-04  798  		kernel_fpu_end();
e845520707f85c Dave Watson     2018-02-14  799  
83c83e658863e4 Ard Biesheuvel  2021-01-04  800  		err = skcipher_walk_done(&walk, 0);
e845520707f85c Dave Watson     2018-02-14  801  	}
e845520707f85c Dave Watson     2018-02-14  802  
83c83e658863e4 Ard Biesheuvel  2021-01-04  803  	if (err)
83c83e658863e4 Ard Biesheuvel  2021-01-04  804  		return err;

Here too.

83c83e658863e4 Ard Biesheuvel  2021-01-04  805  
83c83e658863e4 Ard Biesheuvel  2021-01-04  806  	kernel_fpu_begin();
377aede9f10ee2 Megha Dey       2021-01-20  807  	if (static_branch_likely(&gcm_use_avx512) &&
377aede9f10ee2 Megha Dey       2021-01-20  808  				IS_ENABLED(CONFIG_CRYPTO_AES_GCM_AVX512))
377aede9f10ee2 Megha Dey       2021-01-20  809  		aesni_gcm_finalize_avx_512(aes_ctx, data, auth_tag,
377aede9f10ee2 Megha Dey       2021-01-20  810  					   auth_tag_len);
377aede9f10ee2 Megha Dey       2021-01-20  811  	else if (static_branch_likely(&gcm_use_avx2) && do_avx2)
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  812  		aesni_gcm_finalize_avx_gen4(aes_ctx, data, auth_tag,
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  813  					    auth_tag_len);
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  814  	else if (static_branch_likely(&gcm_use_avx) && do_avx)
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  815  		aesni_gcm_finalize_avx_gen2(aes_ctx, data, auth_tag,
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  816  					    auth_tag_len);
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  817  	else
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  818  		aesni_gcm_finalize(aes_ctx, data, auth_tag, auth_tag_len);
83c83e658863e4 Ard Biesheuvel  2021-01-04  819  	kernel_fpu_end();
e845520707f85c Dave Watson     2018-02-14  820  
377aede9f10ee2 Megha Dey       2021-01-20  821  	kfree(data);
e845520707f85c Dave Watson     2018-02-14  822  	return 0;
e845520707f85c Dave Watson     2018-02-14  823  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

