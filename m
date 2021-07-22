Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 861FF3D2CAF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 21:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbhGVSmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 14:42:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44992 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229556AbhGVSmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 14:42:51 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16MJ300w186773;
        Thu, 22 Jul 2021 15:23:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=Op/Bo1AO/LTdxBBrkjvePPmN6XyZKah3LgizjT4Ell4=;
 b=M8SJjOSzeg+gec1EhqvUJgmpfTDaDue6qpK52ivLGMGBOIyMTpqePqOuHgB2hiW3mfTy
 zf3jx8DdE+4+b5qmoTsNEpc22afQh3rDAsZNA8N4m2h0mMFOWzbqDPTdqtVX7kjtqK1I
 4C/ibnwvYX5m70VWNyF4/o5Ncn5b3mF93eB7wv+S9iaCLcrNUMOb3JH8Cxgghk2pyCZs
 Q3lV8Q1jbUjqgtk/GP0Ng+5bH/OiBJbCk2WSpXk8WgpX9toy5wquerXK0J3gJ3gBA/+l
 s6Nrw3KnY7+Xnz6GYUK4PNV/b3fo86Vyn0MPTed8F4CQij/+Hibpzq+yMXwzOXl6ty8a Pg== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39ycy9v6mw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Jul 2021 15:23:03 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16MJDCST021516;
        Thu, 22 Jul 2021 19:23:01 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 39xhx48tr3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Jul 2021 19:23:01 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16MJKU5u33947950
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Jul 2021 19:20:30 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7B6B0AE045;
        Thu, 22 Jul 2021 19:22:59 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0C99DAE053;
        Thu, 22 Jul 2021 19:22:59 +0000 (GMT)
Received: from oc7455500831.ibm.com (unknown [9.145.166.24])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 22 Jul 2021 19:22:58 +0000 (GMT)
Subject: Re: [PATCH v2 0/4] Fix restricted DMA vs swiotlb_exit()
To:     Will Deacon <will@kernel.org>, iommu@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Claire Chang <tientzu@chromium.org>,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Halil Pasic <pasic@linux.ibm.com>
References: <20210720133826.9075-1-will@kernel.org>
From:   Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <57e37ef9-c055-d6a6-2244-2c7dd243b5c1@de.ibm.com>
Date:   Thu, 22 Jul 2021 21:22:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210720133826.9075-1-will@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: RmyVFFKxtFiVcNLrl6GSKmkPY-rhkY0N
X-Proofpoint-ORIG-GUID: RmyVFFKxtFiVcNLrl6GSKmkPY-rhkY0N
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-22_09:2021-07-22,2021-07-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 adultscore=0 impostorscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107220125
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.07.21 15:38, Will Deacon wrote:
> Hi again, folks,
> 
> This is version two of the patch series I posted yesterday:
> 
>    https://lore.kernel.org/r/20210719123054.6844-1-will@kernel.org
> 
> The only changes since v1 are:
> 
>    * Squash patches 2 and 3, amending the commit message accordingly
>    * Add Reviewed-by and Tested-by tags from Christoph and Claire (thanks!)
> 
> I'd usually leave it a bit longer between postings, but since this fixes
> issues with patches in -next I thought I'd spin a new version immediately.
> 
> Cheers,

FWIW, I just bisected virtio-errors with secure execution mode
qemu-system-s390x: virtio-serial-bus: Unexpected port id 4205794771 for device virtio-serial0.0

to
commit 903cd0f315fe426c6a64c54ed389de0becb663dc
Author: Claire Chang <tientzu@chromium.org>
Date:   Thu Jun 24 23:55:20 2021 +0800

      swiotlb: Use is_swiotlb_force_bounce for swiotlb data bouncing

Unfortunately this patch series does NOT fix this issue, so it seems that even more
things are broken.

Any idea what else might be broken?
Shall we rather revert these patches from next until we have things under control?
