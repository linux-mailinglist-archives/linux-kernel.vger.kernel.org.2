Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDEE0324F02
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 12:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234554AbhBYLTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 06:19:54 -0500
Received: from mail-mw2nam10on2082.outbound.protection.outlook.com ([40.107.94.82]:30752
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232491AbhBYLTr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 06:19:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NhppFZWm+iRjm/vo2J29d2s8Tk7wy/INQU7oHFXNspPszBLXAjhKp1H9Uu71iP8J4ycXbnulxs+dMdByMs4DXlimPTSrShtW9C2/1bYqPgio0tf9tTYUeiIGnHdMIaXDlZqWnhgJzEDrkdyKht995ltgiBx2Z2v30645TxfVxYY+w9AK+XWxW2wQ9IkT2PqJUhlBnwMK9x4dtJStbS33NJNCqQ+y/SAEwJKif+3zwGGd8gOO/VSJ1Xiqy2XpSaNreAcfSPQV1g2BmozB275dNsnn7p399sJZdg/6LOCkAdUaoHzyid8fbj/7YWegRsr22HyRshndGNap1vLzTevPJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZOnuSHfTvVQRrkiN/VH7ECbo3iQ3KL1Gjyo6ewArQ9A=;
 b=HmgU1Uow3Tp3Gy4Rl2anFS1ekFfOGRukARD1mIXo3ibMlr1Spqv55+bem3CXy1eOKylQlJDJLL6HThlasLbSmx8gOl7j/nMRRFYqcoUfMUBQUOz24qLEp4cZAsONPzU0Bgv7hHxtV+QNgD1+nQ53gxGd+n7gXl21l52lK9slAV3FI0oAoq/Eh0UN11yklBjKLEJiU9X2efYzVHaqIlQVnvavV2Dy14KcGkHue/0fdowg9co0DQIlIhaJPiehDQuD9YzNvtWOFJauv3MKJk6KWTYV/wg0ZZKT75W+04xIfaSuhPnubLRoAxzK8RlnCA9I5I7/4RR82jLPcLHS7WPLCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZOnuSHfTvVQRrkiN/VH7ECbo3iQ3KL1Gjyo6ewArQ9A=;
 b=Q43QBd11Ybu+voHah6Zoznx9nOj5VjndiHgo5QdLO7h4wDLhNlarkW2kpxEILByT2I+YwWV8Yt1YVXaWErfmlSFtGjcMNOP1SXRkrIBv9xjBmhKpTXzgWS9FJBwJBZUIUp59kc1nxpHEy2jc/P4KnNFVdW+DCnGhzjStLY0yp2g=
Authentication-Results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none
 header.from=windriver.com;
Received: from PH0PR11MB4904.namprd11.prod.outlook.com (2603:10b6:510:40::10)
 by PH0PR11MB4790.namprd11.prod.outlook.com (2603:10b6:510:40::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.31; Thu, 25 Feb
 2021 11:18:59 +0000
Received: from PH0PR11MB4904.namprd11.prod.outlook.com
 ([fe80::4cc3:4690:b257:8c51]) by PH0PR11MB4904.namprd11.prod.outlook.com
 ([fe80::4cc3:4690:b257:8c51%6]) with mapi id 15.20.3890.020; Thu, 25 Feb 2021
 11:18:59 +0000
From:   Mikael Beckius <mikael.beckius@windriver.com>
To:     anna-maria@linutronix.de
Cc:     linux-kernel@vger.kernel.org, mikael.beckius@windriver.com,
        tglx@linutronix.de
Subject: Sv: [PATCH] hrtimer: Update softirq_expires_next correctly after __hrtimer_get_next_event()
Date:   Thu, 25 Feb 2021 12:18:51 +0100
Message-Id: <20210225111851.8432-1-mikael.beckius@windriver.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210223160240.27518-1-anna-maria@linutronix.de>
References: <20210223160240.27518-1-anna-maria@linutronix.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [94.254.65.183]
X-ClientProxiedBy: BYAPR07CA0046.namprd07.prod.outlook.com
 (2603:10b6:a03:60::23) To PH0PR11MB4904.namprd11.prod.outlook.com
 (2603:10b6:510:40::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from windriver.com (94.254.65.183) by BYAPR07CA0046.namprd07.prod.outlook.com (2603:10b6:a03:60::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend Transport; Thu, 25 Feb 2021 11:18:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e30d1e65-8553-4736-8b3a-08d8d97f25af
X-MS-TrafficTypeDiagnostic: PH0PR11MB4790:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PH0PR11MB47907B69A030758CE9A0BA7F929E9@PH0PR11MB4790.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GM6UqB9GkMPAlZOJOMungM3psmnJYPVvdRVTg/beJUb6IXfy0yTSPfBagbroZLno2+pYKtdBeqYj+2Xebwd8gLzBjrfn7FtfjbiXW5MXpxpeNySC/Fh0egTBC3/TiJZgscUbjgJUe2ca4UqapDQtW6kKce8zeSvdAWS46AgsB24uWtEqEfCgL0fctskJlnLAqOgyjo2qbtF5tK3RK4j3ao6whHmk1qbwx2Xy1FcTfxXUOwQ5xmdrp3vGoraYZN+AyM8/GyKUUCQXjRE6SZ+gG/ibmlLummm7e7W1U2AWyAx9sclAYulXm7StlBpKiUw5WiMG5ld+vTxk5a5G630mK/v7ueinWf4zKPkpyR68zcJEnxw1LtmhmsH6IJ9J3o4DYKANQEnqMT3+8doXNBEJ1ilkYDcKQMYOz+jlUlRBzXrUHWqbvK+C4rmJwaGOH1ITS7lcYyHgJrteM1ErqkChLUPOks3LzMAcqnGmHZkFVCD6ulUSq2riBrFMuvCjoC9gh9/O0wiR9koPp0G0kOs+qQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4904.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(39850400004)(366004)(396003)(26005)(8676002)(2616005)(8936002)(6916009)(36756003)(55016002)(186003)(16526019)(44832011)(7696005)(52116002)(4326008)(4744005)(956004)(2906002)(66946007)(316002)(66476007)(66556008)(5660300002)(478600001)(86362001)(8886007)(6666004)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?R0G7HSSFH6bZe14153YisvbWZkueeXXULG6cHPEQucMBkRMSJLNV5vu+ZqCM?=
 =?us-ascii?Q?Qy5V0jkH7pdFygxVJ1W1a0ljuOLF3r0x04xANTbp4oQ31d+ZgRC4vMWPx7hb?=
 =?us-ascii?Q?eOu0LwKaPMgc25+ZO9sMyiIkZ1BDFqlmyrRTJ6py71MPq9V08YDb0eb6AItt?=
 =?us-ascii?Q?EUVwJhBli0uf+bHn17YrZHrviBfLmORfEzxQEc6pesMiF2KJwkXVvbyW8kwO?=
 =?us-ascii?Q?zWSqeA0XSS/eWLmTXHFNdKXRSmKpPP8Nou8rmNlxNa3MyvF06+XbGLHDHJRv?=
 =?us-ascii?Q?+iZguZfqbA5CWttBYw9SyD/o8e7sXiJ+9aqteVfaacuW5aE7MjLgBANS16sA?=
 =?us-ascii?Q?CfENtUnE6Rv+WUB+CLuEvKCPv/vH6dNKUfy7u7cb7MioPWJ7G4JIuiaPIC75?=
 =?us-ascii?Q?LgjGDthVaOXfwSQ8NBxdjW88V76QEEBjeAAGHOGasK5I73TCGt4FnuRgoML7?=
 =?us-ascii?Q?Q8AEkOiBCbBbU1vNB7zRkehCbWFUxdKL3Oy2Pu+vlsG9TrSB1Hk48b4DHIWi?=
 =?us-ascii?Q?S+K9WKyR60uOJDEPp2Y24AEORd5jQL5vy5qeiwaWMPijhxpGizbZL3RBr8dn?=
 =?us-ascii?Q?FkIWuxHjSL1NxAIMUtNQtd74tsTad2JHEbs5C/zA7tJ/5N+oSdzlFz5VTmTc?=
 =?us-ascii?Q?RMzruITeGHv1je5ijw9C1KmfQqD4uQiafwcCRuDhpxhszsgkj88677L7Nmd8?=
 =?us-ascii?Q?7XF6OiVY4RlpKDy9sOu34jwVg7g8v0PtKRE03n0QaAp4Wxhk+MJpKU6RnSAJ?=
 =?us-ascii?Q?VP58mHXl7xmZSLtESWuyCyS40wFVUapQUMi4IGqXpjS0LGZaV/aWyX4qROZo?=
 =?us-ascii?Q?Ll1BVBSU95iKwSKVsgeIjMe2SmRTydUUf/LSHINW9nDEMRnL7YYla4J6Ot4q?=
 =?us-ascii?Q?kFrt+Gas4t2yNBrKSxnrv74OktGF3xRYeFrSzUEoSDpxytRKca8ghJRYrVI4?=
 =?us-ascii?Q?YpgnlBOTrHuUYSUGtjyc5A/8pySdH0/bWdyHfCgGMmw/J6j21GKjcGXJV0ln?=
 =?us-ascii?Q?YeB3SIRJIH2GhxyMDGJh04ZfAuBzz5ZaT6w6WEVspfq1dwOoHMxoqPlEq/dh?=
 =?us-ascii?Q?TQgDOqVRuWqi6SbUH4mMqxjuD1jnUdaqS5kj/JvGj1NGFT7EnJmcxtOG7frZ?=
 =?us-ascii?Q?USamNw/dDAEK1RDcF8UJ26P2Fp7w3nTG/HU7evvGtyINRskcfveZwAqDv/8E?=
 =?us-ascii?Q?pJpaoB6t9rPHjmP5Iead2yrYtsFuDY9rmkYrNJ65mKSzpLYwrwoojoLIrzGy?=
 =?us-ascii?Q?FUGySBpXWDTUXjJAOneXLTtaSZW+gQnRfvq54eiwUQn2BxBnmcBjPKehogzE?=
 =?us-ascii?Q?TMkBOo5PydZQNEjq2VNeCbtc?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e30d1e65-8553-4736-8b3a-08d8d97f25af
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4904.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2021 11:18:59.2287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C5aehUJsUvTP+tPTvuTxYQuNHkERaShKbttMUyshbiNLtwmEcyWGgVNQZdT0lxx6fxiXIVYPxaFTl8HZ8NH3rfK99GA4AKW618tGbLyZWdA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4790
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Micke, please test this patch - it is compile tested only...

Thanks Anna-Maria, it seems to work equally good or better than the change
I suggested in preventing interrupt storms. After running a test I created,
based on traces from a live system, several thousands of iterations
there are no reproductions. Normally both issues will reproduce within
seconds after only a few iterations.

Also by looking at the source code it seems like your patch should do the
trick.

Micke
