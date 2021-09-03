Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0776E3FFA0C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 07:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234576AbhICF4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 01:56:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59457 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233634AbhICF4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 01:56:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630648532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YVcqIhLjK1aLZFmGstA8aMe5xkC0R7kiAZwq3yD/UZo=;
        b=MZDF97QFhjJS8ErjA7NEtJpZOYG0jzgBTtJjf4MEDi55LTYWJm0NQkO8zD2hI9ZdvbV8B7
        JdHMU8OKf5FMjXsOSdZ10gmY8EG6i+BXXJ4jYYKvpdv1+2/KRDnnyn+e91EI+9MAVzNfU1
        2ui5sEzDugw9iOOwYwwydq+C0Enj1UA=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-191-Sq_uaTahOcaKZTlF_qZPlQ-1; Fri, 03 Sep 2021 01:55:31 -0400
X-MC-Unique: Sq_uaTahOcaKZTlF_qZPlQ-1
Received: by mail-qk1-f199.google.com with SMTP id p23-20020a05620a22f700b003d5ac11ac5cso5260294qki.15
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 22:55:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YVcqIhLjK1aLZFmGstA8aMe5xkC0R7kiAZwq3yD/UZo=;
        b=uT9UncXhmyO8SR42st0LTr8Txx8t0jdNiC44N9DaX2FDiII8sS8fNmlKMFVup/YZ6X
         EGEVOIZo4GMkiVfg/P31N1wpdrby6iF4urPSzYWVsFumrt2vqSmRuSGhTPF6A7bDzShQ
         +RZ4ScPy5rxYspEEXqBKSTIs43QrH0/OVIQfYdq70GwjHJhPBXcBvpiwAAK4rhhtZepR
         KZONTsOqhbZhyOyFzItF84tTB5c9BMXYfGdCjf4qkDC6adjpYNVHN0DqyzBhVbopfYQ9
         ns5wBX2sBs5EZADPyZOy7JNmDlXaFiZk6eZrE5EP0NAziafzXdNRZZrfcLjwk05931FN
         yKpQ==
X-Gm-Message-State: AOAM531uz5qEUCtHZ9K0vPcYNyHOQ4UpdW/AzZyKdNbRtwhhBvxfj+or
        bg31Dtnlq3Mv98WbcQnv/9gnO043iYc3Nm6PfRUitv0p7eP3+ETOUXdEZgqE+A0bvVUY2ZPXlei
        9P2+pT+MDc8d9Pj/PhX0Nw6g9
X-Received: by 2002:a05:620a:1529:: with SMTP id n9mr1829204qkk.322.1630648530598;
        Thu, 02 Sep 2021 22:55:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyBA2PPgx2ogxp7sl4eBWoxXxd8xybtAdlH2aAWqzoyoFquWEXA675Jbr2q0U4tlJxGlHbFOw==
X-Received: by 2002:a05:620a:1529:: with SMTP id n9mr1829187qkk.322.1630648530395;
        Thu, 02 Sep 2021 22:55:30 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::d])
        by smtp.gmail.com with ESMTPSA id g8sm3144077qkm.25.2021.09.02.22.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 22:55:29 -0700 (PDT)
Date:   Thu, 2 Sep 2021 22:55:26 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-arch@vger.kernel.org, Jessica Yu <jeyu@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 1/4] vmlinux.lds.h: Use regular *RODATA and
 *RO_AFTER_INIT_DATA suffixes
Message-ID: <20210903055526.mmi6hoomawavkbsp@treble>
References: <20210901233757.2571878-1-keescook@chromium.org>
 <20210901233757.2571878-2-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210901233757.2571878-2-keescook@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2021 at 04:37:54PM -0700, Kees Cook wrote:
> Rename the various section macros that live in RODATA and
> RO_AFTER_INIT_DATA. Just being called "DATA" implies they are expected
> to be writable.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: linux-arch@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh

