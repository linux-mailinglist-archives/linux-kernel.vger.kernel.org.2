Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 063AF33EF47
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 12:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbhCQLII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 07:08:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22326 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230048AbhCQLHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 07:07:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615979263;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sFmaH41LDlPjG9Ynwp45uLWY+uwr7N1DcuUG5izOuw8=;
        b=OLgkObXWJ7fGt+ohsMwHrhWMqQFtagOkSVoDENf8RAVzuSr7W/8iO3zEjISyAsH3i/tyc8
        fTUUiu4wWr+fWatg57+1V9Gm1/mmL0MwaTHH6X9uHr3vickMxUn0htqZPP5mDpeMZZKYR3
        qTOecSjjHqgVinlYbZGWZU8sE5vEW2g=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-HoriL-B2NOOzhtcMMVINAA-1; Wed, 17 Mar 2021 07:07:42 -0400
X-MC-Unique: HoriL-B2NOOzhtcMMVINAA-1
Received: by mail-ed1-f71.google.com with SMTP id q25so4422973eds.16
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 04:07:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=sFmaH41LDlPjG9Ynwp45uLWY+uwr7N1DcuUG5izOuw8=;
        b=ekq/+ec+EvHmUAS7jIV/TRWQYZKspLuqlQlrq4QqZSvIbfoj9BfXfiXeXVXrhcFWbT
         hQ6puRGBo4Gd82ZJrd7dEGVB1q9gwU+u0WONeNzS/FYldgA41mI8kfFMxv+b2O84854u
         hQ2QBzTBhjJIcTWVQXFozi1flo0wySvn94qGBd5ww6cmEUSbFOQw0gRsjPaCGrFhnvcU
         Z/TC+6XEuME+S3BmRkPdgkbBCsJNjTGpGCYBoPI/InHtj6kJH2uazHxPmk7NklO8fDoz
         +zoZCNnL1i6LVoEgjqF7cqrglJWUmZXSSeMm/dzlfErAJqIWUOpdB8jI7jzVQNVfD5Cb
         pikw==
X-Gm-Message-State: AOAM531SctwBvAg3QokSFgaUnNJu9u1eu3lAELgYFQHZbeBtNXamsWIr
        F/An9gpePspz/2oKvjwrsEKfbYNJt234P+gSTAnkFxKyGSwlSfiQr8tXR1hmPXzHIxDMql2pIt5
        UMXhriYm9iQ3/s+KVXZeJaTJq
X-Received: by 2002:a17:906:2314:: with SMTP id l20mr35375422eja.178.1615979260625;
        Wed, 17 Mar 2021 04:07:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJylmtlvBiYwpe22USdjn0rPdjb/Edoq2N3MMGbDCmY44u09j1aukE8925/xi14GcDNAZySNvg==
X-Received: by 2002:a17:906:2314:: with SMTP id l20mr35375374eja.178.1615979260206;
        Wed, 17 Mar 2021 04:07:40 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a22sm11341585ejr.89.2021.03.17.04.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 04:07:39 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 36DC8181F55; Wed, 17 Mar 2021 12:07:39 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] libbpf: use SOCK_CLOEXEC when opening the netlink socket
In-Reply-To: <20210317104512.4705-1-memxor@gmail.com>
References: <20210317104512.4705-1-memxor@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 17 Mar 2021 12:07:39 +0100
Message-ID: <87y2emca2s.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:

> Otherwise, there exists a small window between the opening and closing
> of the socket fd where it may leak into processes launched by some other
> thread.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

FYI, you should be tagging patches with the tree they are targeting. In
this case probably the 'bpf' tree (so [PATCH bpf] in the subject).

Also, a Fixes: tag would be nice here?

-Toke

