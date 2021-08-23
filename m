Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80FBE3F46B9
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 10:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235681AbhHWIho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 04:37:44 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:7546 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235594AbhHWIhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 04:37:43 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17N8TMXd021828;
        Mon, 23 Aug 2021 08:36:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=+o4ANzrsZz+HzxoxTUEXEByptZ9woSNqlKhBL1SILUA=;
 b=QeGOkVTpBaiPzKXYJsEalM4pzkXXB/bs9904n4pnZ/mk8oZVTG/xknKWGxI1RBYhULFg
 jf4bmx4QTfgFmVPxvEgTIudqVaymmZ8akBq/haf9jlS8OQZ9bHNaNJVyrtoslbZ9/bfv
 LsBGFCWhl9w10Syy+xwsZM259u/unWrr/lVljo2F+2aMJOFckaE6U4thcFJtV0WVQ6qr
 LE+6DQ7YFYTBX3+84y8TsbhpoM7lpF0RqGp28Ji4DBeAh/3f0aJF2xRbX68XaOj32jjQ
 LtOlZIg6HW2awISq/oncZY4PrY7cmMf6QnjuLc5SjuIpN8crcEbHRLMsDGkten4+aGQD Gg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=+o4ANzrsZz+HzxoxTUEXEByptZ9woSNqlKhBL1SILUA=;
 b=uNy6lbt2+Np9Ot+bbL0v8PbW/bvNxF5tUQL3cXk5/1JpyLL2o1Sejr6COwg9Vo9CIpoO
 0oKRVIMt/Sl6axZoqHc/crYPvbZihaXoA4HL9/8pB5QwxI+3Vh/Y/uTF7qIe78enJIg7
 TzEFFbFs33JWObEJw3eTZrdZyiAODGcNCA0Fm9pIypC9+l9INjZx86JFoiFqhy4PAFGM
 f1qVFyRwrlsfIk+SvQugWJ0lztYjFv5on5EBHCC8oyke+1KSepXceb9CRkTGJvMGylGH
 XkL0dBq2gapK/D2jG1ThYQe7o2RdIW92SiYHI6taMD12XdIIQ+srHnqz8ysBjyBd9KUd IQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3akwcf8sky-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Aug 2021 08:36:54 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17N8VBUR026411;
        Mon, 23 Aug 2021 08:36:53 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by aserp3020.oracle.com with ESMTP id 3ajsa2yjjm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Aug 2021 08:36:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pq7fCIF5ktzW7IImVWV+ZPOXrHxwXHg/eu7gO/tWtrBZvhqmdUmkktWxmJkqdPBAP/O+QU9eoEtOekJqgYXlsAYnhhfi36E9gI7JIunlPGMJSlRXYk/5e1g6nmuvolXzcZ9OwW68HSZD+tPDBkdp2FMTGtmVYIurnVHZmz93fmsvwoZcYTAGXsvDbPSckiuXJw53MWhSxDT8bhsV+mpV250K7iGFgw5t/VUr0me7pKcQVjenvzF7LFqZLFTdXv+gJw5Gd7k5+Fi3okjyHvMHtlQmqNovLIpkT4WuZVAu2TgaJyXIgjiZBjDHxZsGGdbCXrTgILUDKL+CGuvCUME5jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+o4ANzrsZz+HzxoxTUEXEByptZ9woSNqlKhBL1SILUA=;
 b=PPQ/718Wv2JUktHNz0TJghthWyfCir+aNiywxZUGQYVac561EfkmTJygE4EE1ppAVuHr0cys6ZiMyaxlENVcZvyyMdzHyrHPSnrVPAHRc6pQrDMad/pgNpXaaf7usGwBE5et5l5CddLTQhqNVYGGY1um14BZY35KCDcPZTmw/67rJ/bRsemXYwq7d1E6yX9BtHyQ2AnFQ+2xWOI4DTOajeEgebX+NkyRv50ALVx4vPNNvnlFtjTJRMnVHdc41EdG8OqRbNB+alX3wHO858D39x+Q6nGfeEjGWvJXw3dS01HEtc2/bWHvhZ8B/IPl0Hf8BqFOYpR8ItwTagsD6yVbuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+o4ANzrsZz+HzxoxTUEXEByptZ9woSNqlKhBL1SILUA=;
 b=vn+yWQuZILeieBLfNhK9ioRC4SjxZoW9ZvBrKnZde+Ou40wr1n5FbttKRmlHvySg2VwmYRC4SWec6ncP5LPtll5t/6IT1OvWdFL9ZB0Lxe/NsQxLNWYilGp38AuWvyKkZX2+qOPVgHcmg5ZzXTwd6A878t9qWRfPrmt1uCe+2rk=
