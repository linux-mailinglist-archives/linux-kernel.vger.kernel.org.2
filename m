Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8ED32534F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 17:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233404AbhBYQOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 11:14:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:54468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232723AbhBYQJP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 11:09:15 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7463B64ED3;
        Thu, 25 Feb 2021 16:08:32 +0000 (UTC)
Date:   Thu, 25 Feb 2021 11:08:30 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Will Deacon <will@kernel.org>
Cc:     Li Huafei <lihuafei1@huawei.com>, gregory.herrero@oracle.com,
        catalin.marinas@arm.com, christophe.leroy@csgroup.eu,
        linux-kernel@vger.kernel.org, zhangjinhao2@huawei.com,
        yangjihong1@huawei.com, xukuohai@huawei.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] recordmcount: Fix the wrong use of w* in
 arm64_is_fake_mcount()
Message-ID: <20210225110830.3656572d@gandalf.local.home>
In-Reply-To: <20210225160116.GA13604@willie-the-truck>
References: <20210225140747.10818-1-lihuafei1@huawei.com>
        <20210225094426.7729b9cc@gandalf.local.home>
        <20210225160116.GA13604@willie-the-truck>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Feb 2021 16:01:17 +0000
Will Deacon <will@kernel.org> wrote:

> Acked-by: Will Deacon <will@kernel.org>

Thanks!

> 
> But you know you could avoid these sorts of problems by moving to little
> endian along with everybody else? ;)

But then how do we find these bug?

-- Steve
