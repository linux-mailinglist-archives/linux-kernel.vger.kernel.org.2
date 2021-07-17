Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8FB03CC208
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 10:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232361AbhGQIce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jul 2021 04:32:34 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:10148 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231862AbhGQIcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jul 2021 04:32:33 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16H8JxcC014263;
        Sat, 17 Jul 2021 08:29:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=WIljOFtjQJe1qFgsp/FtQaYeiwUs0DzHdyWEI/typ4M=;
 b=JvzP3nJrcDITVY/Ird/tXdsrw1YxnOW+VXrJLh+pia/YwW46otrJZDpYRk9lOLg0Kpa8
 QNciZWrA4UXXwLXCjOJkQqTPtBMDKJtaR0qpoiyna5t9lrutFykcw2VUqKexdTukFVsU
 ZJUS0XAKPEVENeKXiwYLqYIHoCIuRjJ4BEtF7nvM0VyR92hHb0wbolTqfonYOOp187dF
 SdY26LYFdMEP8vwZBnuir8tfAvC7Jdo8tgg08vxVmX3ZuAZ+IWFXxnA3zwwStZqEGQ4y
 UyVm1wE6Bhnrwb7DFI+rSPQdEPIEtuefl28Gi4PPzz5vDHFzRM2qL93G6yyIRXIaikce sg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=WIljOFtjQJe1qFgsp/FtQaYeiwUs0DzHdyWEI/typ4M=;
 b=d7o440P/7/Pf54Oed7TcHuas+EchGOodFo7Zw1YRrXun3iv0e3/wyCeHpYBRq3Lhu2I4
 FKneQsHyyQtO3qT21zaIO74aNoep514sSDccSEuzyOI6MNQHEsiGbgIrq2nmxhJUXRxs
 pwm1M/yhNa5YLOJqI16rZ6Yee7ovGAxxuigMXpfab/b2QBYrr8jJvPxqPsK/vJEyKcsW
 JiazBam/15W9YqpuCBLvWORUwgN83wY27JAHuOmLliIN6RG+puemJyTNeuVOAwzKM4bD
 QnacZSOz7fJwmoKrhICAfYE+P3E3jWModh4xbFPwr7lEwiM62vuabK3PHLpx/64BK9HE pA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 39unmbg9ks-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 17 Jul 2021 08:29:25 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16H8Fvm7069006;
        Sat, 17 Jul 2021 08:29:24 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by userp3020.oracle.com with ESMTP id 39uphj5vj7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 17 Jul 2021 08:29:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C1qUAQE7RXnXnMbD1/jSaNlYhJdJkh13PZG0kdNmNDug/9q+zuYp2/bquizzmB2X7vhy+F9pydgsTmmdje6sWySB4RI4e6k3E0ZqIZoPFqZnEYwTaZN1ABuc80w0vaAeO2GHWUfPwCNG5qJ2N22ytCbVReQRhwtFzi4L7LCil+qcKYVW8IveEfRKL1rJGqOcfynpnV6pQj4DRvQMLmCTh2Vjb/00N62EobBgi+DNk+6YQseaxBniLc34ZqGNq66kUqaDxbu7MGop9QuLypv60u9ScbuN5VOYy+x8YLZnu9CzRLxFmJqOMvjBA0i9cUxjWlHwIijgDkn/jR6q29sJwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WIljOFtjQJe1qFgsp/FtQaYeiwUs0DzHdyWEI/typ4M=;
 b=mFEDUAxn/dwsTzlLF/nsKL9oQVCj06xis2azSiNPC0o0aR38f8dbdbr5ZLT3ZXgsEZ+gSfu1AxnMDVR+zV6jIA1HCaDbJCYxd0gIh+2F9kridcDYKk8wkD76tL/VT21lvsXj0AKh174hN1py48J82t1hq6r+ZwtZP8LFwE7m06eSgCra3qeGQ6oWx4Lmod2r5pAIaOarIFi2RepwdtQqKin7upKnNZJo2bjXJJeAoqiv0ScevuUzkkk5u/C/pO4Tcb6JsnKOwIeQib0A7WIc4fGh6qlZC2BKMi6sFEpECTlU8Eugff3YJHASo7cxRsbi2VzEU3zeEZHwwtJCXWpUug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WIljOFtjQJe1qFgsp/FtQaYeiwUs0DzHdyWEI/typ4M=;
 b=GtknD+rIY4/3tddMeVGUCxrvuifXF7b/jcNu0lvaur/Eh+juUjdNiLygtgx2LptcGSN3fAuKR3nJsBdsF0cfE2Y0wwvHyEwTMa8N93X5lwzX1frSVBTYtc8r+fdTYHIz6PXiEKRfFkpNlLObzPYMAu/iqNKdzgZW2wZlg+s2hgU=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com (10.174.166.156) by
 MWHPR10MB1885.namprd10.prod.outlook.com (10.175.51.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.23; Sat, 17 Jul 2021 08:29:22 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4331.029; Sat, 17 Jul 2021
 08:29:22 +0000
Date:   Sat, 17 Jul 2021 11:29:01 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Fabio Aiuto <fabioaiuto83@gmail.com>
Cc:     gregkh@linuxfoundation.org, hdegoede@redhat.com,
        Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] staging: rtl8723bs: fix camel case issue
