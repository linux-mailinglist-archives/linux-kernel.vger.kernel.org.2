Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79EE7400C78
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 20:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237265AbhIDSFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 14:05:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35913 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232946AbhIDSFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 14:05:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630778679;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cz9Ku9KOf6mZgZXN1NhnjRDs1hLQrX4dFP4M4XexeGM=;
        b=K2JgeCxuGAHtertYo0NJGA4S/3H7XiNeboSKAU2M9gc/+lbcYSvROSSWZ+drCqoqGBhZDR
        aVHiizZXQc6HYxKidR+3nLnhsczQN+kcxzeV1mRJf+Rcb4X5vKmtys2Jf8cILYYC1omCvx
        id5ilFrJF3OsjcRmHHBe/pGkCYRhG3Q=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-559-DrJ8W38VOvGx27Hg2ReVWg-1; Sat, 04 Sep 2021 14:04:38 -0400
X-MC-Unique: DrJ8W38VOvGx27Hg2ReVWg-1
Received: by mail-oo1-f71.google.com with SMTP id t1-20020a4ad0a1000000b0028bbf04eae9so1564813oor.10
        for <linux-kernel@vger.kernel.org>; Sat, 04 Sep 2021 11:04:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cz9Ku9KOf6mZgZXN1NhnjRDs1hLQrX4dFP4M4XexeGM=;
        b=Ek6kcnuIKj5dZEP7Y+SPPK6Pyh+5ggy7Jv/iV2v+wMPlQ9cIFrCIV/GcqqZIKfK+Kw
         gR2oUEPwBH8n/R5nnwORhckPi9r9WNt4Q1PtFf9oKund/eTJEP5QW49Qd14RIBnTMEPF
         9YRvitcP/YRAahI3cyUwqV6fszCBlaEZ/zXQrCnDTdsxw4Yo4Z2IhpB8FYPiMJGNFAJn
         baSuu4uIe+tXry9h2wbtehjcWZd6zYYc2s0ciYdpOviHcNmNdGpswfYgKE8f/avMYGUI
         vmjZDOIc6KHbU6i50t8mlY8lAULNvW7imUj/Aj4eVu6wZJCHQMLBQMRUF6HXRgbVMd3a
         qyRA==
X-Gm-Message-State: AOAM531pxijWmmrJDOIZVQaqRy+WAV8pzTCHiKXd+jFZFHy4Dj7NZ4GL
        vumGINl8dVFQavLJrwxmJqwY0/aBUsFOOPfmle1Ybf1i5wLBrH3vZw899WU3Nh4cNQczWICwFHY
        ZWEzuT6jelu8U5929RwEzW0Wl
X-Received: by 2002:a05:6808:bc2:: with SMTP id o2mr3449037oik.73.1630778677893;
        Sat, 04 Sep 2021 11:04:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxbMykEdwn1S/PtlTn9+yNv6kBsjxqNdyp/i5WxcXA84q+inbL+YCZ7Bae/m99bNG4eGCNt0A==
X-Received: by 2002:a05:6808:bc2:: with SMTP id o2mr3449020oik.73.1630778677623;
        Sat, 04 Sep 2021 11:04:37 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id v11sm650179oto.22.2021.09.04.11.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Sep 2021 11:04:37 -0700 (PDT)
Date:   Sat, 4 Sep 2021 11:04:34 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/13] kbuild: store the objtool command in *.cmd files
Message-ID: <20210904180434.qkdbs27i5f2vtoxv@treble>
References: <20210831074004.3195284-1-masahiroy@kernel.org>
 <20210831074004.3195284-4-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210831074004.3195284-4-masahiroy@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2021 at 04:39:54PM +0900, Masahiro Yamada wrote:
> objtool_dep includes include/config/{ORC_UNWINDER,STACK_VALIDATION}
> so that all the objects are rebuilt when any of CONFIG_ORC_UNWINDER
> and CONFIG_STACK_VALIDATION is toggled.
> 
> As you can see in 'objtool_args', there are more CONFIG options
> that affect the objtool command line.
> 
> Adding more and more include/config/* is ugly and unmaintainable.
> 
> Another issue is that non-standard objects are needlessly rebuilt.
> Objects specified as OBJECT_FILES_NON_STANDARD is not processed by
> objtool, but they are rebuilt anyway when CONFIG_ORC_UNWINDER or
> CONFIG_STACK_VALIDATION is toggled. This is not a big deal, but
> better to fix.
> 
> A cleaner and more precise fix is to include the objtool command in
> *.cmd files so any command change is naturally detected by if_change.

Nice improvement, thanks!

s/CONFIG_ORC_UNWINDER/CONFIG_UNWINDER_ORC/g

And yes, this means the original ORC unwinder dependency didn't
work:

> -objtool_dep = $(objtool_obj)					\
> -	      $(wildcard include/config/ORC_UNWINDER		\
> -			 include/config/STACK_VALIDATION)


-- 
Josh

