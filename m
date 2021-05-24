Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6670238F258
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 19:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233530AbhEXRit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 13:38:49 -0400
Received: from mail-ed1-f54.google.com ([209.85.208.54]:33673 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232983AbhEXRis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 13:38:48 -0400
Received: by mail-ed1-f54.google.com with SMTP id b17so32959806ede.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 10:37:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dWSRay9M9IWMqg0Wj3duW3D3t7UNiSPY/PB/dhS/Vlw=;
        b=Mu8kXK1P0i7c/4HVXvxfBSMIsY3WdN2Z8KA/gMbJMnNbI5nzs/wZwe/ORrXvTqopVt
         sMMy6feltQUHC+yzf/88CPbGU4k6vgKhonTunTwDcJqtGgy0fXqlkmxQz5HCAepYrSNB
         L+/ts1KuudvlkGXj3MYxAdE9YxBYDw9yr6HkQOYBUAMg5a0Ai0CSgMRbmqiIGh64ZCwk
         5dS9aDlmR27O8tHD/wIOe9VSRKk5jWZ93mu7GraGQ8e8BFdhaV+YljWXQTYVWi9bQh4j
         QIUro6DInkGK7s2HoyMa0kyz8oqVM4Aos7474VMzG6YopMfKIkwaYGrGnNhFuh7y08pU
         PEww==
X-Gm-Message-State: AOAM530vKS1lQvN8oa3VXxFyrW7NlaSDXeFFvdO+U04V9UgvJFuknZeB
        mpAM1apHHdTFD5g8+qOSdM3+fVGb9heAd+/oj7M=
X-Google-Smtp-Source: ABdhPJxfCldghMVxxX3dPpHU2HvWPAl/V4Jzo9oxsvdm9mkZiLf7JSs+5kveLNzvQQiEEhf0LD3P2J8UX5VSjzbH2uk=
X-Received: by 2002:aa7:c818:: with SMTP id a24mr27227561edt.310.1621877839351;
 Mon, 24 May 2021 10:37:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210523193259.26200-1-chang.seok.bae@intel.com>
 <20210523193259.26200-22-chang.seok.bae@intel.com> <8c8d91ae-5a3b-9523-725d-134840102df7@kernel.org>
In-Reply-To: <8c8d91ae-5a3b-9523-725d-134840102df7@kernel.org>
From:   Len Brown <lenb@kernel.org>
Date:   Mon, 24 May 2021 13:37:08 -0400
Message-ID: <CAJvTdKnU6g2H-R67G8LCs4cs0_NqnOzoKbC3J+iNGayFE5RGMQ@mail.gmail.com>
Subject: Re: [PATCH v5 21/28] x86/fpu/amx: Initialize child's AMX state
To:     Andy Lutomirski <luto@kernel.org>
Cc:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 23, 2021 at 11:09 PM Andy Lutomirski <luto@kernel.org> wrote:

> If we're going to start having different states with different
> behaviors, let's make them real defines.
>
> #define XFEATURE_MASK_CLEARED_ON_CLONE ...

Probably a good idea.

However, "cleared on clone" isn't the property.
The property is that the state is treated as VOLATILE.

Len Brown, Intel Open Source Technology Center
