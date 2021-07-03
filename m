Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85B4F3BA8CB
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jul 2021 15:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbhGCNE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jul 2021 09:04:26 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:51868 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229484AbhGCNEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jul 2021 09:04:25 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 163CuiSc014465;
        Sat, 3 Jul 2021 13:01:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2020-01-29;
 bh=cizhVDUUJYZ7ZCMXHmCIuS+uOr/h1XV0BigEnLfYxkQ=;
 b=MGcw351aTILe+JA//oQNsWnP4ZertsitpivFRBTGctm3fzrII9mpOO5JbjUN/sIuyuH2
 uqOXwjfBSC4n9/qzq4QKM0dzyitVvqwLpjZ82HMAwY7NjpX6QblU3U0PoEXXHNnEorz2
 lUzV910NsFVDys+MT6ywQLIObrJsGKh89SR+Ies3T7vQOcR3zb+kKbhGcDxQJ9EtpeUM
 bzaYzTkmrVlkWNqHV48aUZEa9ucXRTWbvEFGjJrtiay8F00ujMUuqRHrcwKt3Gr62frE
 YPv+CnL4vGrOV9nxAsOawD4hEee8dokSF7GIeQEank9+E8Ce9pUZOXg2lIYNDWjsapwr JQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 39jfsc8br0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 03 Jul 2021 13:01:48 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 163CuHg9072901;
        Sat, 3 Jul 2021 13:01:46 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by userp3020.oracle.com with ESMTP id 39jf7knyg2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 03 Jul 2021 13:01:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YEUYMZTaM9bUU2xOCzQyvSLGot+WFPXy7I74oc78O8fsKiE6sclmIEq/I/yypDJo535m6NrTjmqPgkjgv1R1bgJpiXmok3ZEe0gHkXa4pLwYDd8zw/UC+Fx0eMP728sBA0zEnl8liYIf+4wFt1wNKz07Jij3qy/166y19GYp9VOEXlvbMrIRuqFUR6g2FKo92xzy66rAaOxNQyGWURiOMklxLRyEnxwr4aocZQ7bVZy5qzZxNYf/Fx01svNy0JP92OZ2D6Z7LxBgLr85pDaHrbDEKSgOh2/WTfHot5pvE5D1qOrq76JhcjNSB7iOTtS3Z7TJfK52TKOxEEDxFMhSaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cizhVDUUJYZ7ZCMXHmCIuS+uOr/h1XV0BigEnLfYxkQ=;
 b=cBO9/N2bTQMpIrWJKQ0C6F7my/eXJiy8ibsWi47pJN0SUEPWWpBGZrRRb7jOPHgp5LuY2muq4X8LAnqAA3Cam1UBI4dZvojCoJLxXaIvlO726IX6xjG1UgIy4mhJqXh14kUMBU8BugJxjJ7r9m5vCw/0+1jbg3RTHgELdTGH5NKsxLTP7M+Z6S4PaURW3i9KzVD4LFSx2W0k0GI/DQOLDs1n2vOP/pqRXSXUYHopqkgBuGNxozwBEXIcbq0RFQG34VfYZQU/U8DjJHKX1L1TLGkMSuOfziI1OsHqEh1+ZcUvylxzF6M+QakN6Fu7y4aasDgBqN7TD+aS4fCZdN5gqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cizhVDUUJYZ7ZCMXHmCIuS+uOr/h1XV0BigEnLfYxkQ=;
 b=Pj3Sp+KZcsh3ghIOyYRSV1kMqvYIgGq3TTf/lFzJn0PKzgtRNxnwaItXxwNZiWf9aOIB8xlwMzCIBoVyrtu8odCGLs2fnUlb7ZSu9DTft5UrRRF7v/ANS4xCCYOrImpJht5uptLjH6nuYNu7WudagVuQST1NdeZzyh/FhKuA9So=
Authentication-Results: lists.01.org; dkim=none (message not signed)
 header.d=none;lists.01.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1902.namprd10.prod.outlook.com
 (2603:10b6:300:10d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22; Sat, 3 Jul
 2021 13:01:44 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::3413:3c61:5067:ba73]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::3413:3c61:5067:ba73%5]) with mapi id 15.20.4287.030; Sat, 3 Jul 2021
 13:01:44 +0000
