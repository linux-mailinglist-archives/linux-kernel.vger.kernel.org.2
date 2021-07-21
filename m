Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC6D13D0A52
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 10:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235845AbhGUH2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 03:28:05 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:57526 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234850AbhGUH0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 03:26:33 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16L7uxOB011310;
        Wed, 21 Jul 2021 08:06:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=btDEpbx+hrllqOTLrKBvVi1HBaHdLqy5k8oln6TuICM=;
 b=HQzukHRLWX7hoZ3kUpnSlN8OVSrzvC5e2BoVVUUr16uELGpsQbRl6oLQyElnhEd+VLR1
 a1q64Vhx1m31YVf6tXdKgKuCEwUhQN07r9YdWpArrKHaklxu+awf8BqDcP0qs9xbI3Gm
 sFnKb146XE2Keg35qzc7Zk+iVCKqTfy3RRknHveaSjtq/7qq6zCLjzlHY+I3H9RH11/H
 jXX+/9ZB8eVXdpmgLvekfOnwz5VeLG/a4liw3fuw+AxEpjZhfkitTqRrDjqTMNDDdRRm
 /CCQds+7Wu65B/5pAKRKWrt8UkLM/T3i+WKbEtkyL+GzWaTR+US9zEc3+b6qLJvYijY9 mg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=btDEpbx+hrllqOTLrKBvVi1HBaHdLqy5k8oln6TuICM=;
 b=w8MKxPwNjfffzUcb6cKgrRpWjIFK020e7dgyMpV6rkIDKizSrIFts5sVAkQq14TLIG41
 5at8bMgLfUf6Dbm4yt49h8wyB+DM4hVb9xpbJ07+Nz7ztG7c/bxKJIrVv3htVLtyTDew
 oG5L1VqiFyCOIwxHRTHWmKBFbjx+/w0IigB76W2B6h4NbbpKwC8cqtO5T+fReDCZecNO
 te0X+Jm4Pj8e2ZKd8+eysNQuc4fXcZhQdfmvaosz/JObyv/e/KAXFez3vgX5mKVxAxjy
 BvF8w9aJ2RWXq7S/y5U9ydMGRazZDhsOckAE1/cEdXzyWEkfl2gQCQtDrzNQ75prGrjF gQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 39w83cvpmc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Jul 2021 08:06:45 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16L85M84058149;
        Wed, 21 Jul 2021 08:06:44 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2045.outbound.protection.outlook.com [104.47.56.45])
        by aserp3030.oracle.com with ESMTP id 39wunkek41-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Jul 2021 08:06:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i5MhtgiVsNk7QHLrNhb4NSl16jU76AkBp1GbSyRYMSL7lGBq5GTEIy9aXFvMiVzewTlf5R3MEuq7lRhIb7nbUfeO02KvVwx+U1I7lu7o17TkXzRRuTMriIWuJF91k30o6/n9l4pnGTrLfBULEFt6rLaG/uOKMX61B5kI+KwWefT+ydju8OwAMF9hS3oaZngbUKj8shPsN+fpZKC1W1VWoHEzsyUOIHGxJkh5CFeHKP7ZN2cw7NdANQgASsdcshOnkL+qw5FJY9dCb0cvlRRu6prgfeVZnStX/kFZF7AkXbZuOo+aNcL28J1glcC/UjQzV46NUsNG75bH5YQH2shEDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=btDEpbx+hrllqOTLrKBvVi1HBaHdLqy5k8oln6TuICM=;
 b=NvTqUJqllPO+dBbSqpZyoUnJxAwmYyiVUI9hz4RcCJlMobuosXntYI0cW+VCXdwTVBuPC97TRZGcEcZZ7Ep3twquZz2NAc3WPHcVscIx7E7VQGlrORg6GlopQyrivR4tDBskPjW8IqguIpG0ftVEdbf+cv384tb2uj6aC/EW2nuRTWsXylqqla+tdDtuJq2hZxsfWVCR+fmhDXGnpQOkXZpZK3yPr03GNiZTR7erumFbfmvIIKtMZDfeeU1jr2b3wAOct0FuRZdl9k4KLfZrXmbYgskvld/aE+KV8Ol1HaBShhW85Vg1AepMxqFC+lDqH+zyxw/yfnLRQO4bzX7TLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=btDEpbx+hrllqOTLrKBvVi1HBaHdLqy5k8oln6TuICM=;
 b=XuY3NdcKbtlGvO9iIZq4LwuglQ+DVXGBo1YOuNBMNeplHTrWzxNdlLNjv0egMgABMELVX4l0i/ixX6Dd2+uJ85f1yXNm8nxY1JUdwT4JDtj4IF9L5nErcD9a0mO0tf6IZ/ubDxraW3nIA7/2Us9If9ZNoWpk82MWOc3f4a4T60w=
