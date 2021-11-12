Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8AC44E3CF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 10:28:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234782AbhKLJbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 04:31:18 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:1634 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234614AbhKLJbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 04:31:15 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AC8hS27013655;
        Fri, 12 Nov 2021 09:27:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=ZslUU1zN7ZiE3Lz261AsJjrafKy4cq2tVTr4v02k/as=;
 b=FecYRJBH39x5J2xvew6o0+aChVD0ZHbHWjMD7RwIL5j96QGSMld7pZFvkhdhuh+Dc2JD
 HYNlW/NsP01NbZkqS0ZeMSdEaMNdaSiIe1mLrAViYMTr3mikQQsy8CO9pxldF1hnMzXH
 dKnkEp6nQq+iyHaOuYfhaJo92DovzvdxSYbZrN/tKuCfpFyVyVyFXdFCTSmBzyDnt6eJ
 9BZQbuJukdhONURFu3WieZKFZRvsM7vgCa/8s2sYU/5mDP8skbpNSnYJh5h0mVby/BTV
 ert17Rx/P6O4mzfn77xGvUH2T6IQUx2syKKlpScId/yQEaqGh5ikvo3CNv/nhNmwKh0e zQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3c9n0u8twg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Nov 2021 09:27:40 +0000
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AC9DEjn022091;
        Fri, 12 Nov 2021 09:27:40 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3c9n0u8tvv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Nov 2021 09:27:39 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AC9I5nK030717;
        Fri, 12 Nov 2021 09:27:37 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06fra.de.ibm.com with ESMTP id 3c5gykun1w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Nov 2021 09:27:37 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AC9RWUG60293416
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Nov 2021 09:27:32 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5C8D0A405C;
        Fri, 12 Nov 2021 09:27:32 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 34E17A4060;
        Fri, 12 Nov 2021 09:27:31 +0000 (GMT)
Received: from p-imbrenda (unknown [9.145.6.198])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 12 Nov 2021 09:27:31 +0000 (GMT)
Date:   Fri, 12 Nov 2021 10:27:28 +0100
From:   Claudio Imbrenda <imbrenda@linux.ibm.com>
To:     ebiederm@xmission.com (Eric W. Biederman)
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, thuth@redhat.com,
        frankja@linux.ibm.com, borntraeger@de.ibm.com,
        Ulrich.Weigand@de.ibm.com, david@redhat.com, ultrachin@163.com,
        akpm@linux-foundation.org, vbabka@suse.cz, brookxu.cn@gmail.com,
        xiaoggchen@tencent.com, linuszeng@tencent.com, yihuilu@tencent.com,
        mhocko@suse.com, daniel.m.jordan@oracle.com, axboe@kernel.dk,
        legion@kernel.org, peterz@infradead.org, aarcange@redhat.com,
        christian@brauner.io, tglx@linutronix.de
Subject: Re: [RFC v1 2/4] kernel/fork.c: implement new process_mmput_async
 syscall
Message-ID: <20211112102728.47a9d1f2@p-imbrenda>
In-Reply-To: <874k8ixzx0.fsf@email.froward.int.ebiederm.org>
References: <20211111095008.264412-1-imbrenda@linux.ibm.com>
        <20211111095008.264412-4-imbrenda@linux.ibm.com>
        <874k8ixzx0.fsf@email.froward.int.ebiederm.org>
Organization: IBM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: OvKktUrwik7CE0ZcxJzyweGTKKZIUMDu
X-Proofpoint-ORIG-GUID: Us4wHPujpmONJV8KVXLtvm8AuCaFmKml
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-12_03,2021-11-11_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 bulkscore=0 suspectscore=0
 adultscore=0 mlxscore=0 malwarescore=0 clxscore=1015 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111120050
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Nov 2021 13:20:11 -0600
ebiederm@xmission.com (Eric W. Biederman) wrote:

> Claudio Imbrenda <imbrenda@linux.ibm.com> writes:
> 
> > The goal of this new syscall is to be able to asynchronously free the
> > mm of a dying process. This is especially useful for processes that use
> > huge amounts of memory (e.g. databases or KVM guests). The process is
> > allowed to terminate immediately, while its mm is cleaned/reclaimed
> > asynchronously.
> >
> > A separate process needs use the process_mmput_async syscall to attach
> > itself to the mm of a running target process. The process will then
> > sleep until the last user of the target mm has gone.
> >
> > When the last user of the mm has gone, instead of synchronously free
> > the mm, the attached process is awoken. The syscall will then continue
> > and clean up the target mm.
> >
> > This solution has the advantage that the cleanup of the target mm can
> > happen both be asynchronous and properly accounted for (e.g. cgroups).
> >
> > Tested on s390x.
> >
> > A separate patch will actually wire up the syscall.  
> 
> I am a bit confused.
> 
> You want the process report that it has finished immediately,
> and you want the cleanup work to continue on in the background.

yes

> Why do you need a separate process?
> 
> Why not just modify the process cleanup code to keep the task_struct
> running while allowing waitpid to reap the process (aka allowing
> release_task to run)?  All tasks can be already be reaped after
> exit_notify in do_exit.
> 
> I can see some reasons for wanting an opt-in.  It is nice to know all of
> a processes resources have been freed when waitpid succeeds.
> 
> Still I don't see why this whole thing isn't exit_mm returning
> the mm_sturct when a flag is set, and then having an exit_mm_late
> being called and passed the returned mm after exit_notify.

so if I understand correctly you are saying exit_mm would skip the
mmput, set a flag, then I should introduce a new function
"exit_mm_late" after exit_notify, to check the flag and do the mmput if
needed

and that would mean that the cleanup would still be done in the context
of the exiting process, but without holding back anyone waiting for the
process to terminate (so the process appears to exit immediately)

sounds clean, I will do it

> Or maybe something with schedule_work or task_work, instead of an
> exit_mm_late.  I don't see any practical difference.
> 
> I really don't see why this needs a whole other process to connect to
> the process you care about asynchronously.

accounting. workqueues or kernel threads are not properly accounted to
the right cgroups; by using a userspace process, things get accounted
properly.

this was a major point that was made last month when a similar
discussion came up

> This whole thing seems an exercise in spending lots of resources to free
> resources much later.

there are some usecases for this (huge processes like databases, or huge
secure VMs where the teardown is significantly slower than normal
processes)

> 
> Eric

