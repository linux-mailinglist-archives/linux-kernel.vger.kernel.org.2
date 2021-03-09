Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDE2A332A95
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 16:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbhCIPef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 10:34:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51678 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231761AbhCIPeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 10:34:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615304060;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+KPNW3v1CAc3wIUEUXEUEW/rLF0kxRNIq6zRhfWgqXE=;
        b=InhODXkRCjwj2iK4QjlVOAWtG6p4DoWxbqEUzQVadjzkIcBGroO6miE9rekIugzZLLEgXb
        37aZzpn36moIxI48Bk2+tOxE7SxnVJ2u3jz1ZxG+nosEvE6oy8UV8l6YvHVjqXc7jalDNv
        xGhc5UCP7xgUzcQ6rnmrWMtyBgUDRgY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369-9cvrboMHPfWV7fTjaCXVKQ-1; Tue, 09 Mar 2021 10:34:16 -0500
X-MC-Unique: 9cvrboMHPfWV7fTjaCXVKQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 354DA108BD06;
        Tue,  9 Mar 2021 15:34:15 +0000 (UTC)
Received: from treble (ovpn-119-4.rdu2.redhat.com [10.10.119.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E01885C260;
        Tue,  9 Mar 2021 15:34:13 +0000 (UTC)
Date:   Tue, 9 Mar 2021 09:34:11 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     peterz@infradead.org, nathan@kernel.org, ndesaulniers@google.com,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] objtool: Fix a memory leak bug
Message-ID: <20210309153411.sptbrjems3odd75i@treble>
References: <1615279576-100603-1-git-send-email-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1615279576-100603-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 09, 2021 at 04:46:16PM +0800, Jiapeng Chong wrote:
> Fix the following cppcheck warnings:
> 
> tools/objtool/check.c(1102): error: Memory leak: orig_alt_group.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Hi Jiapeng,

Objtool is a short-running process which exits immediately on error, so
we don't worry about memory leaks.

-- 
Josh

