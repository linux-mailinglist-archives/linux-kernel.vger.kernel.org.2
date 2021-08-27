Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4D413F96CC
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 11:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244709AbhH0JYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 05:24:49 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:50862 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244624AbhH0JYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 05:24:45 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17R6J85L020879;
        Fri, 27 Aug 2021 09:23:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=1VwyDzYAIP4Z6HPKifSbOmhD3aEx/10wZvq689HRKFw=;
 b=b9r2ZFg7qnC2a70BNZE0SUFXspZxwMvY+xIiof/Kv7Rgcdlpd/uEQUHW2ftOggrIaq28
 9kz5CXFstKOWhzVoAIgt0HWWq+HgeTMEQfucTt1rtA7relW9jXU7GNyz4njqwi+ATN6a
 ZDRLXrd2xSg8KLA6rjREGfDZb3aLr/l1PhYzsK99/e0Xtz7Do9iahnZGbGvqO3jEd9ZB
 9eyMvcD9q5OCzXhmZEzp4Vt10SnQumVbrjHmIC3Q7ctGIkWEKDwLczFKmzm1ywN03RAg
 NTpIWx5c8960Z14aJCJ2mmnkCHU115g3sp2v/HxqxMsuTAJfnUrgVk3eD0jLY5wbVR6a Ow== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=1VwyDzYAIP4Z6HPKifSbOmhD3aEx/10wZvq689HRKFw=;
 b=mDY643KyUGlCFp7BTNwOxbseMWw6ODrkIybpGBlsoRLb8rPN38o8QpzkfzWQ+HJTVtTd
 mA5zAySFqaBwVyhV5yArxhYbvWPy/hYQuue7N0gkW9ISEntfwarlx7mvAvfTD1WCipP/
 XlT47GCI1v8Dl0imk4ZtmXjb1bzUL4AGuq9hrv0DRmXL1h8/1+yA+i/nEydQ3AV1y7iu
 C5Uh7v7NTcgHv5mGV1a/c+UG6bsrlRDrRimU9mAYNMWVnxu6D30O9rgCvue+x7wmocq0
 kNhgsydkGPRHU4cjYcEPfYjpqbn/FOrS1H0A16MolcJ+GJbrfjZ1jVxwHBsvXD9BIgsI 5A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ap4eku7sv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Aug 2021 09:23:51 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17R9FVIu085950;
        Fri, 27 Aug 2021 09:23:51 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2047.outbound.protection.outlook.com [104.47.51.47])
        by aserp3030.oracle.com with ESMTP id 3ajqhm922f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Aug 2021 09:23:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MCreoHNsMZ2pXZoEFZBX8wWpUXGz/99fiKSX564RMOfU2h32F3kXCLgrqOvLDWpUGOzwMyHr+Ix/YSfUi2yi1Xa4dBmsZ6TFm+sdoeYsIi/qBNXRqGszsBmtSKLGMZofY5V27ryClo61RRbqK+/m7EEFygSkbZbax9PGHmMBcmMuRMd3CbD4oO0yXbdHdOxzRZeZvmIwA60XrdONrFcHVQrWrvyQmeEg//IHXu8UfRJenXyQctahI43RyFaHG7yYlTAxDyZBj+8p7hNeH7FupKsk8DsCnnMJUcPE1a3crRD7lo7hBTSEmMQNpq7oitv1tBbBC51M3fnS8vLDy6jawg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1VwyDzYAIP4Z6HPKifSbOmhD3aEx/10wZvq689HRKFw=;
 b=acQv51TiDlyxeaxOFoySlJtWKdj/hvSSZuNVWK9umuYjdF9Er7DIfuHaQXUxmXBLUKsjf2kLHoVbCJjfjWWS2aEqnt/ap300quE41wmAQfgcuA5DE9/hh7pQPxEvDj8DcV2afusp4LjZ/FUFxXIKXlcu7DqNY0YJEZRBPQFXZ40fmhzNeUnn2wCTp9JAXH9gCkoXxvRJiym1UHpWk4KL8He+PsFbw0/kctgNQ7EKO4+6GacNLwYI0mQu0dVQ4IlLeZVQ6hTtqnTW5qdIm63Qw1SiT5F2n06sTcPLs/5BF+qM1vwSW8iTcgkwNZ5iYfrARgyV53YQ6cOk0b6RW2S58A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1VwyDzYAIP4Z6HPKifSbOmhD3aEx/10wZvq689HRKFw=;
 b=Wt++laTv7sQ0EknmuFuQe4r8jiX0+X7fdIV/IqewlqynXBtu62YcgSWqtHT2XBJmqeK1NnUF/y7+vHiCkOtcGnqVRb9nzNiOj10+7yvdVBtq1eXo08q6VexCyS8AhIZ7xUGwgtFwWUMQQYw8uUsIcoFSlvlGR7jovY1LaEpJ2t8=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1951.namprd10.prod.outlook.com
 (2603:10b6:300:10a::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.22; Fri, 27 Aug
 2021 09:23:48 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4457.019; Fri, 27 Aug 2021
 09:23:48 +0000
Date:   Fri, 27 Aug 2021 12:23:32 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/6] staging: r8188eu: add error handling of rtw_read8
Message-ID: <20210827092332.GI7722@kadam>
References: <cover.1629789580.git.paskripkin@gmail.com>
 <c59d5d850bf9aab208704182c83086609289cb9c.1629789580.git.paskripkin@gmail.com>
 <20210827090706.GA12231@kadam>
 <84e04d0e-8a07-aedd-117a-6b6337b865c7@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84e04d0e-8a07-aedd-117a-6b6337b865c7@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0015.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::27)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (62.8.83.99) by JNXP275CA0015.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.21 via Frontend Transport; Fri, 27 Aug 2021 09:23:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ed823ad-55d8-417f-c36e-08d9693c5fba
