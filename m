Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6BBC3C8321
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 12:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239209AbhGNKq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 06:46:26 -0400
Received: from mail-co1nam11on2081.outbound.protection.outlook.com ([40.107.220.81]:65456
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232133AbhGNKqZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 06:46:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=llYSRwiA2mFkTIMSPrfZtJq/v3TEh3S+bK+PdTTHPam+7VBCRUwebvxFdFNyEaw41nlVqYWRh0KgGIjS4aFWkWm2Df9nxaCx7rKGqsQLK4ICoCYowvBbC+eg49Jsd299N9yIF4sDFu1jHRMEIXbf6H2aTctRPkNqc7JVq8FLPfVpAoG3ld2fSh27xiyOLoaw0Hn+1VdfoAKmABZPi/U0Doua2toy5mLNhDw4zh2Tvv7dHhrhaL5+rFMlZzVmgdWUud/JO9UJNPTIRTX31LAcpNPtuRm7sG6vBzupcl7y5gFBi8Ve8/AGMJogxqhNjDtaKT/4SNNYs8xTsd77b3e+eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NBElTwUIGDvdrXg98Zy4Wo9uaKMNW7AjWwAqQHBKpbc=;
 b=Bcc/BAl1KwsjAWQsPKkyWirEPbNAaDhxDRWCT3LKZVRWyjqlBSmE0fXGsgEhKXVCwXH9kzgWyweAmz8nqIPpsMZz5zlWi0EHdKSopkJntZe46GN7BPKTC6Qua+PLypUhNkCIHU0zwxgNSIYUdnEvgsU4+nNFPkoiRJNeueH9J89NUNj8S0FGTB7Hanj2XY0xiZFTO4lqf1JUyFd24Pn6cxG0UFwNvVAeK4eDGqvlhu94n+kjmeIYQ6k/Bl36aC/X3iOQEk/fvht1BrTSPVP3N/XQQSEJ0YMYxBM4OZNfIK50J1EmaOQXDo4JqnYRN/vhRjHgFdunV6D97Ope3qThpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NBElTwUIGDvdrXg98Zy4Wo9uaKMNW7AjWwAqQHBKpbc=;
 b=IO1MjiqJda1oRvSW/uM+btL8cpcRrd945oN7bxfc4BI+ev2ZAtlL2JjxrkIkXlzpz8lzb4sFtQ5RnFWzSr3vI5JpciGYRO8bqZvjKfx5Y4YyT9zA4tjWC5k/YwExWnVy+8btxiPUqBxkS6vIp3TIBVkfrLwsJ05Y1BYoAARCj+E=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4992.namprd12.prod.outlook.com (2603:10b6:208:3c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Wed, 14 Jul
 2021 10:43:30 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6c9e:1e08:7617:f756]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6c9e:1e08:7617:f756%5]) with mapi id 15.20.4308.027; Wed, 14 Jul 2021
 10:43:30 +0000
Subject: Re: [PATCH] dma-buf: add kernel count for dma_buf
To:     guangming.cao@mediatek.com
Cc:     linux-kernel@vger.kernel.org
References: <1bfb2001-b7d7-28b0-7fdf-ae9dbb7395b5@amd.com>
 <20210714094454.66922-1-guangming.cao@mediatek.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <371c6f09-2bba-a9d6-18e8-114bea97a18d@amd.com>
