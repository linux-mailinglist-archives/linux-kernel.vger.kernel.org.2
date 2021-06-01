Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE0703976B1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 17:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234228AbhFAPct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 11:32:49 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:25708 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230288AbhFAPcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 11:32:47 -0400
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 151FOKew009540;
        Tue, 1 Jun 2021 15:30:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pps0720; bh=iCUWAj7frxQI7LsZaRn7UF3u6PLCoOjGUA7u8YvVpOY=;
 b=DE0K03P+3llubk1hTeCxo/m2cleU7WrD5yK/sXNitoj6Obtsrh+kKX+m7F4Xb/Q5mP1Z
 TGfBVdVULZBym+3kwCWmJvMwjpzRCQs+aNhrpEnZjeTnKQ5C8ZJnRaR2BgKi+o5yMulE
 gSTlfeqbcKphzaJkw1fRkWfYgvFZzLzlerMnVG7Q//Ixc0mJU9+a5GEOSFJkjoTCswc5
 ImsbfIFJoGPTIbegBsSf67FpGNj7WkbHFjhYsYBZpMGLtSE4wy6FwSvMz0DG9dlQLdFf
 Ldl6iRdBifQ03cNKSv2bZs0HjDV14AArCOxDZNUgMXgMLnwb05ofbCftHnQkbKs1HwmD CQ== 
Received: from g9t5008.houston.hpe.com (g9t5008.houston.hpe.com [15.241.48.72])
        by mx0a-002e3701.pphosted.com with ESMTP id 38w2ctrp1k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Jun 2021 15:30:32 +0000
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g9t5008.houston.hpe.com (Postfix) with ESMTP id B4D3D59;
        Tue,  1 Jun 2021 15:30:31 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [16.99.164.36])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id C881448;
        Tue,  1 Jun 2021 15:30:29 +0000 (UTC)
Date:   Tue, 1 Jun 2021 10:30:29 -0500
From:   Steve Wahl <steve.wahl@hpe.com>
To:     Qiheng Lin <linqiheng@huawei.com>
Cc:     mike.travis@hpe.com, dimitri.sivanich@hpe.com,
        russ.anderson@hpe.com, dvhart@infradead.org, andy@infradead.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, steve.wahl@hpe.com,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 -next] x86/platform/uv: Remove the unneeded extern
 keyword
Message-ID: <YLZSlQnGETqw1da6@swahl-home.5wahls.com>
References: <20210601063034.27433-1-linqiheng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210601063034.27433-1-linqiheng@huawei.com>
X-Proofpoint-GUID: YVHJYEDfOUpNWLZyyJeWvmMPjmiPeqYW
X-Proofpoint-ORIG-GUID: YVHJYEDfOUpNWLZyyJeWvmMPjmiPeqYW
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-01_07:2021-06-01,2021-06-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=953 mlxscore=0
 malwarescore=0 adultscore=0 clxscore=1011 priorityscore=1501
 suspectscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106010104
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 01, 2021 at 02:30:34PM +0800, Qiheng Lin wrote:
> The function declarations in bios.h are already marked extern, so remove
> them in the definition.
> 
> This problem was caught by the sparse tool:
>  function 'uv_bios_get_master_nasid' with external linkage has definition
>  function 'uv_bios_get_heapsize' with external linkage has definition
>  function 'uv_bios_install_heap' with external linkage has definition
>  function 'uv_bios_obj_count' with external linkage has definition
>  function 'uv_bios_enum_objs' with external linkage has definition
>  function 'uv_bios_enum_ports' with external linkage has definition
>  function 'uv_bios_get_geoinfo' with external linkage has definition
>  function 'uv_bios_get_pci_topology' with external linkage has definition
> 
> Signed-off-by: Qiheng Lin <linqiheng@huawei.com>

Reviewed-by: Steve Wahl <steve.wahl@hpe.com>

