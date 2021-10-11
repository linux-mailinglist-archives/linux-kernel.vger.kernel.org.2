Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EEEE428515
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 04:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233549AbhJKCXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 22:23:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:46984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233235AbhJKCXa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 22:23:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ABA6860F3A;
        Mon, 11 Oct 2021 02:21:24 +0000 (UTC)
Date:   Sun, 10 Oct 2021 22:21:22 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Carles Pey <carles.pey@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] ftrace: add unit test for removing trace
 function
Message-ID: <20211010222122.7dc1dcab@oasis.local.home>
In-Reply-To: <20210918153043.318016-2-carles.pey@gmail.com>
References: <20210918153043.318016-1-carles.pey@gmail.com>
        <20210918153043.318016-2-carles.pey@gmail.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Sep 2021 19:30:43 +0400
Carles Pey <carles.pey@gmail.com> wrote:

> A self test is provided for the trace function removal functionality.

Thanks, I added it to my queue to be tested.

-- Steve

> 
> Signed-off-by: Carles Pey <carles.pey@gmail.com>
