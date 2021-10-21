Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 093F2435CE8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 10:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbhJUId7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 04:33:59 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:50197 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231153AbhJUId6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 04:33:58 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id E72A3580CBD;
        Thu, 21 Oct 2021 04:31:42 -0400 (EDT)
Received: from imap47 ([10.202.2.97])
  by compute1.internal (MEProxy); Thu, 21 Oct 2021 04:31:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type; s=fm2; bh=zv7mfGOHsGKM1zr1XZkgLlM2m8lC
        CNI7ApvR5YALR+0=; b=fi5BJHf04Hao57T1ilWW/J/38HAInMT0Or1UpL4eCTnZ
        GaaDKDzce/PtYA6ccwTHKIn/r3+EHhRQH2PRHUU90DPyaPvoC6z9ToQ0s1/jm2a+
        iYPqTC7z4l8CzdQ0NEUw+gE0AMSidlsba/Daz0uZSt+QxGJWCP1NeJAsx/iv2ijw
        jj4xuMyPdfVhWPHiiyxuxcTyJpqPC3LAJC+Vwdt7D2jJFN1rDPMDkgiVmuI99n0V
        70xzHr3Y8LriJVr3mYHNl7hIE+DqotghIJcVRyjExU7uEeZIzEiCOfF5Eu4QyjxH
        v7ffdSk8ZeOj7/4NiYKX3Xi9QVsFkgBGNGe39C1fUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=zv7mfG
        OHsGKM1zr1XZkgLlM2m8lCCNI7ApvR5YALR+0=; b=BwTfO/gNQHMyQSj2PGe/CU
        mRRjuc4s3wJl2UDBn94SfePn/dgiCdkA2awvid1an0tTfRxYjp1d5MI6y89a8KNP
        sZttXp1ZoYOPSJ0Gn4sgtc9RzAHzWwkr2KDlDTnjnknW0+lyx1akwcvxqVremAoS
        NfS0k10ZvFY1/Xed0PYMv8IYyQH75EtMY6Jx3na58FTtUE1tRC4Od857SAii2rsN
        oXOSBCFmCEVp0b855A15jnUyfukXRg4fo6WxwJqnxKigleSoaJiYJqlaABnBMHkD
        /JuBHDOoUFLPP6ixggRu7htJ62KFl2cno/ouTfjwTO4sRaxLIdjbvwf3n409RyjQ
        ==
X-ME-Sender: <xms:biVxYeLacb86JFjEgbKeY9WcCIUBUll2NUMvgNpI3O6iz2gm8TsJjQ>
    <xme:biVxYWJab9ruXDDlA_4NN0eeA9J5IjYhCMum4tBWsD-5Nj4e53kWLrNZ5g5JZk2Zi
    yLCRTrEK1i1ySESDMA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvddviedgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdfuvhgv
    nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
    htthgvrhhnpeevvdegveduvdevvdfgleefgeeivdegheeiuedtleevvdeiveevleejfeev
    tdelheenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepshhvvghnsehsvhgvnhhpvghtvghrrdgu
    vghv
X-ME-Proxy: <xmx:biVxYevfVVIfTv-YT_GKVuP3NjgVYIXthYWyfL93xvdUe1cPl5q-AQ>
    <xmx:biVxYTblRLGlEXsA0tiimOIW2wKJdJ9W8TaQim4VHsjg3I3brkzGuw>
    <xmx:biVxYVbgT779MrZEFTMEMpkn-SWf2LhZJ0xcaKPVKzoLlpQZecsaWA>
    <xmx:biVxYTOZuGFnJlSTL-LWZbW5t1tmlWGjUoKENCuRyOa5fpR6G2VswA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 2D86E2740061; Thu, 21 Oct 2021 04:31:42 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1369-gd055fb5e7c-fm-20211018.002-gd055fb5e
Mime-Version: 1.0
Message-Id: <2b8e42be-d572-42e3-8270-b673575cf022@www.fastmail.com>
In-Reply-To: <9e25f2c0-d9d3-475d-e973-63be1891f9a5@linux.intel.com>
References: <20211019163737.46269-1-sven@svenpeter.dev>
 <20211019163737.46269-5-sven@svenpeter.dev>
 <9e25f2c0-d9d3-475d-e973-63be1891f9a5@linux.intel.com>
Date:   Thu, 21 Oct 2021 10:31:21 +0200
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Lu Baolu" <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        "Robin Murphy" <robin.murphy@arm.com>
Cc:     "Arnd Bergmann" <arnd@kernel.org>, "Marc Zyngier" <maz@kernel.org>,
        "Hector Martin" <marcan@marcan.st>, linux-kernel@vger.kernel.org,
        "Alexander Graf" <graf@amazon.com>,
        "Mohamed Mediouni" <mohamed.mediouni@caramail.com>,
        "Will Deacon" <will@kernel.org>,
        "Alyssa Rosenzweig" <alyssa@rosenzweig.io>
