Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D86B4437202
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 08:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231997AbhJVGp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 02:45:28 -0400
Received: from mail-mw2nam10on2080.outbound.protection.outlook.com ([40.107.94.80]:39749
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229609AbhJVGpZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 02:45:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KffSqF9zHAh9jYbAxFdyTmrt5w7hky1cEbSHwmBC+HPy4IUWDh6pCFH+XWYEVLfZrpM6yEFAsG+ppuN8WJGHaSnL8NpZUhS+KA4E9uQsaHRiylY7mvmQxyuhu2Cd+IvobFnjqLRH1ZYV0A/+a2T5pVfYhF2YxhMedwzMEwn/XUrSQxXGeDAZUzDgB3OZCwNC0ghAE6vfv6DjhhphH7Pf04SUZJiIg+h8DtsHK6qhUZp52+GpRAEX7kTLyqi2hGQohI29Xp6N/EDCXW2HWE+PIPuoRsd+PX4V2AvnmFRo4onijILmdrBSdz0xvup/iJomvrk+DzJDWbA0Tj5TllZX9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Gae8WlVTuEmYJXHsuYSfLMGUna6NOrIuLtaqIYv0uo=;
 b=dsgTAyh0RPmqGBNSBIV9HxQUeqIB8ZWWxPrBwg5/OnzwWxQdUXQpi5Nt4TGi4AOfP7+EITnDaj++TZ3HPP4tS8QTQvh6Re+yIpeOM80bZb9axEOPHZ9T42T/NALjiNr7DlvCXfAVGRrJn48ajONgeEQrLZvalr96M4HqBb2TxAsbO6gnGPLRNlk1CdGjpzrJX4ZQNzx/fOavL+dez7ZKlsRMmIe3BB7eMeSvm6g++g56SGxF8L9cUc1XkDcFaO5LF9tg7NRCgZziPVG+iAzVb1N5Ue/mjsJ7QL+GxnrgQVMdgLYFpKXU6z8ot9jGfK5lgyZ+/9cgvZxfHnNSFvfIvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Gae8WlVTuEmYJXHsuYSfLMGUna6NOrIuLtaqIYv0uo=;
 b=S2OsOU2iBtzcfePvGYimJF/V2wA3RgJAvOH9vMRJ+2U1dzuY5052OP88rOo119Wf5f6kDqGAQNlQVZWeGpASWfR34HWYCZ+4lSboRkRDHksj0Ti7d2Zp1NFu23qFyjokPPXl775cL8HlP5U3A3w+ioRzpUZO5bU2Wq+MUjP5zu4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5176.namprd12.prod.outlook.com (2603:10b6:208:311::19)
 by BL0PR12MB5555.namprd12.prod.outlook.com (2603:10b6:208:1c2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Fri, 22 Oct
 2021 06:43:07 +0000
Received: from BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::e8e1:a20d:de7c:8b53]) by BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::e8e1:a20d:de7c:8b53%3]) with mapi id 15.20.4608.019; Fri, 22 Oct 2021
 06:43:07 +0000
Subject: Re: [PATCH v2 2/2] platform/x86: amd-pmc: Add support for AMD Smart
 Trace Buffer
To:     mgross@linux.intel.com, Sanket Goswami <Sanket.Goswami@amd.com>
Cc:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211021093106.196989-1-Sanket.Goswami@amd.com>
 <20211021235753.GF63795@linux.intel.com>
From:   Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Message-ID: <b2d7cb80-a8dc-3951-252f-63ff413ed5b0@amd.com>
Date:   Fri, 22 Oct 2021 12:12:57 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211021235753.GF63795@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0085.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00::25)
 To BL1PR12MB5176.namprd12.prod.outlook.com (2603:10b6:208:311::19)
