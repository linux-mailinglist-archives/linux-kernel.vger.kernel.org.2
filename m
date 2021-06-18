Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB1113AC757
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 11:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbhFRJZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 05:25:45 -0400
Received: from 8bytes.org ([81.169.241.247]:46944 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231602AbhFRJZo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 05:25:44 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 540233A7; Fri, 18 Jun 2021 11:23:34 +0200 (CEST)
Date:   Fri, 18 Jun 2021 11:23:33 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, will@kernel.org, longman@redhat.com,
        boqun.feng@gmail.com, linux-kernel@vger.kernel.org, bp@alien8.de,
        tglx@linutronix.de, bigeasy@linutronix.de
Subject: Re: [PATCH 0/3] lockdep: PROVE_RAW_LOCK_NESTING=y fixes
Message-ID: <YMxmFcJGp8uLbwga@8bytes.org>
References: <20210617185717.486456641@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210617185717.486456641@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Thu, Jun 17, 2021 at 08:57:17PM +0200, Peter Zijlstra wrote:
> Boris said, that Joerg said the locking selftests showed a few FAILED. They
> were right.

Thanks for looking into this. I tested the patches on my SEV-ES debug
kernel and can confirm that the failures in the locking selftests went
away, so

Tested-by: Joerg Roedel <jroedel@suse.de>
