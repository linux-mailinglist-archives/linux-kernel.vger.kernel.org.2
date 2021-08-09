Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B21DE3E482D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 16:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234365AbhHIO4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 10:56:46 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:22490 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233773AbhHIO4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 10:56:44 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 179EkYhF032120;
        Mon, 9 Aug 2021 14:56:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=ZZLIAi4P3Lpksz5fNbLwF+2Ct6r3dlRz+Y2zeOGwA9k=;
 b=UKLraI5OVwzhNMzaMZ59KpJX5AJ5CQBKmLJZNmI4vLP2r03whDCA2XLg4uuM2AiqZY9/
 rfPJxQk88+uaL7R99UkDMCvNWMjQzP/QBTLsGrFSbS8Q7PwRh6JID8/uGGhEwps/ybs9
 VcJOZyMkl31nWrr0L4S9OcBgHa10Dt0NEZ8n1gV45HyHjmBpDSGqHDKrp242XAsLNCDk
 z1w12pKWFGXRUAUs5lODnOTifkCb8s0Ypq7McPPtCBtG5mrQdLsTv+Fm834WDca5eVlR
 1FBm7ln2P5Z1/QOxneA+gdh5AImWVkcD5wY2Jiovv/n3BHEz7y4RkxEPcr7L8cn0kkMN 0Q== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=ZZLIAi4P3Lpksz5fNbLwF+2Ct6r3dlRz+Y2zeOGwA9k=;
 b=cuqt7d3l6G7JLSLnNSv7mvlgDtL3fIi5CnaLj+U7GwdBLUapQb1mSQ/BhqkNEG1SEvW/
 Oi16H7xbWSbUC+BtkIuwDmYWCh53g4JMmZIWHIW3RWWECXBQOUO8HS/Cgle2E5JTqCnN
 TaxEB0QldG+hSYUd3QOLcyo8MVlXf81uXwxwi6n9bDb25wI5Gk22jTOXaYCRl0QGxiVl
 2BptJIk+X2gM7aficJA4TgfAvVLp3mjNv6G4nJWNJjEof+PlZot28Q9ojZtV+HEVvCVg
 Aa8SpP9FopPDdGMjJ+SaX7qWezvrQZH8kAVRXykEkP2uJ0pIazVm1e4iC7dZ6jglHa2H Vw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ab01r8ytd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Aug 2021 14:56:10 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 179Eu473174892;
        Mon, 9 Aug 2021 14:56:07 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
        by userp3030.oracle.com with ESMTP id 3a9f9v5xgn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Aug 2021 14:56:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bk6MT8yU7b1J6rQyqVkD0janUIDW/9hD5usI+3eEX/z5fy7iBLawqGnspE6j9RBhVd8mqc4OW2witc1gQINwvNTWI8Hs6RJ4mwQbmJzMNLZG8vYOZVU22l7aZ6UvKVsn6qu3V8kEFKAa23nwO52T1iAXCPCJzNPD8hgtwEkfJV6CUfZ9Mxc4Uk/VClDKcZUeEOrVLbk54CTGghoHSRAzbObCE+Dw0R9LFvi4goTlQXhWuXX50YeuFRBHvBlVNOXNRddIxZQ0cSWa+L7CTbdOG/feRyoJUyxj+T8jK/9d7CSyTBRn87jDGOp69ypvCEohN90vpQ8SBkAIjgMvSt2oDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZZLIAi4P3Lpksz5fNbLwF+2Ct6r3dlRz+Y2zeOGwA9k=;
 b=VCSSyHhVVYtygRBxgdTBpSe6o2tjdB0Drx7UjyDuEWuZBtuS42T1FLUsuWh7NH66c9Sqtw2GyQuv+BSsK3evJL3Y8QsqpA1g2IAIotDD6u/r+24XBmnkEl0+glV3K6AtjRz7KxFtSMZz55Rd9Q3hiET073RPKkpWQNDvaiiwRkLh2lDqzq5T5c0eTb6rhvASBWikChc2lpUxCZJ87xBaDlRK36pPUfC6aY40Sr6x+McoDtnzGJ3zS2F+ehjYhiY/mdk5/KsMqY1xF+QgB5g0CNLB9CnYLcDGLLU98/vQ+EVup9Ebjotg1rLMAnBp5+T+drkv7+jFMAq8CNA7y13I0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZZLIAi4P3Lpksz5fNbLwF+2Ct6r3dlRz+Y2zeOGwA9k=;
 b=WiCWRCgShpp1J2tAwHBZQp5Uo5W0HCt3OCutDrUYk9GZfSo68e30ixll/8MYNQd+2oxVzT3IlfFL9O0VOV7wWDfTKpli+f/R79EWeopY+M1bFA75lYn+2j1xSGngyCxyEt1cyMyJ9NBv5I/5hQvaUtRt4x+x3dnPTt8XbmTj1T4=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1485.namprd10.prod.outlook.com
 (2603:10b6:300:25::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17; Mon, 9 Aug
 2021 14:56:01 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4394.023; Mon, 9 Aug 2021
 14:56:01 +0000
Date:   Mon, 9 Aug 2021 17:55:43 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Michael Straube <straube.linux@gmail.com>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/17] staging: r8188eu: remove unnecessary parentheses
 in core/rtw_mlme_ext.c
