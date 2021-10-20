Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAABD434566
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 08:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbhJTGte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 02:49:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22172 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229809AbhJTGtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 02:49:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634712439;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zpOHrowC14jNMXm04zF+C/7tsopB9ZkqTu0bv9M163E=;
        b=Xy4FpKVMmx6c6h838qQJMk82QXuaq7XeylrxQkl8QwO9V6D+ilqSglNc+nEMRhcy1Ir1Ru
        FAmrs0A3b+bo6bvi2I9yU8QzqcL8yyi4WEoHKAVHWtXaqGi+PdcJzoOGNT1vI+cFij+ipF
        6n49u728Fe775U1hXUBC4SrnAK+BWCs=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-IIb_uuQ3Ma6nMzmQmONhCw-1; Wed, 20 Oct 2021 02:47:18 -0400
X-MC-Unique: IIb_uuQ3Ma6nMzmQmONhCw-1
Received: by mail-ed1-f71.google.com with SMTP id p20-20020a50cd94000000b003db23619472so20051956edi.19
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 23:47:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zpOHrowC14jNMXm04zF+C/7tsopB9ZkqTu0bv9M163E=;
        b=8HwvUhsCcL3oX8KlRUomSw80KM5b4YUAjIPXjhqXAPx9UkXQ5yqsx6+YUCSmvFkaT/
         kAdSrxmitT+GS+/BkSh4vEqEy8ZSpi27iHKNbhMjhC7vZJTn+hDQNNboW47DAIszDHT1
         zeCeNpIRNQNNkY1v0tlhEzKTQoFd87RFuzcl/RntJP0hYG8+5E7tum+F3RLFN10JIq7f
         fAbq4BgiUKHjinASUxSAJFf+4Xtid2Oj751Xulnu9ed9P8JteosPE6rTDHmA4HxIUDyi
         xHXQscsHif/P+nT0qUxe+/7tsNxh4uSsjJysLkOf7QKTMljQhHxrlN5Z1o9Rnsa+Me9C
         dinQ==
X-Gm-Message-State: AOAM530cGo3D6bSDKRN4WHCJqDGT0TUS0fSl+NgNJn0AIZwU0cjczpZJ
        UR19HGx+WXPB39sXuWuROzcELjiaY2p//VIwy6dqO2c9rBVVvIRsj4V5yHphgrxjcWfyeptM0+i
        vREhhAwZYYRWfCrR6Fs9WJQ07
X-Received: by 2002:a17:907:9694:: with SMTP id hd20mr44089853ejc.550.1634712436927;
        Tue, 19 Oct 2021 23:47:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyy550E6eJ5oKImP0zF38zEk2QLC1XfY1OC8z/GQUXOlKzB6Aj88nUGOpCXToiit1gxihyeyg==
X-Received: by 2002:a17:907:9694:: with SMTP id hd20mr44089826ejc.550.1634712436703;
        Tue, 19 Oct 2021 23:47:16 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.gmail.com with ESMTPSA id o3sm518528ejg.52.2021.10.19.23.47.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Oct 2021 23:47:16 -0700 (PDT)
Message-ID: <45fabf5a-96b5-49dc-0cba-55714ae3a4b5@redhat.com>
Date:   Wed, 20 Oct 2021 08:47:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH v3 3/3] KVM: vCPU kick tax cut for running vCPU
Content-Language: en-US
To:     Wanpeng Li <kernellwp@gmail.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
References: <1634631160-67276-1-git-send-email-wanpengli@tencent.com>
 <1634631160-67276-3-git-send-email-wanpengli@tencent.com>
 <24e67e43-c50c-7e0f-305a-c7f6129f8d70@redhat.com>
 <YW8BmRJHVvFscWTo@google.com>
 <CANRm+CzuWnO8FZPTvvOtpxqc5h786o7THyebOFpVAp3BF1xQiw@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <CANRm+CzuWnO8FZPTvvOtpxqc5h786o7THyebOFpVAp3BF1xQiw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/10/21 04:49, Wanpeng Li wrote:
>> The intent of the extra check was to avoid the locked instruction that comes with
>> disabling preemption via rcu_read_lock().  But thinking more, the extra op should
>> be little more than a basic arithmetic operation in the grand scheme on modern x86
>> since the cache line is going to be locked and written no matter what, either
>> immediately before or immediately after.
>
> I observe the main overhead of rcuwait_wake_up() is from rcu
> operations, especially rcu_read_lock/unlock().

Do you have CONFIG_PREEMPT_RCU set?  If so, maybe something like this would help:

diff --git a/kernel/exit.c b/kernel/exit.c
index fd1c04193e18..ca1e60a1234d 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -235,8 +235,6 @@ int rcuwait_wake_up(struct rcuwait *w)
  	int ret = 0;
  	struct task_struct *task;
  
-	rcu_read_lock();
-
  	/*
  	 * Order condition vs @task, such that everything prior to the load
  	 * of @task is visible. This is the condition as to why the user called
@@ -250,6 +248,14 @@ int rcuwait_wake_up(struct rcuwait *w)
  	 */
  	smp_mb(); /* (B) */
  
+#ifdef CONFIG_PREEMPT_RCU
+	/* The cost of rcu_read_lock() is nontrivial for preemptable RCU.  */
+	if (!rcuwait_active(w))
+		return ret;
+#endif
+
+	rcu_read_lock();
+
  	task = rcu_dereference(w->task);
  	if (task)
  		ret = wake_up_process(task);

(If you don't, rcu_read_lock is essentially preempt_disable() and it
should not have a large overhead).  You still need the memory barrier
though, in order to avoid missed wakeups; shameless plug for my
article at https://lwn.net/Articles/847481/.

Paolo

>> So with Paolo's other comment, maybe just this?  And if this doesn't provide the
>> desired performance boost, changes to the rcuwait behavior should go in separate
>> patch.
> Ok.