Subject: Re: [PATCH v3 4/6] iommu: Move IOMMU pagesize check to attach_device
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, Oct 20, 2021, at 07:21, Lu Baolu wrote:
> On 2021/10/20 0:37, Sven Peter via iommu wrote:
>> The iova allocator is capable of handling any granularity which is a power
>> of two. Remove the much stronger condition that the granularity must be
>> smaller or equal to the CPU page size from a BUG_ON there.
>> Instead, check this condition during __iommu_attach_device and fail
>> gracefully.
>> 
>> Signed-off-by: Sven Peter<sven@svenpeter.dev>
>> ---
>>   drivers/iommu/iommu.c | 35 ++++++++++++++++++++++++++++++++---
>>   drivers/iommu/iova.c  |  7 ++++---
>>   include/linux/iommu.h |  5 +++++
>>   3 files changed, 41 insertions(+), 6 deletions(-)
>> 
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index dd7863e453a5..28896739964b 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -80,6 +80,8 @@ static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
>>   						 unsigned type);
>>   static int __iommu_attach_device(struct iommu_domain *domain,
>>   				 struct device *dev);
>> +static void __iommu_detach_device(struct iommu_domain *domain,
>> +				  struct device *dev);
>>   static int __iommu_attach_group(struct iommu_domain *domain,
>>   				struct iommu_group *group);
>>   static void __iommu_detach_group(struct iommu_domain *domain,
>> @@ -1974,6 +1976,19 @@ void iommu_domain_free(struct iommu_domain *domain)
>>   }
>>   EXPORT_SYMBOL_GPL(iommu_domain_free);
>>   
>> +static int iommu_check_page_size(struct iommu_domain *domain)
>> +{
>> +	if (!iommu_is_paging_domain(domain))
>> +		return 0;
>> +
>> +	if (!(domain->pgsize_bitmap & (PAGE_SIZE | (PAGE_SIZE - 1)))) {
>> +		pr_warn("IOMMU pages cannot exactly represent CPU pages.\n");
>> +		return -EFAULT;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>   static int __iommu_attach_device(struct iommu_domain *domain,
>>   				 struct device *dev)
>>   {
>> @@ -1983,9 +1998,23 @@ static int __iommu_attach_device(struct iommu_domain *domain,
>>   		return -ENODEV;
>>   
>>   	ret = domain->ops->attach_dev(domain, dev);
>> -	if (!ret)
>> -		trace_attach_device_to_domain(dev);
>> -	return ret;
>> +	if (ret)
>> +		return ret;
>> +
>> +	/*
>> +	 * Check that CPU pages can be represented by the IOVA granularity.
>> +	 * This has to be done after ops->attach_dev since many IOMMU drivers
>> +	 * only limit domain->pgsize_bitmap after having attached the first
>> +	 * device.
>> +	 */
>> +	ret = iommu_check_page_size(domain);
>> +	if (ret) {
>> +		__iommu_detach_device(domain, dev);
>> +		return ret;
>> +	}
>
> It looks odd. __iommu_attach_device() attaches an I/O page table for a
> device. How does it relate to CPU pages? Why is it a failure case if CPU
> page size is not covered?

Ideally, I'd only allow allocating DMA domains (which are going to be able
to handle larger IOMMU page sizes) while disallowing UNMANAGED domains
(which can theoretically read the granule but I doubt any client right now
considers this situation and will just run into odd issues) when the I/O
page size is bigger than the CPU page size. There was a brief previous
discussion about this [1,2,3].

Unfortunately, Apple's DART IOMMU is hardwired to either support 4K or
16K pages but never both. And to make things worse there was at least one
SoC used in the iPhones that mixed 4K and 16K DARTs on the same bus. Ugh.
That's why this awkward check is here because this is the earliest
place where I know which I/O page size will be used.


But I guess I could just limit the DART driver to 16K pages for now
(since every instance on the M1 is hard wired for that anyway) and then
just disallow allocating UNMANAGED domains when granule > PAGE_SIZE.

I'd still need a similar check here (at least for now) to prevent attaching
untrusted devices since I haven't changed swiotlb yet to support aligning
buffers correctly to more than PAGE_SIZE. That's possible but the interaction
with min_align_mask is a bit tricky to get right.
If there really shouldn't be any check here I can also do that for the next
version but I'd really like to keep that as a separate series - especially
since Thunderbolt support is still far away.


Thanks,


Sven

[1] https://lore.kernel.org/linux-iommu/7261df01-34a9-4e53-37cd-ae1aa15b1fb4@arm.com/
[2] https://lore.kernel.org/linux-iommu/CAK8P3a18XK2mfMGbZ+M32Mbabhbkd+=DNrnzampOah_j=rWozw@mail.gmail.com/
[3] https://lore.kernel.org/linux-iommu/YO%2FbMUAOLRgOJOvl@8bytes.org/
