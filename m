Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09F1B375F49
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 06:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbhEGEGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 00:06:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41771 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229671AbhEGEGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 00:06:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620360309;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SM2Z2RJmf/HvwWoGqGzjgfGTsjHITFB7ckefQrdnYRA=;
        b=cZ9nLlZL2MgMeHDNdEEi6ejCZLkWkm4FeiAlt60H3XA/83SKkSR7aClOLUVqUe6f9Q58MN
        EPyNlKbRRjKYIhJyDU6Yoxq8CFdNDRE+SGwl4p4U1Jjuy6z5emQcv3l4SwHvjufP0YfOpi
        vehkMD7RqvqayGFQEmHWhNCREaUJgZ0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-1NtUBs4DO8iuBndeOELhRg-1; Fri, 07 May 2021 00:05:05 -0400
X-MC-Unique: 1NtUBs4DO8iuBndeOELhRg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 90D781006C80;
        Fri,  7 May 2021 04:05:04 +0000 (UTC)
Received: from localhost (ovpn-13-30.pek2.redhat.com [10.72.13.30])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 71EE91A866;
        Fri,  7 May 2021 04:05:00 +0000 (UTC)
Date:   Fri, 7 May 2021 12:04:57 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Dave Young <dyoung@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>, kexec@lists.infradead.org
Subject: Re: [PATCH v5 13/13] kdump: Use vmlinux_build_id to simplify
Message-ID: <20210507040457.GB23668@MiWiFi-R3L-srv>
References: <20210420215003.3510247-1-swboyd@chromium.org>
 <20210420215003.3510247-14-swboyd@chromium.org>
 <20210428101355.GB8374@localhost.localdomain>
 <CAE-0n517ZDD8ySTqT2GvKv-KNf1DFP2qmaqt3Pc=-AEndLTevg@mail.gmail.com>
 <20210507035418.GA23668@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210507035418.GA23668@MiWiFi-R3L-srv>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07/21 at 11:54am, Baoquan He wrote:
> On 04/29/21 at 01:14am, Stephen Boyd wrote:
> > Quoting Baoquan He (2021-04-28 03:13:55)
> > > On 04/20/21 at 02:50pm, Stephen Boyd wrote:
> > > > We can use the vmlinux_build_id array here now instead of open coding
> > > > it. This mostly consolidates code.
> > > >
> > > > Cc: Jiri Olsa <jolsa@kernel.org>
> > > > Cc: Alexei Starovoitov <ast@kernel.org>
> > > > Cc: Jessica Yu <jeyu@kernel.org>
> > > > Cc: Evan Green <evgreen@chromium.org>
> > > > Cc: Hsin-Yi Wang <hsinyi@chromium.org>
> > > > Cc: Dave Young <dyoung@redhat.com>
> > > > Cc: Baoquan He <bhe@redhat.com>
> > > > Cc: Vivek Goyal <vgoyal@redhat.com>
> > > > Cc: <kexec@lists.infradead.org>
> > > > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > > > ---
> > > >  include/linux/crash_core.h | 12 ++++-----
> > > >  kernel/crash_core.c        | 50 ++------------------------------------
> > > >  2 files changed, 8 insertions(+), 54 deletions(-)
> > > >
> > > > diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
> > > > index 206bde8308b2..de62a722431e 100644
> > > > --- a/include/linux/crash_core.h
> > > > +++ b/include/linux/crash_core.h
> > > > @@ -38,8 +38,12 @@ phys_addr_t paddr_vmcoreinfo_note(void);
> > > >
> > > >  #define VMCOREINFO_OSRELEASE(value) \
> > > >       vmcoreinfo_append_str("OSRELEASE=%s\n", value)
> > > > -#define VMCOREINFO_BUILD_ID(value) \
> > > > -     vmcoreinfo_append_str("BUILD-ID=%s\n", value)
> > > > +#define VMCOREINFO_BUILD_ID()                                                \
> > > > +     ({                                                              \
> > > > +             static_assert(sizeof(vmlinux_build_id) == 20);          \
> > > > +             vmcoreinfo_append_str("BUILD-ID=%20phN\n", vmlinux_build_id); \
> > >
> > > Since there has been static_assert at above, can we remove the magic
> > > number '20'?
> > >
> > > And I checked format_decode(), didn't find which type corresponds to
> > > 'N', could you tell?
> > 
> > It is documented in Documentation/core-api/printk-formats.rst (see "Raw
> > buffer as a hex string") where the '20' replaces the '*' to specify a
> > fixed size buffer to format. We could pass the 20 as an argument instead
> > of encoding it in the format, but then it would still be there twice. We
> > could use a #define but then it would have to be passed as an argument.
> 
> Thanks for telling, I can see 'phN' is used in many places, but haven't
> figured out how it's parsed, e.g in format_decode() it's not related.
> Anyway, I may need dig further or search to get it.
> 
> > 
> > I don't know of a good way to enforce in printk that the buffer is the
> > size that matches the format size. Maybe it shouldn't be an option to
> > have a size in the format string if it's a problem to put the size of
> > the buffer in there.
> 
> Oh, I meant that we may not need to enforce that because the size of
> vmlinux_build_id can be guaranteed, always 20, we do not need to specify
> the '20'? Afaik, we usually specify the format size when the string size
> is variable, and we want to add '0' to make the width of printing is
                                  ~'space' I meant
> fixed. Anyway, this dones't matter much.
> 
> Acked-by: Baoquan He <bhe@redhat.com>
> 
> Thanks
> Baoquan
> 
> > 
> > >
> > > Other than these, this patch looks good to me, thanks for the effort.
> > >
> > 
> > Thanks.
> > 
> > _______________________________________________
> > kexec mailing list
> > kexec@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/kexec
> > 
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 

