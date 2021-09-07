Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 568AB402652
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 11:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242325AbhIGJqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 05:46:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26762 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240891AbhIGJqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 05:46:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631007936;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YQaVP6nUMw4x6BFpmlG8sNeIQ/JvsCCbiyPoj8fPqMA=;
        b=iCj5Emxlmr+wrRVndO9kk4iDIjiuEsg5qGv8kc9+oQqPd5DTzJTHfBr+mkUdWe0LhifJpN
        Sm/kjFHzTE2FJNDcOWcjX2oxrooNYUeF0whGx9tRNAGezfj6YjwjBVJJLDclVLKWoSkfVg
        JJrq8HEUYUVqfy08me8CoXuR3iRLjD4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-558-wr9upCdMONyb9ue_bgK1VQ-1; Tue, 07 Sep 2021 05:45:35 -0400
X-MC-Unique: wr9upCdMONyb9ue_bgK1VQ-1
Received: by mail-wm1-f71.google.com with SMTP id x125-20020a1c3183000000b002e73f079eefso968211wmx.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 02:45:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=YQaVP6nUMw4x6BFpmlG8sNeIQ/JvsCCbiyPoj8fPqMA=;
        b=onTJYRvWLWB85w1w/9GprGre9DjuiLgZhmXHJ6rl4f44KYJSpPCSIgxGmTbKaH09Yu
         AeRVvSkQDW2CWOV+rf2+GGFASMWXrkmkJEzROWHAl2wMVd5FgNXDG541Ex8oJcn8T/kG
         g72elVF+2AlxJ1LsK4nSjMrYr87rrnc1+JoKUuTy+2bDy5icnFH9wDA/Z8vsQZIw6Ln2
         Z4Vkx2Jq9LAwx8ScoL0HqN/9y+Gk8irsUMH36yvZ3vqfZdYrYc6RCFVhQ7cWj+T5vspK
         NLT1RB+rujB27mKdrleazzw8BAweBMUUE4bFK1kKfpuNNzutxq2H1CWwIOZKkG2pBA1E
         +r3Q==
X-Gm-Message-State: AOAM530go296yu+MFJutSK/ytr6SPNu5SYef0w2ms5IaI7b19Lz0yRiI
        72a82sAIgchxlzToA0Ok/rzujugDu4S6bTwACl7dCSI30y67rZ8KOSsbE1dk0ukGlxr8bI7cV6g
        FicR9HPvZ59HyYH3RduioR1WXyhX+jaMXb49gYk+uM1hkRy39CBPAvhr6vCmmd3Qd1aferHzl
X-Received: by 2002:a7b:c451:: with SMTP id l17mr3000235wmi.74.1631007934086;
        Tue, 07 Sep 2021 02:45:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyxWEzpkEARlcyvljQc93lulpjQLY8kS8yY+V/7Ovug/Mv2+y6l/G+X2Oqe4TPHINVp1NxeXQ==
X-Received: by 2002:a7b:c451:: with SMTP id l17mr3000209wmi.74.1631007933733;
        Tue, 07 Sep 2021 02:45:33 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23fca.dip0.t-ipconnect.de. [79.242.63.202])
        by smtp.gmail.com with ESMTPSA id c24sm10508833wrb.57.2021.09.07.02.45.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Sep 2021 02:45:33 -0700 (PDT)
