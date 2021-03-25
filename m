Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDCBA349BCA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 22:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbhCYVmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 17:42:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:57800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230325AbhCYVmL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 17:42:11 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5359061A25;
        Thu, 25 Mar 2021 21:42:10 +0000 (UTC)
Date:   Thu, 25 Mar 2021 17:42:08 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Devel <linux-trace-devel@vger.kernel.org>,
        "linux-trace-users@vger.kernel.org" 
        <linux-trace-users@vger.kernel.org>
Subject: [ANNOUNCE] KernelShark 1.3
Message-ID: <20210325174208.6db1d1aa@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm happy to announce KernelShark Version 1.3

*** NOTICE ***

KernelShark is now in its own repository (and will depend on libtracecmd).
This is the last version that will home KernelShark in the trace-cmd.git
repo.

New development of KernelShark now lives here:

  https://git.kernel.org/pub/scm/utils/trace-cmd/kernel-shark.git/

After this release, "make gui" will no longer build KernelShark in the
trace-cmd.git repo.

*** END NOTICES ***

Updates since Version 1.2:

 - Use mouse wheel to scroll the graphs.
   The old behavior to zoom in and out is "ctrl+scroll"

More information will be at https://www.kernelshark.org

-- Steve
