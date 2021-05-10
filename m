Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19412377AD4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 05:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbhEJD77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 May 2021 23:59:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:45762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230029AbhEJD76 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 May 2021 23:59:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1BB6D6138C;
        Mon, 10 May 2021 03:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1620619134;
        bh=/w0NtbqYwqN7K08COz9EKLZ5k+fG+jGh0uGGYhBOoGc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ih2TGI4dRSkbM0iIaLGqTPsT4a5wSCCY0PFuMCjMcMYYvJtIZkCIy0x384fZF8kn/
         f4iiVg2T5Rko7/9yEvALnSVRCoHWao10sfGixWutB/PvFJ/xVDXnfADZFuNjpGq5up
         zSbZ4XUY784ko3EgCvOPh9LTGkxJ6cQU20Q6MyWc=
Date:   Sun, 9 May 2021 20:58:53 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     brookxu <brookxu.cn@gmail.com>
Cc:     adobriyan@gmail.com, bsingharora@gmail.com, ebiederm@xmission.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] delayacct: add a proc file to dump the delay
 info
Message-Id: <20210509205853.42a3a06f9c5b70b52bdf8509@linux-foundation.org>
In-Reply-To: <3da76d1d565c423c6cbf92b02cbae9f86cd5accd.1618841970.git.brookxu@tencent.com>
References: <8ac9f35074326cb36e3cdbf0ad70b36dc3412e86.1618841970.git.brookxu@tencent.com>
        <3da76d1d565c423c6cbf92b02cbae9f86cd5accd.1618841970.git.brookxu@tencent.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Apr 2021 22:37:07 +0800 brookxu <brookxu.cn@gmail.com> wrote:

> Many distributions do not install the getdelay tool by
> default, similar to task_io_accounting, adding a proc
> file to make access easier.

Well, we developed and maintain getdelays.c for a reason.  Why should
we add (and maintain) kernel code because some people are too
lame to install the tool we provided?
