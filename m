Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB8D386B18
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 22:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238614AbhEQURL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 16:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236354AbhEQURJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 16:17:09 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A94C061573
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 13:15:51 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id c17so5747618pfn.6
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 13:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sIcPsjBtYPRGoLLSDO2B3/rtbfsSodR/GrhGvihj4OM=;
        b=RSu7OC40KVFAlR4KCToJbuVdsdXMMdWauMKLK7Wuq+G3HBJPMlYyjPoUzP61cyC1Vl
         m/0ekWyPL5MEiBAVKnMW5fX45XTC8Poaug44Gq+M0U2/JeBkXzbPUdTEyjI5/8zCWVg+
         thsRri7EGp+ydsjziIZe1oU1O7MqJfsxARNYFVGrcuMG1tlb9c6Ajf4XDtZnRqupnw8I
         nkd149CYP51BcJ+JU7qkJ/ERnYb/KTJogx3s/nAfWuxNNEmEaokaxbjY8KljjlNFizVw
         vv5s4fcRu46yF+8hfhzROxoqNDVnUBjLcvHefi1zFl9r9QCrvZA+MO/f3Hg0nFdxPgVG
         2SsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sIcPsjBtYPRGoLLSDO2B3/rtbfsSodR/GrhGvihj4OM=;
        b=DINkjfDACFkCFMMFAlAiHJAHmsQG6SwFFqnernLyulDopR1UoLBBzeL0zPR8NtALsW
         2CMP5hRLlVjpxq2gQms4mXwoH5GXMthhdzwvyCeyeXBNwr+k572ZFxm/qBpBW1HBWyEQ
         iHV01biarx6rdHopZ11aEr3rbZhEaGfvhEoseFywRh7ciAXedNLdLvfIGQ9zJ1Xx1HBb
         ri3vpDyQxlQ4WSSLYyhN/tQtV7jfaEVeDFOXby6WGoMBCehaP3LHZKyt2zlbXx0RQh40
         PO91xJJPZt5XLxQIbxzCy6rphYKJVnMyp2Lb508+2mYEggNjz4rdF4/2tasCFDzmNBV2
         RXkw==
X-Gm-Message-State: AOAM532Sk2som+g8Zj4CGAryWGONUhMhI3plelw2J5BqlKhhaNJsqbt/
        1kTR4dz+NiEQGcJvZMsgblGi2A==
X-Google-Smtp-Source: ABdhPJzIWN9dnSGgET3oAfwZG9PR1Jrv82jckv3EBU/ZpcmKnoxMCGPpMfaG3c3dW0YoVPbBtzDwNQ==
X-Received: by 2002:a63:205b:: with SMTP id r27mr1252598pgm.95.1621282550932;
        Mon, 17 May 2021 13:15:50 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id 5sm230348pjo.17.2021.05.17.13.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 13:15:50 -0700 (PDT)
Date:   Mon, 17 May 2021 20:15:46 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     "Bae, Chang Seok" <chang.seok.bae@intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        X86 ML <x86@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 00/11] x86: Support Intel Key Locker
Message-ID: <YKLO8ryjO7gZKJQC@google.com>
References: <20210514201508.27967-1-chang.seok.bae@intel.com>
 <9f556d3b-49d3-5b0b-0d92-126294ea082d@kernel.org>
 <C08CCADB-864B-48E0-89E0-4BF6841771E8@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C08CCADB-864B-48E0-89E0-4BF6841771E8@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021, Bae, Chang Seok wrote:
> On May 15, 2021, at 11:01, Andy Lutomirski <luto@kernel.org> wrote:
> > What is the expected interaction between a KL-using VM guest and the
> > host VMM?

Messy.  :-)

> > Will there be performance impacts (to context switching, for
> > example) if a guest enables KL, even if the guest does not subsequently
> > do anything with it?

Short answer, yes.  But the proposed solution is to disallow KL in KVM guests if
KL is in use by the host.  The problem is that, by design, the host can't restore
its key via LOADIWKEY because the whole point is to throw away the real key.  To
restore its value, the host would need to use the platform backup/restore
mechanism, which is comically slow (tens of thousands of cycles).

If KL virtualization is mutually exclusive with use in the host, then IIRC the
context switching penalty is only paid by vCPUs that have executed LOADIWKEY, as
other tasks can safely run with a stale/bogus key.

> > Should Linux actually enable KL if it detects that it's a VM guest?

Probably not by default.  It shouldn't even be considered unless the VMM is
trusted, as a malicious VMM can completely subvert KL.  Even if the host is
trusted, it's not clear that the tradeoffs are a net win.

Practically speaking, VMMs have to either (a) save the real key in host memory
or (b) provide a single VM exclusive access to the underlying hardware.

For (a), that rules out using an ephemeral, random key, as using a truly random
key prevents the VMM from saving/restoring the real key.  That means the guest
has to generate its own key, and the host has to also store the key in memory.
There are also potential performance and live migration implications.  The only
benefit to using KL in the guest is that the real key is not stored in _guest_
accessible memory.  So it probably reduces the attack surface, but on the other
hand the VMM may store the guest's master key in a known location, which might
make cross-VM attacks easier in some ways.

(b) is a fairly unlikely scenario, and certainly can't be assumed to be the
default scenario for a guest.

> > Should Linux have use a specific keying method as a guest?

Could you rephrase this question?  I didn't follow.

> First of all, there is an RFC series for KVM [2].

That series also fails to address the use case question.

[*] https://lore.kernel.org/kvm/YGs07I%2FmKhDy3pxD@google.com/
