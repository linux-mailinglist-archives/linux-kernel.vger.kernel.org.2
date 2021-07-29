Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 550743D9F9E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 10:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234976AbhG2IcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 04:32:17 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:43310 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234880AbhG2IcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 04:32:16 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16T8RaKJ032672;
        Thu, 29 Jul 2021 08:32:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=qx3x3U8uTjuq+gjaTK2wiAtiM3rJ6g+gQWUUyZ0Mld4=;
 b=jxP1jX+IJnN2XhpajY+voa9XyK3BwoyI1l5uqyM+l6GaUh4Y0Zcz5tfgg9xsdI4gYGub
 3DpSam3g8i3bZd0pNi8O2EEvFbhnEhKIEXTGJz3qQcTidppLVoU4ZzVhcV++v2L2lxfe
 SMqS2i8tlrzhs8RH8bwUd/kwTethQ/qaCJxBa+9QoAUNdvEhFlB1Bn6ZRSGk4LZOxfeQ
 WkQq7Duwd71LgTCOUPP+pTKYejjZID2SmjWHwuOQwWqVZeQjHyIYnXX4GcaCwknXcZvJ
 tfu9hGMCRTc5EyAcoZQOMNBV4QZ0wpS+J36cJ1vPdieOmXkQ0esEt+LeSYcWS6J5TzNF vQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=qx3x3U8uTjuq+gjaTK2wiAtiM3rJ6g+gQWUUyZ0Mld4=;
 b=hc5IQKLjGbX7oxFi6kYpcUGZZgqxRjQ75JPQFhmSCnldmtWcjRGMwF9wxuIcXEj831YE
 187TtaBW8v66oF17lOe76pDxQIRZAg/UY1JZanveSWY0AfD4856NK2nyHvQBwSteVpn3
 mCAGawPT7f5fIhQqaE+z/KVwMuNhfFZXzWHF46PxfgZg0iqZa8qkC3eo7FqUc89meIo0
 k3ngd0ChwNV+l9dPwYEIjuR9GzS5e8zwv8DNBuJOP3s730XDemJyKOeE/pqrDENKjy/2
 YaddTps5Bvwz/exFEwKed7m37lDlLl2ep8hKT84FOCHLbQv7b/1zDk2xV6ZvUGD/HgLc fA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a234w6p1b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Jul 2021 08:32:05 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16T8PnW5092277;
        Thu, 29 Jul 2021 08:32:04 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
        by aserp3030.oracle.com with ESMTP id 3a234e2tt9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Jul 2021 08:32:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bhZa0GNV56Yqe/dm20MdN1mEnAvQdBDFtQVwi7LIC2ASHPZCTrrLDn9CLcrI/05G6fZCk3vNleyWbvrtZVWLrgsvlNc3BNjxhP/eW+yWgKfpW0yLCZzEAm/7eu2qsaSkZZ7gy+cC0RGeuNe/I0untmC3Xvxb0zOIxZvqo3iR7erQoR3iW0d9901uHbCPmyKacT5UK4prkspViJ4Ro4I7EkVdDqCdqmroPf0kQIVgvd2dC7l4jy/B4oYlfjecHTEScw3JoqliqroOqkoOcBLyL9woevk6HLDPftVyR0K+INQE7Zpgm1z4my8Vmk7N5pmFQRG7nHd4E//5E+E5recSeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qx3x3U8uTjuq+gjaTK2wiAtiM3rJ6g+gQWUUyZ0Mld4=;
 b=n3lFnjb+kGJj0Z6M4eOmWgS3AcZHWehIweFH9tuuDU2jTRZ6c3N50qpzS3KsB9M8ITTe74zgzE9TD2vgR09eXu2L1KZyMYg5CUFWq3hlXUSmVdcRixgncai69ZLncto97Ius97TKqFqcfw4RJYrWm6az8KdD6EE1DAuTHO4pDvTbR1DxHAIc2sa2ASbhz71iOpAyqiE+WOUEHYKg6YjuPanxE5Zfm3q+5TVc08GpmPRgvFOkQml/kOwvcvNs1B9kFCV8oOw9SXLvODsVfDO6r31oYoRbHwL2Z5kP+qr8YsU+tm+Y+r7tgLQmf3zt5tqtSzGVmKuSbNMNYHf2DKxrSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qx3x3U8uTjuq+gjaTK2wiAtiM3rJ6g+gQWUUyZ0Mld4=;
 b=Cn7plFXGa3C0jWgdK/qQtopxBhQ+vI8pfdaX8p2NjyBjddZ2Gv3rjKVey1DGaXTBui9aw2QLoM49JC3b213aONuomOtCGMKp0O+EC6MiVB3ETazDwAVMZSlDFxHx0G+LRYSw8jdlaLBVrGSJrY0eYW5u+Oen2fJV2DhmK9wuaaQ=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4705.namprd10.prod.outlook.com
 (2603:10b6:303:96::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.17; Thu, 29 Jul
 2021 08:32:01 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4352.032; Thu, 29 Jul 2021
 08:32:01 +0000
Date:   Thu, 29 Jul 2021 11:31:39 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Salah Triki <salah.triki@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Fabio Aiuto <fabioaiuto83@gmail.com>,
        Ross Schmidt <ross.schm.dev@gmail.com>,
        Marco Cesati <marcocesati@gmail.com>,
        Brother Matthew De Angelis <matthew.v.deangelis@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Ivan Safonov <insafonov@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tablet: acecad: update the reference count of the usb
 interface structure
Message-ID: <20210729083139.GS1931@kadam>
References: <20210724205542.GA549014@pc>
 <20210727123756.GL1931@kadam>
 <20210729005427.GA784014@pc>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210729005427.GA784014@pc>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0003.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::15)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (102.222.70.252) by JN2P275CA0003.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend Transport; Thu, 29 Jul 2021 08:31:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3fb8112d-a960-4b6a-5c17-08d9526b55e4
