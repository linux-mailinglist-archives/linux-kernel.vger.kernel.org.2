Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3220E428AF5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 12:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235974AbhJKKoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 06:44:20 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:64388 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235792AbhJKKoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 06:44:11 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19BAK24a004474;
        Mon, 11 Oct 2021 10:42:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=E5YWr2t5faxwLm84dSO5O53oWLSC9cDseyqitoxR7E4=;
 b=WFJnGalXLVGwvINWPuuXJGRc16AB2+vLftMvAcFsnLAH13K989Axy8erP9F/7X0+BRQS
 pqkdxSqn4fcTTCxVmflvG0RIw06+cNW/LnWuYbni58kBMyDw4WahLWIlxqd4+IpAgWbf
 CowP56yGxyExJHQNy2hhi+AKQGZTv1lBHeZUx8cft6EzMc0M9iCXFVte3yIc54tg2ffj
 CCav/wt3sb8cm+VqWbZSBj5vpVaSFgj2ViPkE+ZVHdisPbkaPwx/ebiDahufnu4IXEto
 ND4L61FnLqu243D58D2Xz4j1uqWp031ZroKysUfyJ5OcXXimEb1W/truacQIjFEV+S2y Pw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bkxs5b9y8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Oct 2021 10:42:05 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19BAf2xo025024;
        Mon, 11 Oct 2021 10:42:04 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
        by userp3020.oracle.com with ESMTP id 3bkyv81wpt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Oct 2021 10:42:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kfB70jxZcDElohhVwQ6l6shBp2cUEIn/BpMd9SobacUqk35pT5AEeE6/b6nO08WW7glQD3OUNgT4TMYEQsPOXiuT+zQSKPz9mnbPkJDMhM/t6WYQz6avuLXCMseZAqr0bqZixGA8wPH3fsniiYLlCyuV/6foLl7x7z7WSBw69g9EepUrZY6Ch1dXwS4Lj9HKXO55aF4opIo5OLldGp07btEzlj/Nq6BMnMmayo6zQQyhfxGpC6pskTNI4ConE4/cc/0zyH8l+d1Njzl81BAl1vYQMCpPLvmFHJefwZ2myonsA21ZJvouBZFQJLGXEi8Ib/TgwgIaVHdXrZ2v578Dxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E5YWr2t5faxwLm84dSO5O53oWLSC9cDseyqitoxR7E4=;
 b=E8rR8aqkJaLpbZza+HWKrhgPQXkDYvyxm2TGG/sAhW7p/05jISV3YVG03FbHBA7PXQpNHiHsk35MUGPIR2czMf9krsA9nD0jDTBhbOvJtxx+aI+Luc9AA8Jwtd5i5X3GnzqjjhFrK2ET1TewSyk0VFoISCBXJmkVv6hKXE3SaEVq7vbWX94p2B8lD5HJjt76Z5WwIstZLJWpOnAgH4nZBkTlYud0W9LVmXfRuFIvMFSrwZwlYv0IzzOUiKL9IQHG15sEOYC1focmf1TuYAuQS5fEhBVcmuGcaMAS0cCCnJqGhWGlIMIcniGSoj8tgyze3O21x+PK6r56d2YJZoCbHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E5YWr2t5faxwLm84dSO5O53oWLSC9cDseyqitoxR7E4=;
 b=fmk8zJzlA1OfmSj3ZOr1hw8FHWcYv0+SNpHqsGICymzEcgvIPpV9NhG4pX8LAttGmhGMilIYBV63Zyzo30hMSdRJrZhAk8WF1rYlBnxPMTR3gQOHlHqS7tSOTNQB0ZCWj+bb+NzBJ12c6RaPXe69op6vOBSnTzFYJZNzWXgY7DY=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2127.namprd10.prod.outlook.com
 (2603:10b6:301:33::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.25; Mon, 11 Oct
 2021 10:42:01 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4587.026; Mon, 11 Oct 2021
 10:42:00 +0000
Date:   Mon, 11 Oct 2021 13:41:41 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Saurav Girepunje <saurav.girepunje@gmail.com>
Cc:     Fabio Aiuto <fabioaiuto83@gmail.com>, saurav.girepunje@hotmail.com,
        gregkh@linuxfoundation.org, marcocesati@gmail.com,
        lee.jones@linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: hal: remove if condition which is
 always false
Message-ID: <20211011104141.GP2083@kadam>
References: <YWKXKGuA/Io9sEjf@user>
 <YWLFf1zPvK9gz+7+@agape.jhs>
 <9dca9f7e-f987-5be5-9523-7dd08c2b364e@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9dca9f7e-f987-5be5-9523-7dd08c2b364e@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0025.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::18)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (62.8.83.99) by JNAP275CA0025.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend Transport; Mon, 11 Oct 2021 10:41:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d71516a9-7725-4e2f-d2d8-08d98ca3c189
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2127:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1001MB212709DE6ED36CA26E8790D78EB59@MWHPR1001MB2127.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YdQGpVu0Ut2qd5N8Q1GgQCfOCGiFe6uv1SXIakoaNsF2blRLt571D3XtMficr51PTZDcNATBdIgjbjCv6LjhFvq8N8BKfmsqhOfMFDMH8eeTUyGRCYuTq9KD70K10aJqZec+rIqO/+l1RIZxkLKYT+sD2Vzp0McUvMShuFgywn1NEd/2q/s2wa4Z/zlYOnlBqk+MseukjKjNs2/e7EKy7OafzGOebfK46OzJpfBfLsvFEH57HCPYcVNmXK1zqy+USKS/yolFe9spskGzTvYUi2vfXxlK8kag6apqVJMufyn/H2RPrH/F28lJhohihe7s/CE9Y7j5Rh/AQhlBOzxHZZc769FHmd6dl1N50pcmkolAuPkd2zoVmszDR/JuTTdopZ+ruxA78XtU5ABWMnnMCZNcCUUDRmJG7v4l5xK7iQpwT3rIbM2iDVadjxnvRP00UbLZncTQHEX2lw8ag/KUWNwdox4GuwtUImtQzLpIlB7xOXDHOaiCtalH6iXax29F7CgcprMSy4DaaI84LZgyyvbew1ppNNg/D6SM7y11VetzayQDeikUn4r7WQps1T+bp5Jc0nt2amayzy3KZesFWy1zWxUsBT3PWck4HqOjypWdA1gn3YhrOsJl/s+QCfKHMORYRq+f5qO5G3CA24FpUuSsoqAfmcjBsFc8MptT4RSgBbYsfeRHcmgyGXeC4+7mdWcylRkSrlrZKc85qFP1xQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(9686003)(956004)(55016002)(26005)(316002)(4326008)(83380400001)(6666004)(9576002)(186003)(66556008)(86362001)(66476007)(66946007)(5660300002)(1076003)(52116002)(6496006)(8936002)(33716001)(508600001)(33656002)(44832011)(38100700002)(38350700002)(8676002)(558084003)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p68/fJBj6u75CgtfmgRR9/x/sXN3DMIrgrklEH/Jfu2ycD9juzc7PdPOaMD5?=
 =?us-ascii?Q?T/D1E6iatL+TtUVmhzDRxdZpm7rjZj90/bKAMnznsvX1uLUm3ByliPJjjDBd?=
 =?us-ascii?Q?xImepWzQMeqkznRQEB/dvB/zrauFFAePwiA62iqqi9mcDZWmHhBjkxa2+UHM?=
 =?us-ascii?Q?vH2s85f+Z9zQCsoFi4XV0SdlBPhEZRmbXdziKCpBPaYZB5Dd12OQ7fYWaouP?=
 =?us-ascii?Q?Se8qFOJfLx6ouiX7IB/N0BYJR4rprWFLckN7JllzdCTg4DgLlo+PHtpePD6k?=
 =?us-ascii?Q?gxQqu5eOoDf4UurGrCmei9BwzdGG1pNMXrLE3mJ72Q4AfQrWgAb7mFFzhnEd?=
 =?us-ascii?Q?K5hVac+6sXkMF6Y6+k5knMfDTKPrDOBEbkbd0KB94Dhvgmm4b22VpN6CD/Vp?=
 =?us-ascii?Q?rQy1KWZHD3XIoYzXqYG+FwnMUAD0puqBif8xvnM2HHY15YQLgrnZs5xl8Q1Z?=
 =?us-ascii?Q?Q2u+2wiBtE4wENyNIcngGbLs2IPCBdLzRR7GNgeNzsSfe6PSMcOmaQlhTme4?=
 =?us-ascii?Q?3QxheApZbZjdCI0ec1Awru0mPwheNS43CYPJQqsEx4E6XQ8gr/2i8EbMdj0K?=
 =?us-ascii?Q?A+q4h8db0g3mWt8iZ6KRtj+ApE1ldTutElowa7nTplc0LuZ27GoO+IiShLAj?=
 =?us-ascii?Q?5WzRUJLOjIIQ5DPO5dVyMk3g6PZ3nTJxtvcCLCvZSO5wkK+kArCJfNZV6ikt?=
 =?us-ascii?Q?xFWRLbPB4c41nJfJ4KwwRz0sGazWX0zZw+AMsNU7gBGPFSeb5pF56Puz+03R?=
 =?us-ascii?Q?1xHzGe+Un0sFV5vJkbWvhIRCSp1NnvQRT1lqtYogPVlULN+f7MGiImT6qfzT?=
 =?us-ascii?Q?IIViPOOu3YRSMGIyHlAKybryLsQGaxBk5c1v1Mf/SP4zJ/ht2nH5+bvet7NB?=
 =?us-ascii?Q?gmZXZ+Yy1+vevpzBOqzPeCzYXfOyhEXy1/ZZbta/I8iLeQ+DIiEU6x/aWZ4U?=
 =?us-ascii?Q?jWhNpCr3KIXDenQqJfiX24YvhEsw9vrKvLO2BhPZLAtiSmwOvp8q1GTRvWpH?=
 =?us-ascii?Q?21kpcmyCtdMfdyEjqxco2bgIAtXZ8THZp5U+T+tzSgyv1ixz8Ucya8bMIMgM?=
 =?us-ascii?Q?wQvs/EPdI+iD0c6HhLkcOeN8a5xEQhiKmp3ZsuYe31101A73X9K5lE5vxmTb?=
 =?us-ascii?Q?61t4UEZ+AJIvMQ18As/tN2/AfuFvnBj3IYH8Cm/TQuJCN+hVOxoJadWOo+67?=
 =?us-ascii?Q?QzIq+8hrvSMUdauZZMqDsktiYdd/uVtUgjvtq4F39+jDtHbTaTeNvs8FHSuT?=
 =?us-ascii?Q?nvTKM9dFwdgQbUtivvNYTFcYy4Xwsk5Ogvb1Ig0Amgd006Ht7E03lNZLTIxs?=
 =?us-ascii?Q?jexDttJ173/0+P8Mz5GRX2fZ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d71516a9-7725-4e2f-d2d8-08d98ca3c189
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2021 10:42:00.5957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qkLUnckGX0jiZoBxNztEQYnpI6zM+ztb3OGYX7pqVaKlVgF0w5y0nwnVyUWRcPZ/UtEqVv0iqwtxMsBo7EDS2M0dxzpPeh/PYD22MFMAtz0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2127
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10133 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 adultscore=0 bulkscore=0 mlxscore=0 spamscore=0 mlxlogscore=901
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110110060
X-Proofpoint-GUID: YATX1ribNQrqECJIfHPwEpHI4pLJJqZ3
X-Proofpoint-ORIG-GUID: YATX1ribNQrqECJIfHPwEpHI4pLJJqZ3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yep.  And please go through the function and clean up all the references
to max_rf_path.  Change the "max_rf_path = 0" to 1 and delete the other
assignment.  Delete the comments about "max_rf_path == 2".

regards,
dan carpenter

