Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28EA83189F1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 12:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbhBKL5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 06:57:01 -0500
Received: from mail-eopbgr770070.outbound.protection.outlook.com ([40.107.77.70]:16889
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229836AbhBKLbu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 06:31:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HcirqISvNr9kIl6/xAcLste7X+F3iNwR1wUyP9wYLcqMDONemTmi/ihKJHpYdUQQcwFoY4hCX5cur1oQPF2Ink4H8Ltk/SHLzFzodO/NrAYqPBCPAgYjo0S6KACQHBc69dW33LwdlF9Bbet2FMhPMfE1kcLMvXqj8Lfh0RvhHA25hT5iHLT4dkT31OJw+DexaVaadERAPo2kdnw7yItVTJvV90I1B6YDt1jbCZ9HoZqwYLMsepb8C3kL+5YtHCKI3sYD6QuPPJ6m5V0k19b+r2clnGQSfZZ9Lh3oONsBxATZGEbiN4LbJzjr6Ma6C39DRUMGuekfeHH1jhXQXw+ndQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CBBAp9i0l3JIs6SDQ+jCxKnhkmuHaHh7FpEOqEysEYk=;
 b=ik0Rbwfu+rjYB2ynwnkyntxgvxKJiLM/GC66GLUVHtd2kWALo/ti6fBo0+kWNLtREa4RYpfk4HP76KleJWW+Et7/6WBSb5wv3ZgumMNwCMaxNkPNi67JMED84HoQEP1tR3R1ZSR7UCy6ckm5JFE3vSHGN1SuXtjlwOVLy9usvYgCx13NLVB8EqDerNKoUsFtmzickYo4wweTaSTlgriQiNIBQAvtsXwEkbFL9iIJaqnXvPeP4suCEKb4MH5E3gI1jO+1ltJ80AUhfwSTYKvXjGynQVgoSV2YK2puxH6O0UsTMVBPBZCS1Tg7uIsSoq896PiFCxQaYzgszsdUJhtYGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=xilinx.com; dmarc=bestguesspass action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CBBAp9i0l3JIs6SDQ+jCxKnhkmuHaHh7FpEOqEysEYk=;
 b=cmFDcVPzGR7APZRO/1DOU3DGndc1D34CyB5DsmejB8Pdl6JG2768VDLV1uToZVudVhJMTOdk9PYShXMQrobCXDusHItw4bt+TFxTqJGtYxQ8Z+UcZVEPEIJgfX1dPItdmA6U3ALWMwhnBrJpqZT//7AFhw2+pO54BpqdU2hauJE=
Received: from BL0PR03CA0032.namprd03.prod.outlook.com (2603:10b6:208:2d::45)
 by SA2PR02MB7530.namprd02.prod.outlook.com (2603:10b6:806:149::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.23; Thu, 11 Feb
 2021 11:30:55 +0000
Received: from BL2NAM02FT049.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:2d:cafe::8a) by BL0PR03CA0032.outlook.office365.com
 (2603:10b6:208:2d::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.28 via Frontend
 Transport; Thu, 11 Feb 2021 11:30:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BL2NAM02FT049.mail.protection.outlook.com (10.152.77.118) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3846.25 via Frontend Transport; Thu, 11 Feb 2021 11:30:55 +0000
Received: from xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Thu, 11 Feb 2021 03:30:13 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Thu, 11 Feb 2021 03:30:13 -0800
Envelope-to: git@xilinx.com,
 michal.simek@xilinx.com,
 linux-arm-kernel@lists.infradead.org,
 robh+dt@kernel.org,
 devicetree@vger.kernel.org,
 monstr@monstr.eu,
 linux-kernel@vger.kernel.org,
 arnd@kernel.org
Received: from [172.30.17.109] (port=42340)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1lAAAm-0007HU-EY; Thu, 11 Feb 2021 03:30:12 -0800
Subject: Re: [PATCH] ARM: zynq: Update Copyright date in DTS
To:     Arnd Bergmann <arnd@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Michal Simek" <monstr@monstr.eu>, git <git@xilinx.com>,
        DTML <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <ac55738da7710848ef4824d45bdac18fa1d11392.1612189714.git.michal.simek@xilinx.com>
 <CAK8P3a2FU1eNnUB+RWREnAaxjSvkVxhJDkW-pMpHmsK_NpeaGw@mail.gmail.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <13c38556-90fb-753f-0a19-f1daccf340d5@xilinx.com>
Date:   Thu, 11 Feb 2021 12:30:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2FU1eNnUB+RWREnAaxjSvkVxhJDkW-pMpHmsK_NpeaGw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65cf3fe2-96b0-429d-192e-08d8ce807f0a
X-MS-TrafficTypeDiagnostic: SA2PR02MB7530:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Antispam-PRVS: <SA2PR02MB7530F92D30EA24504FEA008FC68C9@SA2PR02MB7530.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IFqXcN8+yFzO4CWerHQF2l2p2UyYvbjjBpcUpf0EK+4rEMlJ8eOpdBCrVtdFemEBSBIgmDqr6mVh3C18yRC2Wh17bx+tkuQz2oXiiz+l1fA3XfDKWptZpuj5GxWsEvWcPKtwXBG2uhkqCqwhHB2T55RM7ijLyULChHUIw6Idk+2SRp76+CsI5YYeBiDeW4CfI6p1asfYvLq9+71jcc6kfNFBn+nj/TSwHYm+sNcbPUd+qzWXMvnsANYPc9aSXvsqzFx0kOl1PJPiNbNzo9CxuxVaLS1ssOb9BvdJfAriungHpv9D+KMe0w9mLlYlTEeffSa8WhyBwH67k/Gs8P5bspbK9aawkGif/9Zpz9kYByGaVSJS+7MFIsqawOy1RM/RSoPjtm1MsQrxJVW+Totj/IkZCQzvrfZiceskZyDG2e37XGB5p6MBeQNqcNmO7xvbTMzQWzJ7wJffBORq6lr+kkjNibaTrdUEClJ9WILKSUElSgu0/CbYiAVvy9FN10y8oCTvw2W+N/RVFF2MtAEdMYQGMmcmGymzeWeA3n+vWVWDmRq7xUaI4ffCPxEwqegleWgNAqQbcJGai1blKYIpt1nnoENZcQd0XdnwuvXtcCAOZfWOzxi7fvZYxdZnOBQafgNR56Nchl0IQCColsPli1i61pHbs7yw+Rm6cRnZEps9Kf13Fr1gVPvOZ5CNgiFmbHcH5xDTRkFBTA2GcXIAAg==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(396003)(39860400002)(376002)(346002)(136003)(36840700001)(46966006)(31696002)(70206006)(36756003)(2616005)(7636003)(336012)(54906003)(15650500001)(36860700001)(4744005)(8676002)(2906002)(9786002)(36906005)(4326008)(82740400003)(44832011)(426003)(47076005)(82310400003)(31686004)(5660300002)(83380400001)(110136005)(186003)(26005)(8936002)(356005)(6666004)(53546011)(316002)(70586007)(478600001)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2021 11:30:55.4009
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65cf3fe2-96b0-429d-192e-08d8ce807f0a
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT049.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR02MB7530
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/11/21 12:27 PM, Arnd Bergmann wrote:
> On Mon, Feb 1, 2021 at 3:28 PM Michal Simek <michal.simek@xilinx.com> wrote:
>>
>> Update years in header to be up2date.
>>
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> 
> I saw this in your pull request, and I did not think this was how
> copyrights work.
> 
> From what I can tell, most of the files have not been touched in
> years, so it's surprising that the copyright would include every
> year up to 2021.
> 
> Would you mind respinning the pull request either without this
> patch, or with a clarified patch description that explains
> what you do and a Signed-off-by from one of your company's
> lawyers if they asked you for it?

Ok. I will drop it for now. I will be touching this files with adding
qspi description based on yaml binding.

Thanks,
Michal

