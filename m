Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6FC530FFE2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 23:07:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbhBDWHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 17:07:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:54356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229981AbhBDWGv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 17:06:51 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BB2464E4A;
        Thu,  4 Feb 2021 22:06:09 +0000 (UTC)
Date:   Thu, 4 Feb 2021 17:06:07 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Timur Tabi <timur@kernel.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        willy@infradead.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, roman.fietze@magna.com,
        keescook@chromium.org, john.ogness@linutronix.de,
        akinobu.mita@gmail.com
Subject: Re: [PATCH] lib/vsprintf: make-printk-non-secret printks all
 addresses as unhashed
Message-ID: <20210204170607.175fe23d@gandalf.local.home>
In-Reply-To: <873d7e08-7a70-a1a3-f486-882d1d515965@kernel.org>
References: <20210202201846.716915-1-timur@kernel.org>
        <20210204204835.GA7529@amd>
        <20210204155423.2864bf4f@gandalf.local.home>
        <20210204214944.GA13103@amd>
        <873d7e08-7a70-a1a3-f486-882d1d515965@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Feb 2021 15:59:21 -0600
Timur Tabi <timur@kernel.org> wrote:

> I think the reason behind the large banner has less to do how insecure 
> the system is, and more about making sure vendors and sysadmins don't 
> enable it by default everywhere.

+100

-- Steve
