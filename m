Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8865634AB9E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 16:38:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbhCZPh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 11:37:29 -0400
Received: from mail-ed1-f48.google.com ([209.85.208.48]:42723 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbhCZPg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 11:36:59 -0400
Received: by mail-ed1-f48.google.com with SMTP id l18so6787332edc.9;
        Fri, 26 Mar 2021 08:36:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M7bAOaHuOoPUP0hL0a5lD9zPxMZDsFezwNwO9c9aMSo=;
        b=BhvKfLaarTzv4NarbNrgU+8Pi2szeGwwoSLZvGyR853YQBSZ9wa2Igxogltj9MMb1V
         RQ3DhMHZ3fnlq3J9dP1FJOE9Jl6HqU7kDPXbHFykiiFOaifBLUT+EuR/UbhpynX8qnZ8
         50pdWeLMJVMAEfNOXA4W4Syh1CdI17qZzrysatiVACLEsCQQ2tzHbV2Yk1zXeiz0KSyC
         bjAID0+vDoCwdKF5ztSe8XW3PeYGBO9zvgh88fvBjh2ZVK312+xzw3R1Xh5bUIG9gAWG
         5wqBbGJ1jnVQZIP+biUok/PkBlDxekFjjhNIn0iIVhUB3Tzuflg/GY+h82tgrPRYwtmE
         7WdA==
X-Gm-Message-State: AOAM530VEk4ixVxe6Lo77S/kq8qsFQzd9VN/DqStDVIFFuWvQ6ckN+pJ
        DceXtQ8rnffxTS9JAOL0MP9UgECn9i+q8bC7/nc=
X-Google-Smtp-Source: ABdhPJwVkwNZmu5i9ayfG2g3qmXDWDs2Q5qPfdGT7KjmW2rz52eZ9agkXMzAeOwwkQGBFPGoGYCgjL3nfG+IWovE+Mw=
X-Received: by 2002:aa7:d917:: with SMTP id a23mr15858529edr.122.1616773017835;
 Fri, 26 Mar 2021 08:36:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210221185637.19281-1-chang.seok.bae@intel.com>
 <20210221185637.19281-23-chang.seok.bae@intel.com> <871rc9bl3v.fsf@nanos.tec.linutronix.de>
 <CAJvTdKkOKOgnmvAiPS6mWVoyAggbOB6hBOqb_tcHYDe8+-X+FQ@mail.gmail.com> <87v99evg2j.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87v99evg2j.fsf@nanos.tec.linutronix.de>
From:   Len Brown <lenb@kernel.org>
Date:   Fri, 26 Mar 2021 11:36:46 -0400
Message-ID: <CAJvTdK=zZ7OYr9uO0GpoCG5iufe=NKhoWhkkHX0wTbajQNhYSw@mail.gmail.com>
Subject: Re: [PATCH v4 22/22] x86/fpu/xstate: Introduce boot-parameters to
 control state component support
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Documentation List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 9:50 PM Thomas Gleixner <tglx@linutronix.de> wrote:

> Please provide the architectural document which guarantees that and does
> so in a way that it can be evaluated by the kernel. Have not seen that,
> so it does not exist at all.
>
>   Future CPUID attributes are as useful as the tweet of today.

I will do so the moment I am permitted.
I'm fine with dropping patch 22 until it can rely on the assurance of
that architectural feature.

thanks,
Len Brown, Intel Open Source Technology Center
