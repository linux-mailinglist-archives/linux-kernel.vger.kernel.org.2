Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88D7C42557B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 16:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242099AbhJGOdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 10:33:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38137 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242066AbhJGOdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 10:33:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633617113;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2Ne/ymk4Q7iDTXHBvug37fNABdO4OvzkbsGDyNPNSVw=;
        b=bCkuw1vG4yBBtxv0IhDhB4nNOciHwzcN4IkMcZwH5Vv0QhdqBb9sReRWri3oWKb6+VqCCH
        CpBWT/DHQy6vH/OgeSBQYi3t/itRhMHbicPXmk6qUWhO8KZSWn4+nED2OlZzrQbvGwAz1e
        xzfWViSFFqOl1ypp0G3iPgSWpyhruNM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-124-tDoKpp68Nqya6BvUiGVMEw-1; Thu, 07 Oct 2021 10:31:49 -0400
X-MC-Unique: tDoKpp68Nqya6BvUiGVMEw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E340291165;
        Thu,  7 Oct 2021 14:31:48 +0000 (UTC)
Received: from [10.22.32.238] (unknown [10.22.32.238])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 93A545C1A3;
        Thu,  7 Oct 2021 14:31:48 +0000 (UTC)
Message-ID: <7177cfa8-260a-6e5c-06a5-1683bcf21679@redhat.com>
Date:   Thu, 7 Oct 2021 10:31:48 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: Reason for unused flags argument in trace_raw_output_* function?
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mingo@redhat.com, LKML <linux-kernel@vger.kernel.org>
References: <4988d521-472f-a50e-4686-52afde08d2e9@redhat.com>
 <20211007092026.644d25de@gandalf.local.home>
From:   William Cohen <wcohen@redhat.com>
In-Reply-To: <20211007092026.644d25de@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/7/21 09:20, Steven Rostedt wrote:
> On Wed, 6 Oct 2021 23:49:22 -0400
> William Cohen <wcohen@redhat.com> wrote:
> 
>> Hi,
>>
>> I have some code that analyzes x86_64 binaries
>> (https://developers.redhat.com/articles/2021/08/09/debugging-function-parameters-
>> dyninst#liveness_analysis) and list which function parameters are unused.
>>  I noticed that trace_raw_output_* functions have an unused flags
>> argument.  I assume this is is to make the argument list match up with
>> some other function, but I couldn't see which function(s) the
>> trace_raw_output_* functions are trying to match up with.  Which
>> functions are the trace_raw_output_* function's arguments trying to match?
>>
> 
> The match of other printing functions is in kernel/trace/trace_output.c
> 
> And is called from kernel/trace/trace.c where one place it does pass in
> flags:
> 
> 
> static enum print_line_t print_trace_fmt(struct trace_iterator *iter)
> {
> 	[..]
> 	if (event)
> 		return event->funcs->trace(iter, sym_flags, event);


Hi Steve,

Thanks for pointing to where the trace_raw_output_* functions are called from.

> 
> Now if they are still used, is something we should investigate.

For the trace_raw_output_* functions the flags arg all seems to be unused.  Are there other trace functions should examining for unused args?  With the extensive macro use I could see where some vestigial unused argument gets left behind.

> 
> This code has changed a lot over the years when that "flags" parameter was
> introduced. It could now just be a relic from the old implementations.
> 
> Thanks for pointing this out. If I get time I'll look deeper into it, but
> feel free to look at it yourself.
> 
> -- Steve
> 

Thanks again,

-Will