Authentication-Results: lists.01.org; dkim=none (message not signed)
 header.d=none;lists.01.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4434.namprd10.prod.outlook.com
 (2603:10b6:303:9a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.24; Mon, 23 Aug
 2021 08:36:51 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4436.024; Mon, 23 Aug 2021
 08:36:51 +0000
Date:   Mon, 23 Aug 2021 11:36:38 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Kishon Vijay Abraham I <kishon@ti.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        Bjorn Helgaas <helgaas@kernel.org>,
        linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [lpieralisi-pci:pci/endpoint 2/8]
 drivers/pci/endpoint/pci-epf-core.c:169 pci_epf_add_vepf() warn:
 inconsistent returns '&epf_pf->lock'.
Message-ID: <202108181550.NrTSW4nu-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0024.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::15)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (62.8.83.99) by JNAP275CA0024.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.18 via Frontend Transport; Mon, 23 Aug 2021 08:36:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 05295ac2-c34f-4c13-46fa-08d966112753
X-MS-TrafficTypeDiagnostic: CO1PR10MB4434:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB4434CBEB1D64A35FC78C47908EC49@CO1PR10MB4434.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:67;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iCxVPXh40KLnoj8Iqe/cniaavh/f2+q5pPOu/T8YhRdAsdKRGum0Z58lR0XmjgxO6rD5UN7xRFREH9bZqPkhayGYEMlfKdAp3k9rADo9MLIzOwTvLoXKJeaetyAME0n34/Vk1t39t0rU2qotM5NbsXC1OMP0ecCS/e93g8yFFWrN72rHnROYWLaB81uscB+nBg4F0iR1xBUioMroI+URZbCc5RKy9o1uemx6wDpA4mZytqJjYRp0qBqzNk+6+jeGPH8UN6O6F2fdF6klr56h/3/BiSpf20cvFdYh7AYYWirbxhDQc9yX5+TVuRI0P8c6pTEtrDFq+rbnPV4ysKnuTClnEq22S73+kyiQ/XfDP9pRQRkNDC4/JtYiDYy/TFJH6ZjC5kw11AZZY4LQoj59jzraLVh01DhrrjN23M6925CnrrgNS1o0Po6XvZ2DzsYl1jVzJAxd5HkiZVgX2byyqRlTx7CEGjOaxjbU2FME8x7IsMeYMCyISt/BOD+PZZXJ+Kn5NGaKg5WFte63Rjt8Z+SJNhO2l5a63pPXwVCA/bUqR4fvzBFKe+SgTUS1E4zLJRfYAop1UrKQcb8d6cPp4FDXIdL+wYp+pDCWYZZJlNmLbUwZq9arPrhMqQGUE6A/O7DRCfHdRBEe2QxosN0xnSFOzdI2NDgM1aZZsDK8iPvEkenxbtOnhioIediLAvwcpECAI9LTHTvD/bKfhLn4tock98rtSSC6jgtAQJJGeWKIW9J0XoYLUc56S3IoC2fEMcLuCYncxhd0h1qfyOgv/cogrE5iRGaC/DJ6JhH6PAiGGObsMU9fiT9+wrhTJdZ13PwtOl+RiFbQxElPMS8NLQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(54906003)(66476007)(26005)(66946007)(66556008)(2906002)(5660300002)(6496006)(8936002)(6916009)(6666004)(186003)(36756003)(52116002)(508600001)(6486002)(9686003)(956004)(316002)(38100700002)(38350700002)(966005)(86362001)(44832011)(83380400001)(8676002)(1076003)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rVNG/aZjzLgUcUlR7ahw2SrrTO+oUrNzWNmIAuREjjFXSBVkHJ+fTXO/ikT2?=
 =?us-ascii?Q?sDA1ygh/eDnKWotxnn/34xGJSwkEC7qOU6iCvaF22+DMiODvW/lWnDYAQPRM?=
 =?us-ascii?Q?BhD18JLPlEeTFcjnvFffQYM7PNYyBO2beROQxTEruKMgjNylW56KpaIvpcz6?=
 =?us-ascii?Q?Ve12pU86MYUn61HybEn218uE4Vl3KvdjZSUHwdHO5zHpa6hkVYuIQcpFe+hn?=
 =?us-ascii?Q?eNK17FGpuLztjUspXbUDKzbLfeLkZ1vOkYnHfNkTDJvpOoI7vG+40LzgoSvR?=
 =?us-ascii?Q?xX2qXvns1VSUQmFDeqwxVTjWCunb8Sf0AxpUtRO2WRe57swKp/Laqx6kQhYs?=
 =?us-ascii?Q?hkCiGhqr4e5bdEkTdu8dY3cJqCI0Dj06LLRociCkM2fy8ioohYLmqUqMlUMf?=
 =?us-ascii?Q?GJ9on0kuj89hftf29QBtQG1ycW6YgO//A32REhFkq8H+6Tx4KAqVnN+rFMz+?=
 =?us-ascii?Q?9IJk83W4rguxHzqUtwot9MLtnHCVA3UqPWx/a0RcL7FpZjmfCMflq7rhU0SU?=
 =?us-ascii?Q?ViihvWJcdvrG6GMuEBGXUW5dZegrXcYj2P6ouUiUlxcFzeXyMOM/KloKyRRq?=
 =?us-ascii?Q?RxtOI7fjs5lX4a6nxAN2WWN7e1ccgkWgqp6q7CIVbu1m2wRJoMMpdoVJWt75?=
 =?us-ascii?Q?BbDc+zrsFtyDpiFO5OcIg3PeE1Lr89dmR0CtjYbyaCbu0NlsB6vs15T0pyjU?=
 =?us-ascii?Q?MyGhhIqsQOCGbLCAzWNBI04kneeRRORXAYgqQlzZ+mtrO1MfUBNevhpFpPZB?=
 =?us-ascii?Q?K7IIJR3l+9Ur1Y5qTOOsJo/RhIPhn/8yDgiongVgg5tIr+nzpqneHgsPYrLN?=
 =?us-ascii?Q?QZfRupc4GKnbe9d+UBN+uP4PKSW7k1q840D+pgFzoIP75GtoHNg4mc+zkKM5?=
 =?us-ascii?Q?yx+8DhTetbjM1eMHQyL5eyqGOfHeiMMgwLZf2tUaI447Kq5BmXjd4Rkis8rl?=
 =?us-ascii?Q?9mWoEFIxSqvssSbUHVkOBgGIIsdF5uUVExwZhD326wvNO7W030nUSnaAnUFV?=
 =?us-ascii?Q?YLfTgo4RZkH4W75jBcfRCqzfbQPGa4Ag1PiHdc23fVzp5+7Z+zM5kmLf439d?=
 =?us-ascii?Q?Rx6AsentwT5IvYaXp7auv1bsqyxxx2AQVh0S30CObWnPEddbmrZ3V/j4U+mo?=
 =?us-ascii?Q?br+4y3LeXdwlpSETdAwxskVPQ8GVK1FNUdvPvXnF5Buo0ruOsmHrmcF2w7xx?=
 =?us-ascii?Q?e7OEKOzFEdc2pqDwDC69DW4OcGELfTYDiAAUNaG1hDZGMv7pmUQU92YkUEsa?=
 =?us-ascii?Q?9KNsmBlgTvHepErcGTr/zPu/mRbJGAjgokYZq8gh9Ao5fef4bjqchxURp/Ka?=
 =?us-ascii?Q?0KQ4dBAHhTbRBRzpJ0ZessIC?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05295ac2-c34f-4c13-46fa-08d966112753
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2021 08:36:51.1401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ApFIuI016c4rSyVufkRBCw+vQN8g7B5VbKNsQZJtkQTtZG5AMy5v9393ENF4RUlRVpJVL3OXtEiKakTQ4pMpY6E7CNK6BozvaPTKE/CdbuU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4434
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10084 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108230056
X-Proofpoint-GUID: qaKRDq4fVWlq739EjC2_IR1i8LFQox8o
X-Proofpoint-ORIG-GUID: qaKRDq4fVWlq739EjC2_IR1i8LFQox8o
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git pci/endpoint
head:   805ff686a143d77d44ffbb8e34ec3c08e65cb6c4
commit: b64215ff2b5e9fef9208ba652590c51631a0ac1e [2/8] PCI: endpoint: Add support to add virtual function in endpoint core
config: i386-randconfig-m021-20210818 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/pci/endpoint/pci-epf-core.c:169 pci_epf_add_vepf() warn: inconsistent returns '&epf_pf->lock'.

