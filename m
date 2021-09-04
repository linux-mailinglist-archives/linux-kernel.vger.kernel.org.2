Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 349BD400C80
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 20:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237348AbhIDSUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 14:20:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27052 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234085AbhIDSUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 14:20:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630779559;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lQxLXG+tLC8/gQrf0gKeWEplwFmOd9QxR9rHZUvrWfY=;
        b=ORs1smsT/ObFUCwuDkEzi5iB3IFwSARkdreBdOJ3JhwI/NuyZLhNIofMpzCm4RfOVAnMvm
        +TzwSdEAXdEeM+88cw95SfrI7510NlY9vcVS9Yb72lgvF7C0nhKQaoud6AUzAXN4frQchh
        PLEnl2/YHPW6wuaG5NtHrnk8RrL2U5s=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-183-Q-9zMoy8PdesNxhQYd4VWQ-1; Sat, 04 Sep 2021 14:19:16 -0400
X-MC-Unique: Q-9zMoy8PdesNxhQYd4VWQ-1
Received: by mail-qk1-f199.google.com with SMTP id h186-20020a3785c3000000b00425f37f792aso3782360qkd.22
        for <linux-kernel@vger.kernel.org>; Sat, 04 Sep 2021 11:19:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lQxLXG+tLC8/gQrf0gKeWEplwFmOd9QxR9rHZUvrWfY=;
        b=iQxQdQf7TED7yZxv4ckEv1pOOzAXxeMZ5ZtbaUIlqwJYZ+QX9SWqVTfDm7sVEnX2aq
         9lKEKzoH1JMmcrB4LOggQNd0y4WWDH0nBpH5f9TZAFK+6xdqUhBiNHfU0wzXoqckVv4X
         Ba8Pe4mXwv3uxJDrProCMYaaV2yP06LUr7UBLW1anVEJeSQeR/tP0/Nzv22vAEw34jpF
         9VxslID/cDbJYmEsgz9R/v0Hobl9z0q/XDyrfyxx7uwsT2KgTBZfqNiHymXBgo0MZ1+x
         +7H6Pz4Eg8WlfLTskCvHmzcMqFk1VHgpREZXW4wp1+5WAcaV94ho4euYW69gx0WfULai
         UR7g==
X-Gm-Message-State: AOAM533wKP5XLD/k3kPmgBNI1TStf9R7ofTfoKFuXMh4EESSZPZit5dz
        WD8Q08+STAgaguSVLgzVgOT0s5UkwxpCXxtvDqJTutfi0wpnObl5JoeC3aN5ADY4e95DXTXSiMb
        Az03x23ovx4bdLgAzI5OeYmLS
X-Received: by 2002:ad4:4f50:: with SMTP id eu16mr4957047qvb.27.1630779555729;
        Sat, 04 Sep 2021 11:19:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzvX20+tN9yheBPI5jvjmprAVNHtW9v0MeFxBOaHYR8VeV+71mHDcJZjGt1jc05yuGs2vSzZA==
X-Received: by 2002:ad4:4f50:: with SMTP id eu16mr4957035qvb.27.1630779555587;
        Sat, 04 Sep 2021 11:19:15 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id v10sm2089344qkj.79.2021.09.04.11.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Sep 2021 11:19:15 -0700 (PDT)
Date:   Sat, 4 Sep 2021 11:19:12 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/13] kbuild: rename __objtool_obj to objtool
Message-ID: <20210904181912.r5hgjrpkle3jvm5k@treble>
References: <20210831074004.3195284-1-masahiroy@kernel.org>
 <20210831074004.3195284-3-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210831074004.3195284-3-masahiroy@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2021 at 04:39:53PM +0900, Masahiro Yamada wrote:
> Rename __objtool_obj to objtool, and move it out of the
> 'ifndef CONFIG_LTO_CLANG' conditional, so it can be used for
> cmd_cc_lto_link_modules as well.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh

