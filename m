Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACC4F3653D2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 10:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbhDTIPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 04:15:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40536 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230201AbhDTIPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 04:15:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618906482;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KV7dmFGzJ9Zbd3oVTLLc6xUZJD2xaL8s1NYktGrSB24=;
        b=fU2pGjj2vyVfHFcXYzuiI2eFlQ2fGPdxrLjhjNDKqDrha3sMmAoYFoeLebiQ2VxdUfjApR
        0/0JEAw+2sYEE3zjNAUPenLIdxYrhbxjU6MinoGptY4ZyFlBugLZfSAhN/PsCSbTWG4cEg
        Ue80Ag5wYaVG0D9TrQT/5wZm7lgOs8U=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-525-WKqfrTJoP-anHRb3iOKkUg-1; Tue, 20 Apr 2021 04:14:35 -0400
X-MC-Unique: WKqfrTJoP-anHRb3iOKkUg-1
Received: by mail-ej1-f71.google.com with SMTP id j25-20020a1709060519b029037cb8ca241aso4467372eja.19
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 01:14:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KV7dmFGzJ9Zbd3oVTLLc6xUZJD2xaL8s1NYktGrSB24=;
        b=ZvyY3wqIn3S6b9UNG6S41NjjjAOjIlkQSWHHvVPONBycUiMhmyppEXd0PzmHYDlrL+
         kbJPxgl+Tx7skcfBbxDF/jFrZAxaA2nvB/XrsrBUUACpxP8cedGPmaYfyA0OF2NkBgfr
         IQS+xImDjZBSlc+t0lcnY3AdOHgMlCSKHnJC4SVrjb4teluLBdcooA3Gnik7FF0GZ7Ee
         4+njd2bbSoQEhXZsD0u2VsvfaKOMgZHSOhAQvQAtUwMaWPyOOW6WeOkXrNcYoQr88TAC
         dlLysGKHNhbL8gIGfs6peZWmzeA/roC+yjl5lPpBCD0RB6gg+OuY43rGxUs7ihF60sc1
         Ld6g==
X-Gm-Message-State: AOAM531yGKkJjBiUqJ7Wciu7J0U7R21gdFIZ0fJtO5I04SaJcR9M92J8
        NpOjYmL6Heg4uZPQmMD01b1sFBTGanWOWuEVRT4g9RvFtTOmE3hkPvlx3wi7RuNBPLXwblc01HC
        nLK6xvMxYCDe3LDWKU/YBqPAB
X-Received: by 2002:a17:906:cc46:: with SMTP id mm6mr26886837ejb.138.1618906474616;
        Tue, 20 Apr 2021 01:14:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxpPEvnbrPRPj33zVTbsposR+idCfDNOhL0ex/+4AT2yKt35m84lN5qHgNaytwrjmAsayKPCQ==
X-Received: by 2002:a17:906:cc46:: with SMTP id mm6mr26886811ejb.138.1618906474397;
        Tue, 20 Apr 2021 01:14:34 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id k19sm11468335ejk.117.2021.04.20.01.14.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Apr 2021 01:14:33 -0700 (PDT)
Subject: Re: [PATCH v3 2/2] KVM: selftests: Wait for vcpu thread before signal
 setup
To:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Andrew Jones <drjones@redhat.com>,
        Sean Christopherson <seanjc@google.com>
References: <20210417143602.215059-1-peterx@redhat.com>
 <20210417143602.215059-3-peterx@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <372e505d-7d1d-2614-fe30-55be9ac2bf49@redhat.com>
Date:   Tue, 20 Apr 2021 10:14:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210417143602.215059-3-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/04/21 16:36, Peter Xu wrote:
> The main thread could start to send SIG_IPI at any time, even before signal
> blocked on vcpu thread.  Reuse the sem_vcpu_stop to sync on that, so when
> SIG_IPI is sent the signal will always land correctly as an -EINTR.
> 
> Without this patch, on very busy cores the dirty_log_test could fail directly
> on receiving a SIG_USR1 without a handler (when vcpu runs far slower than main).
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>

This should be a better way to do the same:

----------- 8< ------------
From: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH] KVM: selftests: Wait for vcpu thread before signal setup

The main thread could start to send SIG_IPI at any time, even before signal
blocked on vcpu thread.  Therefore, start the vcpu thread with the signal
blocked.

Without this patch, on very busy cores the dirty_log_test could fail directly
on receiving a SIGUSR1 without a handler (when vcpu runs far slower than main).

Reported-by: Peter Xu <peterx@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
index ffa4e2791926..048973d50a45 100644
--- a/tools/testing/selftests/kvm/dirty_log_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_test.c
@@ -527,9 +527,8 @@ static void *vcpu_worker(void *data)
  	 */
  	sigmask->len = 8;
  	pthread_sigmask(0, NULL, sigset);
+	sigdelset(sigset, SIG_IPI);
  	vcpu_ioctl(vm, VCPU_ID, KVM_SET_SIGNAL_MASK, sigmask);
-	sigaddset(sigset, SIG_IPI);
-	pthread_sigmask(SIG_BLOCK, sigset, NULL);
  
  	sigemptyset(sigset);
  	sigaddset(sigset, SIG_IPI);
@@ -858,6 +857,7 @@ int main(int argc, char *argv[])
  		.interval = TEST_HOST_LOOP_INTERVAL,
  	};
  	int opt, i;
+	sigset_t sigset;
  
  	sem_init(&sem_vcpu_stop, 0, 0);
  	sem_init(&sem_vcpu_cont, 0, 0);
@@ -916,6 +916,11 @@ int main(int argc, char *argv[])
  
  	srandom(time(0));
  
+	/* Ensure that vCPU threads start with SIG_IPI blocked.  */
+	sigemptyset(&sigset);
+	sigaddset(&sigset, SIG_IPI);
+	pthread_sigmask(SIG_BLOCK, sigset, NULL);
+
  	if (host_log_mode_option == LOG_MODE_ALL) {
  		/* Run each log mode */
  		for (i = 0; i < LOG_MODE_NUM; i++) {


> ---
>   tools/testing/selftests/kvm/dirty_log_test.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
> index 510884f0eab8..25230e799bc4 100644
> --- a/tools/testing/selftests/kvm/dirty_log_test.c
> +++ b/tools/testing/selftests/kvm/dirty_log_test.c
> @@ -534,6 +534,12 @@ static void *vcpu_worker(void *data)
>   	sigemptyset(sigset);
>   	sigaddset(sigset, SIG_IPI);
>   
> +	/*
> +	 * Tell the main thread that signals are setup already; let's borrow
> +	 * sem_vcpu_stop even if it's not for it.
> +	 */
> +	sem_post(&sem_vcpu_stop);
> +
>   	guest_array = addr_gva2hva(vm, (vm_vaddr_t)random_array);
>   
>   	while (!READ_ONCE(host_quit)) {
> @@ -785,6 +791,8 @@ static void run_test(enum vm_guest_mode mode, void *arg)
>   
>   	pthread_create(&vcpu_thread, NULL, vcpu_worker, vm);
>   
> +	sem_wait_until(&sem_vcpu_stop);
> +
>   	while (iteration < p->iterations) {
>   		/* Give the vcpu thread some time to dirty some pages */
>   		usleep(p->interval * 1000);
> 

