Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5202732B712
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 12:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357120AbhCCKsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 05:48:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54698 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2361121AbhCBX2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 18:28:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614727619;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w8yXmYgKxvnjqvou08cqwubDp8xzbUl1Kzx0JAA4ffI=;
        b=OZ+ehz34d8xG32wAoCuNLD2B58gNNVzv3+z/RdDdbXOgpr9ghJh6Y2za181VjTppuCtm6s
        DTyDHiiVpkpdKIUnQZp+ivEcrgk4pgssdpV8nCRDKplGZvXyUpcxvGOID/TRMHopD6jWqM
        ELxssEZEFhVllHd2wCffRsaftD1VNqY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-298-3-d5fVc9NP6eOJo2U9q4SA-1; Tue, 02 Mar 2021 18:26:56 -0500
X-MC-Unique: 3-d5fVc9NP6eOJo2U9q4SA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9D045107ACED;
        Tue,  2 Mar 2021 23:26:54 +0000 (UTC)
Received: from treble (ovpn-117-7.rdu2.redhat.com [10.10.117.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E651E60BFA;
        Tue,  2 Mar 2021 23:26:51 +0000 (UTC)
Date:   Tue, 2 Mar 2021 17:26:49 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-hardening@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Justin Forbes <jforbes@redhat.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Frank Eigler <fche@redhat.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH RFC] gcc-plugins: Handle GCC version mismatch for OOT
 modules
Message-ID: <20210302232649.y2tutffhxsblwqlb@treble>
References: <efe6b039a544da8215d5e54aa7c4b6d1986fc2b0.1611607264.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <efe6b039a544da8215d5e54aa7c4b6d1986fc2b0.1611607264.git.jpoimboe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 25, 2021 at 02:42:10PM -0600, Josh Poimboeuf wrote:
> When building out-of-tree kernel modules, the build system doesn't
> require the GCC version to match the version used to build the original
> kernel.  That's probably [1] fine.
> 
> In fact, for many distros, the version of GCC used to build the latest
> kernel doesn't necessarily match the latest released GCC, so a GCC
> mismatch turns out to be pretty common.  And with CONFIG_MODVERSIONS
> it's probably more common.
> 
> So a lot of users have come to rely on being able to use a different
> version of GCC when building OOT modules.
> 
> But with GCC plugins enabled, that's no longer allowed:
> 
>   cc1: error: incompatible gcc/plugin versions
>   cc1: error: failed to initialize plugin ./scripts/gcc-plugins/structleak_plugin.so
> 
> That error comes from the plugin's call to
> plugin_default_version_check(), which strictly enforces the GCC version.
> The strict check makes sense, because there's nothing to prevent the GCC
> plugin ABI from changing -- and it often does.
> 
> But failing the build isn't necessary.  For most plugins, OOT modules
> will otherwise work just fine without the plugin instrumentation.
> 
> When a GCC version mismatch is detected, print a warning and disable the
> plugin.  The only exception is the RANDSTRUCT plugin which needs all
> code to see the same struct layouts.  In that case print an error.

Hi Masahiro,

This problem is becoming more prevalent.  We will need to fix it one way
or another, if we want to support distro adoption of these GCC
plugin-based features.

Frank suggested a possibly better idea: always rebuild the plugins when
the GCC version changes.  What do you think?  Any suggestions on how to
implement that?  Otherwise I can try to hack something together.

-- 
Josh

