Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 019B83426E2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 21:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbhCSU3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 16:29:45 -0400
Received: from mail-bn8nam12on2058.outbound.protection.outlook.com ([40.107.237.58]:2752
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230223AbhCSU3J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 16:29:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iYjRd1SwK8mEMeOGJUiuAsgFQm6h3HgODFUhfOX16GBLGYltf0qnU8BGt7pfyBb7zzM+/izt+hpyjGbsoq+O6BT5bpx66aq6XgcTwQ2S8LhjuZe1cwLasE876ccjryV70qmQajhcPVVKMmj4prFnkcaElJ7TV7bquWMnmObnmeElKYfCRHBdgsNO822JWalM9HoJDq3/YwMr3/C4dbXopBcVOW/CjGsV4uaQUbuCI65yE+X+MqIBQnySlkvfuX5xlZDJJFytK5Bx4H9PAynfJan9g1bciObeauwLkcrqgg5L1BcBBWrB5YEW9N2WS25N8aHUT5+QbSp5gNXEbN7t3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GVFEk47uRZtrWRKf0sFQRGAqfkX620OBPhAZa7JnACI=;
 b=YJv18AMbcsYdNCoHRKGphJaoMEzPj+waDuamOc32FD6aw1IkHQ/TfS6AmFMSC0v3sTnDL0EXSp8KLyBpx6oVc76ApBIflbERb9PmZoDk3/7TwV4WiBEgjv+rMIgPat7zObJlyer9uPXMj7RhTS3++9c8pQpkJ/TA+z64H2ZDIEQCAsVJx9sVxQ2E7FXmzlKB6evz+9ROl4mV73DTHnSYbhab5BdFObicuVR8V6VT5DSfCTHRrLpOatpCPXyzg7Wyyi0pKo0Ue+AIAHKKj9x2mE7QdUUsg3Ghjg/4ezzAz4Fft1roQSTlxT5lVC3+qRARzaNXmAOCRkZzv0N8CTvCRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GVFEk47uRZtrWRKf0sFQRGAqfkX620OBPhAZa7JnACI=;
 b=qvhe8TdhNS9X44tT7sxP9Jl43HsfM66oPidRd8p251/68sV8FRslv4/yf0dZd85oN3Mw0IOiHlwyR3lOqikaj89znPqQ12tqU2cna9MFIu794o8OkBce/NEAIulH4dIZRXyHWuFsPC1SvwEQw9BGmvWyCcFFXInijNG+ieSEdl0=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by MN2PR12MB4334.namprd12.prod.outlook.com (2603:10b6:208:1d1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Fri, 19 Mar
 2021 20:29:06 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033%5]) with mapi id 15.20.3933.033; Fri, 19 Mar 2021
 20:29:05 +0000
Subject: Re: [PATCH] drm/radeon/ttm: Fix memory leak userptr pages
To:     Alex Deucher <alexdeucher@gmail.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>
Cc:     David Airlie <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        Daniel Gomez <daniel@qtec.com>,
        "dagmcr@gmail.com" <dagmcr@gmail.com>
References: <20210318083236.43578-1-daniel@qtec.com>
 <MN2PR12MB37755DAAB03FC0065E98EF1183699@MN2PR12MB3775.namprd12.prod.outlook.com>
 <CADnq5_MMTBXt50sqJvYmXWn0uBALz2fNvpSrCfjSuMa99VLa=w@mail.gmail.com>
