Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A14840DA5A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 14:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239699AbhIPMxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 08:53:48 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:6672 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230299AbhIPMxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 08:53:47 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18GBRKJl004611;
        Thu, 16 Sep 2021 12:52:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=dgEUVLQmKKIseKOStnub6FD4QjtMBW0WIiXK+Djwh0Q=;
 b=jvtfJILJmpvktHyRoTWq1f3wARNvbm7g30LmfhxhZjd57UX7JRzWdQ6V71LW3B2J+BXU
 RKGwFByu95/MuE5cvuPS1NSG39NdOQjESwYvoC1IJIe/S+JVUnlc3Iw8Cvd0FG+WaBc2
 QoS1iQGeKbwIUh5w6OEUnRkjQFAOITuoxVPrsFAaNcjRjoupgrLKbmYQnahY/MyUXRrx
 eN08k7WAwBpj3cgYlUKuYrmqGvc3Axay1MAJ701rp+Vj/bXYcFsDfG/tuYh2ccYZrsZb
 A3FLKQuGL0eRxf3AF05BjC7yYe51RIJytmvi/b7Hr7NQaxYtX0GbSaQV7ybssp5cuYOM zw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=dgEUVLQmKKIseKOStnub6FD4QjtMBW0WIiXK+Djwh0Q=;
 b=CmFgxgFNZ0JJ3SxRMzwLJjdCtQBtWKnbQODk/c9Edz1yqDDdUGiBx1CFK7LlW5Ia24kj
 g8orG1sM/6+qEfiWMvIG/65MYljnnGFjmMwe7YKyqRq544SL25a2TIVyqEs2zJaGMsTr
 zZ6JXLgz9oMgGoFLA4ZOtmR2Ug42KWktOMEtX9+vOPJE9j7QpcED6kvx/YFDH9PO/YRc
 ZDt5s8no9uNKVulsd6+ZKVKVdfCsEMRywUVu5JsXaS3Gf+JbGC3/wgeMTMvt0FBI2Oz3
 2jt/5WZX8hymmY26/Fj4hdNLs2H5iFxRK/09N8ZM02iRKFixBwqTG90P5esvGPgRh1DP HQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b3jy7k9tb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Sep 2021 12:52:19 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18GCjHRk074328;
        Thu, 16 Sep 2021 12:52:18 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by userp3030.oracle.com with ESMTP id 3b0hjy6ed5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Sep 2021 12:52:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZsSDDkB0tkqV/18kDGTKKerXubTIaP4IqVWFXU7fbty2bKEqINGsMDjv9qs96Iq3ObeunmZ+dQkx+myFyDe2uRnUNpyNUXlKxcLeGuxOScUzLwfhDXFUAXfq+CyPNwqCpvQtY+uPV3tLdbtIiKbOlvwUfQM60f5rD6/RnalM/tt9ZK+1LjThIjdscH+1uTYmVlTG7ykpTT+3RllC6QL2AS8aeyoPRBeATGHpaph2+zTeqtyGodbI7nOR2np/wok/SLpB+Op1YAoBiwa9gLkSRuQQdMY+RBawcyKUBdu0ZsrbiheiFQJxI+QlGwKygqoG9HsS4BCSvGIIzS9c7gA1sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=dgEUVLQmKKIseKOStnub6FD4QjtMBW0WIiXK+Djwh0Q=;
 b=Sb2qQPklU5q854m+pBRhRisjM8zLRacabWdSuAYgsdzIXobqIdDfv0vfUfS1FkUSIKszm0JHiB+VRj0no5ffXmzpN3q5HoLO/6iMxjCt7+a5oCodNmloF7wzKuNla/qkl4dafuwzpqeHhN67wZHo0SlY2VDjZEHpoqE3DpbQSM+p79e4spQxOLVPIv/rKSTtkT0BEL2/tXMQmaUENjpNmYI/2KtcuNmd9Jr4zTGIkQzYsVEIduhZOz2Mjn5GzNBUKGWZlzLW0YBa9fGV6MUQxF0IjcX7tAlLVPwBtNTdi49i/u/yOYhcPOA7/XvZHruHpur2MfBAEhHy6KyrCt08yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dgEUVLQmKKIseKOStnub6FD4QjtMBW0WIiXK+Djwh0Q=;
 b=EMIqtSXL0kZqh28963eR5+WJj4vKVCLZctjupFY/YqduW3nHFYhYOsDY93Tnas/EFTOuJB/hk5T+LJydIxZy3NasdeftEqozTBJ5rND2I9p9uqHlPUjQdPS1UBEqBN2CrBj1rgUiRLCxiCfnSXvINfJVGu1pxstdkEDM0Xgo3EU=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4449.namprd10.prod.outlook.com
 (2603:10b6:303:9d::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Thu, 16 Sep
 2021 12:52:16 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4523.016; Thu, 16 Sep 2021
 12:52:16 +0000
Date:   Thu, 16 Sep 2021 15:52:00 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>
Subject: Re: [PATCH v6 14/19] staging: remove struct _io_ops
Message-ID: <20210916125200.GM2116@kadam>
References: <20210915211103.18001-1-fmdefrancesco@gmail.com>
 <20210915211103.18001-15-fmdefrancesco@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210915211103.18001-15-fmdefrancesco@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0007.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::19)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (62.8.83.99) by JNXP275CA0007.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Thu, 16 Sep 2021 12:52:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: acbc80df-7e78-4db7-311f-08d97910cfee
