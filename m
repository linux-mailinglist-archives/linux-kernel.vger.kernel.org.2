Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC03A3A8A00
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 22:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbhFOUOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 16:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbhFOUOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 16:14:48 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA248C061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 13:12:43 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id z3-20020a17090a3983b029016bc232e40bso351856pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 13:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OJpltfx/a56QUhVgKubqHz/HzmJzoc4/jhS4am6AsFk=;
        b=CDAdqPMb73aYyytTCgeboChEjDbwQKkFccAdYShDWK8OLLVwDxaN/Nrpdno91Hp74n
         5Oe8k5ShUJ6MuBWbjJCxynCYRaTkDjyUJev5B61rpzYyTTQBqcTUXUkbWRRozjmhgPQC
         7nXZh8iP/9lzYNZxx25LFBJ4mY8B2VY+hvVL8Bnr5EZ8Iv7e6uF7MuNzUDbhVeEj/ohx
         9EFU3gxzP4CcGQuS0o7zJZQS9NBlW4RVeJWo++ZrZyVtA4xzd0P2gnyQdf5iHEfLUc8u
         2AnsS6oWxkAAHvgUYMl7Q6fjEFQJm/ybz/+morezb/bfEwu8/OJHRf5p4kc91M1i7jSm
         /o+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OJpltfx/a56QUhVgKubqHz/HzmJzoc4/jhS4am6AsFk=;
        b=o+GHB2ed0t0lhEr7ms61tOVigtQIUHuhPzv9G/an4eminZzX2g1696dQzyh1LmMqyX
         +AioCo6GxElP2FQTWR0Ac/gmWaU6gfSlux2OvOiUGEVgntcGCs1D3Z2vswEsn775UO4j
         jsd6Xgek6wmDo8JfI8n3C3uMrKU+3XrMHatJR4K0+0gXSKLVbdov5eLO6RBWEoTUossi
         D1cvqWKpj8f37XAbmM0FFHz+H6bBxq/SzsUQBJFgAPteoR/lK0Z4eYdXL0bhQsNrBW4F
         Zk9sg+lyxz/sr4HmQbFeJJCB9vhqgqM2V6XfhY603Io+dCqYCyRwWJCkmx4dk9oWCSfb
         vsKw==
X-Gm-Message-State: AOAM5309HsEuSDDpaPhUoe9v/ZBGv2dB8U3y8VfYdxvRqy1n8M2Kw+Af
        IrOJBM4OSVTArzFzAd62zXmON8s0llpE3KOyRL+W/Q==
X-Google-Smtp-Source: ABdhPJynm5DnZNZNPGIOabS0G8oz+1ZovR++p0dCfniOlqWhT9aUYnJ73vKE9pWyCu6eCRQLkSFuzQAideiSMBr+ELc=
X-Received: by 2002:a17:902:6bc8:b029:117:6a8a:f7af with SMTP id
 m8-20020a1709026bc8b02901176a8af7afmr5902760plt.51.1623787962978; Tue, 15 Jun
 2021 13:12:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210513193204.816681-1-davidgow@google.com> <20210513193204.816681-4-davidgow@google.com>
In-Reply-To: <20210513193204.816681-4-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 15 Jun 2021 13:12:32 -0700
Message-ID: <CAFd5g44Pa4wwXYBSHReEMKtDgNQiNjuARiwz++1y=+FVESW8KQ@mail.gmail.com>
Subject: Re: [PATCH v2 04/10] device property: Remove some casts in property-entry-test
To:     David Gow <davidgow@google.com>
Cc:     Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2021 at 12:36 PM David Gow <davidgow@google.com> wrote:
>
> With some of the stricter type checking in KUnit's EXPECT macros
> removed, several casts in property-entry-test are no longer required.
>
> Remove the unnecessary casts, making the conditions clearer.
>
> Signed-off-by: David Gow <davidgow@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
