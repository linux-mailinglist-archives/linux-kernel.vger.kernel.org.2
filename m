Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF8873DEF98
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 16:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236372AbhHCOC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 10:02:27 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:43206 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236580AbhHCOCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 10:02:18 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 173E1TnR001709;
        Tue, 3 Aug 2021 14:02:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=LwAn92r2JUZMyd9uwwjaVcGTmOelcA53hyMjZAwSdic=;
 b=mUY1zc8FENmHWy7vfc78ot6pr9Zbr7BApMm/DXZICvCo9KtPqMfqy1+z91QkMzd8xkV3
 Dombq4b9AWyiKI3zsKK+bJBpKPu/c+9RywH7JwbHa9Z0pWoV2G6utCWutlcZXQWMk3GF
 1pqkFJyUwtseNJ1NA7jQJTZ0L4XdEGu/hMZEdiq/iEGSYM9iEt0s3j07ijVfIai5V4tc
 NtoLWO/ZNCBQHAll7ITpMJPbtiYR5bOCr/4T5WrvLV8PVfdL0JmUltukccAL2+XVLaDs
 MdKynDzeXQYUbElHA0tb7al5WNRLB7YbY2I/iJy9+Z3va+nj1T4S4JjUvB+2XGO+BhoZ bw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=LwAn92r2JUZMyd9uwwjaVcGTmOelcA53hyMjZAwSdic=;
 b=wAhzIMUozP8qtaKlJy10A0ckPOXSCFhxeNo4C8MzJJdDCnp4ooW1C50iA74INRXLqxbm
 Y4PVpCAuSkQC71a3HtzHvdNE1lSo+ukSUgYUdgmlM6l1yMXvLGaZPeHDKmzLTYPIFS8H
 5DY1LY9K/rwA0sTkXrO4ZwbWvXjSZ64fV7cA083cV9ywuTbOVTbWHyoxF4jyfakDA79E
 ND83YDJ8mlDXtfModNgeEW7ppVfBVC8AQrBgQPeAjxfAuTAbMj5d4GBgdtAkrumQo5Nz
 xvVq0245wfr3CIOyLOyY9rwR0Zl23z2gDKf317aCl8fRoYrodvgr5h8ZdDLrlHJIL+hz QQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a65vdc7wd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Aug 2021 14:02:02 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 173DxqP3182255;
        Tue, 3 Aug 2021 14:02:01 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2046.outbound.protection.outlook.com [104.47.56.46])
        by aserp3020.oracle.com with ESMTP id 3a4xb6t1xu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Aug 2021 14:02:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FtWuNT5qUvzAdmwOgbkOOhNOSln20t0aBn1DKTmv42wnTrZHn0bWruMjknjBTxRLcB4ox/TZWu4QZJzw58DNF2x0g7VpMcb7ox22MdW+BEXLmJbPHN4MhC+VDoms0QnkiPCxKV4Rn7KmslQ9cYZQACrezllE67cpFDIBaqlr5/cgTnzU32/jTfFOKQa1SGkt9DXiTj1rtquxK38D8V2HUZp2U9nK7LepBjNdabJyoO9/OfC4FZ03XgJ0KVz53hJCY3Dk/ynC+A2WdeF4UOlRqAJnDepBnBlZzxsbj4s1U/UcByFwfmA8it6zRh6HJyf0GFqk2yksnNYGf49ZJPGuGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LwAn92r2JUZMyd9uwwjaVcGTmOelcA53hyMjZAwSdic=;
 b=n3Bua3hji5cykkTpZ9dedKxfYWkwbFTUupNKpfTGaSY9fwxxwrHapQMMs7QQ0TVh4yJTd6lElaxVGDV8E/shklf42PSs10IiqQl1hHw2pxZUbPXa1da+RpCt5/gLVStyWeAfO3KRSyqx4dmB6JutVEhPOodK6GdRcI+khy9baPPDqZZ30dF4Sx6ETXEG7WEQRGonSWddUc4XLMldMfJzefDtydh8+FHTBCfwXL2G/mZY2j75N7mBPByuozUFPjrncIXKBMogtfsmgCRLdt+otcTcw34LCyZ+MNkOakv/Yn5FHOm/EWqCels+NW8GifzlccjT0N5IIxWZhcd2VbrlBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LwAn92r2JUZMyd9uwwjaVcGTmOelcA53hyMjZAwSdic=;
 b=z97pjLzG4AF1u0mv5H7RwS5kLpo6w4XjB7v2lQ/73mkrZAQ06rUVZtiLQl+fIwPmb/uTCX8TVEhBCOCnUNVN5ukGruKoJCeNwgq9CRV4XTlXh3vXOi3+T4Wb8ys2C0Sp/sz5Nt9IAdMgrxC++3IC915X5x7Ck0QH54oobihjHIc=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4595.namprd10.prod.outlook.com
 (2603:10b6:303:98::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.21; Tue, 3 Aug
 2021 14:02:00 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4373.026; Tue, 3 Aug 2021
 14:02:00 +0000
Date:   Tue, 3 Aug 2021 17:01:40 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: Fix different base types in
 assignments and parameters
Message-ID: <20210803140140.GM25548@kadam>
References: <20210730181452.23062-1-fmdefrancesco@gmail.com>
 <20210802140505.GZ1931@kadam>
 <2671423.i2fK0j4CO3@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2671423.i2fK0j4CO3@localhost.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0056.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::8)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (102.222.70.252) by JNAP275CA0056.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend Transport; Tue, 3 Aug 2021 14:01:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 70616db7-ef2a-4b94-204a-08d956874331
