Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0857A3D67E0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 22:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbhGZT0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 15:26:22 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:63714 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229646AbhGZT0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 15:26:21 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16QK593V018129;
        Mon, 26 Jul 2021 16:06:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=hU37SZ69R0NzM9u0/Q/TcpUqbJmAa+F8/i/B0yPzv7w=;
 b=X8MF+hPh5Te1PfFvJ/6jKYDjQduc2nTKpvnWAyeHnYDvj3hBf3sdvo1q9dzH0lJqK4qx
 ceQ3lcuh/EqXfAsuhGUm4hyArz7EU9gpVvatLYX8gtKPWZelVL/BDPRGJTfmHi0Wp5XV
 WdVGay7Bb6+npRF69sEq++ZnjkcYOUbQr4SvMWhyAvGSuXJ/UvcVcC0p2YKwxHOMO7yo
 NzBuSNNhflkq1yNtRW2GxpGlU3WtHo/5uIX9C2n/g9D3Q/1N2XU9CDfqI44fG7tPCadb
 h3aF5PK+fnGxpxGtYmZgNEYfa8eImSwq9UFqIUiPMiJ9Kd83ga6s36kBNI3fHy/Avbt9 lA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3a23159a9b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Jul 2021 16:06:38 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16QK5Rat020447;
        Mon, 26 Jul 2021 16:06:37 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3a23159a8a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Jul 2021 16:06:37 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16QK3fgo031536;
        Mon, 26 Jul 2021 20:06:36 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma05fra.de.ibm.com with ESMTP id 3a235pr0b0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Jul 2021 20:06:35 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16QK3tBT26214780
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Jul 2021 20:03:55 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 620B152050;
        Mon, 26 Jul 2021 20:06:33 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.31.73])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id A462E5204E;
        Mon, 26 Jul 2021 20:06:32 +0000 (GMT)
Date:   Mon, 26 Jul 2021 23:06:30 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Matt Turner <mattst88@gmail.com>
Cc:     Michael Cree <mcree@orcon.net.nz>, linux-mm@kvack.org,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Regression bisected to fa3354e4ea39 (mm: free_area_init: use
 maximal zone PFNs rather than zone sizes)
Message-ID: <YP8Vxt0xuV1m5EPS@linux.ibm.com>
References: <20210726192311.uffqnanxw3ac5wwi@ivybridge>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210726192311.uffqnanxw3ac5wwi@ivybridge>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: x0y-SDgBhG6-F_cnI_wlHkfkGzSKw941
X-Proofpoint-GUID: JYt-xnelJjDtNFZV3OYu9F88n5CeFwyu
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-26_14:2021-07-26,2021-07-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 spamscore=0 priorityscore=1501 clxscore=1011 phishscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107260118
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matt,

On Mon, Jul 26, 2021 at 12:27:50PM -0700, Matt Turner wrote:
> Reply-To:
> 
> Hi Mike!
> 
> Since commit fa3354e4ea39 (mm: free_area_init: use maximal zone PFNs rather
> than zone sizes), I get the following BUG on Alpha (an AlphaServer ES47 Marvel)
> and loading userspace leads to a segfault:
> 
> (I didn't notice this for a long time because of other unrelated regressions,
> the pandemic, changing jobs, ...)
 
I suspect there will be more surprises down the road :)

> BUG: Bad page state in process swapper  pfn:2ffc53
> page:fffffc000ecf14c0 refcount:0 mapcount:1 mapping:0000000000000000 index:0x0
> flags: 0x0()
> raw: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> raw: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> page dumped because: nonzero mapcount  Modules linked in:
> CPU: 0 PID: 0 Comm: swapper Not tainted 5.7.0-03841-gfa3354e4ea39-dirty #26
>        fffffc0001b5bd68 fffffc0001b5be80 fffffc00011cd148 fffffc000ecf14c0
>        fffffc00019803df fffffc0001b5be80 fffffc00011ce340 fffffc000ecf14c0
>        0000000000000000 fffffc0001b5be80 fffffc0001b482c0 fffffc00027d6618
>        fffffc00027da7d0 00000000002ff97a 0000000000000000 fffffc0001b5be80
>        fffffc00011d1abc fffffc000ecf14c0 fffffc0002d00000 fffffc0001b5be80
>        fffffc0001b2350c 0000000000300000 fffffc0001b48298 fffffc0001b482c0
> Trace:
> [<fffffc00011cd148>] bad_page+0x168/0x1b0
> [<fffffc00011ce340>] free_pcp_prepare+0x1e0/0x290
> [<fffffc00011d1abc>] free_unref_page+0x2c/0xa0
> [<fffffc00014ee5f0>] cmp_ex_sort+0x0/0x30
> [<fffffc00014ee5f0>] cmp_ex_sort+0x0/0x30
> [<fffffc000101001c>] _stext+0x1c/0x20
> 
> I haven't tried reproducing this on other machines or QEMU, but I'd be glad to
> if that helps.

If it's reproducible on QEMU I can debug it locally.
 
> Any ideas?

It seems like memory map is not properly initialized. Can you enable
CONFIG_DEBUG_MEMORY_INIT and add mminit_debug=4 to the command line. The
interesting part of the log would be before "Memory: xK/yK available ..."
line.

Hopefully it'll give some clues.

-- 
Sincerely yours,
Mike.
