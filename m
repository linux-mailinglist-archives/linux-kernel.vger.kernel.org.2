Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D135E44E3E5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 10:35:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234797AbhKLJiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 04:38:23 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51812 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234614AbhKLJiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 04:38:18 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AC9ENPE006498;
        Fri, 12 Nov 2021 09:34:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=7cwt4AT1QjTUgKa8sxcTBMQE0d4Px34PsgVdvpoiweg=;
 b=NIpxfvBxs9HwTvdatgUcysCioh21u5zRRrKQr47sHKrV2paiddhqzkanM1W6vhLho2/d
 SdttHcuG3COt3XZ8wdf0dX2z6FMBVMvDTqx2U22LeWNj/CMEGVKIo7czNeCkuB/w6pDh
 cPRwxHCb0U7CvzZLZ9rGPJsIYIqvR4UrlfiTfK1nKtiN7hAbj3Ez92etxibQUEPtFrkh
 BJYYQpJWS3lnZZmBa6ze4ajhc4hK1VN29B0P9bZnG+ii5qL0mFrVAgnTUP94SHAInyPD
 chccCkyHXt7zfEoup4VzZbTJPkHorYrmKswjEcQqB6hJ///GPuRhdWNSI1IvUx7fWlBN rw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3c9nfb8d0b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Nov 2021 09:34:52 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AC9EUpC007131;
        Fri, 12 Nov 2021 09:34:51 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3c9nfb8cym-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Nov 2021 09:34:51 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AC9XL0Z020025;
        Fri, 12 Nov 2021 09:34:48 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04fra.de.ibm.com with ESMTP id 3c5hbaunc3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Nov 2021 09:34:48 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AC9S05262718334
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Nov 2021 09:28:00 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AF57B4203F;
        Fri, 12 Nov 2021 09:34:43 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8AE8B42052;
        Fri, 12 Nov 2021 09:34:42 +0000 (GMT)
Received: from p-imbrenda (unknown [9.145.6.198])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 12 Nov 2021 09:34:42 +0000 (GMT)
Date:   Fri, 12 Nov 2021 10:34:39 +0100
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
Message-ID: <20211112103439.441b4c12@p-imbrenda>
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
X-Proofpoint-ORIG-GUID: wYUp4jYQXevSbwEoGnS_6eLANud7K0fM
X-Proofpoint-GUID: hqeNNGxrdhxIiKg0-_TUWO2BGY-nDive
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-12_03,2021-11-11_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 impostorscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 clxscore=1015 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111120053
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
> 
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

nevermind, exit_notify is done after cgroup_exit, the teardown would
then not be accounted properly

> 
> Or maybe something with schedule_work or task_work, instead of an
> exit_mm_late.  I don't see any practical difference.
> 
> I really don't see why this needs a whole other process to connect to
> the process you care about asynchronously.
> 
> This whole thing seems an exercise in spending lots of resources to free
> resources much later.
> 
> Eric

