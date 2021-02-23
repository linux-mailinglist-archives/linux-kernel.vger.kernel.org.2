Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 953FB3233B2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 23:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbhBWW1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 17:27:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:44056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230330AbhBWW1A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 17:27:00 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 923B364E3F;
        Tue, 23 Feb 2021 22:26:18 +0000 (UTC)
Date:   Tue, 23 Feb 2021 17:26:17 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "chenjun (AM)" <chenjun102@huawei.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gregory.herrero@oracle.com" <gregory.herrero@oracle.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "Xiangrui (Euler)" <rui.xiang@huawei.com>
Subject: Re: [PATCH] recordmcount: use w8 to read relp->r_info in
 arm64_is_fake_mcount
Message-ID: <20210223172617.1aeb8e2d@gandalf.local.home>
In-Reply-To: <CE1E7D7EFA066443B6454A6A5063B50220C5B320@dggeml509-mbx.china.huawei.com>
References: <20210222135840.56250-1-chenjun102@huawei.com>
        <CE1E7D7EFA066443B6454A6A5063B50220C5B320@dggeml509-mbx.china.huawei.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Feb 2021 15:50:19 +0000
"chenjun (AM)" <chenjun102@huawei.com> wrote:

> Hi
> 
> There is no problem when I use aarch64_be(gcc v10.2). Because gcc v10.2 use __patchable_function_entries
> instead of __mcount. I am not sure when the change happened.

But you are still saying that this patch needs to be applied, right?

-- Steve