Message-ID: <20210809145543.GR1931@kadam>
References: <20210807101119.16085-1-straube.linux@gmail.com>
 <20210807101119.16085-4-straube.linux@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210807101119.16085-4-straube.linux@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0009.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::21)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (102.222.70.252) by JN2P275CA0009.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Mon, 9 Aug 2021 14:55:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ce565bf-748e-4094-7065-08d95b45cd54
X-MS-TrafficTypeDiagnostic: MWHPR10MB1485:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB1485141ECAD32065F9D334668EF69@MWHPR10MB1485.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KwEy57X77dikzcN35MMk+Rnuv5BIqn36jFS0ZVp1Xl6zSQnwLxJQC9a6n10ucyN9tYPYN1i9BZ0H5EsQ/744l8M+fWDrIqMRTyGDyx2CUHIQRJN6a0k2nt7eNyI49oC2c9QPqFnmln0uMbJPm/ZgpCDgbFz2GhUOD/oGtUXlG0wHN1+v9+jBHpdgWc4+1ZGYun5DjZnpQS947eJpAKERaYPSNL/9AYKAxYwoWxwkbMlWxgia7F+p3yw8goM5QtYijvnKPORSnWRc4Mzu4sUVNn/g+x9Mk9HtdNgupP0O+b3gHQhiFB18oAj/FYQPj1qor3OGEbYBLLBGj3QnhIFcr8ZhY/mpWpwrezOJfKmpqhlPrvRsi/hsTC+BOdxg75O2hlux9zFNtJ7A+EQAW/efWsUOhMJGrGH778IG+pq3563oJKK3osS0Ei3CXX9oVoLv3DyOJjkS7CY1E9eZxcrFXkL5I/1QONLpNX2nmAek2OexRVl+w9SOlkRF/5GT3z3Rsr6iTodv3rFi587cGEN1+h1TWcr+nGt5RTY68mF1gSO//9fpDBlybS3VqnP8xfNYsD7MkcsLGZwanmCxKKvklYpdz0Rw28Ny/DouKe/0lOLgO6kHppDktqJXYZ7wBBVQAh9aCu1lQHfw8Jkso4wVT8VBjiA6+U+Fc0zdO7TpoYeXHrLvZxQKjj2038UAbmS3t8kEqLn+QwY7fscM7dufAw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(346002)(396003)(39860400002)(136003)(66556008)(66476007)(2906002)(8936002)(55016002)(6666004)(66946007)(316002)(6916009)(44832011)(9686003)(52116002)(86362001)(8676002)(6496006)(9576002)(26005)(186003)(478600001)(4326008)(956004)(38100700002)(1076003)(38350700002)(83380400001)(33716001)(33656002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GOUv9Lz/gPnMqK7MxMyQTkMK7XJc9S7TTbwQmOSrW2C7rbNzqzOfXI7TLoDd?=
 =?us-ascii?Q?g1qUJhHHWO+tbDU/j44m/fZ+f44AS5FgF8mnZ1uHCHXrUwZtrfZ3VNJD5fdb?=
 =?us-ascii?Q?cWuOS8DGtR7dQtXAchMKkPAMtky2pxpQxAz5tjek8j2mIolJH2FCp80QiaEk?=
 =?us-ascii?Q?WSWOTPr5hIqi7d/VghvD1ykpOk+sjLSnHNWRKbmhyzS01UIfZdq+6ocBrWh0?=
 =?us-ascii?Q?5fuHVFkkBN8MTKuWuZUQlskIoSKejg0WIiD9/Wvr7lff9zK5bM4euJzCjM+N?=
 =?us-ascii?Q?hlgPgX8r/iR/joH9HsCOBWtiJYh/QkTuRkN0SgxbJPselZNBwIFGNVPtjUAE?=
 =?us-ascii?Q?SH4X5tFG3HC7Hf4ITszwFatcvOhRtwl+hAyhWz59mGQARrXHydtGmb7EQAZG?=
 =?us-ascii?Q?4d1eC2eZb8b6u8NAIEzoGznIi1GnS6dQAl6+tahpnFRCxYqFAokXjNLygWB6?=
 =?us-ascii?Q?lszHw/p7yBgHi3NMEENrrKOEjuJ1gOdLL1ql6ePQj9784YNG2nRVxDt+AykV?=
 =?us-ascii?Q?+pn3mCVkU6mZ1IPMv0MDC8T22R1gil0FJAjJLtTdTktI8EGRoYaEO/ptqwgI?=
 =?us-ascii?Q?zTnq0uVb2cjRaUVAx2iUAHOyFHvM6q3Zhqz5eNdtkma+a25kRwzRMvKLUcjJ?=
 =?us-ascii?Q?tDqEvKpbZSkr934B39DzTPEgRAL6mz+Y+0GhAmiqTgyXkAZ5GXMHwPfFTUIQ?=
 =?us-ascii?Q?a8WEhVRxwLxvxJEqJ0Ge+8zN0jGC4XeY/yQWs6OpbmUAAqYwwUg3a0EYYtbj?=
 =?us-ascii?Q?QHn/UrcMc0ax2JoJn/yiT5mMufdcAvg9SRf7fYRlUrA6PxyNeJMx6xKd/WbP?=
 =?us-ascii?Q?1EqP8OsA4jqgo80TYUmUiV2/1Z5eMuVSt2vIY98iNQFnZmwTMCOnU4KKm/v+?=
 =?us-ascii?Q?qT702LthFu4OtitZMAyKm9AJH8bnnXIo6V/WNGlv6SxmoudSx/FI2ZuJEPJJ?=
 =?us-ascii?Q?XGP8Ab7JTsxXUxhySLBMN+ASDGhh22exGFvkfRJT9A/FOX7DSDqekHS/spDx?=
 =?us-ascii?Q?vU2IAoLjbx/v5Uu/qqkGN0Z/P3vstCetSDVTU+1M6VtWjh5YAjYNel1r/Hpq?=
 =?us-ascii?Q?miI2hLx2Rz+9RUN1qKaN3Nt+aZQNif6Ia4bgrpmJixh6rsgwQAYWDFbZtvyS?=
 =?us-ascii?Q?Kpcq7duCu/4k1XUJwe3dku3uEoR2QWLRW0Z4d+EErUecLM5xVntws826ek0i?=
 =?us-ascii?Q?ehZmlnj58RRXnB1iF6OoxHNMY4MzHAE0uken689zVxbA+ADL+R6z4abdqF1V?=
 =?us-ascii?Q?CVGETZN6PaN8NZdZa3URAZb9GAmdxP6C6pNmsb/wBeP2hAZ49ONBBHS4ORHO?=
 =?us-ascii?Q?yBzDFQ2rz3nUG9pCI4IufNwC?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ce565bf-748e-4094-7065-08d95b45cd54
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2021 14:56:01.1896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NH318X7mOWvYGlNtTQTGF6kAIVkxfdNjGC6LPSbmcvm6DVcWkiLLFHQ29LGxAu5qLNNhr7WFTV4IVxAgPzh0UqHDVhx5uYBjU2yzAyd+1nA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1485
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10071 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108090110
X-Proofpoint-ORIG-GUID: p_tw4v7j4feuUUVdekquADsT8VmBt6OC
X-Proofpoint-GUID: p_tw4v7j4feuUUVdekquADsT8VmBt6OC
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 07, 2021 at 12:11:05PM +0200, Michael Straube wrote:
> @@ -1855,12 +1855,12 @@ void issue_p2p_GO_request(struct adapter *padapter, u8 *raddr)
>  	pframe += sizeof(struct rtw_ieee80211_hdr_3addr);
>  	pattrib->pktlen = sizeof(struct rtw_ieee80211_hdr_3addr);
>  
> -	pframe = rtw_set_fixed_ie(pframe, 1, &(category), &(pattrib->pktlen));
> -	pframe = rtw_set_fixed_ie(pframe, 1, &(action), &(pattrib->pktlen));
> -	pframe = rtw_set_fixed_ie(pframe, 4, (unsigned char *)&(p2poui), &(pattrib->pktlen));
> -	pframe = rtw_set_fixed_ie(pframe, 1, &(oui_subtype), &(pattrib->pktlen));
> +	pframe = rtw_set_fixed_ie(pframe, 1, &(category), &pattrib->pktlen);
                                             ^^^^^^^^^^^
These should be removed as well.

> +	pframe = rtw_set_fixed_ie(pframe, 1, &(action), &pattrib->pktlen);
                                             ^^^^^^^^
> +	pframe = rtw_set_fixed_ie(pframe, 4, (unsigned char *)&(p2poui), &pattrib->pktlen);
> +	pframe = rtw_set_fixed_ie(pframe, 1, &(oui_subtype), &pattrib->pktlen);
                                             ^^^^^^^^^^^^^^

All the third parameters of rtw_set_fixed_ie() in this patch really.

>  	pwdinfo->negotiation_dialog_token = 1;	/*	Initialize the dialog value */
> -	pframe = rtw_set_fixed_ie(pframe, 1, &pwdinfo->negotiation_dialog_token, &(pattrib->pktlen));
> +	pframe = rtw_set_fixed_ie(pframe, 1, &pwdinfo->negotiation_dialog_token, &pattrib->pktlen);
>  
>  	/*	WPS Section */
>  	wpsielen = 0;

regards,
dan carpenter

