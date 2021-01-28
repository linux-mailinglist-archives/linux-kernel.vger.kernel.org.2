Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34D38306C45
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 05:33:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbhA1EcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 23:32:18 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34494 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229528AbhA1EcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 23:32:16 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 10S3WSkn115533;
        Wed, 27 Jan 2021 22:53:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=references : from : to :
 cc : subject : in-reply-to : date : message-id : mime-version :
 content-type; s=pp1; bh=mphtyr7bxoawE01T3pM8T9wObaEFhCrepFpBhh7nMlA=;
 b=k8vWXsAimExK65/25AL1Dx5UF7MqJTHm+v8TStgFR/UD87qFTrqvJzc4nVWSWE+UaabI
 3s/WiuuQXRwjsxi5spkZ7WPFNFSNIoqHYcX9IC+OGIaSe1E6dPu525gL7T6XBXxef2Ly
 v0PWdLhSwUnG0Vurrg/ExR5Z7REhQNbCiF2ZBTKwI0yAmKiJFiCmv43k9WBKj4dxQMkH
 oX5xXS/Dfw6Mctr0kbsEuEdsRXjoeL2CRCR2RQD/vcGYoIBw/1x7dAJ/fMZr4MO/+bHM
 81UcobnoR9Xor0jpfbIEPDGRBCDIc931gb6CN/t8ZOUN/yp54TfowrKVlpdS2OQJS41Q NA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36bdh8kq7c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Jan 2021 22:53:01 -0500
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 10S3qiEH184922;
        Wed, 27 Jan 2021 22:53:01 -0500
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36bdh8kq72-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Jan 2021 22:53:00 -0500
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 10S3VsHp021689;
        Thu, 28 Jan 2021 03:53:00 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma03wdc.us.ibm.com with ESMTP id 36a0t2tua7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Jan 2021 03:53:00 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 10S3qxpa19792354
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jan 2021 03:52:59 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0ABE0BE051;
        Thu, 28 Jan 2021 03:52:59 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BA087BE04F;
        Thu, 28 Jan 2021 03:52:50 +0000 (GMT)
Received: from manicouagan.localdomain (unknown [9.85.200.195])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Thu, 28 Jan 2021 03:52:50 +0000 (GMT)
References: <20210115173017.30617-1-nramas@linux.microsoft.com>
 <20210115173017.30617-10-nramas@linux.microsoft.com>
 <20210127165208.GA358@willie-the-truck>
 <d3330793-6054-6e59-b727-44bf8e5653cd@linux.microsoft.com>
 <20210127184319.GA676@willie-the-truck>
User-agent: mu4e 1.4.10; emacs 27.1
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     Will Deacon <will@kernel.org>
Cc:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        zohar@linux.ibm.com, robh@kernel.org, takahiro.akashi@linaro.org,
        gregkh@linuxfoundation.org, catalin.marinas@arm.com,
        mpe@ellerman.id.au, james.morse@arm.com, sashal@kernel.org,
        benh@kernel.crashing.org, paulus@samba.org, frowand.list@gmail.com,
        vincenzo.frascino@arm.com, mark.rutland@arm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        pasha.tatashin@soleen.com, allison@lohutok.net,
        masahiroy@kernel.org, bhsharma@redhat.com, mbrugger@suse.com,
        hsinyi@chromium.org, tao.li@vivo.com, christophe.leroy@c-s.fr,
        prsriva@linux.microsoft.com, balajib@linux.microsoft.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v15 09/10] arm64: Call kmalloc() to allocate DTB buffer
In-reply-to: <20210127184319.GA676@willie-the-truck>
Date:   Thu, 28 Jan 2021 00:52:48 -0300
Message-ID: <871re5soof.fsf@manicouagan.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-27_10:2021-01-27,2021-01-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=999 adultscore=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101280014
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Will Deacon <will@kernel.org> writes:

> On Wed, Jan 27, 2021 at 09:59:38AM -0800, Lakshmi Ramasubramanian wrote:
>> On 1/27/21 8:52 AM, Will Deacon wrote:
>> 
>> Hi Will,
>> 
>> > On Fri, Jan 15, 2021 at 09:30:16AM -0800, Lakshmi Ramasubramanian wrote:
>> > > create_dtb() function allocates kernel virtual memory for
>> > > the device tree blob (DTB).  This is not consistent with other
>> > > architectures, such as powerpc, which calls kmalloc() for allocating
>> > > memory for the DTB.
>> > > 
>> > > Call kmalloc() to allocate memory for the DTB, and kfree() to free
>> > > the allocated memory.
>> > > 
>> > > Co-developed-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
>> > > Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
>> > > Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
>> > > ---
>> > >   arch/arm64/kernel/machine_kexec_file.c | 12 +++++++-----
>> > >   1 file changed, 7 insertions(+), 5 deletions(-)
>> > > 
>> > > diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
>> > > index 7de9c47dee7c..51c40143d6fa 100644
>> > > --- a/arch/arm64/kernel/machine_kexec_file.c
>> > > +++ b/arch/arm64/kernel/machine_kexec_file.c
>> > > @@ -29,7 +29,7 @@ const struct kexec_file_ops * const kexec_file_loaders[] = {
>> > >   int arch_kimage_file_post_load_cleanup(struct kimage *image)
>> > >   {
>> > > -	vfree(image->arch.dtb);
>> > > +	kfree(image->arch.dtb);
>> > >   	image->arch.dtb = NULL;
>> > >   	vfree(image->arch.elf_headers);
>> > > @@ -59,19 +59,21 @@ static int create_dtb(struct kimage *image,
>> > >   			+ cmdline_len + DTB_EXTRA_SPACE;
>> > >   	for (;;) {
>> > > -		buf = vmalloc(buf_size);
>> > > +		buf = kmalloc(buf_size, GFP_KERNEL);
>> > 
>> > Is there a functional need for this patch? I build the 'dtbs' target just
>> > now and sdm845-db845c.dtb is approaching 100K, which feels quite large
>> > for kmalloc().
>> 
>> Changing the allocation from vmalloc() to kmalloc() would help us further
>> consolidate the DTB setup code for powerpc and arm64.
>
> Ok, but at the risk of allocation failure. Can powerpc use vmalloc()
> instead?

I believe this patch stems from this suggestion by Rob Herring:

> This could be taken a step further and do the allocation of the new
> FDT. The difference is arm64 uses vmalloc and powerpc uses kmalloc. The
> arm64 version also retries with a bigger allocation. That seems
> unnecessary.

in https://lore.kernel.org/linux-integrity/20201211221006.1052453-3-robh@kernel.org/

The problem is that this patch implements only part of the suggestion,
which isn't useful in itself. So the patch series should either drop
this patch or consolidate the FDT allocation between the arches.

I just tested on powernv and pseries platforms and powerpc can use
vmalloc for the FDT buffer.

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
