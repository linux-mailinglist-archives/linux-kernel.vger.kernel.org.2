Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6636D4114AD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 14:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238570AbhITMlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 08:41:09 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:36012 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238562AbhITMlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 08:41:08 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18KBOSXT012290;
        Mon, 20 Sep 2021 12:39:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=ajGzVh6MTgwCvda5mZtTJgywyYfokugygjr6NEwE21Q=;
 b=ZqnqahL9yh+Rk5UvAHu5Q4j5AEG298EkeRe8x+Sug2hQQ1TJ+zbUz1XhCuxDN2bhA5ZS
 nZ97SXETD+cHiUgJNa3IV12ATdvlbtdv7fCOyxvdj04TTqi7W8mnc6Y12Fpj16RVwI39
 ghnIkI9H5RTpbbc3RgBnRP3gSma6HWiT81bNN796mLNGprNNTNxEEdR9t/UL65ZYZBWr
 v3dVpUXGskXJjNN7ZO41Gd4p1aqCrkj71Uwe8xmPlK6eZ7mGABdyFh17g3LmFvMJlsh6
 9yTpagtf1ptyTsB6OpD/tTEpbRxIbL0rRnYMijm7Zeyts3Fg+fvHVtUWhUkbGmfVTM/D AA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=ajGzVh6MTgwCvda5mZtTJgywyYfokugygjr6NEwE21Q=;
 b=TvZzujonU1URMl/ANQxb7M+AdMzcyt7KSgdiJEX6F6eHc5fW4Me9a0cn0Zlop6AEjaa1
 uzITIKKDOt2uv/VViiGS0b50ZDoVPqa93BLRfpEiW6lAkOuvN5toihhnvOckHMIle8IR
 xWiAqVNDsTlh6negYR6QyGcttvPYuLyzrDXY9etD3u/zvYRMiniGRDynZYxIH6blcFAq
 q7NUB0kCYCGFl7uCrUnEDrd5I6LWuX8SxGfTpxwJEsZBTgCJafWjRWwXQd2yPuFlNAfv
 Ua0OYUo6G01RBz29eEpdhBPLzdQOKigfzepPbs6nMMF7MIHTIj1lCmAcOPT0uVHDmCpQ hg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b66wn2bbd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Sep 2021 12:39:31 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18KCZTJZ107138;
        Mon, 20 Sep 2021 12:39:30 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2175.outbound.protection.outlook.com [104.47.73.175])
        by userp3030.oracle.com with ESMTP id 3b557vfr37-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Sep 2021 12:39:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dtYGn96XwcwCUjKJ59e0UVwZDb+dl2AayMMnbRBCp0boWD+s2SwqFx66upo8rPEwBr9eseOhWEYvK0mJ6scmlVCVYxD0YlFEbFoWjt1TnlnehEBYCCjKTLvhjpPuii7E0l0lIBD9ap3/U155Ng90wcqBBpXi8E2CrEsXyJhL7valEWYWz30NxDFpkUMSzwtXWoTtM5sLzLIViuwvYLe157bRc1Ol/PtqUieQULh/C5+tMDUD4k4PJqQU1/GpBYgESjHR63NLth7NaELQiSCi7A8fmj3IdyTyvTn045FcEBemag7BSNDkDY/ftQLbD7Hyi6OrnQ6pMrcDRRxeEsBVpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ajGzVh6MTgwCvda5mZtTJgywyYfokugygjr6NEwE21Q=;
 b=l966ZVt0+UiIea03+kSiSj92NN1BQqwTUEkUct7sACwp384CYvr84rJgmlpElfucdMg6Dfz2Cc8crHLz6MVcRuuXwbdUFNiZuK9XMFi3lXhAXBaEIiwTkuMnTHPVxaMOL6PUEPrzCtD2YgTO4NtuNhVCmnB23jkCA/RkIWLzRu5MMc7AjpR0i7FhsF4NDwRXQBw3Y6t9VZE5bc2OlXyk1srE1dnPFaXPymR+N2gzcn1fLQSWw0NwfUI3GIJgbOr+ADk3BXDEooi7kJgyZIKG9bHJuRtbQluEWX32Cor+RTyTjvE6Bq2cAAgshn+KO61EqUQq55dTAza5AXwp2QDEIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ajGzVh6MTgwCvda5mZtTJgywyYfokugygjr6NEwE21Q=;
 b=JJzlRSN75p3pVFQPtG70rjDlgyKFuVGJo7FHhM5kuRaNWbQuMNwGJDgUVfeB4NuIXfdVVjZAuI4oODQalybU1mY1Qizj+SAZ/qmR2PfnQXH3UMOYnPJNxzS526Ond7uqUMFbKtmfv3KTxgmZdk93bX0dnuFtFjZCwK3RDcjRvBY=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4483.namprd10.prod.outlook.com
 (2603:10b6:303:98::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Mon, 20 Sep
 2021 12:39:28 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4523.018; Mon, 20 Sep 2021
 12:39:28 +0000
Date:   Mon, 20 Sep 2021 15:39:10 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Saurav Girepunje <saurav.girepunje@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        saurav.girepunje@hotmail.com, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, straube.linux@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: core: remove the function
 power_saving_wk_hdl
Message-ID: <20210920123910.GQ2088@kadam>
References: <YTub30ZRG3oLbxQW@user>
 <1651026.4NJzAxWbHA@localhost.localdomain>
 <20210920113221.GP2088@kadam>
 <2311011.CixZWWR6MO@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2311011.CixZWWR6MO@localhost.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0023.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::35)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (62.8.83.99) by JN2P275CA0023.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Mon, 20 Sep 2021 12:39:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cdb77d74-b0a0-464e-658b-08d97c33af92
