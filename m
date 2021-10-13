Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83A1C42C0E3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 15:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233900AbhJMNFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 09:05:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:57020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231516AbhJMNFj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 09:05:39 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9268F610CB;
        Wed, 13 Oct 2021 13:03:35 +0000 (UTC)
Date:   Wed, 13 Oct 2021 09:03:33 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Andrew Halaney <ahalaney@redhat.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>, akpm@linux-foundation.org,
        bp@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] init: Make unknown command line param message clearer
Message-ID: <20211013090333.19d55216@gandalf.local.home>
In-Reply-To: <20211013125638.4nc4bnbzbeixfrii@halaneylaptop>
References: <20211012213523.39801-1-ahalaney@redhat.com>
        <20211012200106.1afdbb0b@gandalf.local.home>
        <87853d4f-d6f8-1d58-1a07-c8232dae87fd@infradead.org>
        <20211013125638.4nc4bnbzbeixfrii@halaneylaptop>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Oct 2021 07:56:38 -0500
Andrew Halaney <ahalaney@redhat.com> wrote:

> I'll spin a v2 with that considering everyone likes that form more.

Right, because we don't need a novel in the kernel to be printed ;-)

Just enough info that makes sense, and have comments or documentation
elsewhere that can explain more details.

-- Steve
