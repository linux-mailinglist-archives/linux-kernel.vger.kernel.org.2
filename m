Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A48913B8918
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 21:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233717AbhF3TUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 15:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233670AbhF3TU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 15:20:28 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F39C061756
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 12:17:58 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id bu19so7098173lfb.9
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 12:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4T+GID+oMnIZlCqDCJF0ldXeQDAkPgspY/ySOTASFzI=;
        b=OsGeYpUKTFPyN5n360XNZX8s/aqdMHN9tQztcumkZMUEG0EKEgHA2J/bHBhbdu8wiR
         ClWnoPCQmYWxP2n/dlnN1fE0QB/HOvPEfl0TYUAdfEux0/vvSPpQzzuxcD9wpjOUwDnm
         ODKvHI15ym8cJPnCdDXTIIdO883VCyNE7rJaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4T+GID+oMnIZlCqDCJF0ldXeQDAkPgspY/ySOTASFzI=;
        b=Qd9z0o1wRAQVB66CNzPSUm+wxmlaR7Y5ACDarDmu0aPl4Bnwjf1B+1l1AibEcMQWxq
         xCSgYmZvID/JV8uD8KozpUFihFJbI/VGBKGYVli6j1LIH2+2ymYi4+U9bySjE23serip
         r7fbq6O2u1UY4NajTo82Y9lQVjHKvKMioxHUUTtNkwl2010wXWSDq9vFIFn/eI5IK4rE
         fq+y6TB7oOqPvf5tNWVgkGN6ZBuIVkRJqPrqw4biXiah/x7jf1R4Df1NPWwlA44h12tj
         xl1QOQX2YXZgtfDubqqBtDCGtLjEJAwNe5NziRuVXkxrbSKdUSwkERPsrS/bZW+ZyfOm
         WVfg==
X-Gm-Message-State: AOAM533lmjqT6sn7eIfoX2dEctRHwF/ErMfSExehQRPOlK+AoSQ1saYD
        gVwTEZ9JS0F+uvU9Pb92u74n7tUuZ75w1j2Jc+k=
X-Google-Smtp-Source: ABdhPJyJtByP1Z7qKLndH+tsSrq8KxTmJ/p4cMBda+r0JwrNs3m0F8NX3N7RdSby5uAIZ2j5EwHHFw==
X-Received: by 2002:a05:6512:32a6:: with SMTP id q6mr29587062lfe.308.1625080676644;
        Wed, 30 Jun 2021 12:17:56 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id c18sm2223791ljf.102.2021.06.30.12.17.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jun 2021 12:17:56 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id a11so7073040lfg.11
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 12:17:55 -0700 (PDT)
X-Received: by 2002:a19:7d04:: with SMTP id y4mr27583898lfc.201.1625080675538;
 Wed, 30 Jun 2021 12:17:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210629213421.60320-1-stefanb@linux.vnet.ibm.com> <20210629213421.60320-2-stefanb@linux.vnet.ibm.com>
In-Reply-To: <20210629213421.60320-2-stefanb@linux.vnet.ibm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 30 Jun 2021 12:17:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgVZ6PUJ6Q=vqnhSkHnE2Rvr72xPFjoRU4=HHn-Rqxu4w@mail.gmail.com>
Message-ID: <CAHk-=wgVZ6PUJ6Q=vqnhSkHnE2Rvr72xPFjoRU4=HHn-Rqxu4w@mail.gmail.com>
Subject: Re: [PATCH v8 1/2] certs: Trigger creation of RSA module signing key
 if it's not an RSA key
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     Jessica Yu <jeyu@kernel.org>, keyrings@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Nayna Jain <nayna@linux.ibm.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stefan Berger <stefanb@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 29, 2021 at 2:34 PM Stefan Berger
<stefanb@linux.vnet.ibm.com> wrote:
>
> Address a kbuild issue where a developer created an ECDSA key for signing
> kernel modules and then builds an older version of the kernel, when bi-
> secting the kernel for example, that does not support ECDSA keys.

Thanks, these two don't confuse me any more.

                Linus