X-MS-TrafficTypeDiagnostic: MWHPR10MB1951:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB195116DC5EEBA7AB0C1FD5118EC89@MWHPR10MB1951.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DpaW+AFIE83SDtZp0ul6vOb170/iaXyyd2xgUq8bCzn3bHmgVsr0E59S8f+GafudBNIEG8yDyuFih3o7ZfBTFdSxq7Y1jKoFScchxta3eSLqT8yxkLJaimk1N62apGFtUoBAEIMtBiYNxBAIzAvbvhrno/lEQ2tS+cWb2HGj3w2w4eVqTkTLdH9gIO4NXPSrxKpcPtU/TL8asm8PllfnTGDEn4YOOgakPA21QFRVENpRncE9U0livgzQ4nsdpzi7iRR7MhJoq39cspKd/Q0PzjG9xR43u6brjNKy5123rvIEKiAXx7MXOrPWqQ26DsZ5A6QNjDd4z86EVPzPHMeEkPUrpAI6RYZu4SDLa77hjeyVJzFX1tQDFpeuA5jlwqLT2g8t5mPYKuSww+Q/HalK354K4LU51l2yNr21nGMu0b7sfwrQhXq5KrZzAd5TuvWmxhoj641jMKO+Y0SiAdXB+vCJ+Bg9+yXK2t4hCZ8NOHIHKC6WW1GoqFMP3d8638ARRmlXdDaSq+r243042mbHkAJzWe7nYdjD2Emc1+kPSGR06822I55x727RbE8gfg4fgPaNWQlzYCpaxaD+ljQXkDnvoxltuLQVW5akMtbZe9YSpPih/WjDPhBqBVOMH3ADQLMSbl4G39tPrVGZCvU6Xl9BbJZdHEezXotM9Ut59tkPxSfFw8yR23BuiCBynngeTkxGPGSDx8VD5PfWrcuoDQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6916009)(66946007)(66556008)(186003)(66476007)(52116002)(316002)(9686003)(44832011)(86362001)(1076003)(55016002)(956004)(5660300002)(83380400001)(8936002)(38100700002)(38350700002)(6666004)(508600001)(9576002)(2906002)(33716001)(6496006)(26005)(53546011)(8676002)(33656002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ftxxDZ9SDCbD779VTAOQRcR9I0B0yMH3K0Lhi0Mwnx3k7GMAJWcd9TzqNizP?=
 =?us-ascii?Q?vTIi7ETv1CD3SJ7j3M1ZnJJiROX7FxQPsQup+69HRG6PreTTMu7RAvQIzTZ6?=
 =?us-ascii?Q?SX4nSX1stxATaGuKR4xdqJ+XDkO5mEUYXF3ZmTicIvsgFAVKml3mn/GQFWLu?=
 =?us-ascii?Q?vv/jF2ZbF4CIeGyis3eU7Z+rr6M2TGy2hBYqpRUsvYVUYOTbipIq9m5Bs35I?=
 =?us-ascii?Q?vCfcPntr+LccFv/lOsD0gbAqVGgDqsljfHDqvr0L+VRYxV7T23ve1tlGzJRM?=
 =?us-ascii?Q?mzs49yOq+Qd8pFgU2yNBhus00tZ+V3PCw+KgT6Zp8K/eAXiBBlmDkDccWkr1?=
 =?us-ascii?Q?YuyUY9S/xvz1V4DRilpzTD5aCxmFuA3DRjjk2BnFI+2lqPF0HA0n1HJwpJOF?=
 =?us-ascii?Q?Lp5VBXrKna235APvk/68EiuZO7vVjlIILet1OhMNWan/2T4cfKLfBmCNxgOu?=
 =?us-ascii?Q?jWshz6pNmW3fqNjRYMaqklxS2/CqqKOZYI1aWTfSGPf2HBqkmcoZz37rwmFY?=
 =?us-ascii?Q?Czd7BBa2cZZYpAhYu9kBeMQ+YBJ58UWmGKRKcdk69K3pIZ5nZJ02XTCubc8m?=
 =?us-ascii?Q?3sPgPxplvrcbEP0N/dplBSEJqGyBsVaLfpAbBK9h5g4IKW3dy3QjwFcI5cZB?=
 =?us-ascii?Q?4StKHNTtmqxGIpYTnaR1B8JLq06ixUwEUoQgkVggP+qlPmCY7nA12HJNmCNE?=
 =?us-ascii?Q?VIJIG0ycYv14ROPc7ti9+sYOW5tPAWguZNNBnSIOSvNCFxreoAU+O4NMB1/I?=
 =?us-ascii?Q?t7Y4E71/9KgXLwqfhQ9iSydrxIETWpkfcOGlom0og8FudvXLW9wiDutJ6zAI?=
 =?us-ascii?Q?T4ZYOQPbT0Fk8Ta24Q0qnqyt2kKbVcQLZQYM7E2QaDGw8u7MLdB9ehbpGnqX?=
 =?us-ascii?Q?X0abLtv75W7JIiZvEbUsh2XFwqWhYeyQeSTYv8CEvX0Glx/qgpWfJp1M4R3P?=
 =?us-ascii?Q?iM40BKrdur42EWWcYaDSzqdJIJEVCwOnbYsOMfr9YeqOdw7kv1hU/vjQ0vOU?=
 =?us-ascii?Q?MY2RY9Dw3DcVsY8OM0YK2V5WxTc+KfgpC0p8ixn4rhALUqfyZGX4QKIygJyV?=
 =?us-ascii?Q?FZCmWs/m3OQCSWHlCyzUKC+/eQORsZ9o69dxsn5/L3Pz7XB6vBrKyB6Mcn1e?=
 =?us-ascii?Q?+uCX5l8ij+ue6lqzTiyU+vdpBtSILv65K00+YSkynY96AD+w5N5jzO+X11bX?=
 =?us-ascii?Q?q3YWC42U0z48nbG4I0yb/il9uFkAvl21FnzQJ21ttZ9o67rHaTB4gkuO9TZb?=
 =?us-ascii?Q?Ua+af7q/UtCSp0fem8RbtCBPMGZy7uQs0aBtLBAZ10pPOvGaMshHOjMdwLg4?=
 =?us-ascii?Q?B+CqTFR4qksQv2ubunUrRAUc?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ed823ad-55d8-417f-c36e-08d9693c5fba
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2021 09:23:47.8907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 12//6yMDgipF35W6W0C8ySdeTvcZTs9G8APOqix03eK9WeyXSdA7bp4dRsixSLKuCT94iO7+OxiPkDjzO9s4tdIyZB1U6CJwaYBvXz1IRxw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1951
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10088 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108270059
X-Proofpoint-GUID: X6zretUguUscmShRBHzwIpZtsV3lsf7e
X-Proofpoint-ORIG-GUID: X6zretUguUscmShRBHzwIpZtsV3lsf7e
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2021 at 12:16:25PM +0300, Pavel Skripkin wrote:
> On 8/27/21 12:07 PM, Dan Carpenter wrote:
> > On Tue, Aug 24, 2021 at 10:27:27AM +0300, Pavel Skripkin wrote:
> > > @@ -83,7 +83,12 @@ int proc_get_read_reg(char *page, char **start,
> > >  	switch (proc_get_read_len) {
> > >  	case 1:
> > > -		len += snprintf(page + len, count - len, "rtw_read8(0x%x)=0x%x\n", proc_get_read_addr, rtw_read8(padapter, proc_get_read_addr));
> > > +		error = rtw_read8(padapter, proc_get_read_addr, (u8 *) &tmp);
> > > +		if (error)
> > > +			return len;
> > > +
> > > +		len += snprintf(page + len, count - len, "rtw_read8(0x%x)=0x%x\n",
> > > +				proc_get_read_addr, (u8) tmp);
> > >  		break;
> > 
> > Oh my goodness...  :P
> > 
> > If you look at what proc_get_read_addr is, it turns out it's a 32bit
> > address which is controlled by the user in proc_set_read_reg().  LOL!
> > Just a giant security hole.
> > 
> > My advise is just delete this dead code.  No one is using it so how
> > necessary can it be?
> 
> 
> Yep, it's dead code as was already mentioned. My plan is to convert all this
> code to sysfs.

I thought this was a good plan until a few minutes ago when I noticed it
was a ***GIANT SECURITY HOLE***!  :P

I mean presumably this is root controlled but these days we try to
restrict root as well in some ways.  Even confined to root only, this
code is incredibly risky and bad.  Don't convert it.  Just delete it.

regards,
dan carpenter