From:   Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <375f0915-83b3-c729-b95f-939d828d24d0@amd.com>
Date:   Fri, 19 Mar 2021 16:28:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <CADnq5_MMTBXt50sqJvYmXWn0uBALz2fNvpSrCfjSuMa99VLa=w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: CH0PR13CA0058.namprd13.prod.outlook.com
 (2603:10b6:610:b2::33) To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.226.80] (165.204.55.251) by CH0PR13CA0058.namprd13.prod.outlook.com (2603:10b6:610:b2::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.9 via Frontend Transport; Fri, 19 Mar 2021 20:29:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0349f8ba-e78b-4aab-0e03-08d8eb15a432
X-MS-TrafficTypeDiagnostic: MN2PR12MB4334:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4334BC7C0912D05934E4946792689@MN2PR12MB4334.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u7BbOSpBCF1p8P3cXQIpJykf1TTdIcxP+DBRTAns6rxldLPLLtQGVjdyZeqa+dA1B0DDzaGMA2XPRRlzE9a5mstJX2o8d1UYTK/IaPVeBii7KP/DywqvP7+CerUOi8k9Cqz87B5t8R259CLb1Rrn/GmEamxBU4i4k9u5ybdC3x0O7CQbcN40kI4SjB7ZyjjZZgeH/dwlA/3EULw1w9NofN0HDTeKYQ9cBZWG3KpsI4U3Qp4XGmH6/HXiDNyQPLxgFY1FlA1sczhJDR33t8sXA4BETnYIaRuj3e/2zCLyloJAm6fPHpGnul7iDi0XqQ5W4duV1sTyNvMwbepkrgN6jf2PFP676xxkZB01HmGASy6SREa/523F1zdUPQ7tFI8UPNnGv1Cae3KnnC76m/EVcrRmeK2a8ujktfsi5w2xhi+qJjpr7Jvbl60lwz57ZGls4XdRpsV5TiJd7N9ZWB8YVoiMoQD7DgAXIA4UbRki7yqMK7DbeYYgbZRP7ZZUa7mNVDwoDZThvgGEr0PpRx/kfktEkLYDOLSJCRNcjvp8I19pocgiXIJ5E1INpClaLvQwntifPuXA0289UmhJuw9QtLjSvD1kqL5TJKb6rOgjZupVgoI1DahY+jaMKlgfpk5AnhuMA4fzpjxKcB9xiAsU95swrD6DO+oP3TmSQNSaBKbJM8z7klr4SPJkw4IKzX8/RiJDapAql7u47JBvijrJmy5CUV6/XxYf1BDXNLYKZ7RuL+7c+pb2nrqR0+K7TGIJLmFG7M7dC8UEsBOHSzJo7A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4948.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(366004)(346002)(396003)(39860400002)(36756003)(16576012)(44832011)(66574015)(54906003)(110136005)(8936002)(8676002)(2906002)(2616005)(316002)(956004)(26005)(16526019)(186003)(966005)(36916002)(83380400001)(31686004)(31696002)(66556008)(66476007)(6486002)(4326008)(6636002)(66946007)(53546011)(52116002)(45080400002)(478600001)(86362001)(6666004)(38100700001)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ZW5SOTRVTGtvNFpteUtzNjFOSVlwR011WVBzSlN2TWppWkw1dlluUThKZEh5?=
 =?utf-8?B?b1NqbFZxZjlZYXRGR05tMjU3elhpbWNVd1M4c2hUbkE5aHhBZUtaeTJ1T2VU?=
 =?utf-8?B?RU5EQy8zTkJoOWJvcnFNaEZMMXRZMjE1RlBhRDdKdUZkUG9ZVEVWc2ZCS1Zp?=
 =?utf-8?B?SGFuUm8rTnZxRlBGRWtjQWJHbm5RaENkbkp6MG9GTHQ0elNKeCtqdTVzdlM1?=
 =?utf-8?B?ZUk1azA3R3JDK2RLTTZCdUgyaU5maHdLZWJmRm94RHFFTFYzQ0RaU1BvdlZK?=
 =?utf-8?B?RVJIam1XVjVZVG1pa1hLWkhvc3luMXZIK3Yzd3YvdVVtNnArM0YrVkdISVNj?=
 =?utf-8?B?aUhZd2lybTNxTjVpcitaNTEwN1poQkg3QjRwYlVtRjdSSFNlMkxsdVhhRWVj?=
 =?utf-8?B?cGRCZGFrUGE4T2FNenRUNXpVdkI1bWMyaEZ0ZkFCM25HTzRZQzFFVEZaaFlk?=
 =?utf-8?B?cW9MNVVObkJCSlZ5R0Zkb1VUdm1PUk14RllCamFpWXhMbnhQMW4ydDR6QnZP?=
 =?utf-8?B?cllRS28vK1JqR3FnWTN6cG9lYWEvdkVtcFYxMjBrcVZLc3pBdlVteVlhcjJK?=
 =?utf-8?B?eFZWWWkxNkFtWDc1REpBNFpnaFA5S1dIMWxRY05SUUY5cnhBSTBZNzR3VzFO?=
 =?utf-8?B?a1BsN080MXpNZW9BVndnVkxWVTdwZC85R1M0dGl6ZTNxUFRQbFptNEhDb2pt?=
 =?utf-8?B?QjBNYXF1enA3MnNqcXRaWjk0WE0yYWh4SGVUd1htWkxQUmFCRTlxQTIzYlhE?=
 =?utf-8?B?cG1CNVNoUGJhVXNkcjlidGtQTUFONE9yY1d2eTJWMWE4NWtraTNhdWJJeTYy?=
 =?utf-8?B?bllhVHRwcjAzL1ZSaEJ2L2p1QWY1alpkcVEwdE5tTnNibU5RdzYycGJBcXhX?=
 =?utf-8?B?bEgwc2hkNkhRU2ZPUjJJU3hKdDNGY21aWElkakJhTkZ2VzkzVnVaZG1PWXpy?=
 =?utf-8?B?Z1dQU0QvTWFpUHBqTVd4TW84ODNjVTJ6bWg0NlZ4bWtJV2ZlNGJ6VG9FYkFT?=
 =?utf-8?B?L2VGdm9VUG9UQk5aRFVaNTgrYzlrbERsY2N1bFdWdWNUOXJ3N2ZFeWg2Tno5?=
 =?utf-8?B?R25HTUJPa0VJWG5XUlg0b3FDZ3BaalhINDRQUTZpM2t2V0VwdmVKTnBxOVp3?=
 =?utf-8?B?d2RNYVdJUFZmMXNKV1RMV0xnTDNKLzE0WHRLQkc5emtTWVU4NU9LUmNMeFdV?=
 =?utf-8?B?RE5WNnVMMTZUUnFqTFprZ2dsY2crR0VGcGtrKzQ2c05WTyszRTdNSnd1ZHBU?=
 =?utf-8?B?YzAzdi9DYTRSVTJKRHdLMmZJMThJVVVkOTlQZDRPQ1JJR09MUHdaN2lpekdw?=
 =?utf-8?B?WktjYU14U0p1a0lBSms2dXdxWGZmUVBITHpac2xFT3JnbHFDZ2VqQ1NzTll6?=
 =?utf-8?B?YlhJUnJCUDU0YTQ5NjhkcFh1QWVOZFQzY1A5Q1Y3bDlrRmhna0tMaXZuNWJr?=
 =?utf-8?B?cVlNYVJMZVA2L1JtQzdyeVBUQ0dmS3ZlMmRaNTZWSjZmb3dFTEdaalk0NTlp?=
 =?utf-8?B?bUdPOHNwc2JBK0ZOZkJBcDdKWWU1V09OSTZDZEdkcUcwYUJ4T3FjL2t0T0hF?=
 =?utf-8?B?T3dkaHlLNmgveUNsZlB3Ym4yZm5WVXB2QkROcnZFM00rTUZLRGM2ZEcwSk9F?=
 =?utf-8?B?V05EeFVaeElpaEsyVzhTOUZteDdBQU5kRkxzV1BJWXZkQWhxWm1mbXkrdzBz?=
 =?utf-8?B?cm1JMlFrSk4xYXZwVDlaTFkydjlCMjVkR3RTa3ExU3Rzb0hTaGFEeHdvZWkz?=
 =?utf-8?Q?MUbW0aaIYbRsqfGwmqDIbuSrK9GElAvT46smtJ2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0349f8ba-e78b-4aab-0e03-08d8eb15a432
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2021 20:29:05.7805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KJWRN9sJqx3JTKveWPMee1NhqNSQM1vR37i1DeC/If8lHCL/6uZbo9yGe+Jsfwh8jnf7ayqwrjMLoRWrwXy/gA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4334
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This caused a regression in kfdtest in a large-buffer stress test after 
memory allocation for user pages fails:

[17359.536303] amdgpu: init_user_pages: Failed to get user pages: -16
[17359.543746] BUG: kernel NULL pointer dereference, address: 0000000000000000
[17359.551494] #PF: supervisor read access in kernel mode
[17359.557375] #PF: error_code(0x0000) - not-present page
[17359.563247] PGD 0 P4D 0
[17359.566514] Oops: 0000 [#1] SMP PTI
[17359.570728] CPU: 8 PID: 5944 Comm: kfdtest Not tainted 5.11.0-kfd-fkuehlin #193
[17359.578760] Hardware name: ASUS All Series/X99-E WS/USB 3.1, BIOS 3201 06/17/2016
[17359.586971] RIP: 0010:amdgpu_ttm_backend_unbind+0x52/0x110 [amdgpu]
[17359.594075] Code: 48 39 c6 74 1b 8b 53 0c 48 8d bd 80 a1 ff ff e8 24 62 00 00 85 c0 0f 85 ab 00 00 00 c6 43 54 00 5b 5d c3 48 8b 46 10 8b 4e 50 <48> 8b 30 48 85 f6 74 ba 8b 50 0c 48 8b bf 80 a1 ff ff 83 e1 01 45
[17359.614340] RSP: 0018:ffffa4764971fc98 EFLAGS: 00010206
[17359.620315] RAX: 0000000000000000 RBX: ffff950e8d4edf00 RCX: 0000000000000000
[17359.628204] RDX: 0000000000000000 RSI: ffff950e8d4edf00 RDI: ffff950eadec5e80
[17359.636084] RBP: ffff950eadec5e80 R08: 0000000000000000 R09: 0000000000000000
[17359.643958] R10: 0000000000000246 R11: 0000000000000001 R12: ffff950c03377800
[17359.651833] R13: ffff950eadec5e80 R14: ffff950c03377858 R15: 0000000000000000
[17359.659701] FS:  00007febb20cb740(0000) GS:ffff950ebfc00000(0000) knlGS:0000000000000000
[17359.668528] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[17359.675012] CR2: 0000000000000000 CR3: 00000006d700e005 CR4: 00000000001706e0
[17359.682883] Call Trace:
[17359.686063]  amdgpu_ttm_backend_destroy+0x12/0x70 [amdgpu]
[17359.692349]  ttm_bo_cleanup_memtype_use+0x37/0x60 [ttm]
[17359.698307]  ttm_bo_release+0x278/0x5e0 [ttm]
[17359.703385]  amdgpu_bo_unref+0x1a/0x30 [amdgpu]
[17359.708701]  amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu+0x7e5/0x910 [amdgpu]
[17359.716307]  kfd_ioctl_alloc_memory_of_gpu+0x11a/0x220 [amdgpu]
[17359.723036]  kfd_ioctl+0x223/0x400 [amdgpu]
[17359.728017]  ? kfd_dev_is_large_bar+0x90/0x90 [amdgpu]
[17359.734152]  __x64_sys_ioctl+0x8b/0xd0
[17359.738796]  do_syscall_64+0x2d/0x40
[17359.743259]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[17359.749205] RIP: 0033:0x7febb083b6d7
[17359.753681] Code: b3 66 90 48 8b 05 b1 47 2d 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 81 47 2d 00 f7 d8 64 89 01 48
[17359.774340] RSP: 002b:00007ffdb5522cd8 EFLAGS: 00000202 ORIG_RAX: 0000000000000010
[17359.782668] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007febb083b6d7
[17359.790566] RDX: 00007ffdb5522d60 RSI: 00000000c0284b16 RDI: 0000000000000003
[17359.798459] RBP: 00007ffdb5522d10 R08: 00007ffdb5522dd0 R09: 00000000c4000004
[17359.806352] R10: 0000000000000000 R11: 0000000000000202 R12: 0000559416e4e2aa
[17359.814251] R13: 0000000000000000 R14: 0000000000000021 R15: 0000000000000000
[17359.822140] Modules linked in: ip6table_filter ip6_tables iptable_filter amdgpu x86_pkg_temp_thermal drm_ttm_helper ttm iommu_v2 gpu_sched ip_tables x_tables
[17359.837776] CR2: 0000000000000000
[17359.841888] ---[ end trace a6f27d64475b28c8 ]---
[17359.847318] RIP: 0010:amdgpu_ttm_backend_unbind+0x52/0x110 [amdgpu]
[17359.854479] Code: 48 39 c6 74 1b 8b 53 0c 48 8d bd 80 a1 ff ff e8 24 62 00 00 85 c0 0f 85 ab 00 00 00 c6 43 54 00 5b 5d c3 48 8b 46 10 8b 4e 50 <48> 8b 30 48 85 f6 74 ba 8b 50 0c 48 8b bf 80 a1 ff ff 83 e1 01 45
[17359.874929] RSP: 0018:ffffa4764971fc98 EFLAGS: 00010206
[17359.881014] RAX: 0000000000000000 RBX: ffff950e8d4edf00 RCX: 0000000000000000
[17359.889007] RDX: 0000000000000000 RSI: ffff950e8d4edf00 RDI: ffff950eadec5e80
[17359.897008] RBP: ffff950eadec5e80 R08: 0000000000000000 R09: 0000000000000000
[17359.905020] R10: 0000000000000246 R11: 0000000000000001 R12: ffff950c03377800
[17359.913034] R13: ffff950eadec5e80 R14: ffff950c03377858 R15: 0000000000000000
[17359.921050] FS:  00007febb20cb740(0000) GS:ffff950ebfc00000(0000) knlGS:0000000000000000
[17359.930047] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[17359.936674] CR2: 0000000000000000 CR3: 00000006d700e005 CR4: 00000000001706e0

Reverting this patch fixes the problem for me.

Regards,
   Felix

On 2021-03-18 10:57 p.m., Alex Deucher wrote:
> Applied.  Thanks!
>
> Alex
>
> On Thu, Mar 18, 2021 at 5:00 AM Koenig, Christian
> <Christian.Koenig@amd.com> wrote:
>> Reviewed-by: Christian König <christian.koenig@amd.com>
>> ________________________________
>> Von: Daniel Gomez <daniel@qtec.com>
>> Gesendet: Donnerstag, 18. März 2021 09:32
>> Cc: dagmcr@gmail.com <dagmcr@gmail.com>; Daniel Gomez <daniel@qtec.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; David Airlie <airlied@linux.ie>; Daniel Vetter <daniel@ffwll.ch>; amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; dri-devel@lists.freedesktop.org <dri-devel@lists.freedesktop.org>; linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>
>> Betreff: [PATCH] drm/radeon/ttm: Fix memory leak userptr pages
>>
>> If userptr pages have been pinned but not bounded,
>> they remain uncleared.
>>
>> Signed-off-by: Daniel Gomez <daniel@qtec.com>
>> ---
>>   drivers/gpu/drm/radeon/radeon_ttm.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/radeon/radeon_ttm.c b/drivers/gpu/drm/radeon/radeon_ttm.c
>> index e8c66d10478f..bbcc6264d48f 100644
>> --- a/drivers/gpu/drm/radeon/radeon_ttm.c
>> +++ b/drivers/gpu/drm/radeon/radeon_ttm.c
>> @@ -485,13 +485,14 @@ static void radeon_ttm_backend_unbind(struct ttm_bo_device *bdev, struct ttm_tt
>>           struct radeon_ttm_tt *gtt = (void *)ttm;
>>           struct radeon_device *rdev = radeon_get_rdev(bdev);
>>
>> +       if (gtt->userptr)
>> +               radeon_ttm_tt_unpin_userptr(bdev, ttm);
>> +
>>           if (!gtt->bound)
>>                   return;
>>
>>           radeon_gart_unbind(rdev, gtt->offset, ttm->num_pages);
>>
>> -       if (gtt->userptr)
>> -               radeon_ttm_tt_unpin_userptr(bdev, ttm);
>>           gtt->bound = false;
>>   }
>>
>> --
>> 2.30.2
>>
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
