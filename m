Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D892400303
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 18:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349946AbhICQO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 12:14:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:12779 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349935AbhICQOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 12:14:20 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 183G3v7R055041;
        Fri, 3 Sep 2021 12:13:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : from : to : cc
 : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=1zL/52MMTZrZR0OrYn35IWORfBwfxoL7gxdgJoMivZY=;
 b=UpLT2B6oqrgyB8DSyjYijBqUVYZtmyxgN9Y4KU5VKWcrgq+HWHpxeE5paG3PBwOtGCV1
 Z5mcUFfcCrY00EZPS7vF19J/0tb0VjYucDJW3821NERl8Az44oZvHkKUsfeU7a8Gclo/
 DWcy8eOVtSw7aJ484Cz4c9sHIJjLbTfb/wXKdfDP246YrmlyhHPswC2OAVA+7bduZPuV
 I96SS7viMOe6Z2YTv1ChPIDK12HYg9bY27HjHoN6vOio9PkBKkH1q6UfrDEsPgCc4f1m
 MfDT2yzbgyzzQAVdXnWZKBTbzndXr0v7JsMaZUMwyOQ2c0h3jKy8djAGf/lbQ6mQMxHd Nw== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3audm46r8v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Sep 2021 12:13:18 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 183Fvj9w010177;
        Fri, 3 Sep 2021 16:13:16 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06fra.de.ibm.com with ESMTP id 3au6q0aa7n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Sep 2021 16:13:16 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 183G97rP58458596
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Sep 2021 16:09:07 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3CAE211C05E;
        Fri,  3 Sep 2021 16:13:14 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E3F5F11C052;
        Fri,  3 Sep 2021 16:13:13 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  3 Sep 2021 16:13:13 +0000 (GMT)
Received: from [9.206.212.242] (unknown [9.206.212.242])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 59F08600F5;
        Sat,  4 Sep 2021 02:13:12 +1000 (AEST)
Subject: Re: [ANNOUNCE] [CFP] linux.conf.au Online 2022 Kernel Miniconf
From:   Andrew Donnellan <ajd@linux.ibm.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     lwn@lwn.net
References: <e7e0d0c0-799f-28b7-2a2e-418afe809f24@linux.ibm.com>
Message-ID: <1f527127-6884-765f-3029-6f70b0cb61bd@linux.ibm.com>
Date:   Sat, 4 Sep 2021 02:13:11 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <e7e0d0c0-799f-28b7-2a2e-418afe809f24@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: yMOrZ-7-mmg8ifJjBi3pF_VUzcl9kLU9
X-Proofpoint-GUID: yMOrZ-7-mmg8ifJjBi3pF_VUzcl9kLU9
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-03_07:2021-09-03,2021-09-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 adultscore=0 impostorscore=0 mlxlogscore=894 bulkscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 mlxscore=0
 spamscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2108310000 definitions=main-2109030096
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/8/21 1:19 am, Andrew Donnellan wrote:
> LCA2022 Kernel Miniconf - Online - 2022-01-14
> ---------------------------------------------
> 
> The linux.conf.au 2022 Kernel Miniconf Call for Proposals is now open. 
> Start working on your talks!
> 
> Date: 2022-01-14
> Location: The Internet (again)
> Submissions close: 2021-09-05, 23:59 AoE/UTC-12
> Submissions: https://linux.conf.au/proposals/submit/kernel-miniconf/
> More info: https://lca-kernel.ozlabs.org/2022-cfp.html

The CFP for both the Kernel Miniconf and the main linux.conf.au 
conference has been extended to 2021-09-12, due to a shortage of 
submissions.

We have an audience consisting of not just kernel developers but also 
downstream users, so we are interested in a wide range of topics - if 
you or someone you know has something that might even possibly be 
interesting to talk about, please submit!

If you have any questions please contact me.

> 
> Significant changes from last year:
> - All miniconf speakers are guaranteed a free ticket
> - All talks will be 30 minutes long
> - CFP is now being run at the same time as main conference CFP process: 
> if your talk is of broader interest consider submitting to the main 
> conference as well
> 
> ***************************************************************************
> 
> linux.conf.au 2022 will be held from 14-16 January 2022.
> 
> Due to the ongoing COVID-19-related restrictions on events and travel, 
> LCA2022 will once again be held online. (Silver lining is you can speak 
> or attend from wherever you are without flying here!)
> 
> The Kernel Miniconf is a single-day miniconf track, held on Friday 14 
> January, about everything related to the kernel and low-level systems 
> programming.
> 
> The Kernel Miniconf invites talks about up-and-coming kernel 
> developments, the future direction of the kernel, and kernel development 
> community and process matters. Past Kernel Miniconfs have covered topics 
> such as memory management, RCU, scheduling, testing/CI and filesystems, 
> as well as community and process topics such as licensing, developer 
> workflows, safety critical processes, and so on.
> 
> We invite submissions on anything related to kernel and low-level 
> systems programming. We welcome submissions from developers of all 
> levels of experience, and from anyone connected with the kernel whether 
> you are an upstream kernel developer, distro maintainer, academic 
> researcher or a developer who works further downstream. The focus of the 
> miniconf will primarily be on Linux, however non-Linux talks of 
> sufficient interest to a primarily Linux audience will be considered.
> 

-- 
Andrew Donnellan              OzLabs, ADL Canberra
ajd@linux.ibm.com             IBM Australia Limited
