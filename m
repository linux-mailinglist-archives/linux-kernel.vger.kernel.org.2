Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1764D3B3C08
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 07:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233105AbhFYFSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 01:18:42 -0400
Received: from mta-11-4.privateemail.com ([198.54.127.104]:4826 "EHLO
        MTA-11-4.privateemail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbhFYFSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 01:18:41 -0400
X-Greylist: delayed 124202 seconds by postgrey-1.27 at vger.kernel.org; Fri, 25 Jun 2021 01:18:41 EDT
Received: from mta-11.privateemail.com (localhost [127.0.0.1])
        by mta-11.privateemail.com (Postfix) with ESMTP id 60C3680094;
        Fri, 25 Jun 2021 01:16:21 -0400 (EDT)
Received: from [192.168.0.46] (unknown [10.20.151.241])
        by mta-11.privateemail.com (Postfix) with ESMTPA id B114C8008B;
        Fri, 25 Jun 2021 01:16:20 -0400 (EDT)
Date:   Fri, 25 Jun 2021 01:16:14 -0400
From:   Hamza Mahfooz <someguy@effective-light.com>
Subject: Re: Question regarding the TODO in virt/kvm/kvm_main.c:226
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <2ZR8VQ.IJMS3PQLNFAS3@effective-light.com>
In-Reply-To: <HCVNTQ.0UPDP6HCEHBP3@effective-light.com>
References: <HCVNTQ.0UPDP6HCEHBP3@effective-light.com>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping

On Tue, May 25 2021 at 07:45:53 AM -0400, Hamza Mahfooz 
<someguy@effective-light.com> wrote:
> Would it be preferable to remove kvm_arch_vcpu_should_kick or
> kvm_request_needs_ipi when merging them. I ask since, the last time I
> checked, both functions are only used in kvm_main.c on Linus's tree.
> 


