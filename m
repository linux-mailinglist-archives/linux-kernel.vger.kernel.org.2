Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CADA33DE0E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 20:47:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240685AbhCPTrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 15:47:07 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:35660 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237069AbhCPTqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 15:46:45 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12GJhi5h108871;
        Tue, 16 Mar 2021 19:46:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=erV69msJ3oojLMafl/GuaBF+ZNSj4aEaRElfRLebJbU=;
 b=aRH52FZ2hP1qGl5ipHq+wbVsIX63Q9HquqJ3y5QIYEhONjmEyCUKUQEM1czxuPtT7gKz
 XkpSumHCp7FsYkWU/hCHQ1wpZjT9HgRL1suLs1bb6EEAFgA2ikk0Ze83qRWPULIb57yp
 F1CtyrO9zz+OQH8+WSHj2OHMGIrwhVv8vwje23chMAzxSA9DBxhlA1Ex37cPOHCH8o0R
 bBwwy2WffaeNnvslLtOx31fSr0CFUawHdj2fLZmS15DiALxVuxtS1PPHBm1j0JB8oOug
 PfIGlHG97Zy5IbYH6hNREu2sDKPLMsNCp7ZzJ38JRRAYJ9VEY/po0QAUEWVtnZlGZTRT jg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 378p1nss3c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Mar 2021 19:46:23 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12GJagm3085287;
        Tue, 16 Mar 2021 19:46:22 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by aserp3030.oracle.com with ESMTP id 3796ytwm5s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Mar 2021 19:46:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lLt4x/PuaL7I/+M0toSFuGtew4/0GFz4MofXc8dhnPGnBy6ypTl4hM/p9K6lR382pZEwPmNR+ETFP1LIrqkockGOlGuSWMPq1ihbdVVrWg2VNaP4aMwH3bzbgbisocjRbs8fmkHcMCOGOfxzyMD7mkDvbiElFggetSQ4cy6ku7e/hKAi5t7byzYDi3L8gU6Xta+oA3/p5EkvTyptfGFpdX0j43n50IWyw3c1zj5ZpeJ0vBueyLpyBZMDNtIUkg0cO/FTJ4Po5G7FJPTCc2EtOX1VOlSiiqaufOAvVYw1YyfIKV5tRa5nvBCJsotQVGjh/YOKh1eY3A8ASMf5wjqn2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=erV69msJ3oojLMafl/GuaBF+ZNSj4aEaRElfRLebJbU=;
 b=PmqDqaK26D2mspvlbKHc7BVg6uz4GnOUSCqfLfVxCN4hTxOpvMwlmEq8GCMsbc9TV8WHjI5CDYLAljkXFHLwQ1vhq8kHmMQqgbbCyjhwVTOVPb55cMXvhPzuTLDAZAjFINLfwyVwKCVt2E9wcwVgPbPVTo8Pb/XL910I8qF2toZd6fmvFV7vrJCYQzBVbpSW2IjdNrioCSwxXN21NSG3RAWWMY0xrdpvSuRR8Re0wphN4LbKDSbU7EiKCnRnFEfJfnOjFpBIgmgHf6fNx50HGH5j25jA48UfScV5RixP74I1GG5DaZBpP7PYVhjfV0FvBGGYI2+4AvBFC7iXy3n27w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=erV69msJ3oojLMafl/GuaBF+ZNSj4aEaRElfRLebJbU=;
 b=OK4DyUr85SL1ogTVwDbDHgRw9VtpP52syjBPNXSy94eUMT872eho62UegMM/eGyY9C4w+qGQ6CwNIHjC5YDI/+9dnDILHf27iGizV0a/VhULFU7vD4dvaQW3DgLwTd26KymIvjpyJyotfp4pynCUAkULDEtWBWhFZr8S1lIwbbU=
Received: from BYAPR10MB2999.namprd10.prod.outlook.com (2603:10b6:a03:85::27)
 by BYAPR10MB3079.namprd10.prod.outlook.com (2603:10b6:a03:89::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Tue, 16 Mar
 2021 19:46:18 +0000
Received: from BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::50f2:e203:1cc5:d4f7]) by BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::50f2:e203:1cc5:d4f7%6]) with mapi id 15.20.3955.018; Tue, 16 Mar 2021
 19:46:18 +0000
Date:   Tue, 16 Mar 2021 15:46:09 -0400
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Tom Saeger <tom.saeger@oracle.com>
Cc:     linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Thomas Tai <thomas.tai@oracle.com>,
        Konrad Rzeszutek Wilk <konrad@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Al Stone <al.stone@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: arm64/acpi : clarify arm64 support of IBFT
Message-ID: <YFELAVASqoAlNguH@Konrads-MacBook-Pro.local>
References: <9efc652df2b8d6b53d9acb170eb7c9ca3938dfef.1615920441.git.tom.saeger@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9efc652df2b8d6b53d9acb170eb7c9ca3938dfef.1615920441.git.tom.saeger@oracle.com>
X-Originating-IP: [138.3.200.29]
X-ClientProxiedBy: CH2PR18CA0053.namprd18.prod.outlook.com
 (2603:10b6:610:55::33) To BYAPR10MB2999.namprd10.prod.outlook.com
 (2603:10b6:a03:85::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Konrads-MacBook-Pro.local (138.3.200.29) by CH2PR18CA0053.namprd18.prod.outlook.com (2603:10b6:610:55::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Tue, 16 Mar 2021 19:46:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af23e4b8-97b1-4d62-f7af-08d8e8b42ac6
X-MS-TrafficTypeDiagnostic: BYAPR10MB3079:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB307908284CC3F9B0856E8A89896B9@BYAPR10MB3079.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bw2RzV5Mb8o/9atOFQj1uk37qA3ybOf36LKu8jX1yDenmIvDI8+5rti0OeR/Yv5+L5/e7s/3qDsrAwEHO1kOeQCk1ZgVMxBtzlBT1mM3qYqmoVfqLchMB8Vy+LxodzKFZ4cZXOC8swQ6Nmhnzq7j2Htka6EViB/7QMrDIr7HiBVjejgxwnOk6glS1AHtUcTCTOohD3Nx7HVmqIN4gnZ9ZULYPWRtEO2GO/u/TIzJaodO5XAYZ+9mMtqk025pVSkGnl5ibkd3qJk+2qsBDHCIqa7cX8pkD0dmr7RHY2Tl+BwUqDwnK5Zmdh83WtZMRt8A0yfhtp8YWmQmfM0J8CPUGl8tVdimZi6dWXMhSU6dbhmOM7QabIbm1KosgRYu95XmFMz/RZBIjQCElVNXWY6qqsDVGT+NvK91JWcN3LVmDGZhMxk/911JZQNIAHwDy86w2LRVCcUr1zuAKh4Fsbsxh+iKmQKaNK4Kut4JdrfhhXBNRrW4UKjednidJbrROJqlaIHtCufAs1tqGVVBJUS3vi+p4jVaJ3LdTFhUBt8PkK1InDt8NTubjiceqXOFYmKWLWw4ZmOH+rN0sbfX8pN/FEUOTvUmyhY5GNzyXxyunwO/CC8QXB/kXSkqbyOVm/ppUx8XdIMjoDde/CIJS7jeLw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2999.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(376002)(136003)(39860400002)(346002)(66946007)(4326008)(186003)(83380400001)(6636002)(6862004)(16526019)(9686003)(66476007)(966005)(2906002)(66556008)(52116002)(55016002)(26005)(86362001)(54906003)(8676002)(8936002)(6666004)(5660300002)(6506007)(478600001)(316002)(7696005)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?BtdnFOQmM4isNxgvPKxD0jaJNxADi8zh8hutwEYOXG2bIBesR8osAsl6Ag0p?=
 =?us-ascii?Q?nolh2IGRFGjYe+qRMwlQCmoInDyC6bTVJOgbsGKSNjuuv3XIMmgYeVWfhYzZ?=
 =?us-ascii?Q?g051NnI+uy5abXmSU5fPEvZapptah/dy36r7o+sYcdzbLa+9ZH3lPbpFHUPE?=
 =?us-ascii?Q?7JLBGCwliiytDV0mnIxIXA6NZT8l5VR0he67l+Y16VnKoGF5yLgJc137+CM5?=
 =?us-ascii?Q?NaQM7dIBvIpIrPlLH6wyCPbt+rRp30sWmfbHLxuPRty+V94a2FD7mm0GCy5D?=
 =?us-ascii?Q?z1InqUcGzo99sHeak5+r/PkA3p3w+by02gCiN3MMGlI//wZ/eIrQYl0WooGi?=
 =?us-ascii?Q?pU/BB18XzsUrdiEhGJKLh/BsZW61l5Omu86cJNW5d4U6GQ0ifAkr3o8lkXLz?=
 =?us-ascii?Q?mzf1BYLkEzQwRyqEl/rC1qgnDy3t6ddPh4JYqTefSJOLMsDGMqmBc885PMuN?=
 =?us-ascii?Q?/5u9I482tivX/j2VKIce0VvldTpFnZBz5Cex4r29I819hmesDTjs5tK4PdEu?=
 =?us-ascii?Q?x7ygf5Bm6pvxNgjlvqy/BVufQb7jaSrRAv/b9JSF3KJqf0kilhYuv9VXGzij?=
 =?us-ascii?Q?pMErvDGK75iOFTQrkjUUG/IzT6ijQTa79EENjs4ok4SZAo9eaceNiA5x2yD2?=
 =?us-ascii?Q?Echj7Q8zA/kLoprDi6wtyoemqbQL+dFPABDZ4BWGKc+7lrC27f1kARORWYRq?=
 =?us-ascii?Q?Hf3cfInwC0kRc1Hmlxyq4vbJ5ieE/zcjcQB2Y7Q28U1E4E/VzvzpmW/oXFBU?=
 =?us-ascii?Q?I6wRNRYUYLCzPt32EUtIZMecefurNwlksM1FRRVTHGz6R3AagjMxiaybEASi?=
 =?us-ascii?Q?79VzlIruKOpMBEizYSMRrlVEKiWyNkJkC2URm+/sJUOXQgcu4kBm7/IIy3f1?=
 =?us-ascii?Q?WKU4ASmFM+0Mjp7DobmK9TXIRPWYEsCOpNCefD+eCEW8IyFtv7ifx/RCEOXg?=
 =?us-ascii?Q?LrG2B/g21hXBK4bAGvlo3tPGlYehe7cMiCfjb0teb402iWaI7wCgSakdE146?=
 =?us-ascii?Q?AkfVdwoWVp4t8gpUcmb/DOkBOn97oYkEadThK9RRe9ZqZ6BWCZWLCz5A3Bg/?=
 =?us-ascii?Q?Ayebq+z8xiLtLn8pvglKK2JobALVgivhpY8YriTFRhI/BudII+lr+x/T+0xW?=
 =?us-ascii?Q?LrVFGwt/huSYZkSqO6jMDX4XNWga8IsGSxP2ujrgQmJ4Q2gfK7kFK+L4f42E?=
 =?us-ascii?Q?sO0x2SY6n7I80ehidZNKW6qtoFtFFo/y+yUvN4h/LkDiMdGfHdX/htJV5jMm?=
 =?us-ascii?Q?hbnPiqa21wZVjb5WerOrFpG8tiMAtkUgDfySmtVvvP4MvwCI65QjFL2Qvtp8?=
 =?us-ascii?Q?yX6IDRvQIN1DIhx0+oD0bhx8?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af23e4b8-97b1-4d62-f7af-08d8e8b42ac6
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2999.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2021 19:46:18.4393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7NcRhFSbLAgokFd6YGq51kkBSm7ELFAN3TCwxxq62PoerEwzeQRd0R7HbT22FpqNNwI6gUoktwUaYOaqvULOUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3079
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9925 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103160122
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9925 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 adultscore=0
 spamscore=0 clxscore=1011 phishscore=0 malwarescore=0 priorityscore=1501
 bulkscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103160123
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021 at 12:50:41PM -0600, Tom Saeger wrote:
> In commit 94bccc340710 ("iscsi_ibft: make ISCSI_IBFT dependson ACPI instead
> of ISCSI_IBFT_FIND") Kconfig was disentangled to make ISCSI_IBFT selection
> not depend on x86.
> 
> Update arm64 acpi documentation, changing IBFT support status from
> "Not Supported" to "Optional".
> Opportunistically re-flow paragraph for changed lines.
> 
> Link: https://lore.kernel.org/lkml/1563475054-10680-1-git-send-email-thomas.tai@oracle.com/
> 
> Signed-off-by: Tom Saeger <tom.saeger@oracle.com>

Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

Thank you!
> ---
>  Documentation/arm64/acpi_object_usage.rst | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/arm64/acpi_object_usage.rst b/Documentation/arm64/acpi_object_usage.rst
> index 377e9d224db0..0609da73970b 100644
> --- a/Documentation/arm64/acpi_object_usage.rst
> +++ b/Documentation/arm64/acpi_object_usage.rst
> @@ -17,12 +17,12 @@ For ACPI on arm64, tables also fall into the following categories:
>  
>         -  Recommended: BERT, EINJ, ERST, HEST, PCCT, SSDT
>  
> -       -  Optional: BGRT, CPEP, CSRT, DBG2, DRTM, ECDT, FACS, FPDT, IORT,
> -          MCHI, MPST, MSCT, NFIT, PMTT, RASF, SBST, SLIT, SPMI, SRAT, STAO,
> -	  TCPA, TPM2, UEFI, XENV
> +       -  Optional: BGRT, CPEP, CSRT, DBG2, DRTM, ECDT, FACS, FPDT, IBFT,
> +          IORT, MCHI, MPST, MSCT, NFIT, PMTT, RASF, SBST, SLIT, SPMI, SRAT,
> +          STAO, TCPA, TPM2, UEFI, XENV
>  
> -       -  Not supported: BOOT, DBGP, DMAR, ETDT, HPET, IBFT, IVRS, LPIT,
> -          MSDM, OEMx, PSDT, RSDT, SLIC, WAET, WDAT, WDRT, WPBT
> +       -  Not supported: BOOT, DBGP, DMAR, ETDT, HPET, IVRS, LPIT, MSDM, OEMx,
> +          PSDT, RSDT, SLIC, WAET, WDAT, WDRT, WPBT
>  
>  ====== ========================================================================
>  Table  Usage for ARMv8 Linux
> -- 
> 2.31.0
> 