X-MS-TrafficTypeDiagnostic: CO1PR10MB4595:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB4595A22CBAC48A7DFF103C7C8EF09@CO1PR10MB4595.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:288;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PgCzgODR3FMBcW9YKczLPq0BCytVoCjcIQfYfWFBTKR/qH+am8QJeJiRUHpHKVioFOZ3gPaqaUFcVMhUZOfUUdjVEUsdfNqu42g7D/HLMOW+1jIKNg4DClc9vHIjtGEfMoWTvtGaPXD397r9EqP0n6NbMCTzid9ABt6uWqErqyhilUT8PWmOK8unQkMn00eXEAXQwAhKlBhniqfZvQC2JtOQgMhrNN6/O5/kkOEJsVZ4W5IHnmEbK8MYomi/Fp/BRLi1M6d/px6eSvg3V1aTKJqiCUzOJmY3qmh/RA0ZtpVV3acMNUumzyTn1gMD+hl8+fkhNbMzOwu3JnRubpMwnAf4zZIF4XyR2YcV5U33lFveWNjGyTV6OA7q+ea3C85M58nNHqAF2Knu+bTvz50ASubrwpqy6bhh8uP415t+kCW1bblmKkLUtnNEkD4zPpvq5C7+2XRD3+pIL8Ap3KzobrrEqm/JBQt4qtDZX9vEEZF0JEnuy1/HFeAw7Py9ObhzOQm1Qw47dwcbIw0K3q/zfS8oLoiWJeSYrOJlGkvTV93H5Mgv1gzrxHDv9dCWN3X76NggvvnRuD5bR207b74JHyPtey5lGm4MIe9JYEAk+6Ruzq6H4pb0DmKTqY2DbRux1hDrXggln3MpvWf8uaGJ6JfrzgSQYjq0oe/tREY7rg5k81sERPGkouq8fqN/PBm2XN8gt36NBV/SeqZabB8QWQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(366004)(396003)(39860400002)(136003)(4326008)(33656002)(86362001)(4744005)(83380400001)(1076003)(66476007)(66556008)(66946007)(5660300002)(186003)(44832011)(956004)(316002)(478600001)(9686003)(55016002)(2906002)(6666004)(8676002)(8936002)(52116002)(6496006)(6916009)(54906003)(9576002)(26005)(38100700002)(33716001)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RUAR/YNmo+0O2nALFZrSSL2r7pNAd+Vcw3c+kSYsfgKVDc87KDKUcHiEodBY?=
 =?us-ascii?Q?pLX5I/XMIwe8b+sgBlF2AX51wMUw88yHnRckvHbPmfi/aLNw00c4VsyajeUG?=
 =?us-ascii?Q?7EmzW4rC+Fl6CH+ha/IkomTcwKp2faVa+ZA9+mXhnCped1nBKltOPTrOfuEP?=
 =?us-ascii?Q?tZLIkSgpbyBIZEVoB9Z6tup5zHELIyQ0O7q0yTIMII60SCWP/WWTNBH7xIDK?=
 =?us-ascii?Q?SzHTBCVHW0DApqr6XbTToSeZ8cm0kd/Oym+AI5Xq0B8XTyEkRPNS1lbSAdi+?=
 =?us-ascii?Q?Cge52SxVTzmUHohi7hUbqkJiemFuCRpB3aZoZe7VycGhtErt4ncKRrefh908?=
 =?us-ascii?Q?FrNRPGC1eiE5CyqLm2G2ppTQbDhjHB32ycnfA+qaEL015D6cWTFkTSN6yjJ9?=
 =?us-ascii?Q?F1MCltv+CAXaeHSXxdnu8N8FIangqZs+g2wEZUm+nKXtZPQOuqDpZSfUeZOt?=
 =?us-ascii?Q?+J0XpM2kk7zH7qjf+6fxPlTLLSr229tB5OfMWetgUpAcv9qHC0cHI4OCgFsG?=
 =?us-ascii?Q?qbBnt2ysTx6zePTdgZEW3TZRQaqpchw5V5b4u0MO+1sy6NUovnMTDoeS2YCh?=
 =?us-ascii?Q?82cBp2ZUQMB5Zw+oXG/HILLrKBzxkFm0ZicC2aLXdV0kYV4oErWJlEx5ioPo?=
 =?us-ascii?Q?k5OY2yS8TA8VzuIroUNCO1SaIw8ol/4QJS0cO6AB4OnHgmU7VieIFMw3Wint?=
 =?us-ascii?Q?AosQkV2RpgJqVddQI2HyuOIcHswOw7fsXZIyYB2vkd3pLU1oKyXkvT1LUz8u?=
 =?us-ascii?Q?d+d3nBQKwH6DKsJBsGoVzNbEJo/YZm1w9MYIPH5Q9G5J03EP/paUAl1Nhy63?=
 =?us-ascii?Q?u/au8/hXYEp0Q9kXJmRBxihPylhuLxSV75LGY71FTW5hkDJpuPIGvWW7+vaB?=
 =?us-ascii?Q?1+o5kim0CXKR7+pAj090P6BCSxylLekvrR8P2Wde3LK/MAGiaZTUbvfTG47E?=
 =?us-ascii?Q?VAARTnLCTodj3KVnUABVEe2MW+WtqN1LVYqR0bidkROkJjrZEkBvUBFQzgIC?=
 =?us-ascii?Q?vapDfauNT1NlyXCEm9qgeFpJQgG3RNjMp6BbQOnCkxm0GTcDhK38rfZyrfSI?=
 =?us-ascii?Q?Ou1wfNnFR9/F1GjiADqQWXyN3zcKoD95csUJz8nwJz5/nPHC5eAXOq2pBKw9?=
 =?us-ascii?Q?kD5TO419vUMpB4F/QiBJJm9kDyTrM6qhHcj0UZ34yHhXDTXDXZGhMxHHMQ9J?=
 =?us-ascii?Q?PlUPeOJcS15tDI/3or9tHIIyW4duKpGJEBR/cVMNDiRRvpWou5kdVoerLBwK?=
 =?us-ascii?Q?Fnx+dv9gMPXfR7snoYwX4KwS2OenKYLqbTqaPPJD4+YOfIw/o/tUw8N0jrfs?=
 =?us-ascii?Q?zvk07NQKdNwFw28GlsTVxdY2?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70616db7-ef2a-4b94-204a-08d956874331
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2021 14:01:59.9511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UdJ8HNH0VJkOqzge0nUpAoLJsWeJxKL6pn/vSHFgQR51ik8kJNPrnmXPFdmyHcotXEplF6L0S2lk1H5EcO88Ah7pEtWS3jXf6y4tBS6Z5Dc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4595
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10064 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 bulkscore=0 spamscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108030093
X-Proofpoint-GUID: UbhSNvU5gmxA8m5lQxDUpBYKAsbyfl7S
X-Proofpoint-ORIG-GUID: UbhSNvU5gmxA8m5lQxDUpBYKAsbyfl7S
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1) I'm pretty sure after a little more review that the patch introduces
   bugs.  The data is supposed to be big endian.

2) The commit message did not clearly describe the "bug" and how the it
   looks like to the user.

3) The way we set variables to zero is we say "foo = 0;"  We do not
   say "foo ^= foo;".  Everyone knows the XOR a variable with itself
   trick but obfuscated code makes us cross.

4) The unions were unnecessary and ugly/bad.

regards,
dan carpenter

