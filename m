Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31F8940583B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 15:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356839AbhIINsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 09:48:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39173 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1355293AbhIINqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 09:46:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631195127;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xTpohogIA64F7YnEY632XtA1i/qGIAHCwBWGTfs60IE=;
        b=LBZTIrrMiRMH8qNFWOaIYhyoj6vShDuTQGC8Y7wtgO29L1voiqj/4l+EcM5RHs5TqqCbCx
        WoKtOOMNoF/m8EuQpO9iHJnwPw97HEYtOkotrTsidoaavaKEAGaVVFxRxrkSpLqFISwwqd
        3rjZ9PyD5oTHvT3kNSS9YwOFlP/lNcI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-rtbv8SMHP8OgJkd5YHg30A-1; Thu, 09 Sep 2021 09:45:24 -0400
X-MC-Unique: rtbv8SMHP8OgJkd5YHg30A-1
Received: by mail-wm1-f72.google.com with SMTP id w25-20020a1cf6190000b0290252505ddd56so795365wmc.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 06:45:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xTpohogIA64F7YnEY632XtA1i/qGIAHCwBWGTfs60IE=;
        b=HeRRIIKc/D0zm0qPIwED+X/mFoWjQQ3RYkOKqckJjja9/gCnl55pOSSmKr5E7cMIYD
         yDlpcWyZIbhd/5miRmE9h4LSjZWxFWy954HiKSE0flklyvGFo0aBp/QC+GaWUeXiyYjO
         ESz5qaRIFKo4SVyDBJTtQX9VAE/YGWvboFKDEU9uaDJguWiydPBVp5j5hCtz6n054xQr
         QpNbnX74abOnsDqasfQSvG8IDo9of1t4PEuzkIfPyTdQ1VorLruF3dZP5Gb4ieoF3AyG
         4yQVPSpI6dL9OILBpzBRPmuPaFaJjhl60nvy/DdwstWiiMb6rUvNIigyVo92nqNbsmBu
         ebRw==
X-Gm-Message-State: AOAM532RAlPlMNMB3ER3X++PZnQ78i7GVmYbv9Jn63vtAUl0cTR6c4f4
        jDeEtN7wVX2sbAtlII15DPArJvcZmw53Sx58Lq245p+sbMk/qizZVAbEolnZtQtgk/qKbVwYcOA
        hjZ0iU7bW652e2vj4+fRo4Vwb
X-Received: by 2002:a7b:cbc9:: with SMTP id n9mr3122665wmi.50.1631195123207;
        Thu, 09 Sep 2021 06:45:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx7puNMDXniSPYBQjdcRLIZDpZ0bmtEJYUCUsx+UIrFjPnaJ0zlntbh8UgDW66c97dJo2dZeQ==
X-Received: by 2002:a7b:cbc9:: with SMTP id n9mr3122635wmi.50.1631195122967;
        Thu, 09 Sep 2021 06:45:22 -0700 (PDT)
Received: from gator (cst2-174-132.cust.vodafone.cz. [31.30.174.132])
        by smtp.gmail.com with ESMTPSA id u16sm1719047wmc.41.2021.09.09.06.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 06:45:22 -0700 (PDT)
Date:   Thu, 9 Sep 2021 15:45:20 +0200
From:   Andrew Jones <drjones@redhat.com>
To:     Raghavendra Rao Ananta <rananta@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Peter Shier <pshier@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Oliver Upton <oupton@google.com>,
        Reiji Watanabe <reijiw@google.com>,
        Jing Zhang <jingzhangos@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH v4 16/18] KVM: arm64: selftests: arch_timer: Support vCPU
 migration
Message-ID: <20210909134520.yxrjestdwsishce2@gator>
References: <20210909013818.1191270-1-rananta@google.com>
 <20210909013818.1191270-17-rananta@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210909013818.1191270-17-rananta@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09, 2021 at 01:38:16AM +0000, Raghavendra Rao Ananta wrote:
