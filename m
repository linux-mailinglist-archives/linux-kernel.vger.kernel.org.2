Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF1E352078
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 22:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235612AbhDAUOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 16:14:39 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:35992 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235002AbhDAUOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 16:14:38 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 131HSslf068416;
        Thu, 1 Apr 2021 17:33:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=/cvWMU3uk49zkTMPP0FtFHhnsSPN3AACc92qIjsNF7I=;
 b=lqn2w/XQkcWdlaDvRA+jmtykXYGxvlUZUSUnDMPq2vf5tXRiFUVyCmBthjwTqSMuLE/n
 lrf06CwcO6QS/pZ1spq0wSpkCdXIuh1Kb7gXoxaGFChb/56ZF1kUfoQ58Ulsqu/a18XF
 rW8NY+cWmJWfLEkEqNYLNA/m/EXeuxNqg13U1HJRL3Mm5eW6/4vd8PIicmeDoQPWyJFU
 31nddDliuiZw9n9GZ+06J3EE60h+7NgdJQqxfNXh0Lx7r+XAtbZv9adgHww+vXbjBAP2
 7R/OhrjAqofmpgsqEhR06V5NOv7urrK9JFYR8qs3fAvkLbuaGXJGxkXkfR/OG/y2xsvd 4g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 37n33dtked-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Apr 2021 17:33:36 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 131HTa8Y153227;
        Thu, 1 Apr 2021 17:33:35 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by userp3030.oracle.com with ESMTP id 37n2at3npa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Apr 2021 17:33:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TEW3BNEvXAz5IhdL51gRP9SYoEZd3LKcHsEYYn5SOgJ5VEok8pNx46HY3WK24HbKb7LRfn5j/hPYYTxMaBUuI4arcUPc3NhkNGO0JnryIpqCp/IMnqsVsMctcwg9VfMVjBIWbUzBHmNIoxkBATUrhjHCOtVi8wcWOvyMdmBE6GinIIbKx/6Pp0erTiUbEEsncVDBkXHpQ5hTP42SDjBg2M0dr6Jrtvhv/dV0E1f+9kvLObPLzVKnrN2KMSDQe3Urf8cFVv2Y9rBl/+SNWHxXwkbsBpPUvbZ+1NQzEPzttmSOakuKqXeL5JBiMN12NpDPYbC/4VIpC0e7EyfCyeKnVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/cvWMU3uk49zkTMPP0FtFHhnsSPN3AACc92qIjsNF7I=;
 b=nFcIizTkVqgT0zXiZWl5Sd1ui+cpN8ZzkIYKvicKBPAu15uJI1ThaQyKNnIgTgyUDa9tCOuyhpZroaA7P1oDbkMZV9shbLOBeTiV5Ah0T0/BmL8A5Oxpjp/jD1QFcXNyx2c7eGQnUHJkygFR27Z/C5QMLkJLOQKzE8/VU0ZS96O44kPRTlSAjRu/da/BlfXbeYxaAwQiTmHNWeJ5Aj/CB8EtKtTj8WnDI0ECGZma1/NWwVa5wJgiHxSfWBUz/i9EDK9cxbRnC54yrR+n5RBm8rp4gSBiUNIaalsLycKRGnsyqaF2mMo5SPElLhZRGSUV6DN9Q+mnb1y31aAXDwO2iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/cvWMU3uk49zkTMPP0FtFHhnsSPN3AACc92qIjsNF7I=;
 b=H7+fPDaiVa6Lg7+h2QfNxOwvQMAgc04ZzKFtJsxXJPzAUNDhLtICyB3AwAJNuxRFbZQW26SWWgBsPAtMglvP3/thoDxhVcTgb7xFRDBrDRIZXenO6MTgV1d0nxf4+89gL3f+3ZHZyIw2fQKrQbvtphVrLJotfFxKl2TGCaIKrUU=
Authentication-Results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB2999.namprd10.prod.outlook.com (2603:10b6:a03:85::27)
 by BY5PR10MB3970.namprd10.prod.outlook.com (2603:10b6:a03:1ff::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.30; Thu, 1 Apr
 2021 17:33:33 +0000
Received: from BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::50f2:e203:1cc5:d4f7]) by BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::50f2:e203:1cc5:d4f7%7]) with mapi id 15.20.3977.033; Thu, 1 Apr 2021
 17:33:32 +0000
Date:   Thu, 1 Apr 2021 13:33:23 -0400
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xensource.com,
        linux-arm-kernel@lists.infradead.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "open list:SWIOTLB SUBSYSTEM" <iommu@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>, opendmb@gmail.com
