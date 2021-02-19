Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF03431FE6A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 18:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbhBSRzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 12:55:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbhBSRz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 12:55:27 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37489C061756
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 09:54:47 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id o38so5119446pgm.9
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 09:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=glvZ+nCfB9TtbAroDymQkDFhBNuKdCgNd2JMzbDR3kI=;
        b=OCyoHdUAUdv7opL3EZFA7lTMEfk3yF8FryLxCsvYVnjGDzjyo3IU/c24JBfeqd7Wek
         htlrq3CI2X7xA4XR6tgBgRmcOimlCZyvreXpDi0cBn0e7Op3Gtb9GT+mvag2vQoL86sf
         J0f5gDbks/Dkv/ld51c1f0GgMocBOlWoIoOEdzcEOPTTrwnF/h8V0l0WfEqpLvGWNdWX
         pRsJzlcOFdUHpbWX4cx1FCRdE1h+ASi7U36zIZ2gY/fAR3a14ZS2bBkxXS4Pg3/6hmRG
         uxDTlXeWoVGVQ+nqd4wJZsOKg5SJvzrp201YnPYTjQuRSLi2j+7jVMsSPZO2TUloFe1t
         ZqWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=glvZ+nCfB9TtbAroDymQkDFhBNuKdCgNd2JMzbDR3kI=;
        b=MdkhdOFxUAVb9h1pBwWbmCI2C9d43dix7gfmCI9rxHOBns0608DtS5Iy0/6bU8od3x
         n8fUsD8MPJisgjdxizXs8pB4OzRyrv5R6Vk+wQ6Y3Bou/ZyGTLbiDnAYz3oDTIRD9GmK
         2lSHgrq+4NFWY0GjVzh6rh03uWA40wzX+sY4WSzSvZfY+8wRHQgV1rKfCKZgB1JoJC3w
         5+W1SXMZYr/yinDDS4k1MsvlpDuzpVcTf0n+YQfLCQwZNB1BZrCE4PiLAfoFhPl9TrOP
         5JuGgIUlHY20vCRrPCOXqO4JK++jvMGBXNu6XsPSydn6f0+BgtKJ08ShI8JYnyzYOxqo
         242w==
X-Gm-Message-State: AOAM533fn0Jrneq34ksGvpj/V/U3v6GdZj1LLVQ70wnN9mdpx0HlO3Zv
        Y5eN1jRGVpRkm37uLAuo9JBX+g==
X-Google-Smtp-Source: ABdhPJx6LkZZbRlVWvf8Qceg5jpRQTiPkyf5Y3+HD6ZGTTavt9ztCUZdCVv8/v9Y3O4vJmgK1tv/Fw==
X-Received: by 2002:a62:7985:0:b029:1e1:1703:c2e7 with SMTP id u127-20020a6279850000b02901e11703c2e7mr10602461pfc.69.1613757286450;
        Fri, 19 Feb 2021 09:54:46 -0800 (PST)
Received: from google.com ([2620:15c:f:10:903f:bec1:f9d:479b])
        by smtp.gmail.com with ESMTPSA id t2sm5997590pfg.152.2021.02.19.09.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 09:54:45 -0800 (PST)
Date:   Fri, 19 Feb 2021 09:54:38 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Quentin Perret <qperret@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, android-kvm@google.com,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        Fuad Tabba <tabba@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        David Brazdil <dbrazdil@google.com>
Subject: Re: [RFC PATCH v2 00/26] KVM/arm64: A stage 2 for the host
Message-ID: <YC/7XuB30N8C3sNx@google.com>
References: <20210108121524.656872-1-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210108121524.656872-1-qperret@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 08, 2021, Quentin Perret wrote:
> [2] https://kvmforum2020.sched.com/event/eE24/virtualization-for-the-masses-exposing-kvm-on-android-will-deacon-google

I couldn't find any slides on the official KVM forum site linked above.  I was
able to track down a mirror[1] and the recorded presentation[2].

[1] https://mirrors.edge.kernel.org/pub/linux/kernel/people/will/slides/kvmforum-2020-edited.pdf
[2] https://youtu.be/wY-u6n75iXc