X-MS-TrafficTypeDiagnostic: CO1PR10MB4705:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB4705F2A047F47F1C785547F68EEB9@CO1PR10MB4705.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4n2FtzODS+Aw3Q8GYPOWHxjyXiryeR2lXPP9CcIALS0k1a8eHX93OMNs7VPJiwxka2otdhk5lJpvTTAkvel8ANexSxvIMbG7aWsNmzeTRpQ3GKppiQF6zWz7cjR0qxEDyQhtiOpAtOJFVdOyePbo2jeQLu6rKk+7YywrvKs/QaS08vVM+q/ir3rBrFAhxG5twzWtakRLzG67c6GDkeJTI43+MZTwvWd+vbATJpET4LGVbZoh0xoTDJUuKSmp1uoRUFUTn4MvrQU0R/6ddcdl6/RVnZhBi2PGmXFFDIdLJWfXi7oPGtlwW/psXVEVGQVdwjmrLm+rpmxTGyd99wYk9njZUTEkjM7dq7A/kZD1jBnLLf/q/zDgHkZouW4xeAfDhAJP/Ijo6Ms3ETD9vWVh/z68lVAU/kyvYwAd1Tr/T8O96KFpanGDJNE/lGn48XiONo5EaznoGp9SQ63OZwM29sY4Y5ABKZ3c9LeeXBngR6LDSmjDUl8Phafdc0+Kld5C4ZpO0QG23sMy800LhcfU56MTMwG4acfNMOx9DgeFYP/UihPZ5uvqrzyMBA6irxoyPFyEVh8ZhbBnMsO0+TrHnM3VhfDYhB8se+UbSgAhO7JpLlAdScxTTLYm8WqXaaIwkgdjC0F3jsdHV+3nrbgzq/+1xtAYAfGMcNMQuVOVDCP6fCf0nW2zK8BYjLdvh4i9yCyMk7BJyOwe803Y22vNmg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(346002)(136003)(396003)(366004)(15650500001)(33716001)(33656002)(44832011)(8676002)(956004)(54906003)(7416002)(38100700002)(9576002)(38350700002)(6916009)(5660300002)(26005)(52116002)(4326008)(8936002)(66946007)(478600001)(6666004)(66556008)(9686003)(6496006)(2906002)(4744005)(83380400001)(186003)(66476007)(316002)(1076003)(86362001)(55016002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HAP0rv7X4QvUXHOe0f4y3smD+l5qr5DtqEC/wK4LS/W3fU+3ELN4Xo4eauaZ?=
 =?us-ascii?Q?FzeDwgQT/2HCNb7Lum86kkGfGfIFMTxvUqcEhlDs5LXhet04m4koFKybsPDl?=
 =?us-ascii?Q?+FhyNqZUhK7WVMDCcflfjjKY+E43Qpw2mQLS1PwQCilTnBLqfQgzR/YLZclx?=
 =?us-ascii?Q?6VdvzahDNoAAqOkuf7I0fRmgjyx8WwSt9Dq+ZB04eOVJGIQri2koclBSHD+o?=
 =?us-ascii?Q?4ZaR040hnOXjngdyizx7ptkDD4fz5S4iKMQBeeK9swTPoU8w+QSCq3JNwgKr?=
 =?us-ascii?Q?RK6fmi8wiPEZaG3m58B1Bx2DZ/4rov0ccDnC68vrM70pjvvF7uhVkeYueyW8?=
 =?us-ascii?Q?LaXyAtZuNF89Blw20K6XgrXujZne1VZHbX7dYdNVFz4FO+JZT0nreVVHRu7c?=
 =?us-ascii?Q?ywDfcZIh56XsQlUgdb9cTtx65E6JjC/9sV9xWewmSntSa/DpV2299lh17RUx?=
 =?us-ascii?Q?iVSu0JxJ8KffWbU3L+ldQ5BHoZ5t0sA9z/lbUgOYRJB0XazlfSYwjCC/eTqb?=
 =?us-ascii?Q?4tVP/OoFAoaBmepdGetZXb75p1QioEIVhVQTzXr7a6uThoK3Qy+D67icCYsQ?=
 =?us-ascii?Q?egS+bLf2SG0ca37WOGLEGfuQZY6TdMizDlWn8OohA3+Lvj96OEz7Ap/XlQYh?=
 =?us-ascii?Q?d2Sakz/Tytus73yVLIZ2KpAOTF90toS6qDIc9tfo1oI0upqycnuF1iWgwV8E?=
 =?us-ascii?Q?E0MLuOscsFb0fh5DdqaDUOdtziSTm4uoHX+rjTsT7JJm942mnvLw5EfBzYWs?=
 =?us-ascii?Q?2LAAAAfjPDsppCJlcR+Z8t69iMwlgxic0eIJS7BWYbb5c904rKJ7mEJXNFcv?=
 =?us-ascii?Q?oQtbu5c4W0mjPL8XH7H3TX+OMnjaE9jecvTLvAB9HHLF2aH3s4dzHrdpzXF5?=
 =?us-ascii?Q?r2bgqsD+ioCSjKJKsQtmE6yMLzWrISZ0+vLLEnBmKPbjUQ+Jbgj8fAcs8fnZ?=
 =?us-ascii?Q?ff8ztlPW2sdOTAfzsFNn1RG9ylPsRDlHmcWicMe4hLQ59kU8emdOrISSuQJI?=
 =?us-ascii?Q?xMFXIKxKK8ML5tVWiNwqhOoFx6xKwUCyQOn7hGjntSrYVLLKhDjo0+BrkU1w?=
 =?us-ascii?Q?0Lu+0CbgPUNh5ypSHA0+jT0pslpdTR1kQreulCgajLUiiJ3hII+kYG4vRxeJ?=
 =?us-ascii?Q?asqz+E/ge4doBy4FLKbDZuBrhyfWCwapBgmBSOq5DavyX2d+gVf3ted9HEnK?=
 =?us-ascii?Q?TSgnBvjkRmf2legEdzburGOy5Bkw5x5JnbGGR2jrHA+uxHcp+jPN8LFxld9C?=
 =?us-ascii?Q?XhgSZw+XhqpQ41EODHmOEoFRYOSTMHmNhwGiYJgeLLPbmGbhC6O67Q/qVGoV?=
 =?us-ascii?Q?MOBAIihMhq1nDNgRZ330tv5s?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fb8112d-a960-4b6a-5c17-08d9526b55e4
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2021 08:32:01.0100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gr4QkbK9lDtRmglrpQbzX9rBtqLF2N+JKuxeZujWqjukVMpRedsa/vU6d4fNy2zUGo0RJ7bAzUekoF9UNuPuhP+HeymZvfav/MrJlFTWzAU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4705
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10059 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2107290055
X-Proofpoint-ORIG-GUID: brv3AZWlgqdG45XEU6vRWeZhHS3XVK3k
X-Proofpoint-GUID: brv3AZWlgqdG45XEU6vRWeZhHS3XVK3k
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 29, 2021 at 01:54:27AM +0100, Salah Triki wrote:
> On Tue, Jul 27, 2021 at 03:37:56PM +0300, Dan Carpenter wrote:
> > This commit message doesn't say what the user visible effects are.  If
> > you encountered this bug at runtime then please put the stack trace in
> > the commit mesage.
> > 
> 
> I made this patch based on the following documentation of
> usb_get_intf():
> 
> [quote]
> Each live reference to a interface must be refcounted.
> 
> Drivers for USB interfaces should normally record such references 
> in their probe methods, when they bind to an interface, and release them 
> by calling usb_put_intf, in their disconnect methods.
> 
> [/quote]

Put that information in the commit message.  Otherwise to review this
patch then I'm trying to look through the syzbot dashboard to find the
stack trace.

regards,
dan carpenter
