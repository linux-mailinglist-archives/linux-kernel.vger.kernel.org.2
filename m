Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A053D3FF1C5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 18:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346217AbhIBQrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 12:47:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50410 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242304AbhIBQrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 12:47:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630601179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wM5jeR/BgbaPO4304Czble7Nihbr6/IU4liWjqxSIng=;
        b=Y6Ew6lBZVSPk80fdPR6SzZqzr8Lz4neR4w+2QF0U5SGv0K1/cFubRCo96QydhENElLhvRi
        CF0RVca+6Me+dILzvPRJrYTP8NH8oE24XVABGE0HlCjb5iuILO33vhl97rDIynhkGZtK8R
        cmOxfn4EYCyBbv2+RIAsRgNhZSmTbtg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-D419PRdIMKm1neoGJsfXkQ-1; Thu, 02 Sep 2021 12:46:18 -0400
X-MC-Unique: D419PRdIMKm1neoGJsfXkQ-1
Received: by mail-wm1-f70.google.com with SMTP id f19-20020a1c1f13000000b002e6bd83c344so922144wmf.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 09:46:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=wM5jeR/BgbaPO4304Czble7Nihbr6/IU4liWjqxSIng=;
        b=ijBb6GHPEHhH91oitgl+IQis5o/BoP/I8JYusyX4ciaKF8ZGI6VMTfkfhJDb4zMcIB
         1ve5Shg2IwRD+adZTDKfE11Qmd844a3gbkp4Xm2RsGoJv3BWtFEbrlztVDMVrtfSdFUa
         ig7TcvocdSWM6+/52+0YZFp9HFeJFARJQVuCRoV9f9TUIVDymLG62AWThOb456YxRIHg
         hphI1XsNpJVy0zTvNDaqayz9M4yoQMVcNON7amvqi3IqAxh+Oz5XPED1RUusDqgWpsMR
         UOpdpIOOnX1uqfJTD3tfIGSTu0CL+RoK08vTCVt2bCotRk/XE+OL/mnT31Wq3SzClybx
         MvdA==
X-Gm-Message-State: AOAM5314DuP4NJytxsjtZ8DH6pRcHqh2nFEJcndKGlYgLqHpbXqUKJeM
        8wwEIS5TIQHdIe8GiAEo2JBMRp9HRjrozXx1L4wzYI+xdcIO11tLtY88/imS3bR50SnrTdVjYc5
        ISUby5qGddIjGsMlghdsAIlTy
X-Received: by 2002:adf:c390:: with SMTP id p16mr5093845wrf.105.1630601176842;
        Thu, 02 Sep 2021 09:46:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy+Mu40jTTtKwfCi2VF1Q5s3Y3vUCWCZb2j0MvPEkAE/tQN20FSjlYWAo4PNCuAbQImt5QboQ==
X-Received: by 2002:adf:c390:: with SMTP id p16mr5093827wrf.105.1630601176625;
        Thu, 02 Sep 2021 09:46:16 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id j20sm2228400wrb.5.2021.09.02.09.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 09:46:15 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] KVM: Drop unused kvm_dirty_gfn_harvested()
In-Reply-To: <YTD+eBj+9+mb9LVg@google.com>
References: <20210901230506.13362-1-peterx@redhat.com>
 <87y28flyxj.fsf@vitty.brq.redhat.com> <YTD+eBj+9+mb9LVg@google.com>
Date:   Thu, 02 Sep 2021 18:46:14 +0200
Message-ID: <87r1e7lycp.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> On Thu, Sep 02, 2021, Vitaly Kuznetsov wrote:
>> Peter Xu <peterx@redhat.com> writes:
>> 
>> > Drop the unused function as reported by test bot.
>> 
>> Your subject line says "Drop unused kvm_dirty_gfn_harvested()" while in
>> reallity you drop "kvm_dirty_gfn_invalid()".
>
> Heh, Peter already sent v2[*].  Though that's a good reminder that it's helpful
> to reviewers to respond to your own patch if there's a fatal mistake and you're
> going to immediately post a new version.  For tiny patches it's not a big deal,
> but for larger patches it can avoid wasting reviewers' time.
>

Indeed. It's also a good reminder for reviewers that inbox is best
treated like a stack and not like a queue :-)

-- 
Vitaly

