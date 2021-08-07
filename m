Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DBDE3E33B6
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 08:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbhHGGPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 02:15:09 -0400
Received: from shark3.inbox.lv ([194.152.32.83]:47138 "EHLO shark3.inbox.lv"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229495AbhHGGPI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 02:15:08 -0400
Received: from shark3.inbox.lv (localhost [127.0.0.1])
        by shark3-out.inbox.lv (Postfix) with ESMTP id 4860C2800E0;
        Sat,  7 Aug 2021 09:14:50 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.lv; s=30062014;
        t=1628316890; bh=Ptap/6l1yZ7EnO/jIDCw2RESpsUNpoGTIwGUz06W0Gc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=AQZNnGoAhYTSW2QNsWn0dhCY5G07WVDq7EPHtiwwi0KpvM5yo+c5zQd/8nQk/yLd4
         g1hhkUqltPaNIXvVnlbB41RmZhQq+U1o+iZ0yVv9OCBbS/VcRMmWZxhzSA+sCuG9hr
         q5BwtI1NSCIJ49AJ/e79rzXxPHliPRx8T5G6oJj0=
Received: from localhost (localhost [127.0.0.1])
        by shark3-in.inbox.lv (Postfix) with ESMTP id 424A12800F5;
        Sat,  7 Aug 2021 09:14:50 +0300 (EEST)
Received: from shark3.inbox.lv ([127.0.0.1])
        by localhost (shark3.inbox.lv [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id 7kLTAMNmrYQB; Sat,  7 Aug 2021 09:14:50 +0300 (EEST)
Received: from mail.inbox.lv (pop1 [127.0.0.1])
        by shark3-in.inbox.lv (Postfix) with ESMTP id 0F0412800E0;
        Sat,  7 Aug 2021 09:14:50 +0300 (EEST)
Received: from mail.inbox.lv (unknown [79.105.9.99])
        (Authenticated sender: hakavlad@inbox.lv)
        by mail.inbox.lv (Postfix) with ESMTPA id A4E043E6019B;
        Sat,  7 Aug 2021 09:14:47 +0300 (EEST)
Date:   Sat, 7 Aug 2021 15:14:24 +0900
From:   Alexey Avramov <hakavlad@inbox.lv>
To:     Nico Pache <npache@redhat.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, hannes@cmpxchg.org,
        aquini@redhat.com, shakeelb@google.com, llong@redhat.com
Subject: Re: [PATCH v2] vm_swappiness=0 should still try to avoid swapping
 anon memory
Message-ID: <20210807151424.76b4ee3a@mail.inbox.lv>
In-Reply-To: <20210807022129.8842-1-npache@redhat.com>
References: <20210807022129.8842-1-npache@redhat.com>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: OK
X-ESPOL: EZeEAiZdhRsytcG4Kodl4OvixdOvJSku30Lmt9097ntHt7PErddreWaJeffiER4=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>vm_swappiness=0 should still try to avoid swapping anon memory

Swapping with swappiness=0 depends on vm.watermark_scale_factor.
Decrease vm.watermark_scale_factor to avoid swapping and get OOM,
and increase vm.watermark_scale_factor to get successful swapping 
even with swappiness=0.

Maybe I misunderstood you and you are solving some new problem? 
