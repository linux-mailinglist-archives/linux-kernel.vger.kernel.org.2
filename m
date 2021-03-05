Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 263E132ED03
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 15:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbhCEOVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 09:21:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:33498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230415AbhCEOVj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 09:21:39 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D2A66509B;
        Fri,  5 Mar 2021 14:21:38 +0000 (UTC)
Date:   Fri, 5 Mar 2021 09:21:36 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     <Viktor.Rosendahl@bmw.de>
Cc:     <vulab@iscas.ac.cn>, <linux-kernel@vger.kernel.org>,
        <colin.king@canonical.com>
Subject: Re: [PATCH] tracing/tools: Remove unneeded semicolon
Message-ID: <20210305092136.7f6a33d1@gandalf.local.home>
In-Reply-To: <480322830b8aa400f4293e635184a31d392e4dad.camel@bmw.de>
References: <20210305094005.1724-1-vulab@iscas.ac.cn>
        <480322830b8aa400f4293e635184a31d392e4dad.camel@bmw.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Mar 2021 10:42:08 +0000
<Viktor.Rosendahl@bmw.de> wrote:

> Looks good but I would suggest to fix also the other instances of superfluous
> semicolons with the same patch.
> 
> There seems to be a lonely semicolon on line 1944, i.e this code:
> 
> 			if (value < 0) {
> 				warnx("TIME must be >= 0\n");
> 				show_usage();
> 				;
> 			}
> 
> In that case the lonely semicolon should be replaced with "exit(0);"

Agreed. I'll wait for v2 of the patch.

Thanks,

-- Steve
