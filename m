Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7059C31543A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 17:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232975AbhBIQqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 11:46:01 -0500
Received: from mail-eopbgr10097.outbound.protection.outlook.com ([40.107.1.97]:6439
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233088AbhBIQmy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 11:42:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G5aUhMyIhGgv24rR//wfJk06VF65qbPiChHlMrPmlzVKWbl1ewIeiG0wUe6YBqJcqYaQlaqlqBLlb4y40cpZTCjO5Lh5aONIeqadWZ36a6YMWdPjs93EwGAAr3mWI9Mit2Poq0xu+ko9ly3HkZTDCvHHlRo/rZuLfrYGMUXRDDs3yrPvqmtuhggzEzeybxIJP1A8A62xWwSoSEyM1rjO84B8xN7aXl2Z6EaCM4NTE8zZ2yy+0gasVp+HbAaQZ85xyUfluOJY/C1axVvTd0xsn3CB7w3B5tGBGGjKnn3xXokqmZ12Ga+FHL7VbsHDVb+SI81+ZBRb+aPU3q8Bdo5vbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t5MkiUP7aMPwdOhKQ/9Z1JAO4ThJaJOanHtQBNyUm7E=;
 b=jqfaBfcvMoe09ABi/BLtnk5cMZhNcdJ5zScgwfT8QWuW1XLXdDXRyXPnjsCl0wR+AEUIBb7opIfpezE/1cALdgR/0jPLu9mkTYmv8on/6coAgFgsylbuvhVjPra+jdAr862ueC2+jenmU3U2Rtt4wA3lqKszab4aVGqCQ8KhuFZZuj2f787Bjn/iaTNgTpSFhAZIw+a8bIsq8ixuo+utQNEO7GaA3KT5wb1XNvVHHeEH/JRGERp5l3WUDLjWNz947IO0i4AgFoFL7XaorJ4N0pTf6AF6X8GOC8OJkJqKe17hQ09H3gUtuNmTAIDBv74/YVEBOJ7KzK8vmY2CHL034A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=studio.unibo.it; dmarc=pass action=none
 header.from=studio.unibo.it; dkim=pass header.d=studio.unibo.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=studio.unibo.it;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t5MkiUP7aMPwdOhKQ/9Z1JAO4ThJaJOanHtQBNyUm7E=;
 b=Wl1nsNHUYAk7w5gTzVWql/uCfb1ejgna+3y3JFrh3DdjktIirgCPCD/cYNMg0bMTZSfXP817BzZxnMZT5kD2tIMnEHtWoCnFuPN6FNHh+xvsEEp16EyMEDlg76SYCsk4VYF2RYOEdf/5p8f1zpyRRN2s85iM/WemEpU6h3T/B/8=
Authentication-Results: narfation.org; dkim=none (message not signed)
 header.d=none;narfation.org; dmarc=none action=none
 header.from=studio.unibo.it;
Received: from DBAPR01MB7109.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:19a::15) by DB8PR01MB6294.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:145::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.23; Tue, 9 Feb
 2021 16:42:05 +0000
Received: from DBAPR01MB7109.eurprd01.prod.exchangelabs.com
 ([fe80::39e5:9fa3:1133:7922]) by DBAPR01MB7109.eurprd01.prod.exchangelabs.com
 ([fe80::39e5:9fa3:1133:7922%6]) with mapi id 15.20.3825.030; Tue, 9 Feb 2021
 16:42:05 +0000
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
 <ad4fd822-016e-e11e-682c-077a1ced2a18@studio.unibo.it>
 <231074135.378774.1612888173941.JavaMail.zimbra@nod.at>
