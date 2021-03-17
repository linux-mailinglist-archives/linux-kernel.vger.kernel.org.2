Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0980833F15A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 14:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbhCQNme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 09:42:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:40594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230434AbhCQNm2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 09:42:28 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DFD2364DFF;
        Wed, 17 Mar 2021 13:42:24 +0000 (UTC)
Date:   Wed, 17 Mar 2021 09:42:23 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     colin.king@canonical.com, guoren@kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ftrace: Fix spelling mistake "disabed" -> "disabled"
Message-ID: <20210317094223.34797d5d@gandalf.local.home>
In-Reply-To: <mhng-9cd288c7-8f95-4e86-9b2b-bb405e3f74fe@palmerdabbelt-glaptop>
References: <20210311094022.5978-1-colin.king@canonical.com>
        <mhng-9cd288c7-8f95-4e86-9b2b-bb405e3f74fe@palmerdabbelt-glaptop>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Mar 2021 21:21:08 -0700 (PDT)
Palmer Dabbelt <palmer@dabbelt.com> wrote:

> Thanks, this is on fixes.

What does this mean? Is there a tree that spelling fixes go through now?

I had already pulled this patch into my queue for the next merge window
(and it's still in the testing phase with other patches before going to
linux-next).

Should I drop it?

-- Steve
