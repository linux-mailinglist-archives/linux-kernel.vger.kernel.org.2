Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35B303408FE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 16:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbhCRPf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 11:35:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43662 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231842AbhCRPft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 11:35:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616081749;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T4A9o56mRsBOrfihYljW1/jP87nLFshUiBkxTmGR3aw=;
        b=dYnonW7R9XmwouMUr/DDaYrekpehK+zp2DnTVbB27ULiHTbREYUWB06v5HZzDvSJMwa1CQ
        kCgIi7H4aW31D9kk79BAeJPtCoWsdAj2wv2mB77vaHQ9csOKdC3lHrJtdDYpTfciimmI2i
        fcnVjjZ549DR+GSNi06LqXEWBdVkttQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-NfhdjoTeOYSNInNYhhMMqw-1; Thu, 18 Mar 2021 11:35:47 -0400
X-MC-Unique: NfhdjoTeOYSNInNYhhMMqw-1
Received: by mail-ej1-f71.google.com with SMTP id di5so16809656ejc.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 08:35:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=T4A9o56mRsBOrfihYljW1/jP87nLFshUiBkxTmGR3aw=;
        b=JuPgt1t3jQhnGgArKOkybPh2taIDgvOL0WB2dksw8k5W/Wrxrao9CqtgEjI5ltyVNU
         Sz01Jxni/5j0zAr8AfJHFSI3+wqYLAppSF8NQPd6y9dFwBYZmKkmm6z78tcHTFaJpa7a
         u5Gy4JiLW7h6e1kN1qbVhgGNxcw4jfaWFrQ5rUjhChyjZ6sYiGIdMGho8JG/q9G3Cy66
         EMunk8VPWIH8bW/nVMT3heAPSreXq80M+O6C/DDk9ERwPIy3508LGsudM15EQYxzGjWE
         zkV8kZIK0RstPwu/9969xn/lab/njEcQ8fkNHhpI2NZjfdxM6r/XNVz9yVUU6RA8A95N
         qU8A==
X-Gm-Message-State: AOAM53277Lpe4tRNDUngWtl5wUGvzi+cw3SaQ6vO6G+usczPGndmn0p3
        wO4mxueL4076qTmq6GdV3gOl0eEiGitLTWXKZi5nxt/I5YD4fL8ffqw3/CIwV3RM/+nhuFWhM3d
        NunRjVMilEi6004wrEwxpRFaN6V1JiFfCM+TDihMRuLVcttGQuZhMXNZNY7WIYj7slF93fUny0k
        D7
X-Received: by 2002:a05:6402:2070:: with SMTP id bd16mr4382178edb.133.1616081746048;
        Thu, 18 Mar 2021 08:35:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz4KPzbOX5m9ycoPWC7zVaZIZYQ+wLLhhSIehmdE0OsZn5m9eUT881TI6PbbfOmDXRzKaIDdA==
X-Received: by 2002:a05:6402:2070:: with SMTP id bd16mr4382152edb.133.1616081745815;
        Thu, 18 Mar 2021 08:35:45 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id jj15sm2178426ejc.99.2021.03.18.08.35.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Mar 2021 08:35:45 -0700 (PDT)
Subject: Re: [PATCH] selftests/kvm: add get_msr_index_features
To:     Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        linux-kselftest@vger.kernel.org
Cc:     Shuah Khan <shuah@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210318145629.486450-1-eesposit@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7875edc7-1fec-6d54-4787-e577f087ae3b@redhat.com>
Date:   Thu, 18 Mar 2021 16:35:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210318145629.486450-1-eesposit@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/03/21 15:56, Emanuele Giuseppe Esposito wrote:
> Test the KVM_GET_MSR_FEATURE_INDEX_LIST
> and KVM_GET_MSR_INDEX_LIST ioctls.
> 
> Signed-off-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>

Looks good, thanks.

I queued it with a little extra code to verify KVM_GET_MSR_INDEX_LIST in 
the case that does not return E2BIG.

Paolo