> ---
> Changes in v2:
>  - adjust the subject and commit message
> 
>  arch/x86/platform/uv/bios_uv.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/platform/uv/bios_uv.c b/arch/x86/platform/uv/bios_uv.c
> index bf31af3d32d6..7e7634c8be62 100644
> --- a/arch/x86/platform/uv/bios_uv.c
> +++ b/arch/x86/platform/uv/bios_uv.c
> @@ -172,55 +172,55 @@ int uv_bios_set_legacy_vga_target(bool decode, int domain, int bus)
>  				(u64)decode, (u64)domain, (u64)bus, 0, 0);
>  }
>  
> -extern s64 uv_bios_get_master_nasid(u64 size, u64 *master_nasid)
> +s64 uv_bios_get_master_nasid(u64 size, u64 *master_nasid)
>  {
>  	return uv_bios_call(UV_BIOS_EXTRA, 0, UV_BIOS_EXTRA_MASTER_NASID, 0,
>  				size, (u64)master_nasid);
>  }
>  EXPORT_SYMBOL_GPL(uv_bios_get_master_nasid);
>  
> -extern s64 uv_bios_get_heapsize(u64 nasid, u64 size, u64 *heap_size)
> +s64 uv_bios_get_heapsize(u64 nasid, u64 size, u64 *heap_size)
>  {
>  	return uv_bios_call(UV_BIOS_EXTRA, nasid, UV_BIOS_EXTRA_GET_HEAPSIZE,
>  				0, size, (u64)heap_size);
>  }
>  EXPORT_SYMBOL_GPL(uv_bios_get_heapsize);
>  
> -extern s64 uv_bios_install_heap(u64 nasid, u64 heap_size, u64 *bios_heap)
> +s64 uv_bios_install_heap(u64 nasid, u64 heap_size, u64 *bios_heap)
>  {
>  	return uv_bios_call(UV_BIOS_EXTRA, nasid, UV_BIOS_EXTRA_INSTALL_HEAP,
>  				0, heap_size, (u64)bios_heap);
>  }
>  EXPORT_SYMBOL_GPL(uv_bios_install_heap);
>  
> -extern s64 uv_bios_obj_count(u64 nasid, u64 size, u64 *objcnt)
> +s64 uv_bios_obj_count(u64 nasid, u64 size, u64 *objcnt)
>  {
>  	return uv_bios_call(UV_BIOS_EXTRA, nasid, UV_BIOS_EXTRA_OBJECT_COUNT,
>  				0, size, (u64)objcnt);
>  }
>  EXPORT_SYMBOL_GPL(uv_bios_obj_count);
>  
> -extern s64 uv_bios_enum_objs(u64 nasid, u64 size, u64 *objbuf)
> +s64 uv_bios_enum_objs(u64 nasid, u64 size, u64 *objbuf)
>  {
>  	return uv_bios_call(UV_BIOS_EXTRA, nasid, UV_BIOS_EXTRA_ENUM_OBJECTS,
>  				0, size, (u64)objbuf);
>  }
>  EXPORT_SYMBOL_GPL(uv_bios_enum_objs);
>  
> -extern s64 uv_bios_enum_ports(u64 nasid, u64 obj_id, u64 size, u64 *portbuf)
> +s64 uv_bios_enum_ports(u64 nasid, u64 obj_id, u64 size, u64 *portbuf)
>  {
>  	return uv_bios_call(UV_BIOS_EXTRA, nasid, UV_BIOS_EXTRA_ENUM_PORTS,
>  				obj_id, size, (u64)portbuf);
>  }
>  EXPORT_SYMBOL_GPL(uv_bios_enum_ports);
>  
> -extern s64 uv_bios_get_geoinfo(u64 nasid, u64 size, u64 *buf)
> +s64 uv_bios_get_geoinfo(u64 nasid, u64 size, u64 *buf)
>  {
>  	return uv_bios_call(UV_BIOS_GET_GEOINFO, nasid, (u64)buf, size, 0, 0);
>  }
>  EXPORT_SYMBOL_GPL(uv_bios_get_geoinfo);
>  
> -extern s64 uv_bios_get_pci_topology(u64 size, u64 *buf)
> +s64 uv_bios_get_pci_topology(u64 size, u64 *buf)
>  {
>  	return uv_bios_call(UV_BIOS_GET_PCI_TOPOLOGY, (u64)buf, size, 0, 0, 0);
>  }
> -- 
> 2.31.1
> 

-- 
Steve Wahl, Hewlett Packard Enterprise
