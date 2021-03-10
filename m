Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DBB2333328
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 03:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232158AbhCJCdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 21:33:10 -0500
Received: from mail-eopbgr1310045.outbound.protection.outlook.com ([40.107.131.45]:18540
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231228AbhCJCcm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 21:32:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cd1K50c5Lxgof5d9Py8wFlZ2IsB2DNK10gBzCk9TjOT8RkFTUgdooJ9v6uoTBXVa01AzoeZUhQPPjRlQXyzRRxgjri7jt88ZMokQZs652Clp7SK+zAmTn+88U1fhuZ9Q1B+iqPswJHU55vf9NHYrwUoH3/BAHOe5Qj10dznqVfpp44cTK1QkeRqCf1kjmcBNSK6Z5fGrlY+JhxrsgZZQ2Xg7rsVtJaHa3W0DR2V6+3kzcpp6FLkmPTXjZR3KIvCR0enhV3AYcQx5xdRpMR07CHcz7XrhJOnJ86ILk/vfo8/KkiQ4RjWoZ8/Fw6EpOjyyo11Lc78p2vsL0eh/e0MocQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8fnhNiz1bwO5vm56jltOYl6joWGGG0dysi/7y4imvgw=;
 b=HCXfHSSyfsInr5IU4czsuba+p4hXCg+a0BC4bqB9LSGaubWqNo/P2yLfDRXbxERcj+KZXZgRNSA2JimXEBRGzDF9L1RmU9TSo2ScyJ6LtjDFfp5DGaG/Ui8yP7TkHBYEr0zcaZARp5t71cKnjIYlWrFD69oYt4fY6j1gnoe79H2GEIYE8BT/eAB94OOV8q42pxxBUXJIMOhWl1jzzcE2d9+JXCTu/i7Zz2KRSnnA3XMV8WGWLf59TXoJxQPbH+dM3daG8bLcGFMvZ4GaHLwGLrfnYcBhXbgDue4KSEi6XZkuPmKMu6h+FGpwaQMLwq/nNIhQuk5w8wvpoaiM6mVvhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8fnhNiz1bwO5vm56jltOYl6joWGGG0dysi/7y4imvgw=;
 b=mBra+lq2L9eiVf6C6vTWBtz+LhsWlgyWIEpaGYVKS4++y1ExQUit6CmEPzvKximcwIYAiu4we26VRmD9y0erBCkQSgi/dJKdetmyPqC8KTUcuqgYQ+ffazZBAJb62kcrjD0QQyHKs3ujwh8qPgj1JJctllEvRySDHrx7B9umMWU=
Authentication-Results: lists.linux.it; dkim=none (message not signed)
 header.d=none;lists.linux.it; dmarc=none action=none header.from=oppo.com;
Received: from TY2PR02MB4110.apcprd02.prod.outlook.com (2603:1096:404:fa::17)
 by TYZPR02MB5022.apcprd02.prod.outlook.com (2603:1096:400:8b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Wed, 10 Mar
 2021 02:32:37 +0000
Received: from TY2PR02MB4110.apcprd02.prod.outlook.com
 ([fe80::480b:f970:c93:6d99]) by TY2PR02MB4110.apcprd02.prod.outlook.com
 ([fe80::480b:f970:c93:6d99%3]) with mapi id 15.20.3890.039; Wed, 10 Mar 2021
 02:32:36 +0000
Subject: Re: [LTP] [f2fs] 02eb84b96b: ltp.swapon03.fail
To:     Matthew Wilcox <willy@infradead.org>,
        Weichao Guo <guoweichao@oppo.com>
Cc:     rpalethorpe@suse.de, kernel test robot <oliver.sang@intel.com>,
        lkp@intel.com, Linux Memory Management List <linux-mm@kvack.org>,
        Chao Yu <yuchao0@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        Jaegeuk Kim <jaegeuk@kernel.org>, ltp@lists.linux.it
References: <20210308072510.GA902@xsang-OptiPlex-9020>
 <87h7llhnfe.fsf@suse.de> <c75229cc-e325-1c8b-0afa-fd236db8319c@oppo.com>
 <20210309040144.GH3479805@casper.infradead.org>
From:   Huang Jianan <huangjianan@oppo.com>
Message-ID: <c84bf5c9-501e-6c25-1728-a7c6281093fd@oppo.com>
Date:   Wed, 10 Mar 2021 10:32:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
In-Reply-To: <20210309040144.GH3479805@casper.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [58.252.5.72]
X-ClientProxiedBy: HK2PR02CA0210.apcprd02.prod.outlook.com
 (2603:1096:201:20::22) To TY2PR02MB4110.apcprd02.prod.outlook.com
 (2603:1096:404:fa::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.118.0.32] (58.252.5.72) by HK2PR02CA0210.apcprd02.prod.outlook.com (2603:1096:201:20::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Wed, 10 Mar 2021 02:32:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1815d36-4512-4576-cb9e-08d8e36cc478
X-MS-TrafficTypeDiagnostic: TYZPR02MB5022:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <TYZPR02MB50229F66764D0E1DBF49A40AC3919@TYZPR02MB5022.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0VzIF/1M8gXnarymL7b2SDVRO0tCgY/WkNssHzbym3HTyAdLvJPnvPvNq7/oxP7DUCi7f1uLE09+1VjZDTllNnEbNuShQ2e3XhSWG3aUxfO6DXvcfS34xyYebdFp1oyE1UpKEw4tN/lrBDVyi3Ck//0hDcB4B/pXek+PKs/f9JHivaqLQgUmzQd0xEV7dvr0W3wcXxe7l+Wxw5xKilLI37R7saMUz9qwKSZ+bLc33MVqHP7hp7SufkgKy/b46To5QPINOAOcHW2t7qD8WDOqaLpRMvJ9NnlkaSZRecvOIFON7BROxRvtnNr/Qj9bZsuRYkZo5zHUu7dfEPXgMR9NLLivvdbJGHZgGR+Prq1aUAEPh484V/gl4SBpk9B+16CnQn91kWJuTSH3HvC/d7CcH55mcW3UW2A3/RM1PkPW2QCIEwdwa2nQH/p67RGn8jI8SNACIom6VMCreJY/Lh7AjCyak2NcQry5xNvNztA5BGTNj9sZaH6np46sf/1Hrb3vu93QTGkJTOTLz14CsfEMfVQVFaZL4BCPUycq6YShBNfp1ZlrFVL+bNyoLJ64RHof1ZSrcOQ0wjKujCXklJ0S836lRslXm2WNPkiilBw8GIybTtv3MBX+jt/ar9lx/Nn5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR02MB4110.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(366004)(396003)(136003)(39860400002)(83380400001)(6666004)(6636002)(36756003)(66476007)(66556008)(6486002)(5660300002)(66946007)(31686004)(8936002)(186003)(16526019)(7416002)(86362001)(956004)(8676002)(2616005)(26005)(478600001)(53546011)(31696002)(316002)(54906003)(16576012)(4326008)(2906002)(110136005)(52116002)(11606007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?MnVUdE9kM3p0QTNtamhaVEdPL2kyK1F1YVdlVDlXOHhxcGd6d1FwVXJmU2Zy?=
 =?utf-8?B?NmNGL2FmcHp2Ykp3cXZ2cjJYUkRkWTE2ZDhEL2R4Z21Vc0d3MFE1WXZMTlgv?=
 =?utf-8?B?blI4b0hzM0RGOWxnT2N6T0ZOUVNxUVdQRXRpczVmWWFuM00zelUxdW1jRmZZ?=
 =?utf-8?B?eVR6MmZVM0htamNkYW52UU1oOWJDWjF3eXhVcXNnd3g5cklaMHN5dHJYV2lY?=
 =?utf-8?B?TWlLVFNxVE9QbFBUdTRYODBPZ3UveGFKdXdVdXdqQ3FyaVQ0RTdKM2VXdWRv?=
 =?utf-8?B?R2V5MzNwRkVqZmNZb1p5Y0UzT0ZDSklmL2NzK2MyWU90UFlSaDk4K1Q3ZStn?=
 =?utf-8?B?WCtyL29HRG05K1lKdGNjTWtHbEhVbWMwL293K2RSRnQyQndkeHhZMzR0VHl1?=
 =?utf-8?B?b3FRQjBYWll4b21MVEhDVTdkZnlHZEdwaFZ2dDU2SDRCZk9EZmtoOGdSU0xR?=
 =?utf-8?B?MkNBcVY3OEJaWURKNWR5MWNyQzhBay90WDdKbUtaU1hzMkVjclNNcU9QTHBq?=
 =?utf-8?B?K2dQSit6dkxkc0xwcFovY3NYNjBHMWxGVHg5TGR3TGZ2Yld6M0x1TnN1U2N2?=
 =?utf-8?B?ZEViSStYZVNCbmVSUmtiRDgrQ1NzeURwaUxQclJOSGE5b0Z6cEFGMi9hWGNN?=
 =?utf-8?B?Y0paT3NPZXpmeG1ES0RyWGNDTDdaQlAyRHFXYWRQSUZwUmJlSk5uNUJ4czZ1?=
 =?utf-8?B?LzJPNjhhMFI2S1FnbC9XU3JnQ3RFQ1F1eGlxelhBYWY1WWZzUmt4YzEzdkVB?=
 =?utf-8?B?N1NzWnArMWExWWFzVWh4NE4rRFNrc1I1bDdNbHJPYUxxYkxGVHE0dnI0enMz?=
 =?utf-8?B?ZVNCUWhPQnVmdXRrNFZ5aEhvckJ4Q1gzZjN5a1NiNU8zOW10NXhBT3hXOUNz?=
 =?utf-8?B?Sm5oZFBQV09pbDhYZ3g2SzBtWFF4KzRWSnFpelVxcEFoTUFBeGdPUlBielRZ?=
 =?utf-8?B?SDZPOHkxbXBOZlJ3QmliVjE4dEZqNnNyU1JIcVpuaVBBYndWcVYzdkNHa0M1?=
 =?utf-8?B?RDUyWEFXZ3N5TkV0bERodkdDUTN1empaOG9hS2dRZmRNTkpnK2pUL2YzTTVC?=
 =?utf-8?B?cldXTDVkU1N0eGNzK2xmWGNtWWpmTDBjb0paQzcyaysydlY1ZmloaHBhK2NN?=
 =?utf-8?B?RGdBcEVyeTRNNEV5cVNjaVM5VTNONjZXMHV1M2Mwb3lESHBXNkF2YnNVZ2hw?=
 =?utf-8?B?Nkt2TXpjU3gxL21hQys2YmNyeDMwdXBvSmxjQ3ZkcUVRUTY3UU1LSEM3RVZ3?=
 =?utf-8?B?QWN3WksxMkJKSWUvanZKejd6WkdzclBsQ1ZWbnFlc1czSytkV2RPUDhIRVhQ?=
 =?utf-8?B?STZ1dnR5a2RsZTh4Y2pRdUNBZmhqZjhVblE3TWh3dUxLSlEwU1JoZUI1cFhO?=
 =?utf-8?B?QWlxa3NVWXF5Y3pDQUZDYXpXNzdhTHNUaS9acFk5Tk1BU2NRY1FLUGJRazF0?=
 =?utf-8?B?NlEwWUc2WTJLL2xyeDBQQUx3WnhucWZyanV5YmxncHY1SmNraFo3OWM4VGZr?=
 =?utf-8?B?dFY3SkoveUZZVm54RUhyY2JUYk9YUWVtK0xhQ2hyUVNkNy8xbkNWVE41WGtS?=
 =?utf-8?B?NjVCVTY4aWlkMEhXRUtCQklRVkZnVVdZM203V2F1YUUvbVRPa1NtUDMrazl1?=
 =?utf-8?B?aXV1Q1RKb2V5dDFXRkp2M0M0RU5xejhYN09OZGE1K0s4emYvOHAzMkRDblBK?=
 =?utf-8?B?RzRVRVpvMDlHMXBYTWR2ZHQrRFdOTmtoTGJSSG9PRjlLY2FzUGZnS0o1Z2JY?=
 =?utf-8?Q?hwm+ATcmL1IuXgutl9MTTFMwuEEtEcYOgfw2Aiq?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1815d36-4512-4576-cb9e-08d8e36cc478
X-MS-Exchange-CrossTenant-AuthSource: TY2PR02MB4110.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2021 02:32:36.8327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wrwSzygHzGj9oKqpT/M15CO49gc/sjLAxfb294Sr8o1LyLEgKTAAwKOfZtWRc/r1hEt0o7aI0f6kVnJt9vLl5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR02MB5022
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard,

On 2021/3/9 12:01, Matthew Wilcox wrote:
> On Tue, Mar 09, 2021 at 10:23:35AM +0800, Weichao Guo wrote:
>> Hi Richard,
>>
>> On 2021/3/8 19:53, Richard Palethorpe wrote:
>>> Hello,
>>>
>>>> kern  :err   : [  187.461914] F2FS-fs (sda1): Swapfile does not align to section
>>>> commit 02eb84b96bc1b382dd138bf60724edbefe77b025
>>>> Author: huangjianan@oppo.com <huangjianan@oppo.com>
>>>> Date:   Mon Mar 1 12:58:44 2021 +0800
>>>>       f2fs: check if swapfile is section-alligned
>>>>       If the swapfile isn't created by pin and fallocate, it can't be
>>>>       guaranteed section-aligned, so it may be selected by f2fs gc. When
>>>>       gc_pin_file_threshold is reached, the address of swapfile may change,
>>>>       but won't be synchronized to swap_extent, so swap will write to wrong
>>>>       address, which will cause data corruption.
>>>>       Signed-off-by: Huang Jianan <huangjianan@oppo.com>
>>>>       Signed-off-by: Guo Weichao <guoweichao@oppo.com>
>>>>       Reviewed-by: Chao Yu <yuchao0@huawei.com>
>>>>       Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>> The test uses fallocate to preallocate the swap file and writes zeros to
>>> it. I'm not sure what pin refers to?
>> 'pin' refers to pinned file feature in F2FS, the LBA(Logical Block Address)
>> of a file is fixed after pinned. Without this operation before fallocate,
>> the LBA may not align with section(F2FS GC unit), some LBA of the file may
>> be changed by F2FS GC in some extreme cases.
>>
>> For this test case, how about pin the swap file before fallocate for F2FS as
>> following:
>>
>> ioctl(fd, F2FS_IOC_SET_PIN_FILE, true);
> No special ioctl should be needed.  f2fs_swap_activate() should pin the
> file, just like it converts inline inodes and disables compression.

Now f2fs_swap_activate() will pin the file. The problem is that when 
f2fs_swap_activate()

is executed, the file has been created and may not be section-aligned.

So I think it would be better to consider aligning the swapfile during 
f2fs_swap_activate()?

