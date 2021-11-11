Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6652B44D914
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 16:18:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233995AbhKKPU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 10:20:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56823 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233982AbhKKPUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 10:20:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636643886;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q0cNtUhNUJ5YTp4Z6b5j4V9T45pxGqGdZ1VnAV+7W+0=;
        b=HrYJuCFu5hl6FzSMuYS0EpvAypdOwcUbgxizdTmF7z437UzE/CHNkZHTOYncglAjU5P8om
        r1B5IK9qVqodUJDxkN3v7pNFyvXXKjPZ6i2WnEmG1T0DBHQLUsjhLKWaNgHpf8t+xGfryM
        wpVO6iOvOeYl2HKRkg5p9mFfexpQVgw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-ya5QVeZBPaurj3MPhTYdZA-1; Thu, 11 Nov 2021 10:18:05 -0500
X-MC-Unique: ya5QVeZBPaurj3MPhTYdZA-1
Received: by mail-wr1-f72.google.com with SMTP id y10-20020adffa4a000000b0017eea6cb05dso1059924wrr.6
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 07:18:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Q0cNtUhNUJ5YTp4Z6b5j4V9T45pxGqGdZ1VnAV+7W+0=;
        b=nTJv2mrTLKXuf9v7h0CMSosqHCy4UXA84ZdjKh1X44hLAijszAQFaLGniTHByK/24F
         JQ4SeaB4YOYjM+HOmEpNWNI23orTovN/zeY7myIgCnbiWbqWheJeLCGK3wMyQC4+azXd
         Q28QtPYClsSdJxqyzZsB5AxOdJ1/KUQEwsBooXeMnvxzntlRTxuRo3wnbKztGgptXg95
         kdttb3QnFthd/pXs9ZOX/SU3yFkt1XVDN0XJT7mWay8qFEWQqxYtHucFQdQRFnu1ky5N
         nAzjMWtL3WdfelZWKZLGO7oGThf5yPxucDz6TE7lVt6xKohPKAjRmAif3qHz8h+bjzeB
         hIKQ==
X-Gm-Message-State: AOAM530rGOSTyUvLR4J2Lwm7M6CLAHN0BDuAkR8M1Ofc9DhaNMF2FK9i
        wbcLlK1bFXutXFSRY6rbUydoYuE8r9Jnw+Hu2myUB8peB8oAWEPpk5WDni5GYvifp6HVs8ANyAs
        rVR5R1/qTgJjTDyPnJqx24XT6
X-Received: by 2002:a05:600c:19d1:: with SMTP id u17mr26609317wmq.148.1636643883864;
        Thu, 11 Nov 2021 07:18:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyjfe6VczNOYkTc9EVKpzTYfmmgunIBpEZIImi/kWgjnIGXR5Cp5VKUzRC389SULr+6Qtr1Kg==
X-Received: by 2002:a05:600c:19d1:: with SMTP id u17mr26609256wmq.148.1636643883580;
        Thu, 11 Nov 2021 07:18:03 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.gmail.com with ESMTPSA id l8sm10841698wmc.40.2021.11.11.07.18.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Nov 2021 07:18:02 -0800 (PST)
Message-ID: <174d6879-0a5f-5045-c453-c55db6454514@redhat.com>
Date:   Thu, 11 Nov 2021 16:18:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH V11 2/5] KVM: SEV: Add support for SEV intra host
 migration
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>,
        Peter Gonda <pgonda@google.com>
Cc:     kvm@vger.kernel.org, Marc Orr <marcorr@google.com>,
        David Rientjes <rientjes@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
References: <20211021174303.385706-1-pgonda@google.com>
 <20211021174303.385706-3-pgonda@google.com> <YYRZq+Zt52FSyjVW@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <YYRZq+Zt52FSyjVW@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/4/21 23:07, Sean Christopherson wrote:
> 
> That would also provide a good opportunity to more tightly couple ->asid and
> ->misc_cg in the form of a helper.  Looking at the code, there's an invariant
> that misc_cg is NULL if an ASID is not assigned.  I.e. these three lines belong
> in a helper, irrespective of this code.
> 
> 	misc_cg_uncharge(type, sev->misc_cg, 1);
> 	put_misc_cg(sev->misc_cg);
> 	sev->misc_cg = NULL;

