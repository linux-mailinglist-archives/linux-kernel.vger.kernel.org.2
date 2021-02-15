Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18CC631BBFE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 16:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbhBOPMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 10:12:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:37374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230306AbhBOPBo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 10:01:44 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5095E64EA8;
        Mon, 15 Feb 2021 14:59:15 +0000 (UTC)
Date:   Mon, 15 Feb 2021 09:59:13 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     <Viktor.Rosendahl@bmw.de>
Cc:     <mingo@redhat.com>, <joel@joelfernandes.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Add the latency-collector to tools
Message-ID: <20210215095913.40bbfb99@gandalf.local.home>
In-Reply-To: <d68f3fca6e72e090b56d7097884ac1a3f50f4a18.camel@bmw.de>
References: <20210126142652.41b961f2@gandalf.local.home>
        <20210211161742.25386-1-Viktor.Rosendahl@bmw.de>
        <20210211145648.1e1e1325@gandalf.local.home>
        <d2a434e4dfa012dcfdf6525f26ffaa04671fcab9.camel@bmw.de>
        <d68f3fca6e72e090b56d7097884ac1a3f50f4a18.camel@bmw.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Feb 2021 11:54:08 +0000
<Viktor.Rosendahl@bmw.de> wrote:

> Just a quick update: I was able to reproduce this weird behavior that I wrote
> about but it turned out to be a problem with my testing.
> 
> The test was faulty because of a mistake that I had made.
> 
> Sorry for the extra noise.

No problem. Thanks for letting me know.

-- Steve
