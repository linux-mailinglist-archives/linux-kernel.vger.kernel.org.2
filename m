Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF2BC315C2A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 02:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233595AbhBJBZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 20:25:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233894AbhBIW67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 17:58:59 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF364C061794
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 14:58:15 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id t5so282858qti.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 14:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=f+Sfzn1G8buhFeqBg3rOZ1CfjEptJKUCS3yLyjW3ukw=;
        b=fXjKnajjwqEth6ETF1zmiiLoxMzax7fdB27dVNR262PGThQHBnxbxMp2UGW3t2jeCH
         miWabgHcl2q1ZWnK9uGK9EoALG8Euee/lastlI5L2KdpJXgaIX0dqzTO9OuW0rc5cx6k
         C5m5C7QQ9kc9qJRskvxfK1MN46Xvp2TVVnw2BTXt9ulo9j+Gc5ZzXBz5Oe+It8EeP8JE
         8/BrdaedgiCLsiyzN/pd/4asmxv6isVt3lEg34B0E6I+bqoVL13zXrNS8RwcNcvQQDnH
         nh6GuasHgotQuhqOcrCJMz7h5gyUoQluE6z2fn31ffj646DsMg1Ngnerf4JFEPNNtyRM
         ujgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=f+Sfzn1G8buhFeqBg3rOZ1CfjEptJKUCS3yLyjW3ukw=;
        b=tNgHgGc+JMKQOR+lnXsmlDtlOK8G/5mDlp/PKtXC49UDC/8Rl6t8W4jkIbnF4rmtVe
         H7CKZoShXr1p2a2ZHl8hFUgeSz2gW+PwwTRHr9hs1hecFlND3NRvlDsC/6lkn1q26Q4e
         vhGCzVoexabPcdTEJzIcPG08hL1ncrD6vttAADMWVK0g9bDMQKFb3P1NCUMB4jFJxxh1
         9olJ31n6X0lWmM+ohetdv73wT8RDkBHW4oTTdVc2jqB/ObvTTYBr3u3oUE2mazZ0vVao
         quXd1iinK6WXr+hZphFiUxX0b4VrYLwSUfVLj0hEhn43jdbgvzZsDTOhABkF2OsOIeyG
         1f2A==
X-Gm-Message-State: AOAM531yc44nR8iX+mjH6otWfjFJFiBU4IZyw5fXQzWbh/io0NKbTHJs
        h/bVrgf8i5jFXkhaEM4OfIil7v2gCVn85A==
X-Google-Smtp-Source: ABdhPJwVyVK2Hl7yFH//muAVUIkgbpJI5i2isxVp7CWbCELE91YgCxgjZ6Rx+Ko4UqOEcwLTPJzkL/RFmhbwPg==
Sender: "jmattson via sendgmr" <jmattson@turtle.sea.corp.google.com>
X-Received: from turtle.sea.corp.google.com ([2620:15c:100:202:9942:27af:a628:1d1b])
 (user=jmattson job=sendgmr) by 2002:a0c:b59f:: with SMTP id
 g31mr446987qve.28.1612911494938; Tue, 09 Feb 2021 14:58:14 -0800 (PST)
Date:   Tue,  9 Feb 2021 14:56:53 -0800
Message-Id: <20210209225653.1393771-1-jmattson@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: Trouble with perf_guest_get_msrs() and pebs_no_isolation
From:   Jim Mattson <jmattson@google.com>
To:     Peter Shier <pshier@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>, Joerg Roedel <joro@8bytes.org>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sean Christopherson <seanjc@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>, x86@kernel.org
Cc:     Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On a host that suffers from pebs_no_isolation, perf_guest_get_msrs()
adds an entry to cpuc->guest_switch_msrs for
MSR_IA32_PEBS_ENABLE. Kvm's atomic_switch_perf_msrs() is the only
caller of perf_guest_get_msrs(). If atomic_switch_perf_msrs() finds an
entry for MSR_IA32_PEBS_ENABLE in cpuc->guest_switch_msrs, it puts the
"host" value of this entry on the VM-exit MSR-load list for the
current VMCS. At the next VM-exit, that "host" value will be written
to MSR_IA32_PEBS_ENABLE.

The problem is that by the next VM-exit, that "host" value may be
stale. Though maskable interrupts are blocked from well before
atomic_switch_perf_msrs() to the next VM-entry, PMIs are delivered as
NMIs. Moreover, due to PMI throttling, the PMI handler may clear bits
in MSR_IA32_PEBS_ENABLE. See the comment to that effect in
handle_pmi_common(). In fact, by the time that perf_guest_get_msrs()
returns to its caller, the "host" value that it has recorded for
MSR_IA32_PEBS_ENABLE could already be stale.

What happens if a VM-exit sets a bit in MSR_IA32_PEBS_ENABLE that the
perf subsystem thinks should be clear? In the short term, nothing
happens at all. But note that this situation may not get better at the
next VM-exit, because kvm won't add MSR_IA32_PEBS_ENABLE to the
VM-exit MSR-load list if perf_guest_get_mrs() reports that the "host"
value of the MSR is 0. So, if the new MSR_IA32_PEBS_ENABLE "host"
value is 0, the stale bits can actually persist for a long time.

If, at some point in the future, the perf subsystem programs a counter
overflow interrupt on the same PMC for a PEBS-capable event, we are in
for some nasty surprises. (Note that the perf subsystem never
*intentionally* programs a PMC for both PEBS and counter overflow
interrupts at the same time.)

If a PEBS assist is triggered while in VMX non-root operation, the CPU
will try to access the host's DS_AREA using the guest's page tables,
and a page fault is likely (specifically on a read of the PEBS
interrupt threshold at offset 0x38 in the DS_AREA).

If the PEBS interrupt threshold is met while in VMX root operation,
two separate PMIs are generated: one for the PEBS interrupt threshold
and one for the counter overflow. This results in a message from
unknown_nmi_error(): "Uhhuh. NMI received for unknown reason <xx> on
CPU <n>."