Agreed.  Though it's a bit more complicated because if dst->misc_cg ==
src->misc_cg you should *not* charge and uncharge, because charging
could fail.  So I'm going for just simple charge/uncharge helpers for
now:

 From 0ac1004d9e15e9460b51651bd095e6c5ee9cf4f9 Mon Sep 17 00:00:00 2001
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 11 Nov 2021 10:02:26 -0500
Subject: [PATCH 1/4] KVM: SEV: provide helpers to charge/uncharge misc_cg

Avoid code duplication across all callers of misc_cg_try_charge and
misc_cg_uncharge.  The resource type for KVM is always derived from
sev->es_active, and the quantity is always 1.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 7c94fe307b39..5bafa4bf7c49 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -120,16 +120,26 @@ static bool __sev_recycle_asids(int min_asid, int max_asid)
  	return true;
  }
  
+static int sev_misc_cg_try_charge(struct kvm_sev_info *sev)
+{
+	enum misc_res_type type = sev->es_active ? MISC_CG_RES_SEV_ES : MISC_CG_RES_SEV;
+	return misc_cg_try_charge(type, sev->misc_cg, 1);
+}
+
+static void sev_misc_cg_uncharge(struct kvm_sev_info *sev)
+{
+	enum misc_res_type type = sev->es_active ? MISC_CG_RES_SEV_ES : MISC_CG_RES_SEV;
+	misc_cg_uncharge(type, sev->misc_cg, 1);
+}
+
  static int sev_asid_new(struct kvm_sev_info *sev)
  {
  	int asid, min_asid, max_asid, ret;
  	bool retry = true;
-	enum misc_res_type type;
  
-	type = sev->es_active ? MISC_CG_RES_SEV_ES : MISC_CG_RES_SEV;
  	WARN_ON(sev->misc_cg);
  	sev->misc_cg = get_current_misc_cg();
-	ret = misc_cg_try_charge(type, sev->misc_cg, 1);
+	ret = sev_misc_cg_try_charge(sev);
  	if (ret) {
  		put_misc_cg(sev->misc_cg);
  		sev->misc_cg = NULL;
@@ -162,7 +172,7 @@ static int sev_asid_new(struct kvm_sev_info *sev)
  
  	return asid;
  e_uncharge:
-	misc_cg_uncharge(type, sev->misc_cg, 1);
+	sev_misc_cg_uncharge(sev);
  	put_misc_cg(sev->misc_cg);
  	sev->misc_cg = NULL;
  	return ret;
@@ -179,7 +189,6 @@ static void sev_asid_free(struct kvm_sev_info *sev)
  {
  	struct svm_cpu_data *sd;
  	int cpu;
-	enum misc_res_type type;
  
  	mutex_lock(&sev_bitmap_lock);
  
@@ -192,8 +201,7 @@ static void sev_asid_free(struct kvm_sev_info *sev)
  
  	mutex_unlock(&sev_bitmap_lock);
  
-	type = sev->es_active ? MISC_CG_RES_SEV_ES : MISC_CG_RES_SEV;
-	misc_cg_uncharge(type, sev->misc_cg, 1);
+	sev_misc_cg_uncharge(sev);
  	put_misc_cg(sev->misc_cg);
  	sev->misc_cg = NULL;
  }



 From 5214132ae7e8310de26d5791f7fe913085a8e53c Mon Sep 17 00:00:00 2001
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 11 Nov 2021 10:08:32 -0500
Subject: [PATCH 2/4] fix cgroup charging


diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 5bafa4bf7c49..97048ff7c2ad 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -1594,7 +1594,6 @@ static void sev_migrate_from(struct kvm_sev_info *dst,
  {
  	dst->active = true;
  	dst->asid = src->asid;
-	dst->misc_cg = src->misc_cg;
  	dst->handle = src->handle;
  	dst->pages_locked = src->pages_locked;
  
@@ -1602,6 +1601,11 @@ static void sev_migrate_from(struct kvm_sev_info *dst,
  	src->active = false;
  	src->handle = 0;
  	src->pages_locked = 0;
+
+	if (dst->misc_cg != src->misc_cg)
+		sev_misc_cg_uncharge(src);
+
+	put_misc_cg(src->misc_cg);
  	src->misc_cg = NULL;
  
  	INIT_LIST_HEAD(&dst->regions_list);
@@ -1611,6 +1615,7 @@ static void sev_migrate_from(struct kvm_sev_info *dst,
  int svm_vm_migrate_from(struct kvm *kvm, unsigned int source_fd)
  {
  	struct kvm_sev_info *dst_sev = &to_kvm_svm(kvm)->sev_info;
+	struct kvm_sev_info *src_sev;
  	struct file *source_kvm_file;
  	struct kvm *source_kvm;
  	struct kvm_vcpu *vcpu;
@@ -1640,25 +1645,39 @@ int svm_vm_migrate_from(struct kvm *kvm, unsigned int source_fd)
  		ret = -EINVAL;
  		goto out_source;
  	}
+
+	src_sev = &to_kvm_svm(source_kvm)->sev_info;
+	dst_sev->misc_cg = get_current_misc_cg();
+	if (dst_sev->misc_cg != src_sev->misc_cg) {
+		ret = sev_misc_cg_try_charge(dst_sev);
+		if (ret)
+			goto out_dst_put_cgroup;
+	}
+
  	ret = sev_lock_vcpus_for_migration(kvm);
  	if (ret)
-		goto out_dst_vcpu;
+		goto out_dst_cgroup;
  	ret = sev_lock_vcpus_for_migration(source_kvm);
  	if (ret)
-		goto out_source_vcpu;
+		goto out_dst_vcpu;
  
-	sev_migrate_from(dst_sev, &to_kvm_svm(source_kvm)->sev_info);
+	sev_migrate_from(dst_sev, src_sev);
  	kvm_for_each_vcpu(i, vcpu, source_kvm) {
  		kvm_vcpu_reset(vcpu, /* init_event= */ false);
  	}
  	ret = 0;
  
-out_source_vcpu:
  	sev_unlock_vcpus_for_migration(source_kvm);
  
  out_dst_vcpu:
  	sev_unlock_vcpus_for_migration(kvm);
-
+out_dst_cgroup:
+	if (ret < 0) {
+		sev_misc_cg_uncharge(dst_sev);
+out_dst_put_cgroup:
+		put_misc_cg(dst_sev->misc_cg);
+		dst_sev->misc_cg = NULL;
+	}
  out_source:
  	sev_unlock_after_migration(source_kvm);
  out_fput:



 From 943ba93c57ee25f85538decd68dca6e4ebdaf2c1 Mon Sep 17 00:00:00 2001
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 11 Nov 2021 10:13:38 -0500
Subject: [PATCH 3/4] KVM: generalize "bugged" VM to "dead" VM

Generalize KVM_REQ_VM_BUGGED so that it can be called even in cases
where it is by design that the VM cannot be operated upon.  In this
case any KVM_BUG_ON should still warn, so introduce a new flag
kvm->vm_dead that is separate from kvm->vm_bugged.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index ca9693d3436b..185094eb86b6 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9660,7 +9660,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
  	}
  
  	if (kvm_request_pending(vcpu)) {
-		if (kvm_check_request(KVM_REQ_VM_BUGGED, vcpu)) {
+		if (kvm_check_request(KVM_REQ_VM_DEAD, vcpu)) {
  			r = -EIO;
  			goto out;
  		}
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 60a35d9fe259..9e0667e3723e 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -150,7 +150,7 @@ static inline bool is_error_page(struct page *page)
  #define KVM_REQ_MMU_RELOAD        (1 | KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
  #define KVM_REQ_UNBLOCK           2
  #define KVM_REQ_UNHALT            3
-#define KVM_REQ_VM_BUGGED         (4 | KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
+#define KVM_REQ_VM_DEAD           (4 | KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
  #define KVM_REQUEST_ARCH_BASE     8
  
  #define KVM_ARCH_REQ_FLAGS(nr, flags) ({ \
@@ -617,6 +617,7 @@ struct kvm {
  	unsigned int max_halt_poll_ns;
  	u32 dirty_ring_size;
  	bool vm_bugged;
+	bool vm_dead;
  
  #ifdef CONFIG_HAVE_KVM_PM_NOTIFIER
  	struct notifier_block pm_notifier;
@@ -650,12 +651,19 @@ struct kvm {
  #define vcpu_err(vcpu, fmt, ...)					\
  	kvm_err("vcpu%i " fmt, (vcpu)->vcpu_id, ## __VA_ARGS__)
  
+static inline void kvm_vm_dead(struct kvm *kvm)
+{
+	kvm->vm_dead = true;
+	kvm_make_all_cpus_request(kvm, KVM_REQ_VM_DEAD);
+}
+
  static inline void kvm_vm_bugged(struct kvm *kvm)
  {
  	kvm->vm_bugged = true;
-	kvm_make_all_cpus_request(kvm, KVM_REQ_VM_BUGGED);
+	kvm_vm_dead(kvm);
  }
  
+
  #define KVM_BUG(cond, kvm, fmt...)				\
  ({								\
  	int __ret = (cond);					\
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 3f6d450355f0..d31724500501 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3747,7 +3747,7 @@ static long kvm_vcpu_ioctl(struct file *filp,
  	struct kvm_fpu *fpu = NULL;
  	struct kvm_sregs *kvm_sregs = NULL;
  
-	if (vcpu->kvm->mm != current->mm || vcpu->kvm->vm_bugged)
+	if (vcpu->kvm->mm != current->mm || vcpu->kvm->vm_dead)
  		return -EIO;
  
  	if (unlikely(_IOC_TYPE(ioctl) != KVMIO))
@@ -3957,7 +3957,7 @@ static long kvm_vcpu_compat_ioctl(struct file *filp,
  	void __user *argp = compat_ptr(arg);
  	int r;
  
-	if (vcpu->kvm->mm != current->mm || vcpu->kvm->vm_bugged)
+	if (vcpu->kvm->mm != current->mm || vcpu->kvm->vm_dead)
  		return -EIO;
  
  	switch (ioctl) {
@@ -4023,7 +4023,7 @@ static long kvm_device_ioctl(struct file *filp, unsigned int ioctl,
  {
  	struct kvm_device *dev = filp->private_data;
  
-	if (dev->kvm->mm != current->mm || dev->kvm->vm_bugged)
+	if (dev->kvm->mm != current->mm || dev->kvm->vm_dead)
  		return -EIO;
  
  	switch (ioctl) {
@@ -4345,7 +4345,7 @@ static long kvm_vm_ioctl(struct file *filp,
  	void __user *argp = (void __user *)arg;
  	int r;
  
-	if (kvm->mm != current->mm || kvm->vm_bugged)
+	if (kvm->mm != current->mm || kvm->vm_dead)
  		return -EIO;
  	switch (ioctl) {
  	case KVM_CREATE_VCPU:
@@ -4556,7 +4556,7 @@ static long kvm_vm_compat_ioctl(struct file *filp,
  	struct kvm *kvm = filp->private_data;
  	int r;
  
-	if (kvm->mm != current->mm || kvm->vm_bugged)
+	if (kvm->mm != current->mm || kvm->vm_dead)
  		return -EIO;
  	switch (ioctl) {
  #ifdef CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT



 From fb168352e16a4dbd95a7c0d1e6add18f0496ac97 Mon Sep 17 00:00:00 2001
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 11 Nov 2021 10:14:49 -0500
Subject: [PATCH 4/4] mark src vm as dead


diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 97048ff7c2ad..2403aea3dbd3 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -1662,12 +1662,9 @@ int svm_vm_migrate_from(struct kvm *kvm, unsigned int source_fd)
  		goto out_dst_vcpu;
  
  	sev_migrate_from(dst_sev, src_sev);
-	kvm_for_each_vcpu(i, vcpu, source_kvm) {
-		kvm_vcpu_reset(vcpu, /* init_event= */ false);
-	}
-	ret = 0;
-
+	kvm_vm_dead(source_kvm);
  	sev_unlock_vcpus_for_migration(source_kvm);
+	ret = 0;
  
  out_dst_vcpu:
  	sev_unlock_vcpus_for_migration(kvm);


I'll send it out properly when I finish reviewing.

Paolo