Authentication-Results: ACULAB.COM; dkim=none (message not signed)
 header.d=none;ACULAB.COM; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2398.namprd10.prod.outlook.com
 (2603:10b6:301:2f::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.31; Wed, 21 Jul
 2021 08:06:43 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4331.034; Wed, 21 Jul 2021
 08:06:43 +0000
Date:   Wed, 21 Jul 2021 11:06:24 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     Len Baker <len.baker@gmx.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Skripkin <paskripkin@gmail.com>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging/rtl8712: Remove all strcpy() uses in favor of
 strscpy()
Message-ID: <20210721080624.GV1931@kadam>
References: <20210717155145.15041-1-len.baker@gmx.com>
 <20210719053747.GN1931@kadam>
 <de94438319a84e0985b3ba0f5c00807b@AcuMS.aculab.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de94438319a84e0985b3ba0f5c00807b@AcuMS.aculab.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0040.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::28)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (102.222.70.252) by JNXP275CA0040.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Wed, 21 Jul 2021 08:06:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb117d54-c52d-4c8a-b44a-08d94c1e79bc
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2398:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2398958CE06E30A3892649A38EE39@MWHPR1001MB2398.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yJqTjyUePPGSCfP28LUxTlPq5Eofa2yyy2n5YoRrGMGjiFXlyIoaqZHG5zFj0+2w2QgiVGsdIB5WHVicapM9jo3wWR6d5mrRQPqD7XavfsOxUAhP6/W6OUbYvc0XbT8oVM1Xcpx84GKZoO9OhZ9ESzXHNv7kxeG2DLjs43TkvntTe2p+BION9wd15er3wqc8po7nTtXcMcUuNAU6uBB+lSRmw+1Ma+PP3m7D4UW9HuJEtdI80GR8npgz3aU99OFyPX59GMpC2gx0XW19CjoCV1bXzxTJwdv/ecyIZrh6YUBLnbST8yc+dtrtf/Bh0DpJgNuOvR5YvwhHT1tr4omxhhTjJncb11JeNNAXNsg8ZfHdF8ASYSiLzAtsc9E1mmHkUwnITgubv9cKDCE6zd9AsLbJxMKf8Iqyq9A3ZiZQpKdVespWvBAWRPps+XtQAFpV89muPhl4QveJR8UyzmR2Gu8Y5QIsgN5QbbpJSXQDj8CnhhycvzJ+SPs2PGYH3JRPatSKUDihjXcsK6ML+RJ59yDgyHjq72/2Aa6OG+AsAeFoKtHYaxGHzDVKJS9MKHFXO9yq1mygdWdmoCWMHAa8y3PqwUaYc8OZIPXMCVptVu+m8wJNlgYG0XXsVsKJmH/lhOfiggyn5ZnsSitOOZy/uHFx8XWxNyPnuia6VN3w4R8s7zpx8BX4TzdYD9Md+iG+aBXwqyQSNqVzqHf20w7j5A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(396003)(136003)(376002)(39860400002)(66946007)(956004)(66476007)(26005)(38100700002)(38350700002)(66556008)(83380400001)(1076003)(6666004)(33656002)(4326008)(54906003)(8676002)(316002)(6916009)(52116002)(9686003)(5660300002)(478600001)(44832011)(9576002)(4744005)(55016002)(86362001)(33716001)(8936002)(6496006)(2906002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?61ZNeYTqc/rTR4oFG3S094iEZ8zA3NLCAy0YLQc1KcxmnWce+uyJIUycwseo?=
 =?us-ascii?Q?oPw40uMYlcVRvJ+Zy1H7lOl2YbL1iMi3IRRrGseONa9JBtBBhAP0VObR2QNd?=
 =?us-ascii?Q?aMIHmroqUgdG/NbDQNUEPIaJo5jgh+q218oWWhLtrReYRNAg1GlrFOpJhO4t?=
 =?us-ascii?Q?YU3y9DuTHkXpIBmgmG1tEm81e3x/wcKkqAiLFHuR0Dr4Iby2GrYskrcTs9Mm?=
 =?us-ascii?Q?Csgsv2DhnHvWALbusHTB13c1j+SdSmT0eJBigqC7BnSnSHbkmzwAED9hNWEe?=
 =?us-ascii?Q?a93hd989LOQStwvhsFheiUqE+MkN7KZYjY//TFnT5oLJDGDYM32GVQ+ShnaW?=
 =?us-ascii?Q?NFzX8wfYl+TzH7gVi9flRCIz7AKv/+EDClY6oFL99KmAWh3Gs56VoX7h5kWl?=
 =?us-ascii?Q?XC+QS9PNEOC8ouN24rTKXtwAUyyhJua6IICH8Tgu7Qf8ff+9q2tOotmFhG1V?=
 =?us-ascii?Q?2sfT781S1+iFLOvxqMEG8ZukJmKa1HSyDT1G63e9LE9qyKqhvck1Wd8NdhKR?=
 =?us-ascii?Q?nOqejjaPCseOG88Vklvlx+/aBX17Fz7gIhzOqlGlo8NIu9BuoqwLWF3MwuXo?=
 =?us-ascii?Q?nsk7e4r1bbhoEI49XUYR6U5EvzfmixcC14iNgiL//Kfh8tosDK4B9Us8w2P1?=
 =?us-ascii?Q?j7Hj0uUHZNfS5HyPB48twiVMg1+7z5Xaq9D3eseJWNlSXFzpDPInMiKbgOZH?=
 =?us-ascii?Q?ETrZUCa6jtypLAtuuyoxg4/OB+Tf2inYpfngnf5D83d+PCCFrHZwCkz1oJ/z?=
 =?us-ascii?Q?1F+jQ1jrAHrEcbzfSxQ+Iv3jatARUcBaqZ/Bj3uPt18IU1fAz+pF5jcYHRMR?=
 =?us-ascii?Q?YxoqhQcXc62qYvXivkjouGSTwLt0+AmcTs3Knv+svXlEcA3RiE3UiBrAIzCS?=
 =?us-ascii?Q?GU0kU+znIfsuW/f+/Qa14krt3NE9LAokcl7J4+rFpPFbUOg+6pzZyGvXNUBZ?=
 =?us-ascii?Q?WP4KgCQnSCOgi3n5R4PXI3FpWhSgeHy52l/CY26w1soYzPLr/7NfyoZUEiKf?=
 =?us-ascii?Q?H3MqVd6jRpxy+/cPDNxGZk0D7af7PJJ10WmR3O80hFOtcuOOmzf3TTroWTrb?=
 =?us-ascii?Q?gZsuQIa6OnDyrQUJwhhUikDwwLkHV8zZnvYoT2MxRZxKXhju2AmDc5EZ5kOo?=
 =?us-ascii?Q?ioxYDZRe+jxUsxiGrNx/omqB3N3vOI7marYZzv24aqWAgPODcfPU071Edb6T?=
 =?us-ascii?Q?LfTrpLM5iLWCTeZ6b0WxTKOKhbejPhi53c9DP3SC62iZZTtRWkafNvMcD7lO?=
 =?us-ascii?Q?57mQ0A7/nGOBlkRwZno1w/U+tRexDbyI6Ik+92iKHl1WO+nzsDnT0pgCDEvj?=
 =?us-ascii?Q?5dGq18D8ncO3zsjF+R7gpWji?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb117d54-c52d-4c8a-b44a-08d94c1e79bc
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2021 08:06:42.9243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g8Blbw5rgPJ9nSLGEnG33fjTO2NVFsVH6ZRppDaRvDn6pcpfil5dASOxfncIaXd8FsZFswmArxIlh2Fskpfi/qXQztGUmEyvhKii3qGSnfo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2398
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10051 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107210044
X-Proofpoint-GUID: DkUtK1yTVrSL6xkDMelxnkIiQaFvfOAj
X-Proofpoint-ORIG-GUID: DkUtK1yTVrSL6xkDMelxnkIiQaFvfOAj
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 19, 2021 at 03:24:38PM +0000, David Laight wrote:
> From: Dan Carpenter
> > Sent: 19 July 2021 06:38
> ...
> > Not related to your patch but this code is bad.  What it does is the
> > "ifname" can be set as a module parameter.  So instead of testing if it
> > has been set, it uses the checking inside dev_alloc_name() to see if we
> > can allocate what the user requested.  If not then set it to "wlan%d".
> > If we cannot allocate what the user wants then we should return an
> > error.
> > 
> > It should do:
> > 
> > 	if (ifname[0] == '\0')
> > 		strscpy(ifname, "wlan%d", sizeof(ifname));
> > 
> > 	ret = dev_alloc_name(pnetdev, ifname);
> > 	if (ret < 0) {
> > 		dev_err(pnetdev, "allocating device name failed.\n");
> > 		return NULL;
> > 	}
> 
> I know only root can set module parameters, but having one
> that contains a string used as a printf format seems
> dangerous at best.
> 
> Isn't it best to let userspace rename the interfaces later on?

Yeah.  I think you're right.

regards,
dan carpenter