From:   Luca Risolia <luca.risolia@studio.unibo.it>
Message-ID: <705c010b-653a-1dd0-87b9-f3cc83c21802@studio.unibo.it>
Date:   Tue, 9 Feb 2021 17:42:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <231074135.378774.1612888173941.JavaMail.zimbra@nod.at>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [151.41.227.128]
X-ClientProxiedBy: ZR0P278CA0027.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::14) To DBAPR01MB7109.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:19a::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.6] (151.41.227.128) by ZR0P278CA0027.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1c::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.26 via Frontend Transport; Tue, 9 Feb 2021 16:42:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef69183f-0001-4d8e-cf2b-08d8cd19a21c
X-MS-TrafficTypeDiagnostic: DB8PR01MB6294:
X-Microsoft-Antispam-PRVS: <DB8PR01MB62942725E36F65B82F464194DE8E9@DB8PR01MB6294.eurprd01.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J0eIYsIeICPSh54KKAyZPH04zsRqR32xYZWd94CVHpUoC7ZOo2/55NCaMlHwguTo91e8wmaV1BMrJqGyhCODGBnGPmmn06MMhgfPOJvgAtlrw2iQ+tDjOt8NRaJ91HbQt3+dwSHWqOppUofuzZ1f41ZC46ye7XUppay4RWkYc/Z5WE8njMRGtp2Y8oiKVlXsg7CHWZwJzR5kbojELEYzzDFWUrBsAbZarT6Q0+LdmS07855Q+To2sIA7WJEP0HqlnBg5eZFjqJ1GITjI2XM4uPb6n+/BPQvk2PDe7nzgScoa1Dk3Cs/Beamr+qtQb5J9lj64VwgK9zvab2VF+3qE3QUc4DRc2RwXcefSK5dFfnVKzr2VgZlsE2MyVjgtpVJy3lqzAhwXs4RgKwJygKCpgW/kjyWtGRUfKPaJE921HN1gvI1j/8uXLVUokQoekGdEuXCktjCe2O0QdKN1P4636QSKlVSehqWipd3yP/mrgUcRxp1IVPqrPuA/DyrE9mXc2UJKuySocMbkW566f1h6Idp9XglBSBJ7hSyknGPDCq+wsh4OXLzV+VmIVD/SmmR8I2Z2R+cbwvoBhKLuPKHfjQ0FV0Ry+RudOUzD3E2fMto=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBAPR01MB7109.eurprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(366004)(346002)(376002)(39860400002)(4744005)(66946007)(186003)(66556008)(16526019)(31686004)(956004)(2906002)(44832011)(2616005)(26005)(4326008)(66476007)(8936002)(52116002)(16576012)(54906003)(53546011)(86362001)(8676002)(31696002)(7416002)(5660300002)(478600001)(786003)(316002)(6916009)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?bE5rOUFDYjRmMWlkVm9DUjhUN3NVclRlTjYvKzUrMzA0ZWgzWnZmY2JVTVVy?=
 =?utf-8?B?NTdHSEpRUFZtU0JxWHNBUW1hMjRPbG1MNk5LZ05MeXFMclM1SFpFNHpzR25x?=
 =?utf-8?B?MUVzVnNydkEwaUlYalF4QmJ1TVpXUHhjaFhXUnppTDF5SDVQVUZEZklmd0JP?=
 =?utf-8?B?YS8wbWNvSEhUQ2FwaXArdXlUWHZXOXVKM09PeU1sd2EzUFZHd1dsYUNhOGUx?=
 =?utf-8?B?clVDdGdiYlJnbVlVQUFwWTlpaFFOS21CSWtPdUozVXFneUEwQWd2Q2g0M1JZ?=
 =?utf-8?B?VmRSUENHZ3RObXdtaEpraWkvY282OXNUN0ZXd0hwWWpwcHptOEcwQ0Q0ZUxz?=
 =?utf-8?B?MWpWR0dYMVNqb0tWNW9HQU42VG00aXg1NzhvVnV6Qk9BSUFidWxNSWpybVlm?=
 =?utf-8?B?ajk0cXFtS2JTVHhzT01LbXNtNHJQYUkwZCtLYktjanNsclQyYVVzVjVEdERV?=
 =?utf-8?B?V3FnRENjOXB4NGczajl2WHdSbGdqUmZBMXFFWmdVeWZhakZ5NTAyQ3dEZmlV?=
 =?utf-8?B?RjVoZlBuWlBnd1lXT0pFbGpVYWFIVks2YW9KcDRiUVpHN3hUdUdxaTlPM09J?=
 =?utf-8?B?WlNTQlI0TnpBQllDclJSRC9rb29nUG5YQWZLeldldFFCN2g3OWVLU251d1Fv?=
 =?utf-8?B?WEdxNEF1SWxjR1g4RHhtQ3MrakhzbnE5a05yTUxxQ0FqVWliN1BSSDhLdUs5?=
 =?utf-8?B?K0NtVkplTkxhSlVjcjd1bnZ6Q2s4WmR6SDNad0MrYUdZWmIzaTNOdHFNcXN1?=
 =?utf-8?B?c0V1cFFVY1lRdVdkbUtORjRPdklpOEduZXBjaWhlTmJ3K0hzY2QrRDFOdkpQ?=
 =?utf-8?B?ank0cVJDMlVlZnZZaGFQWXcxcXp3Vm9udldMNHM5cGlyN2VjRDhXYlpWRHl1?=
 =?utf-8?B?MWhpempjS1QzRmw4K3lleVVVVjdEUG5abkQ4OTNQdGF0L1dsbTVWWEtuL256?=
 =?utf-8?B?SkRvOTZXRGtIQ1lFYWlodWUrRk5MMncyaExTZ3dNbGZTTEpKWE9abStZeXdN?=
 =?utf-8?B?cWRQTGM1MC83eFprMmN0aWZoWHNwcEJESXlha0lyY3dCc1c1OXB1Uml1Y0E5?=
 =?utf-8?B?aFowL3RRN1ZsemxDVWRQd1N4TTBKcDZsSEJoOVV0bVArckRqUURyYWRMSUdS?=
 =?utf-8?B?Z3RBNHdqcE1ac2ZNU0VjTDFjSzUyZ0VLa0NMUlRIcHRsUW1KcENUcFhhVzVB?=
 =?utf-8?B?SkZhMkVRcExiSkw5VVZROXFyTWovcXcwWUc2Nmw1R3BzU25YbnBmekI4b201?=
 =?utf-8?B?Z21ZeWVHZzBJbzczL2MrWFF0TnVvQmVDTWRoOVViaGRMM1ZiekZ4L2lCZzFL?=
 =?utf-8?B?b0lHTWFzTCsrc2E2eC85Njg3MWtXMkZKcGx3dkpFaHVhRUorNFZaS3AzbUtN?=
 =?utf-8?B?dmVxZGRxSXJDVjVWNVpDd2xWeHZhY1NZNGx2R0pTTm5qbU9VbXozWkM1cUEy?=
 =?utf-8?B?Y3FGRWN5ZnFrUjYwVk5EU1l1NkwydWhIbFI3UWVaSkdNQ3EraUpoalg0VnRV?=
 =?utf-8?B?U1Y0YjUwd2wwRVd3VTJwVDNNSmFjQXl6VTBPd3RRQWFxUU4xNFhIQ04ybmth?=
 =?utf-8?B?S3dYN0V3cWRxRmtoVVlvby9nRUNBNmdQaUxRRHR2ZmxOTHhGV083OTVVdUc1?=
 =?utf-8?B?ODVFcCtQbjBpWlhHcHRjNTZJUjUveU0zYWFTbUljQzVUSWhydnBRMVRuaUlw?=
 =?utf-8?B?aFhGa05LbVlZbmJ1ZXc3QmNlaEsyRWFRek5lYVRCOVFkNFVvUXcyaEZCaFlH?=
 =?utf-8?Q?5xYyaGprO9bposECR+GjpZon3KB8knqZTqLwCBM?=
X-OriginatorOrg: studio.unibo.it
X-MS-Exchange-CrossTenant-Network-Message-Id: ef69183f-0001-4d8e-cf2b-08d8cd19a21c
X-MS-Exchange-CrossTenant-AuthSource: DBAPR01MB7109.eurprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2021 16:42:05.1634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e99647dc-1b08-454a-bf8c-699181b389ab
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tl4CamC/5Q3feC7bwkm2muj/sRUOsYaPr3mBijlPSSKc8IL2ztDUZVoK7xalcseQlS2LX6c15piMrKUyUiIty0PMPGK5J9rdguXZ8QHP454=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR01MB6294
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/02/21 17:29, Richard Weinberger wrote:
> The mmap() call itself. Of course you need to touch code.
> Maybe just cuse_lowlevel.c, maybe kernel too.

A patch had been submitted some years ago, more than once, asking for 
inclusion in the kernel, but facts are that at that time nobody in the 
FUSE group considered it. So much work and time lost, unfortunately.