> ---
>   tools/testing/selftests/kvm/.gitignore        |   1 +
>   tools/testing/selftests/kvm/Makefile          |   1 +
>   .../kvm/x86_64/get_msr_index_features.c       | 124 ++++++++++++++++++
>   3 files changed, 126 insertions(+)
>   create mode 100644 tools/testing/selftests/kvm/x86_64/get_msr_index_features.c
> 
> diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
> index 32b87cc77c8e..d99f3969d371 100644
> --- a/tools/testing/selftests/kvm/.gitignore
> +++ b/tools/testing/selftests/kvm/.gitignore
> @@ -5,6 +5,7 @@
>   /s390x/resets
>   /s390x/sync_regs_test
>   /x86_64/cr4_cpuid_sync_test
> +/x86_64/get_msr_index_features
>   /x86_64/debug_regs
>   /x86_64/evmcs_test
>   /x86_64/get_cpuid_test
> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
> index a6d61f451f88..c748b9650e28 100644
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -39,6 +39,7 @@ LIBKVM_aarch64 = lib/aarch64/processor.c lib/aarch64/ucall.c
>   LIBKVM_s390x = lib/s390x/processor.c lib/s390x/ucall.c lib/s390x/diag318_test_handler.c
>   
>   TEST_GEN_PROGS_x86_64 = x86_64/cr4_cpuid_sync_test
> +TEST_GEN_PROGS_x86_64 += x86_64/get_msr_index_features
>   TEST_GEN_PROGS_x86_64 += x86_64/evmcs_test
>   TEST_GEN_PROGS_x86_64 += x86_64/get_cpuid_test
>   TEST_GEN_PROGS_x86_64 += x86_64/hyperv_cpuid
> diff --git a/tools/testing/selftests/kvm/x86_64/get_msr_index_features.c b/tools/testing/selftests/kvm/x86_64/get_msr_index_features.c
> new file mode 100644
> index 000000000000..ad9972d99dfa
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/x86_64/get_msr_index_features.c
> @@ -0,0 +1,124 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Test that KVM_GET_MSR_INDEX_LIST and
> + * KVM_GET_MSR_FEATURE_INDEX_LIST work as intended
> + *
> + * Copyright (C) 2020, Red Hat, Inc.
> + */
> +#include <fcntl.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/ioctl.h>
> +
> +#include "test_util.h"
> +#include "kvm_util.h"
> +#include "processor.h"
> +#include "../lib/kvm_util_internal.h"
> +
> +static int kvm_num_index_msrs(int kvm_fd, int nmsrs)
> +{
> +	struct kvm_msr_list *list;
> +	int r;
> +
> +	list = malloc(sizeof(*list) + nmsrs * sizeof(list->indices[0]));
> +	list->nmsrs = nmsrs;
> +	r = ioctl(kvm_fd, KVM_GET_MSR_INDEX_LIST, list);
> +	TEST_ASSERT(r == -1 && errno == E2BIG,
> +				"Unexpected result from KVM_GET_MSR_INDEX_LIST probe, r: %i",
> +				r);
> +
> +	r = list->nmsrs;
> +	free(list);
> +	return r;
> +}
> +
> +static void test_get_msr_index(void)
> +{
> +	int old_res, res, kvm_fd;
> +
> +	kvm_fd = open(KVM_DEV_PATH, O_RDONLY);
> +	if (kvm_fd < 0)
> +		exit(KSFT_SKIP);
> +
> +	old_res = kvm_num_index_msrs(kvm_fd, 0);
> +	TEST_ASSERT(old_res != 0, "Expecting nmsrs to be > 0");
> +
> +	if (old_res != 1) {
> +		res = kvm_num_index_msrs(kvm_fd, 1);
> +		TEST_ASSERT(res > 1, "Expecting nmsrs to be > 1");
> +		TEST_ASSERT(res == old_res, "Expecting nmsrs to be identical");
> +	}
> +
> +	close(kvm_fd);
> +}
> +
> +static int kvm_num_feature_msrs(int kvm_fd, int nmsrs)
> +{
> +	struct kvm_msr_list *list;
> +	int r;
> +
> +	list = malloc(sizeof(*list) + nmsrs * sizeof(list->indices[0]));
> +	list->nmsrs = nmsrs;
> +	r = ioctl(kvm_fd, KVM_GET_MSR_FEATURE_INDEX_LIST, list);
> +	TEST_ASSERT(r == -1 && errno == E2BIG,
> +		"Unexpected result from KVM_GET_MSR_FEATURE_INDEX_LIST probe, r: %i",
> +				r);
> +
> +	r = list->nmsrs;
> +	free(list);
> +	return r;
> +}
> +
> +struct kvm_msr_list *kvm_get_msr_feature_list(int kvm_fd, int nmsrs)
> +{
> +	struct kvm_msr_list *list;
> +	int r;
> +
> +	list = malloc(sizeof(*list) + nmsrs * sizeof(list->indices[0]));
> +	list->nmsrs = nmsrs;
> +	r = ioctl(kvm_fd, KVM_GET_MSR_FEATURE_INDEX_LIST, list);
> +
> +	TEST_ASSERT(r == 0,
> +		"Unexpected result from KVM_GET_MSR_FEATURE_INDEX_LIST, r: %i",
> +		r);
> +
> +	return list;
> +}
> +
> +static void test_get_msr_feature(void)
> +{
> +	int res, old_res, i, kvm_fd;
> +	struct kvm_msr_list *feature_list;
> +
> +	kvm_fd = open(KVM_DEV_PATH, O_RDONLY);
> +	if (kvm_fd < 0)
> +		exit(KSFT_SKIP);
> +
> +	old_res = kvm_num_feature_msrs(kvm_fd, 0);
> +	TEST_ASSERT(old_res != 0, "Expecting nmsrs to be > 0");
> +
> +	if (old_res != 1) {
> +		res = kvm_num_feature_msrs(kvm_fd, 1);
> +		TEST_ASSERT(res > 1, "Expecting nmsrs to be > 1");
> +		TEST_ASSERT(res == old_res, "Expecting nmsrs to be identical");
> +	}
> +
> +	feature_list = kvm_get_msr_feature_list(kvm_fd, old_res);
> +	TEST_ASSERT(old_res == feature_list->nmsrs,
> +				"Unmatching number of msr indexes");
> +
> +	for (i = 0; i < feature_list->nmsrs; i++)
> +		kvm_get_feature_msr(feature_list->indices[i]);
> +
> +	free(feature_list);
> +	close(kvm_fd);
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	if (kvm_check_cap(KVM_CAP_GET_MSR_FEATURES))
> +		test_get_msr_feature();
> +
> +	test_get_msr_index();
> +}
> 

