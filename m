Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 057A03153DE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 17:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232852AbhBIQ3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 11:29:16 -0500
Received: from mail-eopbgr00134.outbound.protection.outlook.com ([40.107.0.134]:6321
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232631AbhBIQ3D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 11:29:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IMebVK5wbxRza4AUXjCJJKFLgJDY4peDprSXw7sabutUR3SZZe9Tbu/SKksizj09D8DU8yd73YV9Lmu73/88/I50B4xGATivTxamRt4HG04L0bOVA2ZilCP02n/dMO4QgiDThduIYDNNHAyWAl+ooS2FNLpkiXfGPBw24J+bmd2LXWV9y7abt3XAwfViKGoUJGvqprFIboOC3iyyvAZDS6M/lvri8EwkpXXO/HUDkRGnE5+3jstCL8wvatBdV4qvDiIGmDa3tzHqV1wTWB1PgWTyeR/C/akeo+0w/gTxXBh4DTum+D5aU0th26Katg7sfKBZMIe5wUbPSbYBbakjFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E3lFaiunE/pk4UxPSuwNRDlcgwobIxgrkdPLtCkjJ0g=;
 b=KUPo3kwWW4PicR3RX8/MMIH6H1I7YWenMev/cJsU84lb2LmdyQ0uzOyANgNk4u02nYgsxzoLdhCTrycHrI3ep8S1KKjFI+ponsCcGJVqSMhAywnsZ25Ry3K7CWdvQSIeqvxEiIuXdr7N8k4HvY2vIneAU1HN7QXyxafOosC42byKjhF8+V6kae1tIQJ+FnJaSXR1j2VtFg4ay/K+VWSSKmAZ+Zn1XUUQA+wliMXeT7gqHO+geBY4VtE+dJ0WwCwGN8PJT9Bx+tIIgW+j+lkj3Rqcc2Ehu2ZVAQp171KtVGSNBwrnwUp+NM+Cx/4CyVrmar996qUqlFHY/lQbi01Rmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=studio.unibo.it; dmarc=pass action=none
 header.from=studio.unibo.it; dkim=pass header.d=studio.unibo.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=studio.unibo.it;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E3lFaiunE/pk4UxPSuwNRDlcgwobIxgrkdPLtCkjJ0g=;
 b=i1PQkLNTLIt65k75Jzz9O60A9HmS2W0rFt4SeXB0YDGsiXAuJWB9o/clcCnzsB7ToP8hoOvzwGDapzISWJbjKnHEPOiwe/fn8l6L+LC7ReBbCGE3WC1VN+SVX4/jLsv9tqIqoexo5llBf7V7ToyFAf2+wGWhgydrzF+ozR9Gfac=
Authentication-Results: narfation.org; dkim=none (message not signed)
 header.d=none;narfation.org; dmarc=none action=none
 header.from=studio.unibo.it;
Received: from DBAPR01MB7109.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:19a::15) by DBBPR01MB7738.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1e6::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.25; Tue, 9 Feb
 2021 16:28:15 +0000
Received: from DBAPR01MB7109.eurprd01.prod.exchangelabs.com
 ([fe80::39e5:9fa3:1133:7922]) by DBAPR01MB7109.eurprd01.prod.exchangelabs.com
 ([fe80::39e5:9fa3:1133:7922%6]) with mapi id 15.20.3825.030; Tue, 9 Feb 2021
 16:28:15 +0000
Subject: Re: [fuse-devel] [PATCH 0/8] MUSE: Userspace backed MTD v3
To:     Richard Weinberger <richard@nod.at>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Ron Minnich <rminnich@google.com>, sven <sven@narfation.org>
References: <20210124232007.21639-1-richard@nod.at>
 <CAJfpegvN2KdMj_7T-OF1PAs8xZiU3f4233AvigaXwwRAsgQEjw@mail.gmail.com>
 <563952295.378372.1612881357746.JavaMail.zimbra@nod.at>
 <3a9c19cf-2c25-a3bf-a200-6d223952797a@studio.unibo.it>
 <443281182.378615.1612885278254.JavaMail.zimbra@nod.at>
 <b2424246-d42b-d0bc-8951-8cefdf5b681d@studio.unibo.it>
 <1517729157.378701.1612886684264.JavaMail.zimbra@nod.at>
From:   Luca Risolia <luca.risolia@studio.unibo.it>
Message-ID: <ad4fd822-016e-e11e-682c-077a1ced2a18@studio.unibo.it>
Date:   Tue, 9 Feb 2021 17:28:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <1517729157.378701.1612886684264.JavaMail.zimbra@nod.at>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [151.41.227.128]
X-ClientProxiedBy: MR2P264CA0182.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501::21)
 To DBAPR01MB7109.eurprd01.prod.exchangelabs.com (2603:10a6:10:19a::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.6] (151.41.227.128) by MR2P264CA0182.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.27 via Frontend Transport; Tue, 9 Feb 2021 16:28:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 13e935e6-14a8-4178-f15e-08d8cd17b366
X-MS-TrafficTypeDiagnostic: DBBPR01MB7738:
X-Microsoft-Antispam-PRVS: <DBBPR01MB7738ADE0EC08E0E126ECA0AFDE8E9@DBBPR01MB7738.eurprd01.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:415;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MlHGF8/0nNBEtnXiBjyu2roOq/ESh7g+ykWuSetAyjkQHdMftzq1j3EbJupdRj+rrJnkXlncPiYAlxw+5q3kn6WEDyB5+lQXUTkRiTXi9tLwS25BuASK4lbKL5SDXcDryYf5BHkPlqR+miM3qMTysmLegL59EwCSG19Z/M+xGpTMwxUrg+TC0o6MVKhikT40Hv6Pxv99H55c8XuRGY7nADXkoGTRKcLY2l7Lmg52EXMSTOGI31Q9uekSUlcAwrLGdi4mH3PnKrWexLIUATGOtbdUXLL6wJNIKVcSW1aOiFD7h87aHCLoulhnrYy8nP0tNm2sbjMjhSn5C+JIQ10scla++exhQHJMr7Y+tz9Ds+GKFqu9P4Md5ry2KJTlJ1X6Ekdj5lrha9rtbGGt6QEJTz6ECdWlEUkginHr5MU0Pm1nQSjFGx9CVfsCNlcmWJhTRx+8oNXXUrzbfz3e+PEGLy3DgW/zaMfCubMj+IBRKBqE6+PgQmKz6B9t72LXaLse7G8OWP5bv6Xx6Jen4a2QBwbyWRbdyZi9ddIEK39DI34zzGpTy9glpiwv97MlK552xNTGxBywaPXakfFdmpbJ0N8ESP/IYYfYnt/z4VgA3IA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBAPR01MB7109.eurprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(396003)(136003)(346002)(39860400002)(52116002)(2906002)(44832011)(5660300002)(6486002)(6916009)(8936002)(478600001)(8676002)(86362001)(7416002)(31696002)(558084003)(4326008)(31686004)(16526019)(66946007)(66476007)(66556008)(2616005)(26005)(16576012)(786003)(956004)(316002)(186003)(83380400001)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: jL+RCQHUDkKGoLk/KkFoJcY9vH1L0C8RwXg2qMV0++dpd1TMsyawSDeRFn4tZ4zERK8WOVlJkpBPA2pEo2lrvy+GyfMKjv9HzmvkLWKYiHXKLD1chgqtNt/E2gsduRtSPMRk/p/96SmZQjWMnExCHVzdpry7J5YO7AGum/5iLpYdJNiOQxbumnotCiZ4HhqU+1y1n1zgAO3FqYLyK0DLv/82FPFF47IHc6vUT6uXTDv99BQtEpmXcvzv9weX5NbV2q3wqeDxNWdPVPT/+bFBmqsugg0zEpi3rvsXEGMMmCzijDUx9L0uZvuM7EKsl2TOs77mZDcIhiAMvtpRvvROQ4VeghD73t5OYbdxGIREYmGXEe0qQR3we5k3QhQlUarN6lCLRUst62ncLrYOGTiWRXbU90YxLGQV9PML0OXd39Fhkt3rTHLCUgo6cre4T9nA462l3QNHrTNT0v2A1cea0gj2OlayamUJ6sMDGWFgQ8aUiaT8Q+uck93PrXKiVUt+vrw7jewkRd66T0qr7hk/SW3GUzYJEr1XMCf1QlGux7j+J6eDyuQSnZyOW/j3l4vwutvnxFMQuw+0Ji4/tXKU8mB0qHh97LOLm0kr0rQZUz36zNVdXjtyhFwEF+PKilkd7TywWc832kMjoUmeCaHLmXtiVgmxVSSJKOkhnuRoJ5fbWjA7DxLsNKIozpnw36mMV02LHYi/kgIm/aN+wvFQxhrOxFH/eVgTguAIzWsgsHciXQOJmvcOMA1Ih2jPgMI5
X-OriginatorOrg: studio.unibo.it
X-MS-Exchange-CrossTenant-Network-Message-Id: 13e935e6-14a8-4178-f15e-08d8cd17b366
X-MS-Exchange-CrossTenant-AuthSource: DBAPR01MB7109.eurprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2021 16:28:15.4339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e99647dc-1b08-454a-bf8c-699181b389ab
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eFDIZtFc8vPJOxM7tu4JzXrFckxI23A7X7Pc2QXZ5Z/5i1Z7Zmvpnf0+knD+EHsXU3WxKASYiXX9smOwQlgFUR69VpQOpAvMHFOVAlPDAFk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR01MB7738
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> A simple (but ugly!) approach would be redirecting mmap() requests on CUSE devices to /dev/mem.
> hmm?

what requests are you talking about given that at the moment the CUSE 
client interface (cuse_lowlevel_ops) does not expose mmap?
