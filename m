Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE4D396D7F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 08:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233023AbhFAGly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 02:41:54 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:6104 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232989AbhFAGlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 02:41:52 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FvMsL4DYjzYpFk;
        Tue,  1 Jun 2021 14:37:26 +0800 (CST)
Received: from dggpemm500012.china.huawei.com (7.185.36.89) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 1 Jun 2021 14:40:09 +0800
Received: from [10.174.176.189] (10.174.176.189) by
 dggpemm500012.china.huawei.com (7.185.36.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 1 Jun 2021 14:40:08 +0800
Subject: Re: [PATCH -next] x86/platform/uv: functions should not be declared
 extern
To:     <mike.travis@hpe.com>, <dimitri.sivanich@hpe.com>,
        <russ.anderson@hpe.com>, <dvhart@infradead.org>,
        <andy@infradead.org>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <bp@alien8.de>, <x86@kernel.org>, <hpa@zytor.com>
CC:     <steve.wahl@hpe.com>, <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20210531060747.21934-1-linqiheng@huawei.com>
From:   Qiheng Lin <linqiheng@huawei.com>
Message-ID: <06d88bb6-650d-9b94-f4e6-e274dd188ca1@huawei.com>
Date:   Tue, 1 Jun 2021 14:40:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210531060747.21934-1-linqiheng@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.189]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500012.china.huawei.com (7.185.36.89)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ÔÚ 2021/5/31 14:07, Qiheng Lin Ð´µÀ:
> These function declarations in 'bios.h' are already marked extern, thus
> their definition should not have the keyword.
> 
> This quiets the following sparse warnings:
>   function 'uv_bios_get_master_nasid' with external linkage has definition
>   function 'uv_bios_get_heapsize' with external linkage has definition
>   function 'uv_bios_install_heap' with external linkage has definition
>   function 'uv_bios_obj_count' with external linkage has definition
>   function 'uv_bios_enum_objs' with external linkage has definition
>   function 'uv_bios_enum_ports' with external linkage has definition
>   function 'uv_bios_get_geoinfo' with external linkage has definition
>   function 'uv_bios_get_pci_topology' with external linkage has definition
> 
> Signed-off-by: Qiheng Lin <linqiheng@huawei.com>
> ---
>   arch/x86/platform/uv/bios_uv.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/platform/uv/bios_uv.c b/arch/x86/platform/uv/bios_uv.c
> index bf31af3d32d6..7e7634c8be62 100644
> --- a/arch/x86/platform/uv/bios_uv.c
> +++ b/arch/x86/platform/uv/bios_uv.c
> @@ -172,55 +172,55 @@ int uv_bios_set_legacy_vga_target(bool decode, int domain, int bus)
>   				(u64)decode, (u64)domain, (u64)bus, 0, 0);
>   }
>   
> -extern s64 uv_bios_get_master_nasid(u64 size, u64 *master_nasid)
> +s64 uv_bios_get_master_nasid(u64 size, u64 *master_nasid)
>   {
>   	return uv_bios_call(UV_BIOS_EXTRA, 0, UV_BIOS_EXTRA_MASTER_NASID, 0,
>   				size, (u64)master_nasid);
>   }
>   EXPORT_SYMBOL_GPL(uv_bios_get_master_nasid);
>   
> -extern s64 uv_bios_get_heapsize(u64 nasid, u64 size, u64 *heap_size)
> +s64 uv_bios_get_heapsize(u64 nasid, u64 size, u64 *heap_size)
>   {
>   	return uv_bios_call(UV_BIOS_EXTRA, nasid, UV_BIOS_EXTRA_GET_HEAPSIZE,
>   				0, size, (u64)heap_size);
>   }
>   EXPORT_SYMBOL_GPL(uv_bios_get_heapsize);
>   
> -extern s64 uv_bios_install_heap(u64 nasid, u64 heap_size, u64 *bios_heap)
> +s64 uv_bios_install_heap(u64 nasid, u64 heap_size, u64 *bios_heap)
>   {
>   	return uv_bios_call(UV_BIOS_EXTRA, nasid, UV_BIOS_EXTRA_INSTALL_HEAP,
>   				0, heap_size, (u64)bios_heap);
>   }
>   EXPORT_SYMBOL_GPL(uv_bios_install_heap);
>   
> -extern s64 uv_bios_obj_count(u64 nasid, u64 size, u64 *objcnt)
> +s64 uv_bios_obj_count(u64 nasid, u64 size, u64 *objcnt)
>   {
>   	return uv_bios_call(UV_BIOS_EXTRA, nasid, UV_BIOS_EXTRA_OBJECT_COUNT,
>   				0, size, (u64)objcnt);
>   }
>   EXPORT_SYMBOL_GPL(uv_bios_obj_count);
>   
> -extern s64 uv_bios_enum_objs(u64 nasid, u64 size, u64 *objbuf)
> +s64 uv_bios_enum_objs(u64 nasid, u64 size, u64 *objbuf)
>   {
>   	return uv_bios_call(UV_BIOS_EXTRA, nasid, UV_BIOS_EXTRA_ENUM_OBJECTS,
>   				0, size, (u64)objbuf);
>   }
>   EXPORT_SYMBOL_GPL(uv_bios_enum_objs);
>   
> -extern s64 uv_bios_enum_ports(u64 nasid, u64 obj_id, u64 size, u64 *portbuf)
> +s64 uv_bios_enum_ports(u64 nasid, u64 obj_id, u64 size, u64 *portbuf)
>   {
>   	return uv_bios_call(UV_BIOS_EXTRA, nasid, UV_BIOS_EXTRA_ENUM_PORTS,
>   				obj_id, size, (u64)portbuf);
>   }
>   EXPORT_SYMBOL_GPL(uv_bios_enum_ports);
>   
> -extern s64 uv_bios_get_geoinfo(u64 nasid, u64 size, u64 *buf)
> +s64 uv_bios_get_geoinfo(u64 nasid, u64 size, u64 *buf)
>   {
>   	return uv_bios_call(UV_BIOS_GET_GEOINFO, nasid, (u64)buf, size, 0, 0);
>   }
>   EXPORT_SYMBOL_GPL(uv_bios_get_geoinfo);
>   
> -extern s64 uv_bios_get_pci_topology(u64 size, u64 *buf)
> +s64 uv_bios_get_pci_topology(u64 size, u64 *buf)
>   {
>   	return uv_bios_call(UV_BIOS_GET_PCI_TOPOLOGY, (u64)buf, size, 0, 0, 0);
>   }
> 

I have sent a new patch with the correct subject and commit messages, 
please ignore this version.

Sorry for the noise.
