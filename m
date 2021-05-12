Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3CA37EB9D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 00:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381516AbhELTed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 15:34:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:30236 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237501AbhELRnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 13:43:39 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14CHXvfF060751;
        Wed, 12 May 2021 13:42:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : mime-version : content-type; s=pp1;
 bh=5UEOyhyG3UqZMGkMbJ2es9GH2HaBaoPnwmm2+3ugwhA=;
 b=ozIOnF4dUcWD+eidG33ji2vm+VoANffAUd2Wxxg/zuqkpOsZxYgslInHijODl6xWw7r9
 oEWvFAunsmuWbaiJI8kwP5NVOPpWWOqpztkboAgS84OHCUkWs0eh0ALxkpiEEI5hAZKZ
 g/X1E+fatrAV/dLQBqcCbweV46r9BpbeW2yXYtj6TLSCWBdPqKfEWUTPQ0SmZLhFPVpo
 yqusIlAIMltw64ypfNALE4+rwqBtZfGiq8n6/iIY1lfqM32qQZb6nlN+/EP1BQgU7pgj
 CTkayjFo5eYlOG2PEwuGbxFawNDovcvgoEEsKfnyN2fYNBnk01FtWPW35Iqji4RNXlBF VQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38gkcn0f09-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 May 2021 13:42:14 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14CHYJXQ062526;
        Wed, 12 May 2021 13:42:14 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38gkcn0eyr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 May 2021 13:42:14 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14CHfL2u013169;
        Wed, 12 May 2021 17:42:12 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06fra.de.ibm.com with ESMTP id 38dhwh19g9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 May 2021 17:42:12 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14CHg9It26935648
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 May 2021 17:42:10 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D3261A405B;
        Wed, 12 May 2021 17:42:09 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 76004A4054;
        Wed, 12 May 2021 17:42:09 +0000 (GMT)
Received: from localhost (unknown [9.171.5.155])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 12 May 2021 17:42:09 +0000 (GMT)
Date:   Wed, 12 May 2021 19:42:08 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        Miroslav Benes <mbenes@suse.cz>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] objtool: fixes for couple of endianness issues which
 appeared in v5.13-rc1
Message-ID: <cover.thread-6c9df9.your-ad-here.call-01620841104-ext-2554@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Patchwork-Bot: notify
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nbsJECEDXp3LJrPj75YOvc65yVtkbkHI
X-Proofpoint-ORIG-GUID: fQFwr_jC5CgCE8q9Q_nt8Vg0dRDadVA2
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-12_09:2021-05-12,2021-05-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 adultscore=0
 phishscore=0 bulkscore=0 mlxlogscore=862 spamscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105120114
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vasily Gorbik (2):
  objtool: Fix elf_create_undef_symbol() endianness
  objtool/x86: Fix elf_add_alternative() endianness

 tools/objtool/arch/x86/decode.c | 3 ++-
 tools/objtool/elf.c             | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

-- 
2.25.4