vim +169 drivers/pci/endpoint/pci-epf-core.c

b64215ff2b5e9f Kishon Vijay Abraham I 2021-08-11  141  int pci_epf_add_vepf(struct pci_epf *epf_pf, struct pci_epf *epf_vf)
b64215ff2b5e9f Kishon Vijay Abraham I 2021-08-11  142  {
b64215ff2b5e9f Kishon Vijay Abraham I 2021-08-11  143  	u32 vfunc_no;
b64215ff2b5e9f Kishon Vijay Abraham I 2021-08-11  144  
b64215ff2b5e9f Kishon Vijay Abraham I 2021-08-11  145  	if (IS_ERR_OR_NULL(epf_pf) || IS_ERR_OR_NULL(epf_vf))
b64215ff2b5e9f Kishon Vijay Abraham I 2021-08-11  146  		return -EINVAL;
b64215ff2b5e9f Kishon Vijay Abraham I 2021-08-11  147  
b64215ff2b5e9f Kishon Vijay Abraham I 2021-08-11  148  	if (epf_pf->epc || epf_vf->epc || epf_vf->epf_pf)
b64215ff2b5e9f Kishon Vijay Abraham I 2021-08-11  149  		return -EBUSY;
b64215ff2b5e9f Kishon Vijay Abraham I 2021-08-11  150  
b64215ff2b5e9f Kishon Vijay Abraham I 2021-08-11  151  	if (epf_pf->sec_epc || epf_vf->sec_epc)
b64215ff2b5e9f Kishon Vijay Abraham I 2021-08-11  152  		return -EBUSY;
b64215ff2b5e9f Kishon Vijay Abraham I 2021-08-11  153  
b64215ff2b5e9f Kishon Vijay Abraham I 2021-08-11  154  	mutex_lock(&epf_pf->lock);
                                                        ^^^^^^^^^^^^^^^^^^^^^^^^^

b64215ff2b5e9f Kishon Vijay Abraham I 2021-08-11  155  	vfunc_no = find_first_zero_bit(&epf_pf->vfunction_num_map,
b64215ff2b5e9f Kishon Vijay Abraham I 2021-08-11  156  				       BITS_PER_LONG);
b64215ff2b5e9f Kishon Vijay Abraham I 2021-08-11  157  	if (vfunc_no >= BITS_PER_LONG)
b64215ff2b5e9f Kishon Vijay Abraham I 2021-08-11  158  		return -EINVAL;
                                                                ^^^^^^^^^^^^^^
Needs unlock before return.

b64215ff2b5e9f Kishon Vijay Abraham I 2021-08-11  159  
b64215ff2b5e9f Kishon Vijay Abraham I 2021-08-11  160  	set_bit(vfunc_no, &epf_pf->vfunction_num_map);
b64215ff2b5e9f Kishon Vijay Abraham I 2021-08-11  161  	epf_vf->vfunc_no = vfunc_no;
b64215ff2b5e9f Kishon Vijay Abraham I 2021-08-11  162  
b64215ff2b5e9f Kishon Vijay Abraham I 2021-08-11  163  	epf_vf->epf_pf = epf_pf;
b64215ff2b5e9f Kishon Vijay Abraham I 2021-08-11  164  	epf_vf->is_vf = true;
b64215ff2b5e9f Kishon Vijay Abraham I 2021-08-11  165  
b64215ff2b5e9f Kishon Vijay Abraham I 2021-08-11  166  	list_add_tail(&epf_vf->list, &epf_pf->pci_vepf);
b64215ff2b5e9f Kishon Vijay Abraham I 2021-08-11  167  	mutex_unlock(&epf_pf->lock);
b64215ff2b5e9f Kishon Vijay Abraham I 2021-08-11  168  
b64215ff2b5e9f Kishon Vijay Abraham I 2021-08-11 @169  	return 0;
b64215ff2b5e9f Kishon Vijay Abraham I 2021-08-11  170  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