Subject: Re: [PATCH] ARM: Qualify enabling of swiotlb_init()
Message-ID: <YGYD40RbKN9r8I8n@Konrads-MacBook-Pro.local>
References: <20210319040333.183827-1-f.fainelli@gmail.com>
 <20210319130731.GB2624@lst.de>
 <20210319195929.GA1346384@konrad-char-us-oracle-com.allregionaliads.osdevelopmeniad.oraclevcn.com>
 <alpine.DEB.2.21.2103191718210.439@sstabellini-ThinkPad-T480s>
 <3db926f4-6047-cc62-8654-a965b8570e75@gmail.com>
 <20210330053607.GA4863@lst.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210330053607.GA4863@lst.de>
X-Originating-IP: [138.3.200.16]
X-ClientProxiedBy: SN4PR0201CA0055.namprd02.prod.outlook.com
 (2603:10b6:803:20::17) To BYAPR10MB2999.namprd10.prod.outlook.com
 (2603:10b6:a03:85::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Konrads-MacBook-Pro.local (138.3.200.16) by SN4PR0201CA0055.namprd02.prod.outlook.com (2603:10b6:803:20::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27 via Frontend Transport; Thu, 1 Apr 2021 17:33:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b18b61b-3528-44f0-2e5d-08d8f534455a
X-MS-TrafficTypeDiagnostic: BY5PR10MB3970:
X-Microsoft-Antispam-PRVS: <BY5PR10MB39706C5D991BAFABB0769B4B897B9@BY5PR10MB3970.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ObfV5ioplR9s8jZZTd+N6VE08yhxNPzEhuZuVfUT5mD5+TM3/YALlUj3LLmjzFOcqkE2Ho8PH8OAHd5AjB3y8B7Xsqfj1rRMMquuoiy9CNk47Hdy5CNjZX9GpPPk+pPTwANJg8iMr6f6oD7R36hxre8MuYFBCDI2as57qyDDL3B7SeCJds9fyXaRNTHkbtuGU9kd69x2xG7C3esHoUT8awl+kc/57fq2RHbcUDUKZosK7Im8tyFDtlkhACQbfbHaz4hp0V0Hl2cmOYpJzYw+m71PvIzIcQr3mO0+Ved15sGfJXKrTDy3FlxYDnec5WyKnhObMl3WWdFawLCV6SGcbtUq+3awS4uY1eAgh7NL76ZaCNJf1Mv2c13aew4EAmDzhoKrykKS54SRrI3VmwA2p2xk1I9pBRwPsXew1QOzOjwNSs3SDu2ne2FHUAaXXg8YPlE9KhE4zmG5sDSQMsJa8EfFV0K+haxZr80dv49oxoq71j0jJMtzAI4vzmDwMJwpaljCltFhk7BG/mD8aYYfSBVJJOvJKU7eAosgijaogfZiTGJLtgd3eQ56KokXXdKYZj6wpJZfohnSKmapySsA5lUC+5MZs6IO6TxaWGP9DHFbbEj/xEIjNIGZxoeeuXCmuBK3TvhEI9MMhNKWnzmZcrbA3P7Fjf8MEie+Pmet0pw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2999.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(346002)(39860400002)(136003)(366004)(66556008)(8936002)(6916009)(66476007)(52116002)(8676002)(66946007)(186003)(38100700001)(6666004)(54906003)(16526019)(6506007)(7696005)(4744005)(2906002)(956004)(478600001)(86362001)(55016002)(7416002)(5660300002)(9686003)(4326008)(26005)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?OPBPbuZZOpaJxMjM21tugKQqPLvG5wFQdTelIFs0JnuE071VVreJTCMH+qyv?=
 =?us-ascii?Q?yCX1sy+hWmhxfYpfWBnHxgQi+fOZredUpHyD3UWW1P2g5qdVzDFCv20G5uvf?=
 =?us-ascii?Q?ORJWMGflQCcmn4YhSyHLnAxqJTG1J62INGxAGEpwCRR9V7wKeN6cKrsSoIt8?=
 =?us-ascii?Q?Ww1Ru5+kJqAy/N4hD6bkI5NiY7ncXg59iEmFnL2wYwmyXtzKkA+/xqvSVmLB?=
 =?us-ascii?Q?ppoF6Dhmr5qB5n/xIYkcBrQtGwdnf7e6djkwfC5/nXwygpXsF9FMuQnD4jw2?=
 =?us-ascii?Q?MsPUCNfHuYob0D4VlA3MU6SN+raVlcdwziujUbhwHbXGb0qhrBswzAqCL3Iz?=
 =?us-ascii?Q?Le/zx4HoIR5Vlxuac0gXtUyJdeUhh2NqpsuampDyk486z09afJrWfKwG0Oq1?=
 =?us-ascii?Q?+OnB37j9MOBaQxzTJGm2HA4tUXelqi57N1zOXX9F5G0dCvQqbVtB4N4N92n0?=
 =?us-ascii?Q?o19YqeuuOdjURnTvfjnLmuVWLgO/9wkbyCbddmxeNpOxFF6hotRTh/u5HSkj?=
 =?us-ascii?Q?jNux5vgg8223H46S/zY/0YCrTAfudZ/5Ik6gFE72gedCz5Q0w3JhNlvhnFsI?=
 =?us-ascii?Q?G5MC3ipPU7suJXEvQCWENsDNGR4a6mrBxE5qVM0R28Tj1IGdzfMRinnYnGg6?=
 =?us-ascii?Q?lQOun9olsO2E9llT6OcumpOXJqjiOrte0h5GJEk2uJex605+GbaeH2GhvLnC?=
 =?us-ascii?Q?DkMMMjnI2+ClYHlvMHGsGLpJyt9wAmutXqpIHZlPy/0TBWhbuIVTzyzNzVxD?=
 =?us-ascii?Q?HEv3bkmgLIGwQuaCGYtk3ecZW+6g2NiGQyR/YBTf7hQidgbr7KMi+eV5cH5i?=
 =?us-ascii?Q?vXsR7KVO7U7JM3fizwoekeGTjNlod3cW0zp6NnaPqgC4l4V2mQ2NobH+R9pO?=
 =?us-ascii?Q?rRaggpYrRybTLuRv0Qg4BEvbLFLT5ljTUIJzxhF8UwpclF1RCB9bFlVgXPXp?=
 =?us-ascii?Q?HrK8yLUao0gAaixMQoQjZgCGLc8obDOkcVtKE1D2PdoOUc0+GVi9WtGDc02L?=
 =?us-ascii?Q?JhmXDEgpwvS5E9AqgoLtgSaz5TIhlcfGPBeIksX/NvV75m50t08/34lg6kG5?=
 =?us-ascii?Q?HdaF/U5rnn4jNg3xO7h6TZQ1Xe5/oaP+Y8nOixv985F8RlzB7+YbPVpil7/j?=
 =?us-ascii?Q?anMFQyQ5bPjlkFKI9VYQu1iRIxHNd0GqOB9gdAcwdffgAwaCuZgRmSKifj0e?=
 =?us-ascii?Q?4lcaYsUOHxhJN2rk+fstg3OHtWVWFEBPUOe6Z+5V6jqV6I/0B/pfRyK5GfP6?=
 =?us-ascii?Q?2wB+AmGnCH+//EPv6oIBMa1ZUth7/f18kOW8bQ5J496t9HiZGfc2cz/65Ke2?=
 =?us-ascii?Q?jUvhPxSZLRLHQ9igj5/bJhyP?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b18b61b-3528-44f0-2e5d-08d8f534455a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2999.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2021 17:33:32.7985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ab9jMVKZQynnC9Xu5yJGSP53LQCCsVHrRwWA44xdolKg/dpKgbW4C0sKLR4b0ruqV+FZZipejUupuQ3JGMQ8Yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3970
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9941 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 spamscore=0
 mlxscore=0 mlxlogscore=875 bulkscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103310000
 definitions=main-2104010113
X-Proofpoint-GUID: XCgJ2K9yj_J7KwxloqcVXOgcCemyI69b
X-Proofpoint-ORIG-GUID: XCgJ2K9yj_J7KwxloqcVXOgcCemyI69b
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9941 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 clxscore=1015 impostorscore=0 malwarescore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103310000
 definitions=main-2104010113
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2021 at 07:36:07AM +0200, Christoph Hellwig wrote:
> On Mon, Mar 29, 2021 at 12:30:42PM -0700, Florian Fainelli wrote:
> > Should I toss this in Russell's patch tracker or do you need me to make
> > some changes to the patch?
> 
> Due to all the other changes in this area I don't think anything but
> the swiotlb tree makes much sense here.

I've put them all on 

git://git.kernel.org/pub/scm/linux/kernel/git/konrad/swiotlb.git
devel/for-linus-5.13


