Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38ECB38F558
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 00:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233913AbhEXWIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 18:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232911AbhEXWH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 18:07:59 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F81DC061756
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 15:06:29 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id h24-20020a9d64180000b029036edcf8f9a6so2378206otl.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 15:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0x7KBa33YCdVpWQcerdsesPKCRJBcikDlHAi09xfS34=;
        b=rgfuObfd7/poNAOG7HADeiA06piRoZurmGfRdshD9nR6+/A1XwcwHBvr0fIuXJzTAe
         Bkh+E0t0AjhEyoqyxwfWpNleTenSMsqifsVjcsL40F+AlKaZrOqXdtv3khemVGnARE0E
         5EteI+YhBAJxnuMmq5MMPd0RGCc292UG81YeprAZUxQi/XGGMlIsBJF45esOXqY9eUUe
         Bq3M9XWw+JQkd74ygxUdxx/9g8ybvDDHcVLL9cQzYzynMuU75F3ecNzMBrO3S+/PRDvd
         jSgjLBfc3/EK3k1ydIoMgeGMp4l6VBb3E7+/HvRS9JMVRL2/lWHBGPW9ax8kPvodyPZM
         wP2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0x7KBa33YCdVpWQcerdsesPKCRJBcikDlHAi09xfS34=;
        b=uWFcwbquqFUyebR9UTHHOT1sAH6wVKOnThgtpV6N3qTXBiJFlJ9kcV8VnC6njlTCCs
         46JD7mOHSQz7QKFIQiVg6sbLLX2dGzl4czPTFRjC53fqEF9iDutYp4aN8cxs/5brcaWn
         o57Lu4qK6da4XiDOWYgRQV3atd4El+r/81v8RDUsKAWWME9PnIhWcAh7lioQ+BbNOqmY
         rej8E28+gREQvyaJjQw7un5QvCfYPoWIEbyz0DL0hKlQVULelM9cVkXOIZDGVdQNJJUG
         NSYasKu0P3SDh1OkgD66oPm65AXIUHNMGhKa41KUdiKdAhqmrzlAN9kF4hb6OSVUX+zb
         CFRA==
X-Gm-Message-State: AOAM531nvTiOEtCKFAQRqxsPxT4obEpZA+wBLpX5Wr4sTgyVFvqMwOhG
        mV3Kti9vgHdYOpJh/TWBZlc4Bo/+4ca1G/gPiswWRQ==
X-Google-Smtp-Source: ABdhPJxtCHIcf2YnfiuPHuBuBex18cxxq/QNS2VH1iDkBXBEJiRiDhEZCcB7y8XACmI3TQfSKbxiJELVGfEjPcEAOVU=
X-Received: by 2002:a9d:5786:: with SMTP id q6mr20763785oth.56.1621893988639;
 Mon, 24 May 2021 15:06:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210207154256.52850-1-jing2.liu@linux.intel.com> <20210207154256.52850-5-jing2.liu@linux.intel.com>
In-Reply-To: <20210207154256.52850-5-jing2.liu@linux.intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Mon, 24 May 2021 15:06:17 -0700
Message-ID: <CALMp9eT8SoD0X=RZNv+o4LJLZZioTaPPXBnT199AGJKAwJ=W7Q@mail.gmail.com>
Subject: Re: [PATCH RFC 4/7] kvm: x86: Add new ioctls for XSAVE extension
To:     Jing Liu <jing2.liu@linux.intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, jing2.liu@intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 6, 2021 at 11:00 PM Jing Liu <jing2.liu@linux.intel.com> wrote:
>
> The static xstate buffer kvm_xsave contains the extended register
> states, but it is not enough for dynamic features with large state.
>
> Introduce a new capability called KVM_CAP_X86_XSAVE_EXTENSION to
> detect if hardware has XSAVE extension (XFD). Meanwhile, add two
> new ioctl interfaces to get/set the whole xstate using struct
> kvm_xsave_extension buffer containing both static and dynamic
> xfeatures. Reuse fill_xsave and load_xsave for both cases.
>
> Signed-off-by: Jing Liu <jing2.liu@linux.intel.com>
> ---

> +#define KVM_GET_XSAVE_EXTENSION   _IOW(KVMIO,  0xa4, struct kvm_xsave_extension)
> +#define KVM_SET_XSAVE_EXTENSION   _IOW(KVMIO,  0xa5, struct kvm_xsave_extension)
Isn't the convention to call these KVM_GET_XSAVE2 and KVM_SET_XSAVE2?

Do you have any documentation to add to Documentation/virt/kvm/api.rst?
