Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1EFE400CC4
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 21:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232710AbhIDTFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 15:05:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23393 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230346AbhIDTFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 15:05:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630782254;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8iBLYJMftUwp7hXO2s0oIif0u5EZOHD9H+Oe1M0SPII=;
        b=foEA2N3pYfb8V+eG7oBW0yFep4eRlYkohpbzJ8Q0mJBI2PbDXKuJSYCKw6vxTHTLeBETXw
        nMFh8hx2U9KcipujzbRfUAbSUIScrrYAlkCfeexPpxnQnzRk6EnoThb5qKDcvEB9GZ/l4W
        3zUXJ//ga2Bguq/S4aRlgoDNbYH+ZvU=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-323-UsaJXQkpMzmN88pRDFD6Cw-1; Sat, 04 Sep 2021 15:04:12 -0400
X-MC-Unique: UsaJXQkpMzmN88pRDFD6Cw-1
Received: by mail-ot1-f70.google.com with SMTP id t2-20020a9d7742000000b0051dd85217a3so1506520otl.11
        for <linux-kernel@vger.kernel.org>; Sat, 04 Sep 2021 12:04:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8iBLYJMftUwp7hXO2s0oIif0u5EZOHD9H+Oe1M0SPII=;
        b=l8jHwqlY7A/QwxSfGG+tFQn7zvgiEc1fb0yL7BJOSSUqaJ/7cP3K1l9/0vZ52lqkR4
         agY94dpzCF0MSk+uJ/8olVtZKGU2pqJ0d+IOy6ktYyj4tOv4XlO0tiIseIiqnivd77Zm
         YJgGZXc8oAc9iMc4yrUepnomkCpeWq6gOqpEWyjYKnHYrbaPKvT7LEqBrM1WfN/t+lPl
         fIzQsdJ59zDCENVJeoMniDz9zCzh6VBf+4DpI3iydMXMut6SjNoj6wU7mUWTpXhByG+m
         tKf/djtbUfsp8NiH/OIEbvUhkm5k4ewhZN2k2dofj1GJ0j01zo4Rm37jrL4agoH8PJes
         XYWw==
X-Gm-Message-State: AOAM533kdBJEI4Z00nWn3wvdLsMBmxp+aSpNCsjAvYF8hDv1xyzEgRTG
        XmytWSc7Uzl1uitrp7/ULuDNzdnzx6iuxF4dZm98CZsRCtBT4OYZtawFDAAY8aQe7jKrtAe1VoT
        4QHYqG+r+Rvck3MBg/4ui+YwN
X-Received: by 2002:a9d:4042:: with SMTP id o2mr4133433oti.332.1630782251642;
        Sat, 04 Sep 2021 12:04:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyPB60KqDp75uk3gd5sXgmkng+nzBElGb2AZWYXj7JFmqsg7DcMcmTQT46CTWXzkJvtpOfoKQ==
X-Received: by 2002:a9d:4042:: with SMTP id o2mr4133417oti.332.1630782251450;
        Sat, 04 Sep 2021 12:04:11 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id l21sm663379oop.22.2021.09.04.12.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Sep 2021 12:04:11 -0700 (PDT)
Date:   Sat, 4 Sep 2021 12:04:08 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 05/13] kbuild: detect objtool update without using
 .SECONDEXPANSION
Message-ID: <20210904190408.gslbmm44a5rhknny@treble>
References: <20210831074004.3195284-1-masahiroy@kernel.org>
 <20210831074004.3195284-6-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210831074004.3195284-6-masahiroy@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2021 at 04:39:56PM +0900, Masahiro Yamada wrote:
> Redo commit 8852c5524029 ("kbuild: Fix objtool dependency for
> 'OBJECT_FILES_NON_STANDARD_<obj> := n'") to add the objtool
> dependency in a cleaner way.
> 
> Using .SECONDEXPANSION ends up with unreadable code due to escaped
> dollars. Also, it is not efficient because the second half of
> Makefile.build is parsed twice every time.
> 
> Append the objtool dependency to the *.cmd files at the build time.
> 
> This is what fixdep and gen_ksymdeps.sh already do. So, following the
> same pattern seems a natural solution.
> 
> This allows us to drop $$(objtool_deps) entirely.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh

