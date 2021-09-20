Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A73AC411107
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 10:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235876AbhITIfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 04:35:41 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:48248 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229905AbhITIfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 04:35:38 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18K7v3x6028074;
        Mon, 20 Sep 2021 08:33:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=HBc9loZfPaETps/YZopTnNgHMWtpwCTq5jK2l4Ts8MI=;
 b=VmxUbnrdjUk+J0rQmmBiOmq+kftJ7uVIVwrWENAeW/gxG4lzxdFu7120uwaelfPcmuuv
 4NfT7vhGEfn6cBD6fw4UqYLWckmhnTsUAmL8wjd4J7H8W+8mnMo5RavccQZCJHxnF21/
 LsokBlJOc8BUEFXawmTTobAm2vjzibYzw3UTxUOoGTNffSnM6BqlrTp7grkYcdVCcbt3
 qaMCq9qLoqy1vgy5IR2ALOb+vOXPV1Zd6O8GkUF3FZpgIF2VPE3ROx/euDb696PmY+hB
 eJ4KpPJcXjlVhEtDL2eD8LLKQtEGz7O28hR82/x8PQ+wsajOQ+zH0xKU5nHgsAQ9WGiN kA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=HBc9loZfPaETps/YZopTnNgHMWtpwCTq5jK2l4Ts8MI=;
 b=cLPAwX7eDbPT9kOle1kPOlsZM3Z3Ac0xtEyF22tvRItTDtMQREGU0yZKQwhSRPC9HWhT
 W1DTtzaaflDfNYvHH7VbPoXfBZzyLBCQ1lURaE1pJiLjyBw46/GPxfPKu4uGEc2s9XqE
 fay469bROyatAPbJapZN6b3S83eSZocb5ALYrO4l1el36AaUqJI38w1Cq80d/mqF4CV4
 WjGXufdL0yLMcT8vVWCWB/ZxdUcGgnZoKYc6i0dQlsXWbHpxs1TBc82a/81PS01yoDXe
 PKgLXJcIiDuV4pFLEsOShX5HgiXcxoiURnyPsIh35m161Z6ZQH5EIMw82JU1lyS0WFXZ vg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b65mr9gpq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Sep 2021 08:33:58 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18K8FtLe128978;
        Mon, 20 Sep 2021 08:33:57 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by userp3020.oracle.com with ESMTP id 3b5svqcrfh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Sep 2021 08:33:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XAMj5pSVobBA+F+TlG9YOMrBhRCcaRk+5RxJDSbIocDO6GEc6/51+BVScoRBCXrFgEisT12kL+DQGxfwCPC4PXn3+cGGVyIn+R1Bk1nupejjQkC4ap95FOaRa4kSKpxVZi2h+3NBPgYB06mFBRC3cXNOrcK1bzVx6KbOeRoZWIwIfhMBS+te4VyPLlS4VUiThI8bPTOIYP584vA2fWBxmlQ5QNoete2e3Wd+W4VTZIgFkVnFPgrghMo6DuxOcYMsTp/uCOModtlpMFKkpB5DHyaFIIh5bY8jXO3D5UEkrJcObHQCca/teL69C4Is/SaClzhfio6fLU/Beq77mXz9Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=HBc9loZfPaETps/YZopTnNgHMWtpwCTq5jK2l4Ts8MI=;
 b=mSIGUItLnN6gCdp02uJa/MFhNINqkhg6TQ8Qe4y7WDddg8IkErpRstnWGoH0LMskcg5q0nor20Z0vdGuEeCd1MEqBW/dNaA7UdQd8QMLxPUzpQzR2yOoKvO9zRdcl7cdE8DybaCyiODO7eovenKF7JE6CvXrqH1kP2Lgwfnb/4tThXmSE0XRymqMsCGH8BgPlD/phsaeQTjWxObQkLruLoUzLcihmQyU4azamkQfdx/geBMb/NEUX2aO+Pj7tPvGDgflbCc3NWBMMioqPXyN1U7JK30orQ8go8hBEtpYYPyiC/0jmNcBf8rNqGH0M3KG/rLBlgv6EgahXCdJe5xCbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HBc9loZfPaETps/YZopTnNgHMWtpwCTq5jK2l4Ts8MI=;
 b=WZtNS00JQVvrS/bP4zpINW+wBc8xr/gr14DtEeRwhZT1uZlNgVKwMdGAsNLh17z4aqUEZCGT1pA4KRy0lykcqF7TJvZ+xuA2/ahQwunR9b0jv9R7tU/NpyDFm4pA66/DcSCmnJ/75laO4wXp+C6l5ePA/IkN5Jm/Qsoc8Td+JTM=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1888.namprd10.prod.outlook.com
 (2603:10b6:300:113::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Mon, 20 Sep
 2021 08:33:55 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4523.018; Mon, 20 Sep 2021
 08:33:54 +0000
Date:   Mon, 20 Sep 2021 11:33:30 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Michael Straube <straube.linux@gmail.com>
Cc:     Larry.Finger@lwfinger.net, Phillip Potter <phil@philpotter.co.uk>,
        Greg KH <gregkh@linuxfoundation.org>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: staging: r8188eu: Can odm_DynamicTxPowerNIC() be removed?
Message-ID: <20210920083330.GO2088@kadam>
References: <7f1c135a-d85d-d271-f315-d665a5fe1472@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f1c135a-d85d-d271-f315-d665a5fe1472@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0003.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::15)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (62.8.83.99) by JN2P275CA0003.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.17 via Frontend Transport; Mon, 20 Sep 2021 08:33:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ec7a70a-e45f-4818-a8c7-08d97c1161b6
X-MS-TrafficTypeDiagnostic: MWHPR10MB1888:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB1888C1B1ECF71358DC2CA46C8EA09@MWHPR10MB1888.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gqCEv6fohfG1Sw26G4Dg78TrwBRS1QBMwVr0zhSicXIW5MH9UO471nltxYzhXDRCciF6g/q2uVy+JVFij9RATwIGK93Rem2cCJCA02OA3xTBR2C4X+rLLYH+xInCzT5gzSjXxIzl78yV3zpjnMDC1oUoIIqDVLnflT35qlulkWHSqGaHQFUAh5QhjbkEelV032F+sGJTIHEH7qSshKUcO33DrZ111t7vLpMw1ACGtAUp3hOV4ZxMwIKbuaCgOH5wY7ZYpWNamzCKuVMOd0yaxf4pU5i4eqn/DwvHN5xsMjdwcJif5biRaLdCQ21XUrXc8NVw9AxgH1Bj6Ms9tcW/+avqZTgnuTPjYoYuLU362cMB4ILOCqax9Mi6Zw7U+KMqJeMhbwk/2S6P9SfO6tmI3tgu29ZXIItIFaYSS8s8rTuWv3Pm6cMbu+PhC6CsLCFgvrngzx0Dbh3bJZNAxhsSt0EVg10GgfT3qR778gGZ+/3VrnhClH7L9ixnikScVv+SFew7rZ5vNLcZYISZKM7EkH06Y63P9pL7SaUEjmKIQkj6vJTFMJZIK7ecCmjPMfC59HuLzV8rSdg/16BS4iLHA8SCBh/KzFyJM/kad5IMRuwx1JrCkyXFDxKnhCdI+6c0kRJFBbsYonkmZ1UElncRMFoBRkT2iw5noO7FZnkhbaP1e59N+gCveSvOaiUTv8rDlhzFJ1mxFPyH3mrTBKYF/A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(6029001)(366004)(4326008)(8936002)(1076003)(9576002)(66556008)(6666004)(6496006)(44832011)(55016002)(9686003)(8676002)(83380400001)(316002)(26005)(38350700002)(66476007)(33656002)(52116002)(54906003)(956004)(86362001)(5660300002)(508600001)(38100700002)(33716001)(186003)(6916009)(2906002)(66946007)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eRCN+mVXxIMLgWSS04DJDsAozNyDRMLphKKwhGQehhqfi2v8amvTHC0n4zYM?=
 =?us-ascii?Q?V7iXsev6f7MCKizgTcTmwS0gMvQhkiDhP9gbwdQMLmAuFiTqLl8d79m1udDI?=
 =?us-ascii?Q?lord6CxOz+wjG3xGdRMkqWTcT2hSLFStejvW/zH2TYj7P26oz/JaOl22lp2W?=
 =?us-ascii?Q?M/PhB6j6kX2CdVsZ83KWGEtOdZl13N19kNY8UbYy6RfSB7M5d+K2mxTEadGl?=
 =?us-ascii?Q?67OzkpAF0z92PP4m71kAXhocvLMIPy9ju9l23BhK+lX/StpHpmBhVn01N5xR?=
 =?us-ascii?Q?S7S9ySXsxz/w7xfVZc8Cu4JP7j9G1X+E7dEERroIG7ED0kHAuyFSjJ7pN5Y1?=
 =?us-ascii?Q?aU+X81zDu/zxiFTIQkvK+D14jUVB5x4eG/KOCQ9oozMFZt73Vkx4P07JRStb?=
 =?us-ascii?Q?PGdQl1XW9RO/YR2tu1tAcM7Y/AEVy28P8NOdb3njp3IwMVlQm+xHccTt5jYj?=
 =?us-ascii?Q?/K1eUsSCQML8oDscisoi3BrCCWYW68z48N/YkOExH3ayGGudO2tOpZXr52wg?=
 =?us-ascii?Q?drVzrXXDCah3S2oBWqsjQb+tOkDdy1Mpa189deAoI06S4rrX5sDLjz9eMq+o?=
 =?us-ascii?Q?j4aq6n09c4sTj4+9VmxkohlM+nPzecms9Ut7h/Mm+d9k6gpWzVoWtLZXtYBd?=
 =?us-ascii?Q?72oCJncda2KqMZf+wZi4JUZOITuta8s/jqBN1GwLM8ol2NzJ7NKMSTehjWnq?=
 =?us-ascii?Q?PgCBzCKGbgXUObJiGMCSjwYyGZ2QMQjO7O3Gy/UAOVBKnPWJ5iknlv+ZOjVd?=
 =?us-ascii?Q?VwbU3HgE9pGU+hSbRg6x+p1azgslV2pdV+UsQDuEhBE4zvy9zPC74QjO6Q5y?=
 =?us-ascii?Q?RgfIcy4tE6Nb1L8xb2lKLRn3uQwiRefKr86xP6EMS3ahvsLmdCV8sGRH9YZ+?=
 =?us-ascii?Q?KhdiR8WTjvAEoC2S/Rh7sZPU1MRJXiKNsE0NuOfYigmoMr7t2iRUEUbns/Z7?=
 =?us-ascii?Q?5xg3XZDtLVERMnWWWI7EYs93eW8W8VeZKR56aTPowxqtGteIR55QjQHfa3bL?=
 =?us-ascii?Q?ftiRSZfuKPawF4CaN5C3NTPnyvSOexmTtMcQmSjeKxwnR5x6/d1R0O0KEbY2?=
 =?us-ascii?Q?A4i70N4mVxDyoX+JTJnYzJ9Hq2Fbh11caAyXdVLMPwTqjmlu+EokX4iHwro0?=
 =?us-ascii?Q?iLpRzzskHRQmVdKhrI7z8fExqbLTQUfcV5NmVcK6uvprT2q2G+huggDGgVMB?=
 =?us-ascii?Q?yEY6RgHPv7daLvl+UImYfC9hsrkR55WezJsajFDYnhKMrrVjdfvNAnwTg53A?=
 =?us-ascii?Q?B/KIeAgDj15ljLYAPRkJQ1P4QkcqM4lWWe0xPVo7Kixb3MBICNclRM6+Y9Sv?=
 =?us-ascii?Q?Nu9UiRzv2ChA+iwGLJ2v7ypr?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ec7a70a-e45f-4818-a8c7-08d97c1161b6
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2021 08:33:54.8293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TnakqnFiHBswB6JJGkeA56qKw+U51iiH4YAxeN3z1Hpc7XcKkieTG0juTHNeT6WHrdrF1a2REQ5yGkF/jSQHY5n0AYm7TrXatMIIFqcGhKI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1888
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10112 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=747 adultscore=0
 bulkscore=0 mlxscore=0 suspectscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109200050
X-Proofpoint-GUID: YRoQwv5L423NXFBZWIo_tabWwPWfBWJ6
X-Proofpoint-ORIG-GUID: YRoQwv5L423NXFBZWIo_tabWwPWfBWJ6
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 18, 2021 at 03:31:48PM +0200, Michael Straube wrote:
> Hi Larry, Phillip and all.
> 
> While removing code that checks for the chip type I stumbled upon this:
> 
> 
> void odm_DynamicTxPowerNIC(struct odm_dm_struct *pDM_Odm)
> {
> 	if (!(pDM_Odm->SupportAbility & ODM_BB_DYNAMIC_TXPWR))
> 		return;
> 
> 	if (pDM_Odm->SupportICType == ODM_RTL8188E) {
> 		/*  ??? */
> 		/*  This part need to be redefined. */
> 	}
> }

Always just delete dead code.  The future is very hard to predict so
don't leave things lying around because of possible futures.  Don't be
a hoarder.

regards,
dan carpenter

