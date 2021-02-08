Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F61931413E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 22:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234966AbhBHVG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 16:06:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35310 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236653AbhBHT54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 14:57:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612814190;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Mwlt0efdnbsq04VvTqWwNbBfoFtRj5KAfY+i7K4qdOY=;
        b=AwpAXe7fM7+PZ4JVqlsOHrdvlfgxh++a6Y45uhPRwQlm6tnP5ankh+vp/EGq6lNWcSMnqc
        SaGBP5XLFAYP7oFFXrKtp5cC5Tfu0J398s7Usm46LyLVKDzLDX7WyqO765SM6pX0SJbSeD
        F8J5i9W7juivbKRQkHcPhpi7PtDiwMc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-AXNhtgXZPPG8sy0tzkTo4A-1; Mon, 08 Feb 2021 14:56:28 -0500
X-MC-Unique: AXNhtgXZPPG8sy0tzkTo4A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E652679EC0;
        Mon,  8 Feb 2021 19:56:25 +0000 (UTC)
Received: from treble (ovpn-120-159.rdu2.redhat.com [10.10.120.159])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 449F160C04;
        Mon,  8 Feb 2021 19:56:25 +0000 (UTC)
Date:   Mon, 8 Feb 2021 13:56:18 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Ivan Babrou <ivan@cloudflare.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 2/2] x86/unwind/orc: Silence warnings caused by missing
 ORC data
Message-ID: <20210208195618.3gngafmybdircj46@treble>
References: <cover.1612534649.git.jpoimboe@redhat.com>
 <06d02c4bbb220bd31668db579278b0352538efbb.1612534649.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <06d02c4bbb220bd31668db579278b0352538efbb.1612534649.git.jpoimboe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 05, 2021 at 08:24:03AM -0600, Josh Poimboeuf wrote:
> The ORC unwinder attempts to fall back to frame pointers when ORC data
> is missing for a given instruction.  It sets state->error, but then
> tries to keep going as a best-effort type of thing.  That may result in
> further warnings if the unwinder gets lost.
> 
> Until we have some way to register generated code with the unwinder,
> missing ORC will be expected, and occasionally going off the rails will
> also be expected.  So don't warn about it.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>

Cc: stable@vger.kernel.org

-- 
Josh

