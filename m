Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E14E644EBA8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 17:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235516AbhKLQ5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 11:57:12 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58420 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235511AbhKLQ5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 11:57:11 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ACFg481013656;
        Fri, 12 Nov 2021 16:53:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=Nuv29rlnbbzVUUwqzOGqQpnKpwgBQmi1T7fM3wV7qKY=;
 b=YCxW7nz2uqlNuX0lyJNQcMPA8mbMHdMGfLt6LeMXwVQaW0my5lL53mPzfvdzK40USnTS
 AdIJrDBDpozpGuqYxZAk9/8qt3PmZzMOMdN6jyFPOrh9rqC7DUcU+K4pTAv/2Scw6Kk5
 QUu5i8prFe5RKOpIQMt1NmILWgj27VKKR3qO78oU5khdqKMbkjC8d/i5JzM1pgiFZU27
 cxnvlZGkqJSixyzXhw62t0Cps3UGmyuiEP0NcSiU2sGboi9mft0fz+GdqtVAPT3JGTwm
 XkjDNa2LE6Fvfa+PKIRt0OcEpI++HrPOc+rQawVX0y75PFg/l+NJ4br+7HZ/dTQM4CXz ew== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3c9u4u9mt2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Nov 2021 16:53:22 +0000
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1ACGa484011811;
        Fri, 12 Nov 2021 16:53:21 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3c9u4u9ms4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Nov 2021 16:53:21 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1ACGReLv003326;
        Fri, 12 Nov 2021 16:53:19 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06fra.de.ibm.com with ESMTP id 3c5gykyb6h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Nov 2021 16:53:18 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1ACGrEPr52560136
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Nov 2021 16:53:14 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EA0B811C058;
        Fri, 12 Nov 2021 16:53:13 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D385A11C052;
        Fri, 12 Nov 2021 16:53:12 +0000 (GMT)
Received: from p-imbrenda (unknown [9.145.6.198])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 12 Nov 2021 16:53:12 +0000 (GMT)
Date:   Fri, 12 Nov 2021 17:53:09 +0100
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
Message-ID: <20211112175309.7e0fe52a@p-imbrenda>
In-Reply-To: <87v90xv2uu.fsf@email.froward.int.ebiederm.org>
References: <20211111095008.264412-1-imbrenda@linux.ibm.com>
        <20211111095008.264412-4-imbrenda@linux.ibm.com>
        <874k8ixzx0.fsf@email.froward.int.ebiederm.org>
        <20211112103439.441b4c12@p-imbrenda>
        <87v90xv2uu.fsf@email.froward.int.ebiederm.org>
Organization: IBM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jyyoRymRy2O3ONwgVA0kRy8talRbi7eE
X-Proofpoint-ORIG-GUID: YToPptKTUtlla9hgFfS7T6ZWDkl70BJ6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-12_05,2021-11-12_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 mlxlogscore=999 malwarescore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 bulkscore=0 suspectscore=0 impostorscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111120094
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Nov 2021 08:57:13 -0600
ebiederm@xmission.com (Eric W. Biederman) wrote:

> Claudio Imbrenda <imbrenda@linux.ibm.com> writes:
> 
> > On Thu, 11 Nov 2021 13:20:11 -0600
> > ebiederm@xmission.com (Eric W. Biederman) wrote:
> >  
> >> Claudio Imbrenda <imbrenda@linux.ibm.com> writes:
> >>   
> >> > The goal of this new syscall is to be able to asynchronously free the
> >> > mm of a dying process. This is especially useful for processes that use
> >> > huge amounts of memory (e.g. databases or KVM guests). The process is
> >> > allowed to terminate immediately, while its mm is cleaned/reclaimed
> >> > asynchronously.
> >> >
> >> > A separate process needs use the process_mmput_async syscall to attach
> >> > itself to the mm of a running target process. The process will then
> >> > sleep until the last user of the target mm has gone.
> >> >
> >> > When the last user of the mm has gone, instead of synchronously free
> >> > the mm, the attached process is awoken. The syscall will then continue
> >> > and clean up the target mm.
> >> >
> >> > This solution has the advantage that the cleanup of the target mm can
> >> > happen both be asynchronous and properly accounted for (e.g. cgroups).
> >> >
> >> > Tested on s390x.
> >> >
> >> > A separate patch will actually wire up the syscall.    
> >> 
> >> I am a bit confused.
> >> 
> >> You want the process report that it has finished immediately,
> >> and you want the cleanup work to continue on in the background.
> >> 
> >> Why do you need a separate process?
> >> 
> >> Why not just modify the process cleanup code to keep the task_struct
> >> running while allowing waitpid to reap the process (aka allowing
> >> release_task to run)?  All tasks can be already be reaped after
> >> exit_notify in do_exit.
> >> 
> >> I can see some reasons for wanting an opt-in.  It is nice to know all of
> >> a processes resources have been freed when waitpid succeeds.
> >> 
> >> Still I don't see why this whole thing isn't exit_mm returning
> >> the mm_sturct when a flag is set, and then having an exit_mm_late
> >> being called and passed the returned mm after exit_notify.  
> >
> > nevermind, exit_notify is done after cgroup_exit, the teardown would
> > then not be accounted properly  
> 
> So you want this new mechanism so you can separate the cleanup from
> the exit notification, and so that things are accounted properly.
> 
> It would have helped if you had included a link to the previous
> conversation.
> 
> I think Michal Hoko has a point.  This looks like a job for
> "clone(CLONE_VM)" and "prctl(PR_SET_PDEATH_SIG)".  Maybe using a pidfd
> instead of the prctl.
> 
> AKA just create a child that shares the parents memory, and waits for
> the parent to exit and then cleans things up.
> 
> That should not need any new kernel mechanisms.

Of course, but this also means that it's not possible to stop the OOM
killer while the teardown is in progress, and will require userspace
changes on a case-by-case basis.

Anyway, I will try to kludge something together with clone

> 
> 
> 
> There is the other question: why this is disastrously slow on s390?
> Is this a s390 specific issue?  Can the issue be fixed by optimizing

It's a hardware issue with protected VMs, which are achieved on s390x
without memory encryption. When a protected VM terminates, the
secure/trusted firmware needs to clear all protected memory, and change
the security properties to make it accessible. This last step in
particular takes more time than just clearing memory.

> what is happening on s390?
> 
> Eric

