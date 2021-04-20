Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D23B365F11
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 20:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233495AbhDTSOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 14:14:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47144 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232879AbhDTSOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 14:14:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618942459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xVywtcdWzkrND0c18LWsccBuX85KB1TX7A+WSDqF8ww=;
        b=HrpX1btowMTUM/VG8Mcff+2Y34Nq9ipIdTt0Vpw9sNFHghTvvYq7oLHyWh8QizOHCGLeF3
        4Fxmw/ZaO68uEP2PhE+SZBX0flwH+eQi5ZNPKTljpc/nZcEuF/rDLpKIebRcc/A4azEH3l
        4SdchM8djo0rt+ctZxRneGxsaQ7cYos=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-gZ-L1CbPNe6IEJoEIVvKAg-1; Tue, 20 Apr 2021 14:14:17 -0400
X-MC-Unique: gZ-L1CbPNe6IEJoEIVvKAg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 989E9802B56;
        Tue, 20 Apr 2021 18:14:15 +0000 (UTC)
Received: from treble (ovpn-115-229.rdu2.redhat.com [10.10.115.229])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6B9C560C5F;
        Tue, 20 Apr 2021 18:14:14 +0000 (UTC)
Date:   Tue, 20 Apr 2021 13:14:12 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     x86@kernel.org, Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH 01/15] objtool: Find a destination for jumps beyond the
 section end
Message-ID: <20210420181412.3g5dsyhggxnvif7k@treble>
References: <20210416203844.3803177-1-samitolvanen@google.com>
 <20210416203844.3803177-2-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210416203844.3803177-2-samitolvanen@google.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2021 at 01:38:30PM -0700, Sami Tolvanen wrote:
> With -ffunction-sections, Clang can generate a jump beyond the end of
> a section when the section ends in an unreachable instruction.

Why?  Can you show an example?

-- 
Josh

