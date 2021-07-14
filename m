Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6C73C938A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 00:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236353AbhGNWGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 18:06:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:43894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229498AbhGNWGh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 18:06:37 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 782F8613A9;
        Wed, 14 Jul 2021 22:03:44 +0000 (UTC)
Date:   Wed, 14 Jul 2021 18:03:37 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [GIT PULL] tracing: Add __string_len() and __assign_str_len()
 helpers
Message-ID: <20210714180337.3e78394c@oasis.local.home>
In-Reply-To: <20210714175633.3b53346a@oasis.local.home>
References: <20210713171143.7784697e@oasis.local.home>
        <CAHk-=wj5Pp5J-CAPck22RSQ13k3cEOVnJHUA-WocAZqCJK1BZw@mail.gmail.com>
        <20210714175633.3b53346a@oasis.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jul 2021 17:56:33 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> static inline notrace int trace_event_get_offsets_foo(
> 	struct trace_event_data_offsets_foo *__data_offsets, const char *foobar, int len)
> {
> 	int __data_size = 0;
> 	int __maybe_unused __item_length;
> 	struct trace_event_raw_foo __maybe_unused *entry;
> 
> // The "(len)+1" will be used to calculate the __item_length below
> 
> 	__item_length = (len + 1) * sizeof(char);
> 
> // the dynamic fields (strings and such) are located after the static
> // fields in the trace event, and the offset is recorded in the bottom
> // 16 bits of a 32 bit word, and the size in the top 16 bits.
> 
> 	__data_offsets->item = __data_size +
> 			       offsetof(typeof(*entry), __data);
> 	__data_offsets->item |= __item_length << 16;

I missed a manual substitution of the macro. This should have been:

 	__data_offsets->str = __data_size +
 			       offsetof(typeof(*entry), __data);
 	__data_offsets->str |= __item_length << 16;

As the macro creates the trace_event_data_offsets_foo structure (which
__data_offsets is declared as), which contains a field for every
__string/__string_len/__dynamic_array() in TP_STRUCT__entry.

The -">str" comes from the "str" in "__string_len(str, foobar, len)".

-- Steve


> 	__data_size += __item_length;
> 
> 
> // Each "__string_len()" or "__string()" in the TP_STRUCT__entry is inserted
> // into this macro created function. Thus, the above code is duplicated for
> // each field that uses __string(), __string_len() or __dynamic_array().
> 
> 
> 	return __data_size;
> }

