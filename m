Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9160539003E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 13:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbhEYLrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 07:47:32 -0400
Received: from mta-10-1.privateemail.com ([68.65.122.30]:21635 "EHLO
        MTA-10-1.privateemail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231770AbhEYLra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 07:47:30 -0400
Received: from MTA-10.privateemail.com (localhost [127.0.0.1])
        by MTA-10.privateemail.com (Postfix) with ESMTP id 93B506011B;
        Tue, 25 May 2021 07:46:00 -0400 (EDT)
Received: from [192.168.0.46] (unknown [10.20.151.222])
        by MTA-10.privateemail.com (Postfix) with ESMTPA id D12066011A;
        Tue, 25 May 2021 07:45:59 -0400 (EDT)
Date:   Tue, 25 May 2021 07:45:53 -0400
From:   Hamza Mahfooz <someguy@effective-light.com>
Subject: Question regarding the TODO in virt/kvm/kvm_main.c:226
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <HCVNTQ.0UPDP6HCEHBP3@effective-light.com>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Would it be preferable to remove kvm_arch_vcpu_should_kick or
kvm_request_needs_ipi when merging them. I ask since, the last time I
checked, both functions are only used in kvm_main.c on Linus's tree.