> Since the timer stack (hardware and KVM) is per-CPU, there
> are potential chances for races to occur when the scheduler
> decides to migrate a vCPU thread to a different physical CPU.
> Hence, include an option to stress-test this part as well by
> forcing the vCPUs to migrate across physical CPUs in the
> system at a particular rate.
> 
> Originally, the bug for the fix with commit 3134cc8beb69d0d
> ("KVM: arm64: vgic: Resample HW pending state on deactivation")
> was discovered using arch_timer test with vCPU migrations and
> can be easily reproduced.
> 
> Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
> ---
>  .../selftests/kvm/aarch64/arch_timer.c        | 113 +++++++++++++++++-
>  1 file changed, 112 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kvm/aarch64/arch_timer.c b/tools/testing/selftests/kvm/aarch64/arch_timer.c
> index 6141c387e6dc..aac7bcea4352 100644
> --- a/tools/testing/selftests/kvm/aarch64/arch_timer.c
> +++ b/tools/testing/selftests/kvm/aarch64/arch_timer.c
> @@ -14,6 +14,8 @@
>   *
>   * The test provides command-line options to configure the timer's
>   * period (-p), number of vCPUs (-n), and iterations per stage (-i).
> + * To stress-test the timer stack even more, an option to migrate the
> + * vCPUs across pCPUs (-m), at a particular rate, is also provided.
>   *
>   * Copyright (c) 2021, Google LLC.
>   */
> @@ -24,6 +26,8 @@
>  #include <pthread.h>
>  #include <linux/kvm.h>
>  #include <linux/sizes.h>
> +#include <linux/bitmap.h>
> +#include <sys/sysinfo.h>
>  
>  #include "kvm_util.h"
>  #include "processor.h"
> @@ -36,17 +40,20 @@
>  #define NR_TEST_ITERS_DEF		5
>  #define TIMER_TEST_PERIOD_MS_DEF	10
>  #define TIMER_TEST_ERR_MARGIN_US	100
> +#define TIMER_TEST_MIGRATION_FREQ_MS	2
>  
>  struct test_args {
>  	int nr_vcpus;
>  	int nr_iter;
>  	int timer_period_ms;
> +	int migration_freq_ms;
>  };
>  
>  static struct test_args test_args = {
>  	.nr_vcpus = NR_VCPUS_DEF,
>  	.nr_iter = NR_TEST_ITERS_DEF,
>  	.timer_period_ms = TIMER_TEST_PERIOD_MS_DEF,
> +	.migration_freq_ms = TIMER_TEST_MIGRATION_FREQ_MS,
>  };
>  
>  #define msecs_to_usecs(msec)		((msec) * 1000LL)
> @@ -81,6 +88,9 @@ struct test_vcpu {
>  static struct test_vcpu test_vcpu[KVM_MAX_VCPUS];
>  static struct test_vcpu_shared_data vcpu_shared_data[KVM_MAX_VCPUS];
>  
> +static unsigned long *vcpu_done_map;
> +static pthread_mutex_t vcpu_done_map_lock;
> +
>  static void
>  guest_configure_timer_action(struct test_vcpu_shared_data *shared_data)
>  {
> @@ -216,6 +226,11 @@ static void *test_vcpu_run(void *arg)
>  
>  	vcpu_run(vm, vcpuid);
>  
> +	/* Currently, any exit from guest is an indication of completion */
> +	pthread_mutex_lock(&vcpu_done_map_lock);
> +	set_bit(vcpuid, vcpu_done_map);
> +	pthread_mutex_unlock(&vcpu_done_map_lock);
> +
>  	switch (get_ucall(vm, vcpuid, &uc)) {
>  	case UCALL_SYNC:
>  	case UCALL_DONE:
> @@ -234,9 +249,76 @@ static void *test_vcpu_run(void *arg)
>  	return NULL;
>  }
>  
> +static uint32_t test_get_pcpu(void)
> +{
> +	uint32_t pcpu;
> +	unsigned int nproc_conf;
> +	cpu_set_t online_cpuset;
> +
> +	nproc_conf = get_nprocs_conf();
> +	sched_getaffinity(0, sizeof(cpu_set_t), &online_cpuset);
> +
> +	/* Randomly find an available pCPU to place a vCPU on */
> +	do {
> +		pcpu = rand() % nproc_conf;
> +	} while (!CPU_ISSET(pcpu, &online_cpuset));
> +
> +	return pcpu;
> +}

Missing blank line here.

> +static int test_migrate_vcpu(struct test_vcpu *vcpu)
> +{
> +	int ret;
> +	cpu_set_t cpuset;
> +	uint32_t new_pcpu = test_get_pcpu();
> +
> +	CPU_ZERO(&cpuset);
> +	CPU_SET(new_pcpu, &cpuset);
> +
> +	pr_debug("Migrating vCPU: %u to pCPU: %u\n", vcpu->vcpuid, new_pcpu);
> +
> +	ret = pthread_setaffinity_np(vcpu->pt_vcpu_run,
> +					sizeof(cpuset), &cpuset);
> +
> +	/* Allow the error where the vCPU thread is already finished */
> +	TEST_ASSERT(ret == 0 || ret == ESRCH,
> +			"Failed to migrate the vCPU:%u to pCPU: %u; ret: %d\n",
> +			vcpu->vcpuid, new_pcpu, ret);
> +
> +	return ret;
> +}

Missing blank line here.

> +static void *test_vcpu_migration(void *arg)
> +{
> +	unsigned int i, n_done;
> +	bool vcpu_done;
> +
> +	do {
> +		usleep(msecs_to_usecs(test_args.migration_freq_ms));
> +
> +		for (n_done = 0, i = 0; i < test_args.nr_vcpus; i++) {
> +			pthread_mutex_lock(&vcpu_done_map_lock);
> +			vcpu_done = test_bit(i, vcpu_done_map);
> +			pthread_mutex_unlock(&vcpu_done_map_lock);
> +
> +			if (vcpu_done) {
> +				n_done++;
> +				continue;
> +			}
> +
> +			test_migrate_vcpu(&test_vcpu[i]);
> +		}
> +	} while (test_args.nr_vcpus != n_done);
> +
> +	return NULL;
> +}
> +
>  static void test_run(struct kvm_vm *vm)
>  {
>  	int i, ret;
> +	pthread_t pt_vcpu_migration;
> +
> +	pthread_mutex_init(&vcpu_done_map_lock, NULL);
> +	vcpu_done_map = bitmap_alloc(test_args.nr_vcpus);
> +	TEST_ASSERT(vcpu_done_map, "Failed to allocate vcpu done bitmap\n");
>  
>  	for (i = 0; i < test_args.nr_vcpus; i++) {
>  		ret = pthread_create(&test_vcpu[i].pt_vcpu_run, NULL,
> @@ -244,8 +326,23 @@ static void test_run(struct kvm_vm *vm)
>  		TEST_ASSERT(!ret, "Failed to create vCPU-%d pthread\n", i);
>  	}
>  
> +	/* Spawn a thread to control the vCPU migrations */
> +	if (test_args.migration_freq_ms) {
> +		srand(time(NULL));
> +
> +		ret = pthread_create(&pt_vcpu_migration, NULL,
> +					test_vcpu_migration, NULL);
> +		TEST_ASSERT(!ret, "Failed to create the migration pthread\n");
> +	}
> +
> +
>  	for (i = 0; i < test_args.nr_vcpus; i++)
>  		pthread_join(test_vcpu[i].pt_vcpu_run, NULL);
> +
> +	if (test_args.migration_freq_ms)
> +		pthread_join(pt_vcpu_migration, NULL);
> +
> +	bitmap_free(vcpu_done_map);
>  }
>  
>  static struct kvm_vm *test_vm_create(void)
> @@ -286,6 +383,8 @@ static void test_print_help(char *name)
>  		NR_TEST_ITERS_DEF);
>  	pr_info("\t-p: Periodicity (in ms) of the guest timer (default: %u)\n",
>  		TIMER_TEST_PERIOD_MS_DEF);
> +	pr_info("\t-m: Frequency (in ms) of vCPUs to migrate to different pCPU. 0 to turn off (default: %u)\n",
> +		TIMER_TEST_MIGRATION_FREQ_MS);
>  	pr_info("\t-h: print this help screen\n");
>  }
>  
> @@ -293,7 +392,7 @@ static bool parse_args(int argc, char *argv[])
>  {
>  	int opt;
>  
> -	while ((opt = getopt(argc, argv, "hn:i:p:")) != -1) {
> +	while ((opt = getopt(argc, argv, "hn:i:p:m:")) != -1) {
>  		switch (opt) {
>  		case 'n':
>  			test_args.nr_vcpus = atoi(optarg);
> @@ -320,6 +419,13 @@ static bool parse_args(int argc, char *argv[])
>  				goto err;
>  			}
>  			break;
> +		case 'm':
> +			test_args.migration_freq_ms = atoi(optarg);
> +			if (test_args.migration_freq_ms < 0) {
> +				pr_info("0 or positive value needed for -m\n");
> +				goto err;
> +			}
> +			break;
>  		case 'h':
>  		default:
>  			goto err;
> @@ -343,6 +449,11 @@ int main(int argc, char *argv[])
>  	if (!parse_args(argc, argv))
>  		exit(KSFT_SKIP);
>  
> +	if (get_nprocs() < 2) {

Even though the chance of being on a uniprocessor is low and the migration
test is now on by default, we could still do

 if (test_args.migration_freq_ms && get_nprocs() < 2)

since that's why the skip message says it needs two cpus.

> +		print_skip("At least two physical CPUs needed for vCPU migration");
> +		exit(KSFT_SKIP);
> +	}
> +
>  	vm = test_vm_create();
>  	test_run(vm);
>  	kvm_vm_free(vm);
> -- 
> 2.33.0.153.gba50c8fa24-goog
> 

Reviewed-by: Andrew Jones <drjones@redhat.com>

Thanks,
drew

