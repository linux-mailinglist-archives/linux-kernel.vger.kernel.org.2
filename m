Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCF123B82A6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 15:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234844AbhF3NIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 09:08:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:53392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234804AbhF3NIQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 09:08:16 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9BA161455;
        Wed, 30 Jun 2021 13:05:46 +0000 (UTC)
Date:   Wed, 30 Jun 2021 09:05:44 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     Colin King <colin.king@canonical.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH][next] trace: osnoise: Fix u64 less than zero comparison
Message-ID: <20210630090544.13c0a4df@oasis.local.home>
In-Reply-To: <c74e711e-71c9-df9c-8406-b9e92ef12da0@redhat.com>
References: <20210629165245.42157-1-colin.king@canonical.com>
        <c74e711e-71c9-df9c-8406-b9e92ef12da0@redhat.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jun 2021 19:19:25 +0200
Daniel Bristot de Oliveira <bristot@redhat.com> wrote:

> > Addresses-Coverity: ("Unsigned compared against 0")
> > Fixes: bce29ac9ce0b ("trace: Add osnoise tracer")
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>  
> 
> Steven, can we merge the flags?

I don't usually do that. I just take the first patch that I apply.

This isn't that complex of a patch, do we need to do this?

-- Steve