MIME-Version: 1.0
Received: from [192.168.1.183] (43.224.156.105) by MA1PR01CA0085.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend Transport; Fri, 22 Oct 2021 06:43:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6588bfef-5ffb-4dff-ec7a-08d9952734d2
X-MS-TrafficTypeDiagnostic: BL0PR12MB5555:
X-Microsoft-Antispam-PRVS: <BL0PR12MB555597C8D7ABDFC5431BAFF09A809@BL0PR12MB5555.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rEleAmNxsbo7nn9VsBxwc4m1zwLX+h3zwWB9/paf8116C/27mrdgAuxSQ/THgowp155UVh0gxC65ISaJGAYVBhGCtdZtcqUzbkwQSNxDXSdmQmrB/GeGUv7JI7ycbkKqeePZVQDUxW2m2YSriVEbsMGxXlEHwvmWGMLt2dmeOxN3IfTBD0Eqp4gtmjT0PsTtPXlrPGULiTlXCV2BIMhA71QdRvJezfedqGsfGPs1NsvWH52sbacyB4dy+N3zfqgVBvtTrKVw6VurK+Q4PMO3k8BshqJT1gxmFkCiKP6XgMHFHNmqtH8KzQ0v2w+sI1hnqvmxyrF5B+9r9EgK+p1z4MPSroEn7ChguRF2jgEWSpTjL839YnQpF+gRbYZ5xtTLTyGrNHjZGxZIvSeWAtje98Y4uth1og4v/i//3jIgeGU43aciwZyJUcnMePdjqpduOjKqwku8RlhJ1XBV6taaK6JYJWG7p3W6IToSmXosiOIS9jCboi2K0+ydxdWVPY1fAblSqVlKYuNloSTBQB4j/tfhpDJvH2WD9L7NCnmpTvEWXxTHTD6IsGaTwda49Q9qrCwX0UJn3GTeDD5cFQ5KBnlvD7ZJ3VpaZIVJubDX/TtQbgpygc0tB/0K7EjoSa5lsoXMtKoCqbA6ukEDiiKWd+XvBH73I05Xnsez3tQlN8OQp018I/0CW60l82F4tbfcwG+mH1HhHVLs1mamysGEh6+FrimXiJahnm50jRVv29A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(31696002)(36756003)(956004)(8676002)(2616005)(186003)(86362001)(26005)(8936002)(508600001)(66946007)(83380400001)(6636002)(16576012)(37006003)(66476007)(5660300002)(316002)(38100700002)(66556008)(4326008)(31686004)(53546011)(6486002)(6666004)(2906002)(6862004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZS9XZnRaYmRSbThabW10NUNxTkRGSDllb1NoVVJWMk5kQ0lmRFJsbmVCSnI3?=
 =?utf-8?B?dmZtTkUzMlo1bDgrWnU1ZE9vOFpSYk1RNUhoSlFVK29zVUtsd0F6cTlkNFNi?=
 =?utf-8?B?Yy81SzJwSWFjQmg0dzNBekxYY0x1K1JENTZMa05pb3pjeEE3SXErampVREh4?=
 =?utf-8?B?MWNiaXRqbURxY2xzR2RpaEZhSUgrdEpzTDhsSmMrOXMyWW5hUEp4dDdaWEpl?=
 =?utf-8?B?RUhWOW9iTnpXU2cxenZnbHhkeFN1SEdMS0duQmp2Nm1OK05RVnpscUhCQjVM?=
 =?utf-8?B?ZVJFQ3ZuSVVIdW5OTTZYb2QwcE5OZHU3c2pJK3NNSWZ1RjY0MjVnVytNSzlG?=
 =?utf-8?B?OUxZOStNMkJ6N3ZzYXpiblFlQW5nWDFXdk12ZkNsa2ZITFVxOFZlanBQVmF2?=
 =?utf-8?B?ZTc4d25GeGozVkIwNnJWNzI5S1lKd21jTmUvUkVWQ2hsZVZpTFlMb2lHQnRW?=
 =?utf-8?B?d2o3K0VyeXNDSlBhZlVOZ2Q4aGlHWThWSkxWRm1Yc0crR3RJSUk0OFZnY1pW?=
 =?utf-8?B?eCtxVEI4UURZR051SENqOEJvNFpTVTlQUzVXOTRBdzVVT000a1c2VGFWOXFp?=
 =?utf-8?B?a0EwWGlKOFFVcDBsUkF2M2UzQ3VVTHM0Wnh2N0tyWlBqQmt5VSt6N2lQdW81?=
 =?utf-8?B?VW9HdEVMYkZ3cklQckI4dWlnSHlEcmZneXJLVEZaMnpmVEhmaUZ3dVFLUE1S?=
 =?utf-8?B?WkNzbVVYbFJQZTRHUnJjVVgzUmVjVll3MVY5L0JhajRMWmlmOGFOUGo4d1Fv?=
 =?utf-8?B?QjFEalZiWkVqRnd6L0kvaFNOSEZhUjFlMENkZE10TkZYT2RGNVZLWWpIeTlV?=
 =?utf-8?B?YlZLTDNHUTdUbmE4RjNpWkROak1QNnpPZWFJZkQxWGVLeFo0R3ZyZVByWE9n?=
 =?utf-8?B?WUVPWjI0TjUwbi92Sk04clMzUkU1TEF0Tk9WY2NkSnUydUZsQk5mTFNwRndh?=
 =?utf-8?B?VWlheTR2Vm94YlhSNHFsaXVPcVZEZWlnbGhQdWZaaTkvL05kT0xKdFRUWkth?=
 =?utf-8?B?RzVyVUhGSW5Mb1czK2pLZXVLbGlyaDBNZjJqNTdGREEyaVBKbDRGUkd2Ry9w?=
 =?utf-8?B?Y3pSaVNtN1lua1dDQnc3cGVWZTVhU2FUWVBpelRiaFhMVFdhME5hOTRUdSt3?=
 =?utf-8?B?K21zaEcrV3U4TkkrVVlGRnhmcW1FSSt5ZC9ENVdlMnFUZ3VXdkZoNXZVZHds?=
 =?utf-8?B?QnpMaUZwNER6clk2ckpPY3JYNEZDTXBOZTRZemVmSDhUK2NUdFM3UGk2V1Bq?=
 =?utf-8?B?YkJxWVlLM1pXUzdSRFRuRmJMbjV6VlRPelArVUFrSU9xMEI0U0RxNVdlMFFk?=
 =?utf-8?B?R1VOaFFFMlN2UExudDdveFVTU0ZjWDVXbUtuUVFUdzBrbm5zbW92MkdkT20v?=
 =?utf-8?B?T1k0Z0s2aVh1WUVrclRreDNLMnlZUlUzNjZ0NkhhaStnMTNMaHFZTUd4aGtq?=
 =?utf-8?B?bTFYSktjVXVkSmd4QWZzY3VqYWNMeWV2NlpLSWRnajVTMnprS1h5b3cvejYy?=
 =?utf-8?B?YXo0MFJBZFBTajRPVll0TXlzWnJhNFpDRURtdms2eGliS0tnWlVFK0tzcmti?=
 =?utf-8?B?eTBSRGpocnVZVWUvdUthd1czMjJhL3Z3ZWxkeWs2TWxXUUR1MnFCZEJvVDVm?=
 =?utf-8?B?cXZUbGdCZ1FEU2kranNXMWdBaFhzWk5ySE1XVm9IWisreExXUXNtTnlBdkc5?=
 =?utf-8?B?TGVCbHd2SmtHRm0xMW80T2dkNTRuYml4ZTRCK2lEL3B4d2NRSnVPV0FxR2FV?=
 =?utf-8?B?aVJmYmo3TTNJUVY2T1dsMkJGaHMwalk1VWNnbk1obHRSckZtMEdIMGwxSzhQ?=
 =?utf-8?B?SUtneFhJemZSMzUvc095TGFLV0pQK25ZTFVRem0zMDFSR2g0UnRocmw0SmN2?=
 =?utf-8?B?V1hjMXRjdVVETGVQZnJ0Z0ttK2hKTkJ1WGdUMmJqTmtNdGRkLzJkTWNTTlpK?=
 =?utf-8?Q?G5MzEHOmOkk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6588bfef-5ffb-4dff-ec7a-08d9952734d2
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2021 06:43:07.3680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ssundark@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5555
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On 10/22/2021 5:27 AM, mark gross wrote:
> On Thu, Oct 21, 2021 at 03:01:06PM +0530, Sanket Goswami wrote:
>> STB (Smart Trace Buffer), is a debug trace buffer which is used to help
>> isolate failures by analyzing the last feature that a system was running
>> before hitting a failure. This nonintrusive way is always running in the
>> background and trace is stored into the SoC.
>>
>> This patch provides mechanism to access the STB buffer using the read
>> and write routines.
> I don't see the write routine exported.