Date:   Sat, 3 Jul 2021 16:01:24 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Rob Herring <robh@kernel.org>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: arch/arm64/kernel/machine_kexec_file.c:152 load_other_segments()
 warn: missing error code 'ret'
Message-ID: <202107031042.9GeZ0EQ9-lkp@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [102.222.70.252]
X-ClientProxiedBy: JNXP275CA0028.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::16)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (102.222.70.252) by JNXP275CA0028.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.23 via Frontend Transport; Sat, 3 Jul 2021 13:01:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ba9f3d72-c6f8-43eb-dbf4-08d93e22b54e
X-MS-TrafficTypeDiagnostic: MWHPR10MB1902:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB1902DFD649D0ED09E1D866B88E1E9@MWHPR10MB1902.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:486;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uoD0xAVJTCbiQj/t2MJ4Rmtanj4BI9vzgyKcHfoqGzpAb70EB9WzePA6oItHDEyErFG5pl/MGzFhHEYGffQKK71s83Xsr0mURkwfOv1kB4bTak6BIhuuFAZpTDDPezSAx5bH4rx+n3HoRVo5a/sUU4m4j/fdvxHo72Bu4/V3qZ8UXNDrJHUYkfeymlVSnO+cDfnM/8p/Wb4XfLglS97L0owBYM/mw00E98GZw5IlPjM4BMxpID8i1pAsKYFcQZw0bzSVQ2qqZqQY1b6WWxYkXDInVB2mz19/QpzkBJKvX5+kodACAiehj+SBKQzvABshM2DQdl7joeBdCRsYbACOEnMqX4wuF16zP2xXYbl/EO5/cht6ZgJgSx/evI68ByUsMiTIgWs72d8MXqrKUNeZYtlexBGFnT8RZTQhpKvi4kEQaRvUhGyTRdefdizUjhI5RXJzlrilKoWcoqNU3Q5hyYMtnEbPI23t2Xo+Wii5EUpQvJZSzOnaeEnTpKJseaCq0SfQ4do1fBYPx1VTAQA5x4OdIf57/XySTHDFo35uHC9OimWu2U6Wb/ZlT8HOC4OcVaeWCBzmpHb3iAQ1W+WAq/cc7dcizfHoCFkl7WBG2kBukTf1TxHd73xthx43Z539yikjinUu+3tt96U6Kwsa+V+nGnTg4BMIoiFma3Se5qY7wmQwwTNXdVcf4kmyAENjx2vU7ZC7lfS7ytCqHQ/Q+9bE6qg3CExTxC1QAeFb8WITlG8qxdDHqqcdWCAJ+U9h4ErWjpgflm41QcbqqpM8py9aO8gh0bh/TWs6xUruCmR6P91HkCtZmPIxm2JXsdw35FjxSHo3gOfjir/6U3e6+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(366004)(39860400002)(396003)(136003)(4326008)(86362001)(6486002)(26005)(1076003)(966005)(478600001)(16526019)(66556008)(5660300002)(8676002)(54906003)(8936002)(44832011)(66946007)(956004)(66476007)(316002)(186003)(38350700002)(38100700002)(6666004)(83380400001)(6496006)(52116002)(9686003)(36756003)(4001150100001)(6916009)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFAycllyY2xuRUVKaHQ1QkcvUytjUDZLWmsrR29OTmRnKzZ6czNtYlhDd0U3?=
 =?utf-8?B?dnJNWlRBcVFMa0hDbmpFVjVmSXB5WVVlelFXZDliclVUZ3pMYTlLM2xYdzhl?=
 =?utf-8?B?enRJQkFtenptVWVWL016SHQ2SStVVGZmZHB5VlBZSlVWQUg1ZkpPVTdINS92?=
 =?utf-8?B?M2RoVXYraFFPbW5jRng3a0pLd2IrUWcwK0NqWVlsaVFEUXNwTWxRL04zcVd4?=
 =?utf-8?B?enNMWHp0bU5ydy8wdHVMNEY2KzZDU0lyQ2Ywekd1WGxFZ3B0T3dxeVcwWlhT?=
 =?utf-8?B?ZG9zZUJEK3Rub0Q2L0hYZDByN29HeG9mN0h5Z0NMVWdNaEpDeW9mNlo0NSsr?=
 =?utf-8?B?OXZKdTgyRlRWU3RvSURjcGVYTWRPbVN1VG4wZzhmVWZkR3dUQUJiMFBzaDF6?=
 =?utf-8?B?SXl0eHZEK0xzeXFNZWF0TUgxbm5iT1ArYlBFd0RBQUdJM01NVVR2cm1mZ0FY?=
 =?utf-8?B?azBtWTZLQW9RQ2R2Zi9NZURodkhUN01GQWlZbG0weWJzYVpqaGtmdWRSeSt6?=
 =?utf-8?B?UGIyT1I1SzJDWm1GRGxkcnd0eHVNRHB5bThyc0xDZmdEdFQwTTNSeDBPQStp?=
 =?utf-8?B?bGhGUk1HUnExdzRiNjRYaHVtMGFlYUFGb3hhZnhjYlpDcWFzTjhBcGpoUUsy?=
 =?utf-8?B?dzNMRWdhdFBhd2IvWHVJcWlNWUNSdll2WVRCWm50MVpGdWMxTmsrb3VIQW1u?=
 =?utf-8?B?TXp0VmQ2T3pWcXZmTFNLMmFxc3NrNWhCRnd5UE4vUTFOUEpRK2JkaUZtOWtw?=
 =?utf-8?B?eEJ0MUVpWmgxemFRS0ttQloxQXc2aUFhaWhLbHNoL2FZWGRJVjhWZDdSeEN1?=
 =?utf-8?B?WXB6Z3hVLzZuTWF6TzdPOVZxWnBGT2dEU0tBSVMyT24rSzBzZWdSTDRXUngv?=
 =?utf-8?B?aW5FQmxtWXVTZHdubnhTbmo3aGkrV3EveVc1Ym1PY0JGTkw0a3VUYVR6UldX?=
 =?utf-8?B?SFFNcEdsdGlhaW5Vc1RwWGc1VnhGK3dpdE5JVXdmNEQyUllISjl2RUZqNWUv?=
 =?utf-8?B?YkRnSG1CZGwwdHNzV1FYSFNIZTJPUXIvYzdIbzZEdm82Q3hURmhReVZVYlpH?=
 =?utf-8?B?RUl6NXBrR2x1RzNEVlVROHhmZ3J5Y28yZWZlS3liWExXRkpwd25NSlNtMW05?=
 =?utf-8?B?VVVnNVBHZFVzd3RQem53WjZ5Rk9RVkpZbTJoRVJHT0F5K3ExSXJLekRybjhS?=
 =?utf-8?B?eTFnREUyZXg3aTIxYVFBajdOTnZ0N2RjOG9NclhYR1BOejFWYkUzMGUxc0xn?=
 =?utf-8?B?WXQ4a05CVEc0RTdqeXI5ZzRVTGFGS3ExK2UzdDdiOUQvU0c1cmJYQmtaL2hr?=
 =?utf-8?B?ekNmelY2Q2xoOXAyOTFrdTNhRVZKMHdoWWMxV1g3SVhhUDF6c1JVOUxQdjhs?=
 =?utf-8?B?YmRHMjQ5M0hibTF5MW94VzUzSi9ZOUZRM0FHNW4wRjRxMzhWaTU1YnE3YWk1?=
 =?utf-8?B?eDZZUmNHMnpGb2ljM3hNNnoyMjJGTG94WFZpN01Nc1RkOWUrblZZSWdMNHdC?=
 =?utf-8?B?N25hbkNxNW83eHRKOGVaa3ptQlovM1dzUFpIVnpPamVTNUFOS0g5YStWa1Jy?=
 =?utf-8?B?d1ZSMGxBTVZmZmpiR1hUUDE2UlZ1MFROUHlWbmlmdFRHOTNRd1ROSnlEaFRB?=
 =?utf-8?B?SDZWN0Jwcm1CYTNWZHlYeE1UTUxZbDRLRmExSFJYeEJmbmZROFN3Uml2WUwz?=
 =?utf-8?B?d2QxWGZ2Z1VmWVAxYVpaMHdpMUp0RUxPeHNrTzZtdVFPNnJvMGR1cjd6dXlL?=
 =?utf-8?Q?DQZLkmLWpdeJS/KiLuSDWYKvP1DN1OFGk3j1xl5?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba9f3d72-c6f8-43eb-dbf4-08d93e22b54e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2021 13:01:44.5237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d/4vJrQe/M3l9U73cAsvxXonoyHpXToySlXX8lX9t4ubo3Ll6iTnQIeZ07Xf5zvC/TbHH+nmjU34ZGeDuw66399geNz1WCP9yM1JoMJhuFo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1902
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10033 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 bulkscore=0 spamscore=0 adultscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107030083
X-Proofpoint-GUID: nUtxt_W66n5bBylltat8bYNbJWjQcxHL
X-Proofpoint-ORIG-GUID: nUtxt_W66n5bBylltat8bYNbJWjQcxHL
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d6b63b5b7d7f363c6a54421533791e9849adf2e0
commit: ac10be5cdbfa852139658d52c2f1c608782ce992 arm64: Use common of_kexec_alloc_and_setup_fdt()
config: arm64-randconfig-m031-20210702 (attached as .config)
compiler: aarch64-linux-gcc (GCC) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
arch/arm64/kernel/machine_kexec_file.c:152 load_other_segments() warn: missing error code 'ret'