X-MS-TrafficTypeDiagnostic: CO1PR10MB4483:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB44830C3ACCAE1B0958BD0CEE8EA09@CO1PR10MB4483.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uxWbiEsGlSxgDYPFdfRiZHWeOyANm72ImbK9FZZOaBgpVgnLk59BhtVOV7lS0jJRGBde5JH08Yhp6vtcvuqLRbMjVgLRgBnWQx0HstfEm/vgGs5kDvhCTr3/n3YdDa3V/EpSRLv0LGu7gJl2Uy/jP3twG9O2tk0WDu+QfOxZCt6q6eAHzi6i7GScMnoh2QQ154RStlEG9AxOwO+nZmdCsBgX05DXNNgUUOS1ofyB0Aps+pWvQThhMI1+kzqU2gAjkJDIJ3rZELE8P109WVVH860HKTZXqNfIdfJziPqT+R5i0/9kjas3fdfLrhfNvHYnbJt1sXEC4wE9mCKaKi4OxrMOHfatsvJNiB7SDw9VfcjsSNydhCqLSNRW79fs3d7CUYxfXWDiWKCQe4/NqhO8Dm5s4jplsXYVoLeWZPCJiwplWdnTjOJT8aVNMjiNrf2+CwdwNXW39jkjBZN4fcM/fwi6edlQyb/D/c6yZE5jsei9z2XSYML6BS5WiasprS0o1YnJ5Qnmt6e813KL0iaOvCa4q0//nYqGMEcxu+1hOajDmHwtuuzLMwmLX/9aslWkHuyn1RO+VOHXjzB/dw71FHdfLbKJV24ase7UV3G5WieHzu4C+Bo9kXpFO3oC1ET9VjHaZsOZvcsU2VS2iZchw4Gq76Fhc5erqUnYH3HvlSEtj4aZjj+thyJ11OU5IHwZE8pZglIOrxyoO2syRrDc26U8AcgB67j/VIvoFY1I4qoz85gaSPDEp5N8+UGc7PvhgjoSQNjp4MDfmGfkmeytTgF8o/tvC8Gx1syappJJFrc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(84040400005)(316002)(1076003)(5660300002)(9576002)(55016002)(53546011)(38350700002)(956004)(8676002)(33656002)(54906003)(4326008)(966005)(6916009)(33716001)(66476007)(52116002)(26005)(66556008)(2906002)(6496006)(44832011)(6666004)(66946007)(508600001)(86362001)(8936002)(186003)(9686003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zwCYRm6jru2zKzrAwxs7rYUcq2OxseR5UDDkgWNRO+1n0muMb1R7G8H7MJ4j?=
 =?us-ascii?Q?HBRAfPtLKWM059t1p9JB70Q0yPpYaLXGvv8yCTPczJ/+GP7q7DjkamHl+imR?=
 =?us-ascii?Q?8JY8uI4P+cG98ssHIAswki9GHpe/so0hCL+y/yYsSx9Go8fiZGuYUs/cCkr2?=
 =?us-ascii?Q?sORHot4xGtF1zzt2QZa+j7pdDZe+sCK2dvXOoZCXz5s95f5xqQWrlu8kmtkV?=
 =?us-ascii?Q?2bXQDVPT4LS+NAntmqHh2ocZkrxxkhmqgHcMwuEjxfrCftQ3WQtKEofKlAb4?=
 =?us-ascii?Q?D6xFozaKZrIgNbIYSqvMFoIsamk+fWuviQg23hK+JO0VDalCZZeg/6N4ha3q?=
 =?us-ascii?Q?JhChjgE/0reUQWty43Fax2FhEQ2XOufL6sNgqpcK3+H4+qltVBOtjvrPZU5a?=
 =?us-ascii?Q?TfNLrooM0Ai7+ikxP47VuOMqI7650+SJdBVbPHjcJZ0iUarIT4F+lOr0nL4X?=
 =?us-ascii?Q?a3qKv68FfysOOv7SseCPfEQyDWD25Z85ZWIPPvJ9ieHE2h1PWJL5yVMS1H+k?=
 =?us-ascii?Q?ajPdM8JNQCqkoYrda+j09CWluvvfKOlMVW2qBoDOA2NZnQzzhBJCkfFYd/tJ?=
 =?us-ascii?Q?JivS79SerqXzKIY3J1YfTV6McDPlPRpRZkZLdrGyfSntXhA3cgTF7InnEx+Y?=
 =?us-ascii?Q?aHRpA7vEC9XXGzy1g4Wv/agFjjqSC7855y+cnKBpDMzsNaP6wkOdjzmAs7mz?=
 =?us-ascii?Q?7nSORkLyc0BaHFP3gQypJO9ED3eBOmds6RSu05X4B5sM0DwO5fSdPBjEc6IH?=
 =?us-ascii?Q?ptq3ttMgTjnfqk6t7GtpM8zokA04LJixl6b6D2sqSZ9ShVkHSkis0ktLbjc6?=
 =?us-ascii?Q?JQBCyDIghpdt/P5g9PYdDC4edWcm8+zRemnmqURE9C+kIzRh40gvsBLwEKc/?=
 =?us-ascii?Q?QYN5Ng4a+hjpp23KSsoN3lCXY6MHBOqU/lZnHZtp20GKXuxOrxk553Sq101L?=
 =?us-ascii?Q?s9R/ihfF9c5UJHahSjj6IaE+fNvrEQYgJO5crxHxRVC1DAMukkXcEgXRSkU4?=
 =?us-ascii?Q?5ZSv9gNQ5r4TntLni1uPc4kCOmPuInJGFvOeoxXZk9GVIWBKcVZNuoEbPfqk?=
 =?us-ascii?Q?4ERzcFXHNczWHQEbFn6NVdx1QlFlfsknXyMMg/9sgo/RQoO6xMr5lnGgTPop?=
 =?us-ascii?Q?HxjGQhaeCsFm+DcFiysz6atzM92/1ppWypFuJxfBTlajXdA90xF5PCjf3JQz?=
 =?us-ascii?Q?uRhX5epO23tjHeMOoKJTNCMw3jvsQa9Qww2Sv0+VFwl0TAC8/LKEuJdI6u1i?=
 =?us-ascii?Q?IyV/xBvxmAguJl6jxWB55xSEC5U5Zxinm68HTg+r54IEz3xeUl9ZZr1j1dIi?=
 =?us-ascii?Q?iNGiayWviYGk0k2NyZ2ShXjl?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdb77d74-b0a0-464e-658b-08d97c33af92
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2021 12:39:28.1938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ym/rSAPZzKR2cFldU3FxW8LRGTCSGdIA6MONh8t5U2t2+9d4nMQpP073r+3O8WX0DDOHS+XR3qolyCrbB1RaXSH+VDR3QpsaJqMYzamE/9Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4483
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10112 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 spamscore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109200080
X-Proofpoint-GUID: I5OevqWM81PK5YHZEf8in8PCoisctMfY
X-Proofpoint-ORIG-GUID: I5OevqWM81PK5YHZEf8in8PCoisctMfY
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2021 at 02:31:28PM +0200, Fabio M. De Francesco wrote:
> On Monday, September 20, 2021 1:32:21 PM CEST Dan Carpenter wrote:
> > On Mon, Sep 20, 2021 at 01:13:54PM +0200, Fabio M. De Francesco wrote:
> > > On Monday, September 20, 2021 12:36:06 PM CEST Greg KH wrote:
> > > > On Sat, Sep 18, 2021 at 10:52:50PM +0530, Saurav Girepunje wrote:
> > > > > 
> > > > > 
> > > > > On 13/09/21 9:48 pm, Greg KH wrote:
> > > > > > On Fri, Sep 10, 2021 at 11:24:39PM +0530, Saurav Girepunje wrote:
> > > > > > > Remove the function power_saving_wk_hdl() as it just calling
> > > > > > > the rtw_ps_processor().Instead of power_saving_wk_hdl() call 
> directly
> > > > > > > rtw_ps_processor().
> > > > > > > 
> > > > > > > Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
> > > > > >
> > > > > > []
> > > > > > 
> > > > > > Also does not apply to my tree.  Please rebase against my staging-
> next
> > > > > > branch and resend.
> > > > > > 
> > > > > > thanks,
> > > > > > 
> > > > > > greg k-h
> > > > > > 
> > > > > 
> > > > > Hi Greg,
> > > > > 
> > > > > I always do rebase against your staging-testing branch. Can you help 
> me 
> > > to
> > > > > understand.When we need to rebase on staging-next. Do we always need 
> to
> > > > > rebase against staging-next..!
> > > > 
> > > > Yes, you should.  When you are working on code that lots of other 
> people
> > > > are working on, there will be conflicts like this, and you just need to
> > > > stay on top of it.
> > > > 
> > > > thanks,
> > > > 
> > > > greg k-h
> > > > 
> > > 
> > > Sorry, Greg. I'm confused... :(
> > > 
> > > As far as I know, everyone here make patches for staging-testing.
> > 
> > Nope.  It's only you.
> 
> And Saurav (at least) :)
> 

Nope.  Saurav is working against something old.  You can see the
#ifdef CONFIG_88EU_P2P stuff that was removed in commit 102243f893ec
("staging: r8188eu: Remove conditionals CONFIG_88EU_{AP_MODE,P2P}") was
applied.

> I've been misled and in turn I misled Pavel. This is due to a guide in 
> kernelnewbies.org that explicitly says to use staging-testing:
> 
> https://kernelnewbies.org/OutreachyfirstpatchSetup
> 
> In that page the is a section ("Set up your Linux kernel code repository") 
> which says: "[] Then use the revision control system called git to clone Greg 
> Kroah-Hartman's staging tree repository: git clone -b staging-testing git://
> git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git".
> 

Huh...

Those aren't *bad* instructions.  Working against testing-next is fine,
but just be aware that it can rebase.

regards,
dan carpenter