There is a function which does this job amd_pmc_write_stb()

OR

You mean to say EXPORT_SYMBOL() ?

> 
>>
>> Co-developed-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
>> Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
>> Signed-off-by: Sanket Goswami <Sanket.Goswami@amd.com>
>> ---
>> Changes in v2:
>> - Create amd_pmc_stb_debugfs_fops structure to get STB data.
>> - Address review comments from Hans.
>>
>>  drivers/platform/x86/amd-pmc.c | 120 +++++++++++++++++++++++++++++++++
>>  1 file changed, 120 insertions(+)
>>
>> diff --git a/drivers/platform/x86/amd-pmc.c b/drivers/platform/x86/amd-pmc.c
>> index 502f37eaba1f..df53c5996e2c 100644
>> --- a/drivers/platform/x86/amd-pmc.c
>> +++ b/drivers/platform/x86/amd-pmc.c
>> @@ -33,6 +33,12 @@
>>  #define AMD_PMC_SCRATCH_REG_CZN		0x94
>>  #define AMD_PMC_SCRATCH_REG_YC		0xD14
>>  
>> +/* STB Registers */
>> +#define AMD_PMC_STB_INDEX_ADDRESS	0xF8
>> +#define AMD_PMC_STB_INDEX_DATA		0xFC
>> +#define AMD_PMC_STB_PMI_0		0x03E30600
>> +#define AMD_PMC_STB_PREDEF		0xC6000001
>> +
>>  /* Base address of SMU for mapping physical address to virtual address */
>>  #define AMD_PMC_SMU_INDEX_ADDRESS	0xB8
>>  #define AMD_PMC_SMU_INDEX_DATA		0xBC
>> @@ -80,6 +86,7 @@
>>  #define SOC_SUBSYSTEM_IP_MAX	12
>>  #define DELAY_MIN_US		2000
>>  #define DELAY_MAX_US		3000
>> +#define FIFO_SIZE		4096
>>  enum amd_pmc_def {
>>  	MSG_TEST = 0x01,
>>  	MSG_OS_HINT_PCO,
>> @@ -126,8 +133,14 @@ struct amd_pmc_dev {
>>  #endif /* CONFIG_DEBUG_FS */
>>  };
>>  
>> +static bool enable_stb;
>> +module_param(enable_stb, bool, 0644);
>> +MODULE_PARM_DESC(enable_stb, "Enable the STB debug mechanism");
>> +
>>  static struct amd_pmc_dev pmc;
>>  static int amd_pmc_send_cmd(struct amd_pmc_dev *dev, bool set, u32 *data, u8 msg, bool ret);
>> +static int amd_pmc_write_stb(struct amd_pmc_dev *dev, u32 data);
> shouldn't this be exported as a kernel API to log stuff?  seems like a waist to
> only log the pmc suspend resume status.

Agree. But currently there are no drivers *yet* who are consumers of STB
in the context of APU. PMC is the only driver which is currently taking
advantage of the STB mechanism which is quite useful in debugging the
s2idle failures.

As per STB Spec, not all drivers are allowed to write to the STB buffer.

> 
>> +static int amd_pmc_read_stb(struct amd_pmc_dev *dev, u32 *buf);
>>  
>>  static inline u32 amd_pmc_reg_read(struct amd_pmc_dev *dev, int reg_offset)
>>  {
>> @@ -156,6 +169,51 @@ struct smu_metrics {
>>  	u64 timecondition_notmet_totaltime[SOC_SUBSYSTEM_IP_MAX];
>>  } __packed;
>>  
>> +static int amd_pmc_stb_debugfs_open(struct inode *inode, struct file *filp)
>> +{
>> +	struct amd_pmc_dev *dev = filp->f_inode->i_private;
>> +	u32 *buf;
>> +	int rc;
>> +
>> +	buf = devm_kmalloc(dev->dev, FIFO_SIZE * 4, GFP_KERNEL);
> would it be more readable to use sizeof(u32)?
> 
>> +	if (!buf)
>> +		return -ENOMEM;
>> +
>> +	rc = amd_pmc_read_stb(dev, buf);
>> +	if (rc)
>> +		goto out;
>> +
>> +	filp->private_data = buf;
>> +
>> +out:
>> +	return rc;
>> +}
>> +
>> +static ssize_t amd_pmc_stb_debugfs_read(struct file *filp, char __user *buf, size_t size,
>> +					loff_t *pos)
>> +{
>> +	if (!filp->private_data)
>> +		return -EINVAL;
>> +
>> +	return simple_read_from_buffer(buf, size, pos, filp->private_data,
>> +				       FIFO_SIZE * 4);
> would it be more readable to use sizeof(u32)?
>> +}
>> +
>> +static int amd_pmc_stb_debugfs_release(struct inode *inode, struct file *filp)
>> +{
>> +	kfree(filp->private_data);
>> +	filp->private_data = NULL;
>> +
>> +	return 0;
>> +}
>> +
>> +const struct file_operations amd_pmc_stb_debugfs_fops = {
>> +	.owner = THIS_MODULE,
>> +	.open = amd_pmc_stb_debugfs_open,
>> +	.read = amd_pmc_stb_debugfs_read,
>> +	.release = amd_pmc_stb_debugfs_release,
> are you missing a write fop?  you commit comment talked about a write routine.

As per the STB spec no userspace should write to STB buffer. Hence we
took a call not to include ".write" fop. But yes, userland can read the
buffer any given time.

Rest of the comments will be addressed in the next revision.

Thanks,
Shyam