Subject: Re: kernel/fork.c:1205:24: sparse: sparse: incorrect type in
 initializer (different address spaces)
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
References: <202109070724.Fh8LRlM1-lkp@intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <65c46405-36e6-ab01-0b28-b14b530ee24b@redhat.com>
Date:   Tue, 7 Sep 2021 11:45:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <202109070724.Fh8LRlM1-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.09.21 01:50, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   4b93c544e90e2b28326182d31ee008eb80e02074
> commit: 35d7bdc86031a2c1ae05ac27dfa93b2acdcbaecc kernel/fork: factor out replacing the current MM exe_file
> date:   3 days ago
> config: i386-randconfig-s001-20210906 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> reproduce:
>          # apt-get install sparse
>          # sparse version: v0.6.4-dirty
>          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=35d7bdc86031a2c1ae05ac27dfa93b2acdcbaecc
>          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>          git fetch --no-tags linus master
>          git checkout 35d7bdc86031a2c1ae05ac27dfa93b2acdcbaecc
>          # save the attached .config to linux build tree
>          make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=i386
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> 
> sparse warnings: (new ones prefixed by >>)
>     kernel/fork.c:1005:19: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct [noderef] __rcu *owner @@     got struct task_struct *p @@
>     kernel/fork.c:1005:19: sparse:     expected struct task_struct [noderef] __rcu *owner
>     kernel/fork.c:1005:19: sparse:     got struct task_struct *p
>>> kernel/fork.c:1205:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct file [noderef] __rcu *__ret @@     got struct file *new_exe_file @@
>     kernel/fork.c:1205:24: sparse:     expected struct file [noderef] __rcu *__ret
>     kernel/fork.c:1205:24: sparse:     got struct file *new_exe_file
>     kernel/fork.c:1205:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct file *[assigned] old_exe_file @@     got struct file [noderef] __rcu *[assigned] __ret @@
>     kernel/fork.c:1205:22: sparse:     expected struct file *[assigned] old_exe_file
>     kernel/fork.c:1205:22: sparse:     got struct file [noderef] __rcu *[assigned] __ret
>     kernel/fork.c:1557:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct refcount_struct [usertype] *r @@     got struct refcount_struct [noderef] __rcu * @@
>     kernel/fork.c:1557:38: sparse:     expected struct refcount_struct [usertype] *r
>     kernel/fork.c:1557:38: sparse:     got struct refcount_struct [noderef] __rcu *
>     kernel/fork.c:1566:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
>     kernel/fork.c:1566:31: sparse:     expected struct spinlock [usertype] *lock
>     kernel/fork.c:1566:31: sparse:     got struct spinlock [noderef] __rcu *
>     kernel/fork.c:1567:36: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *q @@     got struct k_sigaction [noderef] __rcu * @@
>     kernel/fork.c:1567:36: sparse:     expected void const *q
>     kernel/fork.c:1567:36: sparse:     got struct k_sigaction [noderef] __rcu *
>     kernel/fork.c:1568:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
>     kernel/fork.c:1568:33: sparse:     expected struct spinlock [usertype] *lock
>     kernel/fork.c:1568:33: sparse:     got struct spinlock [noderef] __rcu *
>     kernel/fork.c:1980:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
>     kernel/fork.c:1980:31: sparse:     expected struct spinlock [usertype] *lock
>     kernel/fork.c:1980:31: sparse:     got struct spinlock [noderef] __rcu *
>     kernel/fork.c:1984:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
>     kernel/fork.c:1984:33: sparse:     expected struct spinlock [usertype] *lock
>     kernel/fork.c:1984:33: sparse:     got struct spinlock [noderef] __rcu *
>     kernel/fork.c:2287:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct [noderef] __rcu *real_parent @@     got struct task_struct * @@
>     kernel/fork.c:2287:32: sparse:     expected struct task_struct [noderef] __rcu *real_parent
>     kernel/fork.c:2287:32: sparse:     got struct task_struct *
>     kernel/fork.c:2296:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
>     kernel/fork.c:2296:27: sparse:     expected struct spinlock [usertype] *lock
>     kernel/fork.c:2296:27: sparse:     got struct spinlock [noderef] __rcu *
>     kernel/fork.c:2345:54: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct list_head *head @@     got struct list_head [noderef] __rcu * @@
>     kernel/fork.c:2345:54: sparse:     expected struct list_head *head
>     kernel/fork.c:2345:54: sparse:     got struct list_head [noderef] __rcu *
>     kernel/fork.c:2366:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
>     kernel/fork.c:2366:29: sparse:     expected struct spinlock [usertype] *lock
>     kernel/fork.c:2366:29: sparse:     got struct spinlock [noderef] __rcu *
>     kernel/fork.c:2384:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
>     kernel/fork.c:2384:29: sparse:     expected struct spinlock [usertype] *lock
>     kernel/fork.c:2384:29: sparse:     got struct spinlock [noderef] __rcu *
>     kernel/fork.c:2411:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sighand_struct *sighand @@     got struct sighand_struct [noderef] __rcu *sighand @@
>     kernel/fork.c:2411:28: sparse:     expected struct sighand_struct *sighand
>     kernel/fork.c:2411:28: sparse:     got struct sighand_struct [noderef] __rcu *sighand
>     kernel/fork.c:2439:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
>     kernel/fork.c:2439:31: sparse:     expected struct spinlock [usertype] *lock
>     kernel/fork.c:2439:31: sparse:     got struct spinlock [noderef] __rcu *
>     kernel/fork.c:2441:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
>     kernel/fork.c:2441:33: sparse:     expected struct spinlock [usertype] *lock
>     kernel/fork.c:2441:33: sparse:     got struct spinlock [noderef] __rcu *
>     kernel/fork.c:2850:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *[assigned] parent @@     got struct task_struct [noderef] __rcu *real_parent @@
>     kernel/fork.c:2850:24: sparse:     expected struct task_struct *[assigned] parent
>     kernel/fork.c:2850:24: sparse:     got struct task_struct [noderef] __rcu *real_parent
>     kernel/fork.c:2931:43: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct refcount_struct const [usertype] *r @@     got struct refcount_struct [noderef] __rcu * @@
>     kernel/fork.c:2931:43: sparse:     expected struct refcount_struct const [usertype] *r
>     kernel/fork.c:2931:43: sparse:     got struct refcount_struct [noderef] __rcu *
>     kernel/fork.c:2024:22: sparse: sparse: dereference of noderef expression
>     kernel/fork.c: note: in included file (through include/uapi/asm-generic/bpf_perf_event.h, arch/x86/include/generated/uapi/asm/bpf_perf_event.h, ...):
>     include/linux/ptrace.h:218:45: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *new_parent @@     got struct task_struct [noderef] __rcu *parent @@
>     include/linux/ptrace.h:218:45: sparse:     expected struct task_struct *new_parent
>     include/linux/ptrace.h:218:45: sparse:     got struct task_struct [noderef] __rcu *parent
>     include/linux/ptrace.h:218:62: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected struct cred const *ptracer_cred @@     got struct cred const [noderef] __rcu *ptracer_cred @@
>     include/linux/ptrace.h:218:62: sparse:     expected struct cred const *ptracer_cred
>     include/linux/ptrace.h:218:62: sparse:     got struct cred const [noderef] __rcu *ptracer_cred
>     kernel/fork.c:2343:59: sparse: sparse: dereference of noderef expression
>     kernel/fork.c:2344:59: sparse: sparse: dereference of noderef expression
>     kernel/fork.c:997:23: sparse: sparse: incompatible types in comparison expression (different address spaces):
>     kernel/fork.c:997:23: sparse:    struct task_struct [noderef] __rcu *
>     kernel/fork.c:997:23: sparse:    struct task_struct *
> 
> vim +1205 kernel/fork.c
> 
>    1170	
>    1171	/**
>    1172	 * replace_mm_exe_file - replace a reference to the mm's executable file
>    1173	 *
>    1174	 * This changes mm's executable file (shown as symlink /proc/[pid]/exe),
>    1175	 * dealing with concurrent invocation and without grabbing the mmap lock in
>    1176	 * write mode.
>    1177	 *
>    1178	 * Main user is sys_prctl(PR_SET_MM_MAP/EXE_FILE).
>    1179	 */
>    1180	int replace_mm_exe_file(struct mm_struct *mm, struct file *new_exe_file)
>    1181	{
>    1182		struct vm_area_struct *vma;
>    1183		struct file *old_exe_file;
>    1184		int ret = 0;
>    1185	
>    1186		/* Forbid mm->exe_file change if old file still mapped. */
>    1187		old_exe_file = get_mm_exe_file(mm);
>    1188		if (old_exe_file) {
>    1189			mmap_read_lock(mm);
>    1190			for (vma = mm->mmap; vma && !ret; vma = vma->vm_next) {
>    1191				if (!vma->vm_file)
>    1192					continue;
>    1193				if (path_equal(&vma->vm_file->f_path,
>    1194					       &old_exe_file->f_path))
>    1195					ret = -EBUSY;
>    1196			}
>    1197			mmap_read_unlock(mm);
>    1198			fput(old_exe_file);
>    1199			if (ret)
>    1200				return ret;
>    1201		}
>    1202	
>    1203		/* set the new file, lockless */
>    1204		get_file(new_exe_file);
>> 1205		old_exe_file = xchg(&mm->exe_file, new_exe_file);
>    1206		if (old_exe_file)
>    1207			fput(old_exe_file);
>    1208		return 0;
>    1209	}
>    1210	

Looks like we can happily ignore this report.


-- 
Thanks,

David / dhildenb

