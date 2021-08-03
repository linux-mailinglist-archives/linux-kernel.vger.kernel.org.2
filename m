Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19FB93DF3FB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 19:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238293AbhHCRej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 13:34:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:29266 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238204AbhHCRei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 13:34:38 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 173HY6kp182576;
        Tue, 3 Aug 2021 13:34:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=xCMK8/8VXneVIihnqtZrubWggVdCb0/Uyk8DBlIiQB0=;
 b=Z4EhkCkFYE11ODtIBa8o2F/bFgxRDZcIwpAwdg5qXagt9PLjt617zl/rUphgWRyK+uaT
 ODCxer0962vJAKx6LnyjYASUL9sZ80xb/PYh+RHiHRcuNr9dIr3swWf6piAq9amCmGJW
 yRdn64jB8dfvzn8tjb3TKh4vWYk8tQk9fWilPRQ0fugaPrK/VaRaK7clznYc+mciIxoL
 2dihYelwTvO/tzl0MsnUKhTM4nG3CdvY4tYyNJb6CswOAOAodKaWFbWuXKJvuFT+q9RQ
 i40NdfFmORwNU35X2mUjjFxqY+h2xDnn6CMeHir0r5O/rtYr7JqZyASXtAKy8b7x3Z+W 2g== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a76r5f34t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Aug 2021 13:34:11 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 173HWNST013340;
        Tue, 3 Aug 2021 17:34:08 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma01fra.de.ibm.com with ESMTP id 3a4x58psjk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Aug 2021 17:34:08 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 173HY51S50987408
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Aug 2021 17:34:05 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 284B6A405C;
        Tue,  3 Aug 2021 17:34:05 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DD344A4066;
        Tue,  3 Aug 2021 17:34:04 +0000 (GMT)
Received: from pomme.local (unknown [9.145.42.112])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  3 Aug 2021 17:34:04 +0000 (GMT)
Subject: Re: [PATCH v5] pseries/drmem: update LMBs after LPM
To:     Nathan Lynch <nathanl@linux.ibm.com>, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Tyrel Datwyler <tyreld@linux.ibm.com>
References: <20210517090606.56930-1-ldufour@linux.ibm.com>
 <87sfzqigd9.fsf@linux.ibm.com>
From:   Laurent Dufour <ldufour@linux.ibm.com>
Message-ID: <dfce4ad9-e779-e25a-5d8e-89a8a9dfa532@linux.ibm.com>
Date:   Tue, 3 Aug 2021 19:34:04 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <87sfzqigd9.fsf@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ytNAPOyUUjceBx_GHWx4lC51zqu37OcO
X-Proofpoint-ORIG-GUID: ytNAPOyUUjceBx_GHWx4lC51zqu37OcO
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-03_05:2021-08-03,2021-08-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 mlxlogscore=999 spamscore=0 lowpriorityscore=0 mlxscore=0 bulkscore=0
 clxscore=1011 priorityscore=1501 adultscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108030114
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 03/08/2021 à 19:32, Nathan Lynch a écrit :
> Laurent Dufour <ldufour@linux.ibm.com> writes:
>> V5:
>>   - Reword the commit's description to address Nathan's comments.
> 
> Thanks. Still don't like the global variable usage but:
> 
> Reviewed-by: Nathan Lynch <nathanl@linux.ibm.com>
> 

Thanks Nathan,

I don't like either the global variable usage but I can't see any smarter way to 
achieve that.

Laurent.