vim +/ret +152 arch/arm64/kernel/machine_kexec_file.c

52b2a8af743604 AKASHI Takahiro         2018-11-15   81  int load_other_segments(struct kimage *image,
52b2a8af743604 AKASHI Takahiro         2018-11-15   82  			unsigned long kernel_load_addr,
52b2a8af743604 AKASHI Takahiro         2018-11-15   83  			unsigned long kernel_size,
52b2a8af743604 AKASHI Takahiro         2018-11-15   84  			char *initrd, unsigned long initrd_len,
52b2a8af743604 AKASHI Takahiro         2018-11-15   85  			char *cmdline)
52b2a8af743604 AKASHI Takahiro         2018-11-15   86  {
52b2a8af743604 AKASHI Takahiro         2018-11-15   87  	struct kexec_buf kbuf;
3751e728cef290 AKASHI Takahiro         2019-12-16   88  	void *headers, *dtb = NULL;
108aa503657ee2 Benjamin Gwin           2020-11-03   89  	unsigned long headers_sz, initrd_load_addr = 0, dtb_len,
108aa503657ee2 Benjamin Gwin           2020-11-03   90  		      orig_segments = image->nr_segments;
52b2a8af743604 AKASHI Takahiro         2018-11-15   91  	int ret = 0;
52b2a8af743604 AKASHI Takahiro         2018-11-15   92  
52b2a8af743604 AKASHI Takahiro         2018-11-15   93  	kbuf.image = image;
52b2a8af743604 AKASHI Takahiro         2018-11-15   94  	/* not allocate anything below the kernel */
52b2a8af743604 AKASHI Takahiro         2018-11-15   95  	kbuf.buf_min = kernel_load_addr + kernel_size;
52b2a8af743604 AKASHI Takahiro         2018-11-15   96  
3751e728cef290 AKASHI Takahiro         2019-12-16   97  	/* load elf core header */
3751e728cef290 AKASHI Takahiro         2019-12-16   98  	if (image->type == KEXEC_TYPE_CRASH) {
3751e728cef290 AKASHI Takahiro         2019-12-16   99  		ret = prepare_elf_headers(&headers, &headers_sz);
3751e728cef290 AKASHI Takahiro         2019-12-16  100  		if (ret) {
3751e728cef290 AKASHI Takahiro         2019-12-16  101  			pr_err("Preparing elf core header failed\n");
3751e728cef290 AKASHI Takahiro         2019-12-16  102  			goto out_err;
3751e728cef290 AKASHI Takahiro         2019-12-16  103  		}
3751e728cef290 AKASHI Takahiro         2019-12-16  104  
3751e728cef290 AKASHI Takahiro         2019-12-16  105  		kbuf.buffer = headers;
3751e728cef290 AKASHI Takahiro         2019-12-16  106  		kbuf.bufsz = headers_sz;
3751e728cef290 AKASHI Takahiro         2019-12-16  107  		kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
3751e728cef290 AKASHI Takahiro         2019-12-16  108  		kbuf.memsz = headers_sz;
3751e728cef290 AKASHI Takahiro         2019-12-16  109  		kbuf.buf_align = SZ_64K; /* largest supported page size */
3751e728cef290 AKASHI Takahiro         2019-12-16  110  		kbuf.buf_max = ULONG_MAX;
3751e728cef290 AKASHI Takahiro         2019-12-16  111  		kbuf.top_down = true;
3751e728cef290 AKASHI Takahiro         2019-12-16  112  
3751e728cef290 AKASHI Takahiro         2019-12-16  113  		ret = kexec_add_buffer(&kbuf);
3751e728cef290 AKASHI Takahiro         2019-12-16  114  		if (ret) {
3751e728cef290 AKASHI Takahiro         2019-12-16  115  			vfree(headers);
3751e728cef290 AKASHI Takahiro         2019-12-16  116  			goto out_err;
3751e728cef290 AKASHI Takahiro         2019-12-16  117  		}
7b558cc3564e6c Lakshmi Ramasubramanian 2021-02-21  118  		image->elf_headers = headers;
7b558cc3564e6c Lakshmi Ramasubramanian 2021-02-21  119  		image->elf_load_addr = kbuf.mem;
7b558cc3564e6c Lakshmi Ramasubramanian 2021-02-21  120  		image->elf_headers_sz = headers_sz;
3751e728cef290 AKASHI Takahiro         2019-12-16  121  
3751e728cef290 AKASHI Takahiro         2019-12-16  122  		pr_debug("Loaded elf core header at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
7b558cc3564e6c Lakshmi Ramasubramanian 2021-02-21  123  			 image->elf_load_addr, kbuf.bufsz, kbuf.memsz);
3751e728cef290 AKASHI Takahiro         2019-12-16  124  	}
3751e728cef290 AKASHI Takahiro         2019-12-16  125  
52b2a8af743604 AKASHI Takahiro         2018-11-15  126  	/* load initrd */
52b2a8af743604 AKASHI Takahiro         2018-11-15  127  	if (initrd) {
52b2a8af743604 AKASHI Takahiro         2018-11-15  128  		kbuf.buffer = initrd;
52b2a8af743604 AKASHI Takahiro         2018-11-15  129  		kbuf.bufsz = initrd_len;
c19d050f808812 Bhupesh Sharma          2019-07-11  130  		kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
52b2a8af743604 AKASHI Takahiro         2018-11-15  131  		kbuf.memsz = initrd_len;
52b2a8af743604 AKASHI Takahiro         2018-11-15  132  		kbuf.buf_align = 0;
52b2a8af743604 AKASHI Takahiro         2018-11-15  133  		/* within 1GB-aligned window of up to 32GB in size */
52b2a8af743604 AKASHI Takahiro         2018-11-15  134  		kbuf.buf_max = round_down(kernel_load_addr, SZ_1G)
52b2a8af743604 AKASHI Takahiro         2018-11-15  135  						+ (unsigned long)SZ_1G * 32;
52b2a8af743604 AKASHI Takahiro         2018-11-15  136  		kbuf.top_down = false;
52b2a8af743604 AKASHI Takahiro         2018-11-15  137  
52b2a8af743604 AKASHI Takahiro         2018-11-15  138  		ret = kexec_add_buffer(&kbuf);
52b2a8af743604 AKASHI Takahiro         2018-11-15  139  		if (ret)
52b2a8af743604 AKASHI Takahiro         2018-11-15  140  			goto out_err;
52b2a8af743604 AKASHI Takahiro         2018-11-15  141  		initrd_load_addr = kbuf.mem;
52b2a8af743604 AKASHI Takahiro         2018-11-15  142  
52b2a8af743604 AKASHI Takahiro         2018-11-15  143  		pr_debug("Loaded initrd at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
51075e0cb759a7 Łukasz Stelmach         2020-04-30  144  				initrd_load_addr, kbuf.bufsz, kbuf.memsz);
52b2a8af743604 AKASHI Takahiro         2018-11-15  145  	}
52b2a8af743604 AKASHI Takahiro         2018-11-15  146  
52b2a8af743604 AKASHI Takahiro         2018-11-15  147  	/* load dtb */
ac10be5cdbfa85 Rob Herring             2021-02-21  148  	dtb = of_kexec_alloc_and_setup_fdt(image, initrd_load_addr,
ac10be5cdbfa85 Rob Herring             2021-02-21  149  					   initrd_len, cmdline, 0);
ac10be5cdbfa85 Rob Herring             2021-02-21  150  	if (!dtb) {
52b2a8af743604 AKASHI Takahiro         2018-11-15  151  		pr_err("Preparing for new dtb failed\n");
52b2a8af743604 AKASHI Takahiro         2018-11-15 @152  		goto out_err;
                                                                        ^^^^^^^^^^^^^
Set the error code here?  (The kbuild bot chopped of the rest of the
function.  :P)




---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

