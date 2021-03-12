Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE2A3339633
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 19:22:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233072AbhCLSWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 13:22:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:39308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233086AbhCLSWI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 13:22:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BE96964F58;
        Fri, 12 Mar 2021 18:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1615573328;
        bh=J7Tr+mjH9dNiT5fOJvztiH8PtErXkUpo7ilRugFk/Fg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=yKSWpQNcy99iWhqp91BhfkK0OInKLDXDyCO65EJvoITm0e6a0m+e+HdscraFD8nsI
         NBPlUJACOxqW+c/3NiGsW9/Z60No4cB9yXJB0sN+VkVh0kMU+v7gLqJcOAkzHOdNSk
         d6NeqHQIHHUoNtRwNUL/0JQNZwnXfsDbMYAtQAnc=
Date:   Fri, 12 Mar 2021 10:22:07 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Jim Newsome <jnewsome@torproject.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Christian Brauner <christian@brauner.io>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] do_wait: make PIDTYPE_PID case O(1) instead of O(n)
Message-Id: <20210312102207.a347e38db375226a78cc37bf@linux-foundation.org>
In-Reply-To: <20210312173855.24843-1-jnewsome@torproject.org>
References: <20210312173855.24843-1-jnewsome@torproject.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Mar 2021 11:38:55 -0600 Jim Newsome <jnewsome@torproject.org> wrote:

> do_wait is an internal function used to implement waitpid, waitid,
> wait4, etc. To handle the general case, it does an O(n) linear scan of
> the thread group's children and tracees.
> 
> This patch adds a special-case when waiting on a pid to skip these scans
> and instead do an O(1) lookup. This improves performance when waiting on
> a pid from a thread group with many children and/or tracees.

Could we please see some performance testing results to permit us to
evaluate the value of this change?

Thanks.

