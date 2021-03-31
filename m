Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A892234FFC2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 13:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235253AbhCaLxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 07:53:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:19904 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235284AbhCaLxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 07:53:19 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12VBXdoa166180;
        Wed, 31 Mar 2021 07:52:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : mime-version : content-type; s=pp1;
 bh=/V7yWWNxYngIC7wyYWbeATuXW63w4vjLjmXFFb6sRso=;
 b=OB+QZSWfadHU9JeKkgyjq8Q8lYiOnSOXXHSQ3gM02s947l02FUplMR+qPNm2PyTH+dwA
 oaz3wKZDBYJbHgD0PKvOirJHWN0DqE0Wiq5o+VvePWn+8XQad5xAFuTVlu3OrQhDe6eF
 eKC0hq8SI0uzv9OzDceLOD7gmBowWTb0Mx4yNQGdTe13lukDLCkXycyTe27oBnlCEXgo
 rEAT092CxDkPqK1XOEVJuIymXsvNNuUJ5xGusV8kpdAmprM52IKdJkvPen8Oys2o6M/h
 LIwixMb0hovpKnjo/AxztUiS3hK4DRQ7PmhrYNjPx7p8Xm4y0WtnDYhNZ/SRVZBPe6oJ zA== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37mnfswa4w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 Mar 2021 07:52:52 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12VBq8c4006263;
        Wed, 31 Mar 2021 11:52:50 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 37matt0hgx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 Mar 2021 11:52:49 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12VBqlDp37945762
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Mar 2021 11:52:47 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AA8D1A4060;
        Wed, 31 Mar 2021 11:52:47 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6AE48A405B;
        Wed, 31 Mar 2021 11:52:47 +0000 (GMT)
Received: from localhost (unknown [9.171.83.5])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 31 Mar 2021 11:52:47 +0000 (GMT)
Date:   Wed, 31 Mar 2021 13:52:45 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Josef Bacik <jbacik@fb.com>, linux-kernel@vger.kernel.org
Subject: User stacktrace garbage when USER_STACKTRACE_SUPPORT is not enabled
Message-ID: <your-ad-here.call-01617191565-ext-9692@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: sDrSpfMaK1BgUhd-7ygtTgiQWv4YnO5R
X-Proofpoint-ORIG-GUID: sDrSpfMaK1BgUhd-7ygtTgiQWv4YnO5R
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-31_03:2021-03-30,2021-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 spamscore=0 malwarescore=0 impostorscore=0 bulkscore=0 mlxlogscore=817
 clxscore=1011 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103300000
 definitions=main-2103310085
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

At least on s390 since commit cbc3b92ce037 ("tracing: Set kernel_stack's
caller size properly") kernel stack trace contains 8 garbage values in the end.
I assume those are supposed to be filled by ftrace_trace_userstack, which is
only implemented on x86.

            sshd-804   [050]  1997.252608: kernel_stack:         <stack trace>
=> trampoline_probe_handler (549628c94)
=> kprobe_handler (549629260)
=> kprobe_exceptions_notify (549629370)
=> notify_die (549686e5e)
=> illegal_op (54960d440)
=> __do_pgm_check (54a106b08)
=> pgm_check_handler (54a112cc8)
=> kretprobe_trampoline (549629438)
=> kretprobe_trampoline (549629436)
=> do_syscall (549611ee6)
=> __do_syscall (54a106ccc)
=> system_call (54a112b5a)
=> 769010000000322
=> 22125e4d8
=> 22125e8f8
=> e000054100040100
=> _end (3220000000c)
=> 2
=> 20f892ec00000002
=> 20f898b800000002

kernel/trace/trace_entries.h:
159 #define FTRACE_STACK_ENTRIES    8
160
161 FTRACE_ENTRY(kernel_stack, stack_entry,
162
163         TRACE_STACK,
164
165         F_STRUCT(
166                 __field(        int,            size    )
167                 __array(        unsigned long,  caller, FTRACE_STACK_ENTRIES    )
168         ),

Is there any reason to keep those 8 extra values in the caller array if
CONFIG_USER_STACKTRACE_SUPPORT is not enabled? Any advice how to fix that
gracefully? It seems to work if I simply set FTRACE_STACK_ENTRIES to 0 when
CONFIG_USER_STACKTRACE_SUPPORT is not enabled.
