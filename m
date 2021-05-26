Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD963916BC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 13:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233520AbhEZL4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 07:56:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48531 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232721AbhEZL4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 07:56:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622030072;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lEsIKIRHCi9DPvJFD3EoQW+cvLnGIYL/CMN7SIV9QKc=;
        b=EkyPrsXBjpK4vNao3pphMVW5Sk+kkhkLC8GYzcKPodl7v239zSTETRj6+DMjK2Ji6CUIat
        TH8+hM++D3/mxd2D/rZ9qlldfUbNqEysUiJus4kx2j9uZOHl2Sc3YhTsDIsNXJsDEUjTCM
        f7qpnlnXBOpeCLhWP/R5wql20zdLqAw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-Snd52LuSPqq8PDX0Y6cjdQ-1; Wed, 26 May 2021 07:54:30 -0400
X-MC-Unique: Snd52LuSPqq8PDX0Y6cjdQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CB6A9107ACF5;
        Wed, 26 May 2021 11:54:28 +0000 (UTC)
Received: from krava (unknown [10.40.195.164])
        by smtp.corp.redhat.com (Postfix) with SMTP id 22EB3E149;
        Wed, 26 May 2021 11:54:26 +0000 (UTC)
Date:   Wed, 26 May 2021 13:54:26 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Denys Zagorui <dzagorui@cisco.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org
Subject: Re: [PATCH v8 1/3] perf report: compile tips.txt in perf binary
Message-ID: <YK428rtY1GsVFL4E@krava>
References: <20210524111514.65713-1-dzagorui@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210524111514.65713-1-dzagorui@cisco.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2021 at 04:15:12AM -0700, Denys Zagorui wrote:
> It seems there is some need to have an ability to invoke perf from
> build directory without installation
> (84cfac7f05e1: perf tools: Set and pass DOCDIR to builtin-report.c)
> DOCDIR definition contains an absolute path to kernel source directory.
> It is build machine related info and it makes perf binary unreproducible.
> 
> This can be avoided by compiling tips.txt in perf directly.
> 
> Signed-off-by: Denys Zagorui <dzagorui@cisco.com>

for patchset

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