X-MS-TrafficTypeDiagnostic: CO1PR10MB4449:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB4449B438310DC2601A8C7B588EDC9@CO1PR10MB4449.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:901;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vhiBiSW6me/7pbXS1QolnwNvBj7g3abrS0hoZeIKZhMj8ugB1Q48xKdpfVNylc3Tnvs6TW7TcZDD9Hjov7kn6wCB8Zm1I5WwcHp4f6pGIvYvL1mhkbdwWsTu9spdTQs21xDTBsVxpowC4CuP6+saIqMxU3HN6w9s7U5lUxJsBim+gFCFxNlSKZoF0rxSw9SnQyQFtcAHIPT0y5DN52rRNPUmpi4H0eiBXvb3wTRWq0Rfs0ahb4kIojCpMpgeT+0utSoR09UYjugJ7HqT1FwFDYQhZxH2YOf8o39bftDW8oROHJEsX5ZASIAoFv8GbJ7tZibLKaZS+kX/BLOvvHqmbJFOJovxVfH+qVpGqBJ6yJOMEgmWFyp0APUPc2PVsVDnM7Gl8t6oWhF3kSuuMk53RXXhSBYvGurLj/HYdXJMubUdrnwsxD1ZKOU+hsaCRnr0aqOOZSexe6qmYPnC2Y7yTOHMp2OHR+BcMM7YYMZfic0mZ8VCIYBjy2Fdedruu/gQOE8N/+6+9HAm0qrvORxzxKLN0d/+z6aVCC3ODKfB5K8Z6OTBRIWLv/UdNEyBZIGD3n9Sw9LmRwDwd2eCaCPqu4z4LuYorS6Rge9PYMxb31HEYMd5X2PS2NFUvx7o9Kax4tscnk6qukGkDdK46F/uOdozQsdbtQ7sXKyH/lRzpDBqVxaEYRgbCheU84NqDiabkwy+pERgqEk06Y/M/XgsAw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8936002)(54906003)(508600001)(33716001)(5660300002)(316002)(6666004)(186003)(44832011)(4326008)(9576002)(38100700002)(8676002)(86362001)(38350700002)(55016002)(956004)(33656002)(9686003)(1076003)(66556008)(6496006)(66946007)(2906002)(6916009)(66476007)(52116002)(558084003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0/NtIcMhTIe+h95NXcLAfmYJSDTmf+qIYTjCP5+pTQfhQ6HWYh5cvCBaJDJX?=
 =?us-ascii?Q?soqNHRbnAjzjL2WnZ5lf0iBHTSBRIoGOP/47fXsRovIoIZ3cGwNH7j8BQ49U?=
 =?us-ascii?Q?+V/ZnwGJUz76NbxCcZqmEYlW4MxokXuTwvgeRo46fy7OPKNMXLWJP4ffxX/p?=
 =?us-ascii?Q?Ndoz6M+l44gYQ6vdn9gR73panikMhzKA0gI/ZnQk/ID0aVjmx4j/t3YtEcxU?=
 =?us-ascii?Q?r3nphZrf31LBlYON6pVd+s4r3v1yh5hi09Gw914LVChucSYYeky4zuMPSbMI?=
 =?us-ascii?Q?2rooZRSElIHTJ3S7cT1Rnq0uoIUtMk9ZyJW0Gq9xEfJ3i++OjTXD3KfpGQda?=
 =?us-ascii?Q?AKaNqpg7gwxX8qT6bUU6fNq6jt0HdUKJeGVAhqy6lUaLvaEYag1Wg+IEfH+n?=
 =?us-ascii?Q?/UM5YqaSODnDMj1hXza8Y72QETHX70hFoQZHdXdNXTs87gZjPl+5eAc1ORxS?=
 =?us-ascii?Q?iAAHDvZshJ+3tQ8mNAvR0Xu8sCNnQhXOiOmd4FsLdP5hEanYvmWbvrOGZK2u?=
 =?us-ascii?Q?To63f7UrpYVZLOlGnUbQLKFwfKQ6xk9kcZcZqn9UtwMY+/QBOMQXTebTd6uR?=
 =?us-ascii?Q?J0bnblIt288kqFmnVse27Sa+T3s1DdOz1rYwISuDdfPCBvMKwUY6tU/MbIGK?=
 =?us-ascii?Q?foDnXKTD1CWRxG9KaDJxpv2x8fOaVXiQOP2RpG6LBne4cIRX+07xBGkLitBD?=
 =?us-ascii?Q?MgAHbeMVNZWhllLl/82IH3w3018S4tSdDulRGL7CGMFzkcUR3LGKcLCCxgi/?=
 =?us-ascii?Q?xNneLFun6iOOif20KAHnLWnWq8MMUfaZOaKqqvvwREF5tiiQqO4rUwii0owl?=
 =?us-ascii?Q?7NdeTyoeyfY37VX5/oBc4JYG7cC0ij1cjczG/ppMCSlUHm9UsL7gg7FW4FT0?=
 =?us-ascii?Q?AgGfVk0u+wxKCC1unhmHNeqS2E27ADqUuGhlrIrMgyfbMWwByqClNBkSlAlU?=
 =?us-ascii?Q?VHydZ5Zk7hjTin73jGbI0VzwrsaGjVDs9m99o3TnnWYJY6lME0LvG+MKe9P2?=
 =?us-ascii?Q?wx45vmRTmE5XRC9fIFUCFJtLvVsjOenOON+ltdD5C/1ai3/xaGdP+gyR2O7Q?=
 =?us-ascii?Q?1rCjvQMOiA5BFpnFn2YBDNr36c4cdthVeC1tea5WinWlQq05pofQI5CWovq/?=
 =?us-ascii?Q?VFz8qDYxRKloEguK5RoHTZpkd2TiQXypD5i9DYZSJmsZAe8MSv/Zli9qkSpr?=
 =?us-ascii?Q?j6OMUNLNI/BtXaW4L30gnNe13Iqx8S/oDoIi/PSG+tZxvdgKfCW/lnneB9bc?=
 =?us-ascii?Q?gB4Cb4CmzJYx3ORMhdhl9wYuVZgug/sO/wyRTra01e0kflgVsNjXuJycsZ59?=
 =?us-ascii?Q?v0Rz9Mis6yWTtzFPGmnkrA2O?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acbc80df-7e78-4db7-311f-08d97910cfee
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2021 12:52:16.5736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YZZaT8YYPQTshiypEyk4+H0+zYtni1/auYsxUmxDWn1w94jpEC3tDu2Eqqb4u5eDR9EjP07E8jRWkWY7Bc3WsqxC/JUByTbvoNRFGUPrW/o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4449
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10108 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109160082
X-Proofpoint-GUID: jiyEZihOfzK_vCbgeEgebE49KiNolk7T
X-Proofpoint-ORIG-GUID: jiyEZihOfzK_vCbgeEgebE49KiNolk7T
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patches 1-14 are great.  Those 14 patches are:

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter

