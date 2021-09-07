Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC9B4026DA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 12:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244809AbhIGKKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 06:10:49 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:47097 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236985AbhIGKKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 06:10:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1631009381;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QT2hWROh4+zHp6bv3m6ZK+pqrsQeBWMYacVPC/7XLFs=;
        b=MEib/EqnGV9tlL2S/+/2ehd9OhOQt50QhZGXI7Gb3aB5ZEmh8ykRlbjWJdBmY5fUHKUAb1
        jyNOfDHxvxF/k8B5ljx1x0ke9ZXgpGFhWDVzBNH6Br0pMp/AgOdIM3Q/GALnPU3omm6l8I
        OqDXenz9qMkkiot5ZO+JeKkPyCeq+rQ=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2170.outbound.protection.outlook.com [104.47.17.170])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-37-kA07ANcXO0q6nVZZ70NSWA-1; Tue, 07 Sep 2021 12:09:40 +0200
X-MC-Unique: kA07ANcXO0q6nVZZ70NSWA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l98EoNAQvlKjJyr2A5jHqWKX7cUvES+NJe7QjVdKj1aTNx+hJoO4uudM1/uSvdUXsEvl9qMi1QTBsx0VpmBtrirB8PKcJWIPfIKquEpGoZ0O7RWtbcmMOt9VL25ybdrBA25tQfTyYw5HiiTzGN2Yp9JocdzcAi1KrbXZ0n+W0sfxnMWzXA2/BT9+TBSnr5PMfHAlWt0yXgLZFpJFIu1gEyMLrOg0bjOeuIVQHktgpQmEw6cpsnqC2o6POd0EMzPsaPGIjbRIfANBCRi+S7fCK4g9w3exPC7Hde4Y4j4VSMtjpAYFrZDDClF5K/1p0LceFJqPTw9t8Jej1Nelca7bMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=QT2hWROh4+zHp6bv3m6ZK+pqrsQeBWMYacVPC/7XLFs=;
 b=Qw4APWuQuUQGwr7Uyu252oUDDJAKww7agbTDd/KdF3C4aNvz8pDmhiX88po8S7yA+1G3yV/Esjk0vnKcNirsZ2glNxKzZQF1274mUUryrvV8C8GjvmpxZEmYSpGf8o6YLfXz3nyT6pPBiF6xhGSebtmRQyHblJq2rs5CQw9fYM7dX6BRGZMZyEyMsjQAdinYNT9hoNq96k+Hm7QegZjjyzsuALRBEDN9/ksqCBU7LI/HyHOfTDwqmfBEoaKajpuk+l1FTq+F9v/eIoU3KUXndlDzWtppzV6xD8NAP+US8nT/tw3Sp5188Rr8yUe7rwVw8ZVt/aDbA1eRNdbx1pJTyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: lists.xenproject.org; dkim=none (message not signed)
 header.d=none;lists.xenproject.org; dmarc=none action=none
 header.from=suse.com;
Received: from VI1PR04MB5600.eurprd04.prod.outlook.com (2603:10a6:803:e7::16)
 by VI1PR04MB6176.eurprd04.prod.outlook.com (2603:10a6:803:f6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.21; Tue, 7 Sep
 2021 10:09:39 +0000
Received: from VI1PR04MB5600.eurprd04.prod.outlook.com
 ([fe80::4d37:ec64:4e90:b16b]) by VI1PR04MB5600.eurprd04.prod.outlook.com
 ([fe80::4d37:ec64:4e90:b16b%7]) with mapi id 15.20.4500.014; Tue, 7 Sep 2021
 10:09:39 +0000
Subject: [PATCH 4/9] xen/x86: allow "earlyprintk=xen" to work for PV Dom0
From:   Jan Beulich <jbeulich@suse.com>
To:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     Stefano Stabellini <sstabellini@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
References: <4efa804e-3250-227f-00c7-347581366cd4@suse.com>
Message-ID: <bbf5f984-d039-97b2-cfa2-23a8a7afcbed@suse.com>
Date:   Tue, 7 Sep 2021 12:09:37 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <4efa804e-3250-227f-00c7-347581366cd4@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR06CA0079.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::20) To VI1PR04MB5600.eurprd04.prod.outlook.com
 (2603:10a6:803:e7::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.156.60.236] (37.24.206.209) by AM0PR06CA0079.eurprd06.prod.outlook.com (2603:10a6:208:fa::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19 via Frontend Transport; Tue, 7 Sep 2021 10:09:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bff94427-b8c0-49da-b1af-08d971e79a59
X-MS-TrafficTypeDiagnostic: VI1PR04MB6176:
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB617638AABEDD98B1FB96A081B3D39@VI1PR04MB6176.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +N71l0PQEY3row9ZcGXcogF87GxEqAmHLNLg4DKPLKSDngbmLEgNg1jdqwvQLDB9xIJIUR8yxpOao7TiJwpS7CmeEQOOWxjjdAo5Nl29E3KaJp5by7R8EUQDe6LwPfEvRq30GRmK7pZZCgWiBdMDHhcyjakTqS0CmtqF86sogz3TybRqeVWHtMQW7IeKRGSzCGqj0W5Ch6if+/KC0+7tgVF0lRP/fmRz1BeG8jfA8nPO+fNCfVLVPAO0euxBWutCr64Mz4d2Q9LwBeTxgJvh7m2KTZJwn5wlvGq08Cjl0XwnDiXBMzXBMRw2kWiXYVg1vpjZAgVohrCwQqnYwPIYkqVv4YE8wnJGmioI9U2PCyFBLIK71vgJF6DLH7sN1UzQ0vBHPL/3lY8rrdVkE0Lb6KLsqjT6+MLrhytRfuyxXbFoNAZZ/lCdbLtgCMDCFyncI0X/2Ziz7rjTtDd1Ne/aYKbupOMIbKQBr7lyw7M1vakbxY6jih674Bf5Iy/MzcmAjpBSATnA7Wc8WEvJ7FxreXjg0wOJsDi25YI4zzE/C21P/L9toLpp1UPY3Ixn+30HiCJhCSyLrD+Lk+iJfYKxDw1qkvMVKcptREZ2YO6Od7WoKIZk5U7uiQ2k3JnL4t3XH4ZHeyBoCZGLS+dwnfyx0Qnu08A/NYqnrG2y3ybBFIvguuLkonQ2vn/RZ/2fDzOyLWHq1iUOT7Ask6WtzDgYsWpZtLy2NwsURdSJBn9A000=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5600.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(39860400002)(346002)(396003)(376002)(54906003)(66476007)(66556008)(2616005)(86362001)(8676002)(66946007)(4744005)(31696002)(956004)(26005)(38100700002)(6486002)(4326008)(8936002)(186003)(31686004)(36756003)(110136005)(316002)(478600001)(16576012)(2906002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZTkvbFdLU2o5RjJLU0kwelFSOEY2R2s5YkdOMy9YRGduVDM0U2tvZHFjdmZY?=
 =?utf-8?B?ajdJOXhHUmRNaW02VzM2eDhLVys5RW1ScFJZZnZ1MXE1K2o5YWZDNERGVkN4?=
 =?utf-8?B?K1BVWVN4M3A4dVd6K21EQS91L085d1lOQ3I5YnlzdEhkUzVMT0ZhdTFWUDd5?=
 =?utf-8?B?L3NwVHNCdTV0dy8xZU82UlFpQU9IcUYrUGE4MEF4Ynlsd2hwQXV1d2ZjeDln?=
 =?utf-8?B?dVgzR2FITWhRRlZSZmV1dmsvcU81eUo3U1QzS0w5NXI2L3RXZDdOeUJiMnJO?=
 =?utf-8?B?bTdZc21UcGdTdzBtd3lKSjR1WldXR25nY3JLeWlNbVdGZFh6Q2lDQit4R1lQ?=
 =?utf-8?B?ZkZ4RThLT0dhWmd2Z2Y3bjZESTVRN3RKZmE4MmUvcC94cjlBeFFlbGkwNE5p?=
 =?utf-8?B?TWlFQUxvaUUvWmlhcTZTdmJsVk5CRzV2eU9mb1VVNmp2c0ZYRVdLNFR0R2tY?=
 =?utf-8?B?UFhLdVUxTC92NkZWcTlWOUtWUjJja1RTb1BrWWdBaHpoazFkVFM0QUkyOHpE?=
 =?utf-8?B?ckdJYVI3UTZsem45WjV2WGE5Mkx5cUNUS0xEV0dYYmpGeHR5bnpYaHBwOUFT?=
 =?utf-8?B?czhjM3VxWXc1MDVpeEZXWmlqNEczN05SVWEydGFzQWNTdm9ncU4zQnN0dDlN?=
 =?utf-8?B?MklEd1lsaGVjTXJONGhlSVpKRU1scWJoSjRmVkdFTlRRTHcwM1NkS1dnNS9q?=
 =?utf-8?B?YVlML1BJdjIxVEd3MEVCTEVoc0thRXFmQWZZeEpsSm1xb1MrYVRLT3JhTDU4?=
 =?utf-8?B?KzUyTWhoUDdXeUxZVW40V0tnTW0xUzdzeWVXcXBQc3hJVnNBL1lDVHUwS0dB?=
 =?utf-8?B?cnoxSTRZR1c5QzVDQzBnQVhQcWtMZFlVNU5ZZE5pK1RQcHVCL2Q0Y2k4SnFt?=
 =?utf-8?B?eHpDQmsyRmxlcGdyQmlaWDlmbDh5Nkg5QkdLazFPc3h1MnBncTJJZ3dUcTFR?=
 =?utf-8?B?RDhlQzhhMkdxVU9vdlRqWUVWVjJTTDZFMmlRVlV3eXBxUTlKUlFOZ2JYV0Ja?=
 =?utf-8?B?WE9MK1YrS0tLbW0xSDhHb083MFNyNU9ELytCU3h5VlVTaFo5WXJ1MnZPaDRp?=
 =?utf-8?B?R0Rmd3VKSVRWUmNueDBnREphditXL01IREZPOGhncTJiaFVWUVNRdlJxMS9K?=
 =?utf-8?B?NkgxL25QTFVzbUczTVhQNGNKMjM3Nk1TbFpWcUFveE5YaThWNkhxRUd3TFQ0?=
 =?utf-8?B?KzA5RUt1bzJOakVtN1Vha2Y3S0pBNkxYOU9sL2dIMjcxaExKeE5FZ013SFVR?=
 =?utf-8?B?TmRpOXZlUGZKTzVlalRrcnRHNUNwSlNySUVVN2tNRkxoS29IWGIyVHhvcUNG?=
 =?utf-8?B?Vy9wVCtPMDVyQUZOQU16MTM5VHQvTkMzZW1qRFdJL2NGVE9VZU1nZVk5RWtJ?=
 =?utf-8?B?bDJ1RFZpZlB0V3M2Q25aL28rN0RlTmV2RCtieGE5bjVteUlrNzdXQTlPWG1n?=
 =?utf-8?B?WjNkY25PZTAzVHhkOVpacHJ0WlI3eTEvZDRoV0ZFS1g2MWFkUFpXODZIaUc0?=
 =?utf-8?B?OWFGUmtmOXhPbkFEcnZIM3lMN2ppSG1xSHFLOUhQMm8rdUk2KzlCU3NyL253?=
 =?utf-8?B?cHhSWC9WRHZiNk1UQklSc1ZQYTdPWk5jZHVvenlzS2h3MjdLRWlSRU5nYzN1?=
 =?utf-8?B?aE1uUVcycmVEa2ROb0JRbkV2T2UrY0R1cEpnbnJUZEl0ZnZoK25vMHZzQkk0?=
 =?utf-8?B?eHZvaGROd3doVEFsQ2Y4OXpSN1VNOVo2YVUxUmZJRkRBSTMwTTIwZjV0Wk1q?=
 =?utf-8?Q?uSGCiFyzaXKMfT/rsEMLHkiw794UOvco+WL125W?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bff94427-b8c0-49da-b1af-08d971e79a59
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5600.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2021 10:09:39.1818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VBVGDkfwwg9LGWcuPiA+qVrOJqYU4F+PwRnvfb2cdy8J77FDERQMebOkkdpivuhmHJZ4ZGSsBkNBCZqWnNl1zQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6176
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With preferred consoles "tty" and "hvc" announced as preferred,
registering "xenboot" early won't result in use of the console: It also
needs to be registered as preferred. Generalize this from being DomU-
only so far.

Signed-off-by: Jan Beulich <jbeulich@suse.com>

--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -1340,7 +1340,6 @@ asmlinkage __visible void __init xen_sta
 	boot_params.hdr.hardware_subarch = X86_SUBARCH_XEN;
 
 	if (!xen_initial_domain()) {
-		add_preferred_console("xenboot", 0, NULL);
 		if (pci_xen)
 			x86_init.pci.arch_init = pci_xen_init;
 	} else {
@@ -1383,6 +1382,7 @@ asmlinkage __visible void __init xen_sta
 #endif
 	}
 
+	add_preferred_console("xenboot", 0, NULL);
 	if (!boot_params.screen_info.orig_video_isVGA)
 		add_preferred_console("tty", 0, NULL);
 	add_preferred_console("hvc", 0, NULL);