Date:   Wed, 14 Jul 2021 12:43:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210714094454.66922-1-guangming.cao@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: PR3P251CA0009.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:102:b5::31) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:fe2b:fec6:eeb5:c7dc] (2a02:908:1252:fb60:fe2b:fec6:eeb5:c7dc) by PR3P251CA0009.EURP251.PROD.OUTLOOK.COM (2603:10a6:102:b5::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Wed, 14 Jul 2021 10:43:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 26decea5-2a35-47e2-030c-08d946b43811
X-MS-TrafficTypeDiagnostic: MN2PR12MB4992:
X-Microsoft-Antispam-PRVS: <MN2PR12MB49921D1FB1E7EF13CC45903483139@MN2PR12MB4992.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DZdprE1ZMninZL3f+kukOw28HwofUFDQ+mjFKiULm7+mR6k6u9x7Jufw6aQmoKZzdgwLHwa/ZMq+0NqEx9PPVwmVwhICaUgzMqmZdfn6A4FcS9IWakkLlXLQ9GvnzXeix3gIjAxyu1Ttm1Krhb0qICW8SnEr/avOcq4DB/UzhKhVcVOG+BaaZhDHPYs3s6QYELweTs8SZZrGVvvr0YAcAzZia9eV5nTeAViCiqwapNhCiheLeirhmorOK8xuwpbOjo9mZr9xD2yiQmpYNzHixfj8DX31VQPk3mofyqO66ecg2MbsejOCCh05PB0gvUMW+Kr3kbjQvNVhhazILgjdGKxB1ZtEtd2eOSE/UsCu/sDB/qkeweQ8oCREbMptWf0PAUsRw3X6ELjOQB4XxyTmR+HcNX6N1ngB6oqf81yqxnQhOI+ImeVshwFHTvpCkHQRLeS+/FyS27JTtG1/PwPmMTBfdDZNLRPgBtnqlcyp0bvdtBDu7RtPwMI19o5syp4Ng2IageFBSKwkt95DrLbFN+qiHcPjvwwk/zKm5ihb/JDE4WvwlexG2L9Jzi1WQBWW5TvWzqBJYWQXh9PeRIWY+F+CZXFkuJrAbVBR6rrieE24dSxgzqXtP43u91CykOMzNOFy6GZOKc3yNVujVraFNsLFayjM9JsNRiIlfrRuAYPOEm/rlUay7l5EKKpLACtTybTdqnrhY3oECO2D2H7VCarMH34MMStVM4EktDskQ7mudNH5LMVvL6KmcK8dmmdi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(366004)(136003)(396003)(39860400002)(86362001)(186003)(31696002)(6666004)(66574015)(38100700002)(83380400001)(66556008)(66476007)(31686004)(6916009)(66946007)(8936002)(5660300002)(45080400002)(478600001)(316002)(2906002)(2616005)(8676002)(6486002)(4326008)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzlsQWp2ZE9JNlFoQXRHQU14YkhkN0dhcHkrYXpPY0FrM09EMzFmQ2lHWlYz?=
 =?utf-8?B?OFJ2RUphWHd1TFlodEtVUWVPODltT3JSbDdFQVpKUFk3ZG45eU9aejViTm80?=
 =?utf-8?B?STFWaitndS9rQUxqcXkvWWtjaHFMdCsrWlVDRm02SndYZUREZGJvdFo3Mm5n?=
 =?utf-8?B?ajlOMDREV3gwV2t6Qi8rSHFFeWx3QmpQN2tCbS91VkF1ank3OGk3QkEvMjdt?=
 =?utf-8?B?dWltOWtmVm5HanVQckUxSUp3MmFRSkJGNlo3N3d4TFJTSWdBWEU1UFppOCsz?=
 =?utf-8?B?b0dJZytIaGxyNHlLU050WjRvc2p1TTJZYTNZZW0xZUxqb2xLSXVESVJiQnox?=
 =?utf-8?B?a0h1UUF2blR5cGExT1ZlTjBaMGtFZm53a1VkZnI0b241MFlSVnQ2WkloN1pO?=
 =?utf-8?B?R1ljUmcralV4TnRGSG1VREEyZ2R1R2dJMlpTMDFSOWw5Y01oYzdQUVNzZk1R?=
 =?utf-8?B?R2RaWmtOUFRJWW02NnJvNEJZdkg5YUUxNWhRVUxYdm12TGVQSTZCTHJGODB0?=
 =?utf-8?B?SlZORXAwQWFGS2VMUWhRN3REMVN6dG16WXVrMmNUK05SRjNYUXhmT05kSkc2?=
 =?utf-8?B?STQvdEZuT2wvWkdYUHlTOEtxQzFnWTFvM0xTRHFwTEppU2xCVVo2RDhWRk5O?=
 =?utf-8?B?aUlvNE9oV2l4Y2xueW9xUFlHbXlHaGZvRlBqQVNQSWpVWmcrNEk2dDk1WStz?=
 =?utf-8?B?NDl2YTFWWmxCL3QwakxaeW9TYURGMkk1Q2h5TXVJYnk0U2FueWZZWDB3bkVy?=
 =?utf-8?B?Qm5XMFU2Uk9BalYzOHgzZHFTdDEzNkxheHFRNHFSbjlKeC9vcEl6WXhOVHJ4?=
 =?utf-8?B?YWhIYnhiNzZqZjBGUVMydThsS1N1b0cycW1hR2tGK3hLa0ZvclpWcTJxc1RV?=
 =?utf-8?B?cXJVamtQdkNlK2FleEl4azYvRThJNU5mcWpIK0t6aEc0ZTV0M2gyd1orUUVN?=
 =?utf-8?B?a29VYUhzaEk0V3lxUzFvNWFsU2loZ3locnNlYlQ4WDIrZlpNVzE3WUpDR1Ey?=
 =?utf-8?B?aVF3UDZiYkpyODJHWUJpYXpQTms2VFFMNExEbzN4RWZLMXIzV0N3a3RGVkJZ?=
 =?utf-8?B?MlF0bkg4R1BoM05oNDVQUjdnUTBNcjFpNitUUy9wWC85OTR4RkhhcGt2US9t?=
 =?utf-8?B?VmFIUGt6ajZwdjg4cjB3c2lYT1E1UTFmRW9yQU80RlEzK2JVaGNxN2xrd1ZY?=
 =?utf-8?B?MzcwT1JtWUxmR01qZDlRb0dNNGdRazJXQ2EzWWZ1OGVVVTlqSGJVMU8zYjl1?=
 =?utf-8?B?NzM0K3BFWEp4ME5IUUhsRmFOaytsREpFYnUrNGdkbHZWYS9MVlJSMnNnL0Fk?=
 =?utf-8?B?eTJJb3d1dXZyVlc3ZXhWUUcwUTdGcURZUSszWkYwTnhkd0x2Z2VIbWRsYlR2?=
 =?utf-8?B?M0JFTUNEdTZrOXZER1d2dmxtMys0ZjV5bFpqbVhHdWFPekNFVmEwN1hsTzNI?=
 =?utf-8?B?elBWV2NxOGtxbnVWc09lTUl5MzFZMDR2bUc3Nk82dE9YYVVweGc4U2NjZ0hk?=
 =?utf-8?B?NG1qWGNyU1NTaVJOWk5BcHpJSXd3NHR5Nms2NGhiWTlKaElILzg1bUlHL3Yr?=
 =?utf-8?B?a0R4QjBuakdCdDhVUlNMS04zdnVUbDJRZE1rcExPd01BSGJkK3cxR3FNRUFJ?=
 =?utf-8?B?WHFuK1RCZUR5bGplOE1wakl2Y1NDbWNlQVRGRTVZTmNZMllpVmkzQU5Zb3ZJ?=
 =?utf-8?B?V1NNdTJsTDlSQ3J2bjErZTVXYjNnT043anZBeGFRYzhPZ3o4ajVrQ2IybmFN?=
 =?utf-8?B?bmdIRllqd2l4eGtROHg4cnludTlNZlplTzJGVDVXYzR4MVlHbFcwUFQ2a0gr?=
 =?utf-8?B?M3I2L2IzbzZaejM0ZVlKNWlFc1NiSktOZFpjeGlDdFNVWTVLaW1qQlJsWjh1?=
 =?utf-8?Q?So7JBvrWI+J1h?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26decea5-2a35-47e2-030c-08d946b43811
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2021 10:43:30.0661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X93yv6uhvOapjNWmYEEJzRIsaOWZTbJKCa+m2qs+6omjmkzAYJ+FBUPV9TttkRv3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4992
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 14.07.21 um 11:44 schrieb guangming.cao@mediatek.com:
> From: Guangming Cao <Guangming.Cao@mediatek.com>
>
> On Wed, 2021-07-14 at 10:46 +0200, Christian König wrote:
>> Am 14.07.21 um 09:11 schrieb guangming.cao@mediatek.com:
>>> From: Guangming Cao <Guangming.Cao@mediatek.com>
>>>
>>> Add a refcount for kernel to prevent UAF(Use After Free) issue.
>> Well NAK on so many levels.
>>
>>> We can assume a case like below:
>>>       1. kernel space alloc dma_buf(file count = 1)
>>>       2. kernel use dma_buf to get fd(file count = 1)
>>>       3. userspace use fd to do mapping (file count = 2)
>> Creating an userspace mapping increases the reference count for the
>> underlying file object.
>>
>> See the implementation of mmap_region():
>> ...
>>                   vma->vm_file = get_file(file);
>>                   error = call_mmap(file, vma);
>> ...
>>
>> What can happen is the the underlying exporter redirects the mmap to
>> a
>> different file, e.g. TTM or GEM drivers do that all the time.
>>
>> But this is fine since then the VA mapping is independent of the DMA-
>> buf.
>>
>>>       4. kernel call dma_buf_put (file count = 1)
>>>       5. userpsace close buffer fd(file count = 0)
>>>       6. at this time, buffer is released, but va is valid!!
>>>          So we still can read/write buffer via mmap va,
>>>          it maybe cause memory leak, or kernel exception.
>>>          And also, if we use "ls -ll" to watch corresponding process
>>>              fd link info, it also will cause kernel exception.
>>>
>>> Another case:
>>>        Using dma_buf_fd to generate more than 1 fd, because
>>>        dma_buf_fd will not increase file count, thus, when close
>>>        the second fd, it maybe occurs error.
>> Each opened fd will increase the reference count so this is
>> certainly
>> not correct what you describe here.
>>
>> Regards,
>> Christian.
>>
> Yes, mmap will increase file count by calling get_file, so step[2] ->
> step[3], file count increase 1.
>
> But, dma_buf_fd() will not increase file count.
> function "dma_buf_fd(struct dma_buf *dmabuf, int flags)" just get an
> unused fd, via call "get_unused_fd_flags(flags)", and call
> "fd_install(fd, dmabuf->file)", it will let associated "struct file*"
> in task's fdt->fd[fd] points to this dma_buf.file, not increase the
> file count of dma_buf.file.
> I think this is confusing, I can get more than 1 fds via dma_buf_fd,
> but they don't need to close it because they don't increase file count.
>
> However, dma_buf_put() can decrease file count at kernel side directly.
> If somebody write a ko to put file count of dma_buf.file many times, it
> will cause buffer freed earlier than except. At last on Android, I
> think this is a little bit dangerous.

dma_buf_fd() takes the dma_buf pointer and converts it into a fd. So the 
reference is consumed.

That's why users of this interface make sure to get a separate 
reference, see drm_gem_prime_handle_to_fd() for example:

...
out_have_handle:
     ret = dma_buf_fd(dmabuf, flags);
     /*
      * We must _not_ remove the buffer from the handle cache since the 
newly
      * created dma buf is already linked in the global obj->dma_buf 
pointer,
      * and that is invariant as long as a userspace gem handle exists.
      * Closing the handle will clean out the cache anyway, so we don't 
leak.
      */
     if (ret < 0) {
         goto fail_put_dmabuf;
     } else {
         *prime_fd = ret;
         ret = 0;
     }

     goto out;

fail_put_dmabuf:
     dma_buf_put(dmabuf);
out:
...

You could submit a patch to improve the documentation and explicitly 
note on dma_buf_fd() that the reference is consumed, but all of this is 
working perfectly fine.

Regards,
Christian.

>
>>> Solution:
>>>       Add a kernel count for dma_buf, and make sure the file count
>>>           of dma_buf.file hold by kernel is 1.
>>>
>>> Notes: For this solution, kref couldn't work because kernel ref
>>>          maybe added from 0, but kref don't allow it.
>>>
>>> Signed-off-by: Guangming Cao <Guangming.Cao@mediatek.com>
>>> ---
>>>    drivers/dma-buf/dma-buf.c | 23 +++++++++++++++++++----
>>>    include/linux/dma-buf.h   |  6 ++++--
>>>    2 files changed, 23 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
>>> index 511fe0d217a0..04ee92aac8b9 100644
>>> --- a/drivers/dma-buf/dma-buf.c
>>> +++ b/drivers/dma-buf/dma-buf.c
>>> @@ -62,6 +62,7 @@ static void dma_buf_release(struct dentry
>>> *dentry)
>>>      if (unlikely(!dmabuf))
>>>              return;
>>>    
>>> +   WARN_ON(atomic64_read(&dmabuf->kernel_ref));
>>>      BUG_ON(dmabuf->vmapping_counter);
>>>    
>>>      /*
>>> @@ -555,6 +556,7 @@ struct dma_buf *dma_buf_export(const struct
>>> dma_buf_export_info *exp_info)
>>>              goto err_module;
>>>      }
>>>    
>>> +   atomic64_set(&dmabuf->kernel_ref, 1);
>>>      dmabuf->priv = exp_info->priv;
>>>      dmabuf->ops = exp_info->ops;
>>>      dmabuf->size = exp_info->size;
>>> @@ -617,6 +619,9 @@ int dma_buf_fd(struct dma_buf *dmabuf, int
>>> flags)
>>>    
>>>      fd_install(fd, dmabuf->file);
>>>    
>>> +   /* Add file cnt for each new fd */
>>> +   get_file(dmabuf->file);
>>> +
>>>      return fd;
>>>    }
>>>    EXPORT_SYMBOL_GPL(dma_buf_fd);
>>> @@ -626,12 +631,13 @@ EXPORT_SYMBOL_GPL(dma_buf_fd);
>>>     * @fd:   [in]    fd associated with the struct dma_buf to be
>>> returned
>>>     *
>>>     * On success, returns the struct dma_buf associated with an fd;
>>> uses
>>> - * file's refcounting done by fget to increase refcount. returns
>>> ERR_PTR
>>> - * otherwise.
>>> + * dmabuf's ref refcounting done by kref_get to increase refcount.
>>> + * Returns ERR_PTR otherwise.
>>>     */
>>>    struct dma_buf *dma_buf_get(int fd)
>>>    {
>>>      struct file *file;
>>> +   struct dma_buf *dmabuf;
>>>    
>>>      file = fget(fd);
>>>    
>>> @@ -643,7 +649,12 @@ struct dma_buf *dma_buf_get(int fd)
>>>              return ERR_PTR(-EINVAL);
>>>      }
>>>    
>>> -   return file->private_data;
>>> +   dmabuf = file->private_data;
>>> +   /* replace file count increase as ref increase for kernel user
>>> */
>>> +   get_dma_buf(dmabuf);
>>> +   fput(file);
>>> +
>>> +   return dmabuf;
>>>    }
>>>    EXPORT_SYMBOL_GPL(dma_buf_get);
>>>    
>>> @@ -662,7 +673,11 @@ void dma_buf_put(struct dma_buf *dmabuf)
>>>      if (WARN_ON(!dmabuf || !dmabuf->file))
>>>              return;
>>>    
>>> -   fput(dmabuf->file);
>>> +   if (WARN_ON(!atomic64_read(&dmabuf->kernel_ref)))
>>> +           return;
>>> +
>>> +   if (!atomic64_dec_return(&dmabuf->kernel_ref))
>>> +           fput(dmabuf->file);
>>>    }
>>>    EXPORT_SYMBOL_GPL(dma_buf_put);
>>>    
>>> diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
>>> index efdc56b9d95f..bc790cb028eb 100644
>>> --- a/include/linux/dma-buf.h
>>> +++ b/include/linux/dma-buf.h
>>> @@ -308,6 +308,7 @@ struct dma_buf_ops {
>>>    struct dma_buf {
>>>      size_t size;
>>>      struct file *file;
>>> +   atomic64_t kernel_ref;
>>>      struct list_head attachments;
>>>      const struct dma_buf_ops *ops;
>>>      struct mutex lock;
>>> @@ -436,7 +437,7 @@ struct dma_buf_export_info {
>>>                                       .owner = THIS_MODULE }
>>>    
>>>    /**
>>> - * get_dma_buf - convenience wrapper for get_file.
>>> + * get_dma_buf - increase a kernel ref of dma-buf
>>>     * @dmabuf:       [in]    pointer to dma_buf
>>>     *
>>>     * Increments the reference count on the dma-buf, needed in case
>>> of drivers
>>> @@ -446,7 +447,8 @@ struct dma_buf_export_info {
>>>     */
>>>    static inline void get_dma_buf(struct dma_buf *dmabuf)
>>>    {
>>> -   get_file(dmabuf->file);
>>> +   if (atomic64_inc_return(&dmabuf->kernel_ref) == 1)
>>> +           get_file(dmabuf->file);
>>>    }
>>>    
>>>    /**