Message-ID: <20210717082901.GM1931@kadam>
References: <cover.1626275102.git.fabioaiuto83@gmail.com>
 <a708b2b9902bedf5bd0466b05516a4c5b4f43723.1626275102.git.fabioaiuto83@gmail.com>
 <20210714152605.GK1931@kadam>
 <20210714190456.GA1402@agape.jhs>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210714190456.GA1402@agape.jhs>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0063.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::21)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (102.222.70.252) by JNAP275CA0063.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Sat, 17 Jul 2021 08:29:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 43c45dfd-e765-4df3-9dd7-08d948fcfa18
X-MS-TrafficTypeDiagnostic: MWHPR10MB1885:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB188543C7E3E2BBA53D27EED98E109@MWHPR10MB1885.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:175;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S36Kd1lYGDbs3QDAtxS5b9W0D9CSjddMy11E0vm18g78UOAwOIgZoSpPOlo36ZM/W1kvrVPBnfiEm/DD6nH7YkNSE2WcIoDoBFkmY8KQbVSS3LrfAzZNnlmOf5720ErBA45uM1QwNpE/ajQ2T9GzsNDUXYjJWfhCsvIxN7E/9IUPc4WbLyBudKLHbP+w+uHusrdqMDUCc4cyydV3VYxrfb1GdbIFnEQ1tKjnaiQEO755bfNQUCalS02rQtBZtsTHcWeiOGdBxyoXtMa5oRiUgiejwnx67fQnPHbOzJLIrZqKXk+lvZgYMvgMFiryhlqB09fVV/c8FDxNv9iT2VfJyoxFggJjH2eGe3HqcxKDxINfxWdp5GdphvqSWr55P7ckig0vbTpFA47/A+P9l/2SfJH1+in5AajHGs/lM6/AoBj0sSA+AgNBX3v1YkLdBIHGwSMWOAIkLRE4uVDtbwbJRM+KI3S1ug7g1W8SSUIa5gpVJ7WQHFa/ED3CqvqRD20AQWPVWhOIb63con6VfPjG5Uac5W2ojXK2NoAvwP3DKlIT+lm1pJ9316kK6a1a355/NA3pO/VfTipkc3svVP2j0v28MTyfE95/224HyzXZvdftXmqLHX06aVKWEjG+xFalYhQoP1WK2UDggXD9rSm/wLQdvfNpVEQYpf8G2kByIS0atX5DL7/r+GHV9BdqBzFqdCLZHomFlYnOVeR7vMsdGA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(39860400002)(366004)(346002)(136003)(38100700002)(33656002)(33716001)(9686003)(1076003)(38350700002)(956004)(5660300002)(8936002)(83380400001)(52116002)(26005)(478600001)(6916009)(4326008)(55016002)(2906002)(6666004)(8676002)(9576002)(6496006)(66946007)(186003)(44832011)(86362001)(66476007)(66556008)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0NE8gEwz5J/zXxAFs6tiQ93FlG0w4jVNgN/BSOaMD+7/MPeYqXNFdecRQRIr?=
 =?us-ascii?Q?0tGiZgTb+MMTF0kL+f67dz7ZgITZbksrjyRxxcASTqKrC6+WTMbxp9DTCZAX?=
 =?us-ascii?Q?L0WfGEzIEvqwgBmrBXx2N4KWHOf4+DtI/lhtx+1EHz+JyUgGD9vOU0n1E12u?=
 =?us-ascii?Q?R86qqb7V3zQ781EQkJrJRJFQlF9JssZ9GgOgaPRBa3fyVTLPtEb64GerLoDJ?=
 =?us-ascii?Q?eK6IjGBr5+FMLbxIVCcGNalHKZcTmp5oL2q5WdQNAdI3923OEaRq2gJ7m4wB?=
 =?us-ascii?Q?/CbqWjXyR+rT2HUOn7VmofVuCS37IbGilx1cRTLtLmpAAA5KmwIvEGjRjueG?=
 =?us-ascii?Q?HAA1LZzQdfO62rfhOgXNoq9sX/P+Ep98DgDD+L3J+lmdPXR8Zfbvsh6vhVut?=
 =?us-ascii?Q?7P0q5n5oiPub+0QaDhnV0Tc0FD2W/hM0J5Eyc1J/H+c8pIiXo1ImErC2SY/7?=
 =?us-ascii?Q?XHJ3pEkWaIBbRqq7LFsFGGW7ygrqOTpyWNrlnmLrHD/QsI4n6i7VOhG8Kq9F?=
 =?us-ascii?Q?h2FlERfha4QYpxgJYzpqlyZvRBAyvs73p4VPdcFRjpn5OUFSXf6HLlO+dRQN?=
 =?us-ascii?Q?+V78fNcPLcm22zi2QwWjUvSgwoOkMHOhwAIz8V0Qb9Yk7xebXih++i7j26Do?=
 =?us-ascii?Q?nifEa0KdtYoY7DbylBj/yJUqIO60LCvgKO1+1XUtZb9KHo+p1HfKEdrkjidw?=
 =?us-ascii?Q?XUxDfnAeikj2DL35HE8/YhIqhFwBYAGJLDWOFe2JbbvE+Ef4CtCkt6HjYH0O?=
 =?us-ascii?Q?9glYCyu8JFTaKfsanZu41ehUQdLW/r7DaFgpSVTpJEEE82QYudWWB7IBa5pp?=
 =?us-ascii?Q?Z6Dz6Bg2PpOKYt9eFl8ibNWvTyUYXoSmBGTC9AarHGXLzS6EtY7iUNYp1MY2?=
 =?us-ascii?Q?MDvL4BcFCT1mHpx2agO7Gqp+fNP4R/x+Wvk66w+ojNrBIAfLw8nxVQbJy1j9?=
 =?us-ascii?Q?WU6i06MvP7FiBvxW3tIk9VHDTNfPF3noy3SLAjCUiYybmL8l9Emx1a/QL0Zo?=
 =?us-ascii?Q?WByOc5TI1qD8jHPcT/dfEkZ/npmLNPTQhSB2iwXDhqNy6zDl1NtBo4Jgt+Db?=
 =?us-ascii?Q?ffUxWJJaDNA+bqsv9tFF/2D+wg3U2Qw+tYlbc5HTlBg0rUn4GJ2KuJT/CqJn?=
 =?us-ascii?Q?e7NuFfAvfTPaDp4mpQeTrNo8AjGuDa6xSpfGTZsDcnnIoEnE3f8FEAEKKlkO?=
 =?us-ascii?Q?CM+yGyEvozYfZjs/gZ0ahmD/Fxvait5hZwI4/wmBokTkQpm+7673Drli63LH?=
 =?us-ascii?Q?6b1naUZ+letaPD9MugLn/UihdckPS/nedWvAB90EmkTxQ7YS72w+Z58uAx0Q?=
 =?us-ascii?Q?T04mvweQDVYRj+ybO4Qyr3Fs?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43c45dfd-e765-4df3-9dd7-08d948fcfa18
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2021 08:29:21.7010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ll5Ywa16/U/CcZkwltv5P/0qHsEcc6Yp8IcuD06axom+LrKVMrSa6Ztc39tEFEes3GJ/f7eLqQDfmfnkztEl1Kyt487ODcJINz0F7iPGcKk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1885
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10047 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 bulkscore=0 mlxscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107170050
X-Proofpoint-GUID: rb9ok7iYm-3StupYzFNKmIeEYk_D--fI
X-Proofpoint-ORIG-GUID: rb9ok7iYm-3StupYzFNKmIeEYk_D--fI
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2021 at 09:04:57PM +0200, Fabio Aiuto wrote:
> Hello Dan,
> 
> On Wed, Jul 14, 2021 at 06:26:05PM +0300, Dan Carpenter wrote:
> > On Wed, Jul 14, 2021 at 05:11:14PM +0200, Fabio Aiuto wrote:
> > > fix following post commit hook checkpatch issue:
> > > 
> > > CHECK: Avoid CamelCase: <NetType>
> > > 45: FILE: drivers/staging/rtl8723bs/include/ieee80211.h:170:
> > > +#define is_supported_ht(NetType) (((NetType)
> > > 	& (WIRELESS_11_24N)) ? true : false)
> > > 
> > > Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
> > > ---
> > >  drivers/staging/rtl8723bs/include/ieee80211.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/staging/rtl8723bs/include/ieee80211.h b/drivers/staging/rtl8723bs/include/ieee80211.h
> > > index 8eb0557a077a..b2c1a7dafcee 100644
> > > --- a/drivers/staging/rtl8723bs/include/ieee80211.h
> > > +++ b/drivers/staging/rtl8723bs/include/ieee80211.h
> > > @@ -167,7 +167,7 @@ enum network_type {
> > >  
> > >  #define IsSupportedTxCCK(NetType) (((NetType) & (WIRELESS_11B)) ? true : false)
> > >  #define IsSupportedTxOFDM(NetType) (((NetType) & (WIRELESS_11G) ? true : false)
> > 
> > These are the same.
> > 
> > > -#define is_supported_ht(NetType) (((NetType) & (WIRELESS_11_24N)) ? true : false)
> > > +#define is_supported_ht(net_type) (((net_type) & (WIRELESS_11_24N)) ? true : false)
> > >  
> 
> NetType -> net_type, or did you mean something else?

Yes.  If you're going to change it then change the surrounding code as
well.

regards,
dan carpenter

